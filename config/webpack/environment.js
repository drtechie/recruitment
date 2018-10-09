const { environment } = require('@rails/webpacker')
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const devMode = process.env.NODE_ENV !== 'production'
const lessToJs = require('less-vars-to-js');
const path = require('path');
const fs  = require('fs');
const webpack = require('webpack');

const themeVariables = lessToJs(fs.readFileSync(path.join(__dirname, './theme-vars.less'), 'utf8'));

environment.plugins.append('MiniCSS', new MiniCssExtractPlugin({
  // Options similar to the same options in webpackOptions.output
  // both options are optional
  filename: devMode ? '[name].css' : '[name].[hash].css',
  chunkFilename: devMode ? '[id].css' : '[id].[hash].css',
}));

const lessLoaders = [
  {
    loader: "css-loader",
    options: {
      sourceMap: true,
      localIdentName: "[local]___[hash:base64:5]"
    },
  },
  {
    loader: "less-loader",
    options: {
      javascriptEnabled: true,
      sourceMap: true,
      modifyVars: themeVariables
    }
  }
]

if (devMode) {
  lessLoaders.unshift({
    loader: "style-loader",
  })
}
else {
  lessLoaders.unshift({
    loader: MiniCssExtractPlugin.loader,
  })
}

environment.loaders.append('less', {
  test: /\.less$/,
  use: lessLoaders,
});

environment.loaders.append('css', {
  test: /\.css/,
  use: [
    {
      loader: "style-loader",
    },
    {
      loader: "css-loader",
      options: {
        sourceMap: true,
        localIdentName: "[local]___[hash:base64:5]"
      },
    },
  ],
  include: /flexboxgrid/
});

module.exports = environment
