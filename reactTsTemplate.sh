#!/bin/bash
mkdir build
mkdir src



echo "<html>
  <head>
    <meta charset=\"utf-8\" />
  </head>
  <body>
    <div id=\"root\"></div>
    <script src=\"main.js\"></script>
  </body>
</html>" > "$PWD/build/index.html"

echo "{
  \"name\": \"my-app\",
  \"version\": \"0.0.1\"
}" > "$PWD/package.json"

npm install react react-dom
npm install --save-dev typescript
npm install --save-dev @types/react @types/react-dom

echo "{
  \"compilerOptions\": {
    \"lib\": [\"dom\", \"dom.iterable\", \"esnext\"],
    \"allowJs\": true,
    \"allowSyntheticDefaultImports\": true,
    \"skipLibCheck\": true,
    \"esModuleInterop\": true,
    \"strict\": true,
    \"forceConsistentCasingInFileNames\": true,
    \"moduleResolution\": \"node\",
    \"resolveJsonModule\": true,
    \"isolatedModules\": true,
    \"noEmit\": true,
    \"jsx\": \"react\"
  },
  \"include\": [\"src\"]
}" > "$PWD/tsconfig.json"

echo "import React from \"react\";
import ReactDOM from \"react-dom\";

const App = () => (
  <h1>My React and TypeScript App!</h1>
);

ReactDOM.render(
  <App />,
  document.getElementById(\"root\")
);" > "$PWD/src/index.tsx"


npm install --save-dev @babel/core @babel/preset-env @babel/preset-react @babel/preset-typescript @babel/plugin-transform-runtime @babel/runtime

echo "{
  \"presets\": [
    \"@babel/preset-env\",
    \"@babel/preset-react\",
    \"@babel/preset-typescript\"
  ],
  \"plugins\": [
    [
      \"@babel/plugin-transform-runtime\",
      {
        \"regenerator\": true
      }
    ]
  ]
}" > "$PWD/.babelrc"

npm install --save-dev eslint eslint-plugin-react eslint-plugin-react-hooks @typescript-eslint/parser @typescript-eslint/eslint-plugin


echo "{
  \"parser\": \"@typescript-eslint/parser\",
  \"parserOptions\": {
    \"ecmaVersion\": 2018,
    \"sourceType\": \"module\"
  },
  \"plugins\": [
    \"@typescript-eslint\",
    \"react-hooks\"
  ],
  \"extends\": [
    \"plugin:react/recommended\",
    \"plugin:@typescript-eslint/recommended\"
  ],
  \"rules\": {
    \"react-hooks/rules-of-hooks\": \"error\",
    \"react-hooks/exhaustive-deps\": \"warn\",
    \"react/prop-types\": \"off\"
  },
  \"settings\": {
    \"react\": {
      \"pragma\": \"React\",
      \"version\": \"detect\"
    }
  }
}" > "$PWD/.eslintrc.json"

npm install --save-dev webpack webpack-cli @types/webpack
npm install --save-dev webpack-dev-server @types/webpack-dev-server
npm install --save-dev babel-loader
npm install --save-dev ts-node

echo "/* eslint-disable indent */
// eslint-disable-next-line @typescript-eslint/no-var-requires
const path = require('path');

module.exports = {
  entry: './src/index.tsx',
  module: {
    rules: [
      {
        test: /\.(ts|js)x?$/,
        exclude: /node_modules/,
        use: [{
          loader: \"babel-loader\",
          options: {
            presets: [
              \"@babel/preset-env\",
              \"@babel/preset-react\",
              \"@babel/preset-typescript\",
            ],
          },
        }],
      },
    ],
  },
  resolve: {
    extensions: [\".tsx\", \".ts\", \".js\"],
  },
  output: {
    path: path.resolve(__dirname, \"build\"),
    filename: \"main.js\",
  },
  devServer: {
    contentBase: path.join(__dirname, \"build\"),
    compress: true,
    port: 4000,
  },
};" > "$PWD/webpack.config.js"

npm install --save-dev fork-ts-checker-webpack-plugin @types/fork-ts-checker-webpack-plugin

echo "{
  \"name\": \"my-app\",
  \"version\": \"0.0.1\",
  \"dependencies\": {
    \"react\": \"^17.0.1\",
    \"react-dom\": \"^17.0.1\"
  },
  \"scripts\": {
    \"start\": \"webpack serve\",
    \"build\": \"webpack --mode production\"
  },
  \"devDependencies\": {
    \"@babel/core\": \"^7.12.10\",
    \"@babel/plugin-transform-runtime\": \"^7.12.10\",
    \"@babel/preset-env\": \"^7.12.11\",
    \"@babel/preset-react\": \"^7.12.10\",
    \"@babel/preset-typescript\": \"^7.12.7\",
    \"@babel/runtime\": \"^7.12.5\",
    \"@types/fork-ts-checker-webpack-plugin\": \"^0.4.5\",
    \"@types/react\": \"^17.0.0\",
    \"@types/react-dom\": \"^17.0.0\",
    \"@types/webpack\": \"^4.41.25\",
    \"@typescript-eslint/eslint-plugin\": \"^4.12.0\",
    \"@typescript-eslint/parser\": \"^4.12.0\",
    \"babel-loader\": \"^8.2.2\",
    \"eslint\": \"^7.17.0\",
    \"eslint-plugin-react\": \"^7.22.\",
    \"eslint-plugin-react-hooks\": \"^4.2.0\",
    \"fork-ts-checker-webpack-plugin\": \"^6.0.8\",
    \"ts-node\": \"^9.1.1\",
    \"typescript\": \"^4.1.3\",
    \"webpack\": \"^5.11.1\",
    \"webpack-cli\": \"^4.3.1\",
    \"webpack-dev-server\": \"^3.11.1\"
  }
}" > "$PWD/package.json"