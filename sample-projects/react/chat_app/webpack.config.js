module.exports = {
	entry: {
		main: [
			'./script1.js',
			'./script2.js'
		]
	},
	output: {
		filename: './public/[name].js'
	},
	module: {
		loaders: [
			{
				test: /\.js$/,
				exclude: /(node_modules|public)/,
				loader: 'babel',
				query: {
		      cacheDirectory: true,
		      presets: ['es2015', 'react']
		    }
			}
		]
	}
}