From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 7/7] i2c: core: hand over reserved devices when requesting ancillary addresses
Date: Thu, 20 Feb 2020 18:24:03 +0100
Message-ID: <20200220172403.26062-8-wsa+renesas@sang-engineering.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-i3c@lists.infradead.org, Kieran Bingham <kieran@ksquared.org.uk>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Luca Ceresoli <luca@lucaceresoli.net>, Jacopo Mondi <jacopo@jmondi.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vladimir Zapolskiy <vz@mleia.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

With i2c_new_ancillary_address, we can check if the intended driver is
requesting a reserved address. Update the function to do these checks.
If the check passes, the "reserved" device will become a regular "dummy"
device.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4000a4384306..ba325f8107a3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -975,6 +975,8 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
 						u16 default_addr)
 {
 	struct device_node *np = client->dev.of_node;
+	struct device *reserved_dev, *adapter_dev = &client->adapter->dev;
+	struct i2c_client *reserved_client;
 	u32 addr = default_addr;
 	int i;
 
@@ -984,7 +986,21 @@ struct i2c_client *i2c_new_ancillary_device(struct i2c_client *client,
 			of_property_read_u32_index(np, "reg", i, &addr);
 	}
 
-	dev_dbg(&client->adapter->dev, "Address for %s : 0x%x\n", name, addr);
+	dev_info(adapter_dev, "Address for %s : 0x%x\n", name, addr);
+
+	/* No need to scan muxes, siblings must sit on the same adapter */
+	reserved_dev = device_find_child(adapter_dev, &addr, __i2c_check_addr_busy);
+	reserved_client = i2c_verify_client(reserved_dev);
+
+	if (reserved_client) {
+		if (reserved_client->dev.of_node != np ||
+		    strcmp(reserved_client->name, I2C_RESERVED_DRV_NAME) != 0)
+			return ERR_PTR(-EBUSY);
+
+		strlcpy(reserved_client->name, I2C_DUMMY_DRV_NAME, sizeof(client->name));
+		return reserved_client;
+	}
+
 	return i2c_new_dummy_device(client->adapter, addr);
 }
 EXPORT_SYMBOL_GPL(i2c_new_ancillary_device);
-- 
2.20.1
