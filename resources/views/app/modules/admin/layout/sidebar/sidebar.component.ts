import { Component, Vue } from 'vue-property-decorator'
declare const _: any;

@Component
export default class SideBarComponent extends Vue {

    sidebar: Array<object> = [
        {
            id: "1",
            text: "Dashboard",
            icon: "fa fa-dashboard",
            expanded: false,
            active: false,
            url: { path: '/admin/dashboard' }

        }, {
            id: "2",
            text: "Shop",
            icon: "ti-shopping-cart",
            expanded: false,
            active: false,
            children: [
                {
                    id: "1",
                    text: "Products",
                    icon: "fa fa-cube",
                    url: { path: '/admin/products' },
                    active: false,
                },
                {
                    id: "2",
                    text: "Categories",
                    icon: "ti-bookmark",
                    url: { path: '/admin/categories' },
                    active: false,
                },
                {
                    id: "3",
                    text: "Tags",
                    icon: "ti-pin-alt",
                    url: { path: '/admin/tags' },
                    active: false,
                }
            ]

        },
        {
            id: "3",
            text: "Delivery Configuration",
            icon: "fa fa-truck",
            expanded: false,
            active: false,
            children: [
                {
                    id: "1",
                    text: "Carriers",
                    icon: "fa fa-truck",
                    url: { path: '/admin/carriers' },
                    active: false,
                },
                {
                    id: "2",
                    text: "Shipping",
                    icon: "fa fa-exchange",
                    url: { path: '/admin/shipping' },
                    active: false,
                }
            ]

        },
        {
            id: "4",
            text: "Payment and Taxes",
            icon: "fa fa-credit-card",
            expanded: false,
            active: false,
            children: [
                {
                    id: "1",
                    text: "Taxes",
                    icon: "fa fa-balance-scale",
                    url: { path: '/admin/taxes' },
                    active: false,
                },
                {
                    id: "2",
                    text: "Currencies",
                    icon: "fa fa-money",
                    url: { path: '/admin/currencies' },
                    active: false,
                },
                {
                    id: "3",
                    text: "Type Payment",
                    icon: "fa fa-credit-card",
                    active: false,
                    url: { path: '/admin/type-payment' }
                }
            ]
        },
        {
            id: "5",
            text: "Specific Prices",
            icon: "fa fa-money",
            expanded: false,
            active: false,
            url: { path: '/admin/specific-prices' }
        },
        {
            id: "6",
            text: "Users, Roles",
            icon: "ti-user",
            expanded: false,
            active: false,
            children: [
                {
                    id: "1",
                    text: "Users",
                    icon: "ti-user",
                    url: { path: '/admin/users' },
                    active: false,
                },
                {
                    id: "2",
                    text: "Roles",
                    icon: "fa fa-users",
                    url: { path: '/admin/users' },
                    active: false,
                }
            ]

        }

    ]

    onParentClick(item: any) {
        _.forEach(this.sidebar, (item: any) => {
            item.expanded = false;
            item.active = false;
        });
        item.expanded = true;
        item.active = true;
    }
}

