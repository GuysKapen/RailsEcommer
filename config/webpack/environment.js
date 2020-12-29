const { environment } = require('@rails/webpacker')

const sassLoader = environment.loaders.get('sass')
const cssLoader = sassLoader.use.find(loader => loader.loader === 'css-loader')

cssLoader.options = Object.assign(cssLoader.options, {
    // loader: "css-loader?url=false"
    modules: true,
    // localIdentName: '[path][name]__[local]--[hash:base64:5]'
    url: false
})

module.exports = environment
