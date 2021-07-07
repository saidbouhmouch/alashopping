import { Component, Vue, Prop } from 'vue-property-decorator'
import { ShippingService } from '../../../../../../business-logic/services/shipping.service'
import { IShipping, Shipping } from '../../../../../../shared/models/shipping.model'
import vSelect from "vue-select";
import { ICountry , Country } from '../../../../../../shared/models/country.model';
import { Logger } from "../../../../../../core/logger/logger.service"
import LoadingComponent from '../../../../../../shared/components/loading/loading.component.vue'

declare const _: any;
declare const $: any;

@Component({
  components: {
    vSelect,
    LoadingComponent
  }
})

export default class CartComponent extends Vue {

  @Prop() shipping!: IShipping;
  @Prop() countries!: ICountry[];
  country : ICountry = new Country() ;
  isLoading: boolean = true;
  logger: any = new Logger();
  shippingService: any = new ShippingService();
  shippings: IShipping[] = [];
  //shipping: IShipping = new Shipping();
  shippingSelected: IShipping = new Shipping();

  constructor() {
    super();
  }

  getShippings() {
    this.isLoading = false;
    this.shippingService.getShippingsByZone(this.shippingSelected).then((response) => {
      this.shippings = [];
      _.forEach(response.data.shippings, (shipping) => {
        this.shippings.push(new Shipping(shipping));
      });

      this.isLoading = true;

    }).catch((error) => {
      this.isLoading = true;
      this.logger.error(error);
    });
  }

  onSelectedCountry(country) {
    this.shippingSelected.to.code = country.code;
    this.country = _.find(this.countries, (c : ICountry)=>{ return c.code == country.code  });
    this.getShippings();
  }

  onSelectedShipping(shipping) {
    this.shippingSelected = shipping;
  }

  closeModal() {
    this.$emit('closeModal', true)
  }

  apply() {
    console.log(this.shippingSelected);
    if (this.shippingSelected.to.code != '' && this.shippingSelected.id > 0) {
      this.$emit('shippingSelected', this.shippingSelected);
      this.$emit('closeModal', true);
    };

  }

  created() {
    this.shippingSelected.from.code = this.shipping.from.code;
    this.shippingSelected.to.code = this.shipping.to.code;
    this.shippingSelected.id = this.shipping.id;
    this.country = _.find(this.countries, (c : ICountry)=>{ return c.code == this.shipping.from.code  });
    this.getShippings();
  }

  mounted() { }

  destroyed() { }

}







