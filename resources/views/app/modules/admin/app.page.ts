import { Component, Vue } from 'vue-property-decorator'
import { environment} from "../../core";

@Component
export default class AppPage extends Vue {
   constructor(){
       super();
        environment.apiUrl+='admin/';
   }
}