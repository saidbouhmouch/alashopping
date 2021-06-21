import { CredentialsService } from './';
import { HttpService, JwtService } from '../'
import { ILoginContext, ICredentials } from '../../shared/'


export class AuthenticationService {

  credentialsService: any = new CredentialsService();
  jwtService: any = new JwtService();
  httpService: any = new HttpService();

  constructor() {
    this.httpService.resourceName = '';
  }


  /**
   * Authenticates the user.
   * @param context The login parameters.
   * @return The user credentials.
   */

  login(context: ILoginContext): Promise<any> {
    context = this.jwtService.encode(context);
    return this.httpService.post('login', context)
  }

  /**
   * Logs out the user and clear credentials.
   * @return True if the user was logged out successfully.
   */
  logout(): Promise<any> {
    return this.httpService.get('logout')
  }

  getToken(){
      this.credentialsService.getCredentials();
        let credentials: any = this.credentialsService.credentials
        if (credentials) {
          return credentials.token;
        }
        return null;
  }

  setCredentials(token: any){
      const _token = this.jwtService.decrypt(token);
      const credentials: ICredentials = {
        username: _token.email,
        token: token,
        remember: _token.remember
      }
      this.credentialsService.setCredentials(credentials);
  }

  destroyToken() {
    this.credentialsService.setCredentials();
  }

}
