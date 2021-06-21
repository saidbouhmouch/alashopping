$(document).ready(function(){
    $('.lazy').lazy({
            delay: 200,
            beforeLoad: function(element) {
                console.log('lazy beforeLoad');
                    var width= $(document).width();
                    if($(element).attr('data-resize')=='true'){
                    // array size=[{type : sm , size : }]  xs=320 , sm=600 , md=800 , lg= 1000, xl=1200

                        if(width < 400){
                            $(element).attr('data-src',$(element).attr('data-xs'));
                        } else if(width < 600){
                            $(element).attr('data-src',$(element).attr('data-sm'));
                        }else if(width < 800){
                            $(element).attr('data-src',$(element).attr('data-md'));
                        }else if(width < 1000){
                            $(element).attr('data-src',$(element).attr('data-lg'));
                        }
                        else if(width < 1200){
                            $(element).attr('data-src',$(element).attr('data-xl'));
                        }
                        else {
                            $(element).attr('data-src',$(element).attr('data-defaults'));
                        }
                    }

            },
            afterLoad: function(element) {
                        //var imageSrc = element.data('src');
            },
            onError: function(element) {},
            onFinishedAll: function() {},
            asyncLoader: function(element, response){}
         });


         // responsive gallery

            //      $.each($('#lightgallery .gallery '),function(index,val){
            //         var width= $(document).width();
            //      if(width < 400){
            //       $(val).attr('data-src', $(val).attr('data-phone'));
            //      } else if(width < 768){
            //       $(val).attr('data-src', $(val).attr('data-tablet'));
            //      }else if(width < 992){
            //       $(val).attr('data-src', $(val).attr('data-desktop-m'));
            //      }else if(width < 1200){
            //       $(val).attr('data-src', $(val).attr('data-desktop-l'));
            //      }else {
            //       $(val).attr('data-src', $(val).attr('data-defaults'));
            //      }
            //   });

            function sliderSrcChange(attr) {
                $.each($('#slider-container .lazy'),function(index,val){
                    $(val).css('background-image',"url("+$(val).attr(attr)+")");
                 });
            }
            // slider
            var widthScreen= $(document).width();
            if(widthScreen < 400){
                sliderSrcChange('data-xs');
            } else if(widthScreen < 600){
                sliderSrcChange('data-sm');
            }else if(widthScreen < 800){
                sliderSrcChange('data-md');
            }else if(widthScreen < 1000){
                sliderSrcChange('data-lg');
            }
            else if(widthScreen < 1200){
                sliderSrcChange('data-xl');
            }
            else {
                sliderSrcChange('data-defaults');
            }


            // <div class="bg lazy"  data-bg="{{asset($slider->image->children->where('size','xs')->first()->url).$version}}"
            //                         data-scrollax="properties: { translateY: '200px' }"
            //                         data-resize="true"
            //                         data-xs="{{asset($slider->image->children->where('size','xs')->first()->url).$version}}"
            //                         data-sm="{{asset($slider->image->children->where('size','sm')->first()->url).$version}}"
            //                         data-md="{{asset($slider->image->children->where('size','md')->first()->url).$version}}"
            //                         data-lg="{{asset($slider->image->children->where('size','lg')->first()->url).$version}}"
            //                         data-xl="{{asset($slider->image->children->where('size','xl')->first()->url).$version}}"
            //                         data-defaults="{{asset($slider->image->url).$version}}"
            //                         ></div>


})