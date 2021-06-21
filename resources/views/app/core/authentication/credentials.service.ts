import { LocalStorageService, JwtService } from '../';
import { ICredentials } from '../../shared';

const credentialsKey = 'TOKEN';

/**
 * Provides storage for authentication credentials.
 * The Credentials interface should be replaced with proper implementation.
 */

export class CredentialsService {

  private _credentials: ICredentials | null = null;
  localStorageService: any = new LocalStorageService();
  jwtService: any = new JwtService();

  constructor() {
    this.getCredentials();
  }

  getCredentials() {
    let savedCredentials = this.localStorageService.getItem(credentialsKey);
    if (savedCredentials && typeof savedCredentials === 'string') {
      savedCredentials = JSON.parse(savedCredentials);
    }
    if (savedCredentials) {
      this._credentials = savedCredentials;
    }
  }

  /**
   * Checks is the user is authenticated.
   * @return True if the user is authenticated.
   */
  isAuthenticated(): boolean {
    return !!this.credentials;
  }

  isAdmin(): boolean {
    const token: any = (this._credentials) ? this.jwtService.decrypt(this._credentials.token) : null;
    if (token && token.role == 'admin') {
      return true;
    }
    return false;
  }

  /**
   * Gets the user credentials.
   * @return The user credentials or null if the user is not authenticated.
   */
  get credentials(): ICredentials | null {
    return this._credentials;
  }

  /**
   * Sets the user credentials.
   * The credentials may be persisted across sessions by setting the `remember` parameter to true.
   * Otherwise, the credentials are only persisted for the current session.
   * @param credentials The user credentials.
   * @param remember True to remember credentials across sessions.
   */
  setCredentials(credentials?: ICredentials) {
    this._credentials = credentials || null;
    if (credentials) {
      this.localStorageService.setItem(credentialsKey, credentials)
    } else {
      this.localStorageService.removeItem(credentialsKey)
    }
  }
}
