const path = require('path')
const webpack = require('webpack')

const babelQuery = {
  presets: ['es2015', 'react', 'stage-0']
}

module.exports = {
	devtool: 'source-map',
	entry: {
		main: [
			'webpack-dev-server/client?http://localhost:8080',
			'webpack/hot/only-dev-server',
			'./src/main.js'
		]
	},
	output: {
		filename: '[name].js',
		path: path.join(__dirname, 'public'),
		publicPath: '/public/'
	},
	plugins: [
		new webpack.HotModuleReplacementPlugin(),
		new webpack.NoErrorsPlugin()
	],
	module: {
		loaders: [
			{
				test: /\.jsx?$/,
				include: path.join(__dirname, 'src'),
				loader: `react-hot!babel?${JSON.stringify(babelQuery)}`
			},
			{
				test: /\.scss$/,
				include: path.join(__dirname, 'src'),
				loader: `style!css!sass`
			}
		]
	},
	cache: false
}