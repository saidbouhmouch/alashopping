
export const environment = {
    appName : 'MYAPP',
    production: process.env.NODE_ENV === 'production'?true : false,
    version: '1',
    serverUrl: '/',
    envName: 'DEV',
    apiUrl:'/api/',
    timeout: 60000,
    language: 'en',
    defaultLanguage: 'en',
    supportedLanguages: ['en']
  };
  