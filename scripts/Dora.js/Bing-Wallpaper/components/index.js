const BingWallpaper = require('wonderful-bing-wallpaper');
const bing = new BingWallpaper({
    size: 10,
    local: 'zh-CN'
})

module.exports = {
    type: 'list',
    async fetch({ args, page }) {
        return [{
            style: 'simple',
            title: 'Hello World',
            onClick: item => {
                $ui.toast(`Clicked ${item.title}`)
            }
        }]
    }
}