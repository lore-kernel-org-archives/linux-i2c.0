From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] i2c: allow attaching IRQ resources to i2c_board_info
Date: Wed,  8 Mar 2017 10:41:02 -0800
Message-ID: <20170308184102.29334-2-dmitry.torokhov@gmail.com>
References: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308184102.29334-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Simple integer for interrupt number is not expressive enough, as it does
not convey interrupt trigger type that should be used. Let's allow
attaching array of resources to the board info and have i2c core parse
first IRQ resource and set up interrupt trigger as needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/i2c/i2c-boardinfo.c | 12 ++++++++++++
 drivers/i2c/i2c-core.c      | 30 ++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  4 ++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index 0e285c68b2ff..31186ead5a40 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -90,6 +90,18 @@ int i2c_register_board_info(int busnum, struct i2c_board_info const *info, unsig
 			}
 		}
 
+		if (info->resources) {
+			devinfo->board_info.resources =
+				kmemdup(info->resources,
+					info->num_resources *
+						sizeof(*info->resources),
+					GFP_KERNEL);
+			if (!devinfo->board_info.resources) {
+				status = -ENOMEM;
+				break;
+			}
+		}
+
 		list_add_tail(&devinfo->list, &__i2c_board_list);
 	}
 
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 3897e78e5e9a..34a5115484dd 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1277,6 +1277,32 @@ static void i2c_dev_set_name(struct i2c_adapter *adap,
 		     i2c_encode_flags_to_addr(client));
 }
 
+static int i2c_dev_irq_from_resources(const struct resource *resources,
+				      unsigned int num_resources)
+{
+	struct irq_data *irqd;
+	int i;
+
+	for (i = 0; i < num_resources; i++) {
+		const struct resource *r = &resources[i];
+
+		if (resource_type(r) != IORESOURCE_IRQ)
+			continue;
+
+		if (r->flags & IORESOURCE_BITS) {
+			irqd = irq_get_irq_data(r->start);
+			if (!irqd)
+				break;
+
+			irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
+		}
+
+		return r->start;
+	}
+
+	return 0;
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -1312,7 +1338,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 
 	client->flags = info->flags;
 	client->addr = info->addr;
+
 	client->irq = info->irq;
+	if (!client->irq)
+		client->irq = i2c_dev_irq_from_resources(info->resources,
+							 info->num_resources);
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ec8f866a5656..2cc3988d127b 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -312,6 +312,8 @@ static inline int i2c_slave_event(struct i2c_client *client,
  * @of_node: pointer to OpenFirmware device node
  * @fwnode: device node supplied by the platform firmware
  * @properties: additional device properties for the device
+ * @resources: resources associated with the device
+ * @num_resources: number of resources in the @resources array
  * @irq: stored in i2c_client.irq
  *
  * I2C doesn't actually support hardware probing, although controllers and
@@ -334,6 +336,8 @@ struct i2c_board_info {
 	struct device_node *of_node;
 	struct fwnode_handle *fwnode;
 	const struct property_entry *properties;
+	const struct resource *resources;
+	unsigned int	num_resources;
 	int		irq;
 };
 
-- 
2.12.0.246.ga2ecc84866-goog
