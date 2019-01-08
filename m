From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [RFC 1/4] i2c: core: let adapters be notified of client attach/detach
Date: Tue,  8 Jan 2019 23:39:50 +0100
Message-ID: <20190108223953.9969-2-luca@lucaceresoli.net>
References: <20190108223953.9969-1-luca@lucaceresoli.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108223953.9969-1-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@aim-sportline.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, jacopo mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
List-Id: linux-i2c@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@aim-sportline.com>

An adapter might need to know when a new device is about to be
added. This will soon bee needed to implement an "I2C address
translator" (ATR for short), a device that propagates I2C transactions
with a different slave address (an "alias" address). An ATR driver
needs to know when a slave is being added to find a suitable alias and
program the device translation map.

Add an attach/detach callback pair to allow adapter drivers to be
notified of clients being added and removed.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++++
 include/linux/i2c.h         |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..4f8776e065ce 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -778,6 +778,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 		}
 	}
 
+	if (adap->attach_ops &&
+	    adap->attach_ops->attach_client &&
+	    adap->attach_ops->attach_client(adap, info, client) != 0)
+		goto err_attach_client;
+
 	status = device_register(&client->dev);
 	if (status)
 		goto out_free_props;
@@ -788,6 +793,9 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	return client;
 
 out_free_props:
+	if (adap->attach_ops && adap->attach_ops->detach_client)
+		adap->attach_ops->detach_client(adap, client);
+err_attach_client:
 	if (info->properties)
 		device_remove_properties(&client->dev);
 out_err_put_of_node:
@@ -810,9 +818,17 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
  */
 void i2c_unregister_device(struct i2c_client *client)
 {
+	struct i2c_adapter *adap;
+
 	if (!client)
 		return;
 
+	adap = client->adapter;
+
+	if (adap->attach_ops &&
+	    adap->attach_ops->detach_client)
+		adap->attach_ops->detach_client(adap, client);
+
 	if (client->dev.of_node) {
 		of_node_clear_flag(client->dev.of_node, OF_POPULATED);
 		of_node_put(client->dev.of_node);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..600d136b1056 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -551,6 +551,14 @@ struct i2c_lock_operations {
 	void (*unlock_bus)(struct i2c_adapter *, unsigned int flags);
 };
 
+struct i2c_attach_operations {
+	int  (*attach_client)(struct i2c_adapter *,
+			      const struct i2c_board_info *,
+			      struct i2c_client *);
+	void (*detach_client)(struct i2c_adapter *,
+			      struct i2c_client *);
+};
+
 /**
  * struct i2c_timings - I2C timing information
  * @bus_freq_hz: the bus frequency in Hz
@@ -674,6 +682,7 @@ struct i2c_adapter {
 
 	/* data fields that are valid for all devices	*/
 	const struct i2c_lock_operations *lock_ops;
+	const struct i2c_attach_operations *attach_ops;
 	struct rt_mutex bus_lock;
 	struct rt_mutex mux_lock;
 
-- 
2.17.1
