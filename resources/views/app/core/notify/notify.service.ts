
import { StateService } from '../state/state.service';
import { NotifyEnum } from '../enum/notify.enum';

export  function notify (tittle : string , msg : string ,type:NotifyEnum , time : number ) {
  StateService.$emit('notify', {tittle, msg,type, time});
};
