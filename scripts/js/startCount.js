var color = require('colors'),
    https = require('https'),
    // 命令行解析库
    opts = require('optimist')
    .usage('Count a Github user\'s a total stars.')
    .demand(1)
    // 别名，缩写
    .alias('t', 'thresh')
    .alias('l', 'limit')
    .alias('a', 'auth')
    // 设置默认值
    .default('t', 1)
    .default('l', Infinity)
    .describe({
        'a': 'Offer Github username and password to solve rate limits',
        't': 'Only show repos above this threshold',
        'l': 'Only show these quantities of repos '
    })
    .argv,
    user = opts._[0]

request('/users/' + user, function(res) {
    if (!res.public_repos) {
        console.log(res.message)
        return
    }
    var pages = Math.ceil(res.public_repos / 100),
        i = pages,
        repos = []

    while (i--) {
        request('/users/' + user + '/repos?per_page=100&page=' + (i + 1), check)
    }

    function check(res) {
        repos = repos.concat(res)
        pages--
        if (!pages) {
            output(repos)
        }
    }
})

function request(url, count) {
    var requestOptions = {
        hostname: 'api.github.com',
        path: url,
        headers: { 'User-Agent': 'Github StarCounter' },
        auth: opts.auth || undefined
    }

    https.request(requestOptions, function(res) {
        var body = ''

        res.on('data', function(buf) {
            body += buf.toString()
        }).on('end', function() {
            count(JSON.parse(body))
        })
    }).end()
}


function output(repos) {
    var total = 0,
        longest = 0,
        list = repos
        .filter(function(r) {
            total += r.stargazers_count
            if (r.stargazers_count >= opts.thresh) {
                if (r.name.length > longest) {
                    longest = r.name.length
                }
                return true
            }
        })
        .sort(function(a, b) {
            return b.stargazers_count - a.stargazers_count
        })

    // 如果仓库的数量大于要求显示的数量，则切片
    if (list.length > opts.limit) {
        list = list.slice(0, opts.limit)
    }

    console.log('\nTotal:' + total.toString().green + '\n')
    console.log(list.map(function(r) {
        return r.name + new Array(longest - r.name.length + 4).join(' ') + '\u2605  '.yellow + r.stargazers_count
    }).join('\n'))
    console.log()
}