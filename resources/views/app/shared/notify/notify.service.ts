/**
 * Notify 
 */

import Swal from 'sweetalert2'

export const notify = {


    topEnd(icon,title,text,showConfirmButton,timer){
      Swal.fire(
        title,
        text,
        icon
      )
        // Swal.fire({
        //     position: 'top-end',
        //     icon, //'success'
        //     text,
        //     title, //'Your work has been saved'
        //     showConfirmButton, // false
        //     timer,
        //     width : 250,
        //     showClass: {
        //         popup: 'animate__animated  animate__fadeOutUp'
        //       },
        //       hideClass: {
        //         popup: 'animate__animated animate__fadeOutUp'
        //       }
        //   })
    }


}

