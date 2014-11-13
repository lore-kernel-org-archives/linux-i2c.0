From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v3 2/2] i2c: mux: create "channel-n" symlinks for child segments in the mux device
Date: Thu, 13 Nov 2014 14:39:56 +0100
Message-ID: <1415885996-14770-2-git-send-email-wsa@the-dreams.de>
References: <1415885996-14770-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415885996-14770-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

This makes the topology clearer. For instance, by adding a pca9547
device with address 0x70 to bus i2c-0, you get:

/sys/class/i2c-dev/i2c-0/device/0-0070/channel-0 -> i2c-1
...
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-7 -> i2c-8

Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
[wsa: simplified sysfs-usage and fixed format string usage]
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
---
 drivers/i2c/i2c-mux.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index f246a9f7dd22..593f7ca9adc7 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -110,6 +110,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 						 void *, u32))
 {
 	struct i2c_mux_priv *priv;
+	char symlink_name[20];
 	int ret;
 
 	priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
@@ -186,6 +187,9 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	WARN(sysfs_create_link(&priv->adap.dev.kobj, &mux_dev->kobj, "mux_device"),
 			       "can't create symlink to mux device\n");
 
+	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
+	WARN(sysfs_create_link(&mux_dev->kobj, &priv->adap.dev.kobj, symlink_name),
+			       "can't create symlink for channel %u\n", chan_id);
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
@@ -196,6 +200,10 @@ EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
 void i2c_del_mux_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
+	char symlink_name[20];
+
+	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", priv->chan_id);
+	sysfs_remove_link(&adap->dev.parent->kobj, symlink_name);
 
 	sysfs_remove_link(&priv->adap.dev.kobj, "mux_device");
 	i2c_del_adapter(adap);
-- 
2.1.1
