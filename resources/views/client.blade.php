<!doctype html>
<html>
   <head>
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="csrf-token" content="{{ app('request')->session()->get('_token') }}">
      <title>Vue and Lumen</title>
      <link rel="stylesheet" href="{{url('css/app.css'.$version)}}" />
      <link rel="stylesheet" href="{{url('css/cart-animation.css'.$version)}}" />
      <link rel="stylesheet" href="{{url('css/tailwind-build.css'.$version)}}">
   </head>
   <body>
      <div id="app">
         <app-main></app-main>
      </div>

    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" integrity="sha512-qTXRIMyZIFb8iQcfjXWCO8+M5Tbc38Qi5WzdPOYZHIlZpzBHG3L3by84BBBOiRGiEb7KKtAOAs5qYdUiZiQNNQ==" crossorigin="anonymous"></script>
    <script defer src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>
    <script defer src="{{'/js/plugins.js'.$version}}"></script>
    <script defer src="{{'/js/app.js'.$version}}"></script>
    <script defer src="{{'/js/custom-script.js'.$version}}"></script>
    <script defer type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/jquery.lazy.min.js"></script>
    <script defer type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.10/jquery.lazy.plugins.min.js"></script>  
    <script defer type="text/javascript" src="{{url('js/lazy.js').$version}}"></script> 
   </body>
</html>
