module.exports = (config) ->
  config.set
    
    basePath: ""
    
    frameworks: ["jasmine"]

    preprocessors:
      "src/**/*.coffee": ["coverage"]
      "test/**/*.coffee": ["coffee"]

    files: [
      "src/**/*.coffee"
      "test/**/*Spec.coffee"
      "node_modules/lodash/lodash.js"
      "node_modules/chance/chance.js"
    ]
    
    exclude: []
    
    reporters: ["progress","coverage"]

    coverageReporter:
      type: 'html'
      dir: 'coverage'
    
    port: 9876
    
    colors: true
    
    logLevel: config.LOG_INFO
    
    autoWatch: true
    
    browsers: ["PhantomJS"]
    
    captureTimeout: 60000
    
    singleRun: false


