# Multi-Inventory

## Pre-requisites and setup

### Commercial Plugin

As MultiInventory is part of the Commercial plugin, it requires an existing Shopware 6 installation and the activated Commercial plugin on top. The plugin can be installed following these [install instructions](../../../../guides/plugins/plugins/plugin-base-guide#install-your-plugin). In addition, the MultiInventory feature requires [Shopware Beyond](https://docs.shopware.com/en/shopware-6-en/features/shopware-beyond).

### Admin UI

While this feature is supposed to be used API first, e.g. by ERP systems, it still comes with an user interface for the administration. If you're looking for user documentation, [please head here](https://docs.shopware.com/en/shopware-6-en/extensions).

### Admin API

To create, alter and/or delete warehouse groups, warehouses and other things related to MultiInventory, you can access Admin API endpoints decscribed in the following paragraphs. The following links provide further documentation regarding the general use of the Admin API.

* [Authentication & Authorization](https://shopware.stoplight.io/docs/admin-api/ZG9jOjEwODA3NjQx-authentication)
* [Request & Response Structure](https://shopware.stoplight.io/docs/admin-api/ZG9jOjEyMzAzNDU1-request-and-response-structure)
* [Endpoint Structure](https://shopware.stoplight.io/docs/admin-api/ZG9jOjEyMzA1ODA5-endpoint-structure)

---

## Working with the API

The following examples contain payloads for typical use-cases of this feature. Basically all new entities fully support the Admin API via sync service or their generic entity endpoints. When working with Product entities, it is recommended to use the SyncService to also include `product.version_id`

### Creating or Updating a WarehouseGroup and assigning an existing Warehouse

```json

// POST /api/warehouse-group
// PATCH /api/warehouse-group/8cf7736855594501aaf86351e147c61e

{
    "id": "8cf7736855594501aaf86351e147c61e",
    "name": "Group A",
    "description": "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore.",
    "priority": 25,
    "ruleId": "93248b220a064424a1f6e90010820ba2",
    "warehouses":  [{
        "id": "4ce2bd36d2824153812fcb6a97f22d22"
    }]
}
```

### Creating or Updating a Warehouse and assigning it to existing WarehouseGroups

```json

// POST /api/warehouse
// PATCH /api/warehouse/4ce2bd36d2824153812fcb6a97f22d22

{
    "id": "4ce2bd36d2824153812fcb6a97f22d22",
    "name": "Warehouse A",
    "groups": [{
        "id": "8cf7736855594501aaf86351e147c61e"
    }, {
        "id": "4154501a3812fcb6a501aaf8c7736855"
    }]
}
```

### Assigning WarehouseGroups to Products, creating ProductWarehouses via assocation

```json

// POST /api/_action/sync

[{
    "action": "upsert",
    "entity": "product",
    "payload": [{
        "id": "86d38702be7e4ac9a941583933a1c6f5",
        "versionId": "0fa91ce3e96a4bc2be4bd9ce752c3425",
        "warehouseGroups": [{
            "id": "8cf7736855594501aaf86351e147c61e"
        }],
        "warehouses": [{
            "id": "f5c850109fe64c228377cbd369903b75",
            "productId": "86d38702be7e4ac9a941583933a1c6f5",
            "productVersionId": "0fa91ce3e96a4bc2be4bd9ce752c3425",
            "warehouseId":"4ce2bd36d2824153812fcb6a97f22d22",
            "stock": 0
        }]
    }]
}]
```

### Updating ProductWarehouse stocks

You can update `product_warehouse.stock` in a batch via SyncApi, or patch a specific entity directly via entity repository.

```json

// POST /api/_action/sync

[{
    "action": "upsert",
    "entity": "product_warehouse",
    "payload": [{
        "id": "f5c850109fe64c228377cbd369903b75",
        "stock": 1500
    }, {
        "id": "228377cbd369903b75f5c850109fe64c",
        "stock": 0
    }]
}]

// PATCH /api/product-warehouse/f5c850109fe64c228377cbd369903b75

{
    "id": "f5c850109fe64c228377cbd369903b75",
    "stock": 1500
}
```

## Concept

### ERP System as Single-Source-of-Truth

* Intended to be used via API and custom-built adapter
* Recommended update frequency?

### Product Availability

* Products, WarehouseGroups & Rules
* WarehouseGroup priorities

### Warehouse stocks

* Products & Warehouses

### Reducing stocks after order placement

* Warehouse priorities
* Order state changes
    * Returns, Cancellation

## Caveats

When working with the MultiInventory feature, there are some caveats to keep in mind

* We decided to **not** add the functionality of `product.available_stock` to MultiInventory. The stock of `Products` (or rather `ProductWarehouses`) will now be reduced immediately after an order was placed. It is no longer necessary to set any order state (for `Products` assigned to `WarehouseGroups`) to reduce the stock.
  * Order states are still important for any other workflow, e.g. FlowBuilder triggers, or event subscribers in general.
* MultiInventory will not recalculate the stock of `Products` assigned to `WarehouseGroups` when editing existing orders in any way. The whole stock handling in this regard is supposed to be done by an external ERP system, the information then need to be pushed to your Shopware instance (e.g. by regular syncs).
* If you decide to stop using MultiInventory for certain products (deleting existing data or deactivating the feature), Shopware will fall back into its default behavior. This is especially important when editing existing orders, since the stocks were taken from `ProductWarehouse` entities. Shopware will use falsy data to increase/decrease `Product` stocks, if the order originally included `ProductWarehouses`.
