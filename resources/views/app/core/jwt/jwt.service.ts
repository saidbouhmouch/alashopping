import * as jwt from 'jsonwebtoken';

export class JwtService {

    decrypt(token) {
        return jwt.verify(token, "secret", { algorithms: ['HS256'] });
    }

    encode(context) {
        var signOptions = {
            expiresIn: 86400,
            algorithm: "HS256",
            data: JSON.stringify(context)
        };
        return jwt.sign(signOptions, 'secret');
    }

}