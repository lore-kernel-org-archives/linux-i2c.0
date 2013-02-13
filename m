From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] i2c-mux: create "channel-n" symlinks for child segments
Date: Wed, 13 Feb 2013 23:28:32 +0100
Message-ID: <1360794512-6338-3-git-send-email-gerlando.falauto@keymile.com>
References: <1360794512-6338-1-git-send-email-gerlando.falauto@keymile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360794512-6338-1-git-send-email-gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: giometti-k2GhghHVRtY@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For instance, by adding a pca9547 device with address 0x70 to
bus i2c-0, you get

/sys/class/i2c-dev/i2c-0/device/0-0070/channel-0 -> i2c-1
...
/sys/class/i2c-dev/i2c-0/device/0-0070/channel-7 -> i2c-8

Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/i2c-mux.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 01b8f8e..c984862 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -96,6 +96,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 {
 	struct i2c_mux_priv *priv;
 	int ret;
+	char symlink_name[12];
 
 	priv = kzalloc(sizeof(struct i2c_mux_priv), GFP_KERNEL);
 	if (!priv)
@@ -142,6 +143,17 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
+	snprintf(symlink_name, sizeof(symlink_name), "channel-%d", chan_id);
+	ret = sysfs_create_link(&parent_device->kobj,
+				&priv->adap.dev.kobj,
+				symlink_name);
+	if (ret)
+		dev_err(parent_device, "Failed creating symlink %s\n",
+			symlink_name);
+	else
+		dev_info(parent_device, "Created symlink %s\n",
+			symlink_name);
+
 	return &priv->adap;
 }
 EXPORT_SYMBOL_GPL(i2c_add_mux_adapter);
@@ -150,6 +162,11 @@ int i2c_del_mux_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 	int ret;
+	char symlink_name[12];
+
+	snprintf(symlink_name, sizeof(symlink_name), "channel-%d", priv->chan_id);
+
+	sysfs_delete_link(&adap->dev.parent->kobj, &priv->adap.dev.kobj, symlink_name);
 
 	ret = i2c_del_adapter(adap);
 	if (ret < 0)
-- 
1.7.10.1
