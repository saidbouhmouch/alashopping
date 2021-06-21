#  custom ecommerce on Lumen and VueJs  .
## What's new?
- Clients Management (including addresses and companies)
- Specific Prices for products
- Cart Rules
- Orders
- Notification Templates
- Users Management
- Roles & Permissions

## All Features
- Create and organize categories & subcategoires
- Create currencies
- Create carriers
- Create taxes and use them on products
- Create order statuses
- Create products and upload product multiple images at once, using dropzone
- Ability to create product groups
- Ability to clone a product
- Add Clients
- See orders & change order statuses that will notify users via e-mail
- Add / Edit Notification templates
- Create users with different roles & permissions
- Create cart rules
- Create Specific prices

## Installation
- Clone repository
```
$ git clone https://github.com/sbouhmouch/Lumen-vuejs-ecommerce.git
```
- Run in your terminal
```
$ composer install
$  php -S localhost:8000 -t public
```
- Setup database connection in .env file
```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=homestead
DB_USERNAME=homestead
DB_PASSWORD=secret
```

## Do not forget to add in your env file following lines:
```
ADMIN_ROLE_NAME=administrator
CLIENT_ROLE_NAME=client
```

- Migrate tables and seed with demo data
```
$ php artisan migrate --seed
```

- Access it on
```
http://localhost:8000/admin/login
```

## Known 
- Product image uploader - responsive

## License

The Lumen framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
