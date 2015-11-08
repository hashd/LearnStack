const webpack = require('webpack')
const WebPackDevServer = require('webpack-dev-server')
const config = require('./webpack.config')

new WebPackDevServer(webpack(config), {
	publicPath: '/public/',
	hot: true,
	historyApiFallback: true
}).listen(8080, 'localhost')