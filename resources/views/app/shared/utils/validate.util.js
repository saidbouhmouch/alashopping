import {logger} from "@core/logger/logger.service";


/**
 * Validate 
 */
export const validate = {

    errors: false,

    validations(obj) {
        this.errors = false;
        const errors = {};
        const keys = Object.keys(obj.rules())
        const attributeRules = obj.rules();

        _.forEach(keys, (key) => {

            if (!this.hasProperty(obj, key)) {
                logger.error(`${key} is undefined in ${obj.constructor.name}`);
            } else {
                /** required */
                if (this.hasProperty(attributeRules[key], "required")) {
                    if (attributeRules[key].required) {
                        if (!this.required(obj[key])) {
                            this.errors = true;
                            errors[key] ={required : true , message : "Please fill in the required field."};
                        }
                    }
                }

                /** minLength */
               else if (this.hasProperty(attributeRules[key], "minLength")) {
                    if (!this.minLength(obj[key], attributeRules[key].minLength)) {
                        errors[key] = {minLength : true };
                        this.errors = true;
                    }
                }
            }


        });

        obj.errors = errors;
        return this.errors;
    },
    hasProperty(obj, property) {
        return _.has(obj, property);
    },
    required(val) {
        return (val != '') ? true : false;
    },
    minLength(property, number) {
        if (typeof property !== "string") {
            throw `${key} not string`;
        }
        return (property.length > number) ? true : false;
    }

}

