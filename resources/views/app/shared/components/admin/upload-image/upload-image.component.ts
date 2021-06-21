import { Component, Vue, Prop } from 'vue-property-decorator'
import { UploadFileService } from '../../../../business-logic'
import { notify } from '../../../notify'

@Component
export default class UplaodImage extends Vue {

    @Prop() picture!: string;
    @Prop() id?: number; // for galleries update
    url: any;
    uploadFileService = new UploadFileService();
    isLoading: boolean = false;


    constructor() {
        super();
    }


    onClickUploadOverlay(event) {
        event.preventDefault();
        const element: any = this.$refs.inputFile;
        element.click();
    }


    uploadImage(e) {
        this.isLoading = true;
        const image = e.target.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(image);
        reader.onload = (e: any) => {
            const name = image.name.substring(0, image.name.lastIndexOf('.'));
            const response: any = { url: e.target.result, name, type: image.type };
            if (this.id !== undefined) {
                response.id = this.id;
            }
            this.uploadFileService.uploadFile(response).then((resp : any) => {
                this.url = resp.data.url;
                response.url = resp.data.url;
                this.$emit('changePicture', response);
                this.isLoading = false;
            }).catch((error) => {
                this.url = '';
                notify.topEnd("error", "Error", "Ops!! upload failed. Try Again", true, 5000);
                this.isLoading = false;
            });
            
        };
    }

    created() { }

    mounted() { }
}


