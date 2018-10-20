process.env.NODE_ENV = process.env.NODE_ENV || 'production'
const TerserPlugin = require('terser-webpack-plugin');
const environment = require('./environment')


environment.config.optimization.minimizer = [new TerserPlugin()];


module.exports = environment.toWebpackConfig()
