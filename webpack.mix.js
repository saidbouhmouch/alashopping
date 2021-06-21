let mix = require('laravel-mix');
const path = require('path');

mix.config.webpackConfig.output = {
  chunkFilename: 'js/[name].bundle.js',
  publicPath: '/',
};

// mix.autoload({
//     'jquery': ['$', 'window.jQuery', 'jQuery']
// });

mix.webpackConfig({
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: 'ts-loader',
        exclude: /node_modules/,
        options: {
          appendTsSuffixTo: [/\.vue$/],
        }
      },
      {
        test: /\.s[ac]ss$/i,
        use: [
          'style-loader',
          'css-loader',
          'sass-loader',
        ],
      },
    ]
  },
  resolve: {
    extensions: ['.ts', '.vue', '.json', '.js'],
    alias: {
      '@app': path.resolve(__dirname, 'resources/views/app/'),
      '@modules': path.resolve(__dirname, 'resources/views/modules/'),
      '@core': path.resolve(__dirname, 'resources/views/app/core/'),
      '@shared': path.resolve(__dirname, 'resources/views/app/shared/'),
      '@services': path.resolve(__dirname, 'resources/views/app/business-logic/services/'),
      '@models': path.resolve(__dirname, 'resources/views/app/shared/models/')
    }
  }
});


mix.js('resources/views/app/modules/client/app.module.ts', 'public/js/app.js');
mix.js('resources/views/app/modules/admin/app.module.ts', 'public/js/app-admin.js');
// mix.sass('resources/assets/styles/cart-animation.scss', 'public/css').options({
//   processCssUrls: false
// });

// if (mix.inProduction()) {
//     mix.version();
//  }

mix.version();

