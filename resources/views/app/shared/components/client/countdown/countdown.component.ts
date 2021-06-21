import { Component, Vue, Prop } from 'vue-property-decorator'

declare const moment: any;

@Component
export default class CountDownComponent extends Vue {

    @Prop() expirationDate!: string;
    days: number = 0;
    hours: number = 0;
    minutes: number = 0;
    seconds: number = 0;
    isShow : boolean = false;

    constructor() {
        super();
    }

    countDown(){
            const second = 1000,
                  minute = second * 60,
                  hour = minute * 60,
                  day = hour * 24;
            
                let expirationDate = new Date(this.expirationDate).getTime(),
                x = setInterval(()=>{    
                    this.isShow = true;
                    let now = new Date().getTime(),
                      distance = expirationDate - now;
          
                    this.days = Math.floor(distance / (day)),
                    this.hours = Math.floor((distance % (day)) / (hour)),
                    this.minutes = Math.floor((distance % (hour)) / (minute)),
                    this.seconds = Math.floor((distance % (minute)) / second);
          
                  if (distance < 0) {
                    this.isShow = false;
                    clearInterval(x);
                  }
                }, 0)
       
    }

    created() {
    }

    mounted() { 
        this.countDown();
    }

    destroyed() {
    }

}




