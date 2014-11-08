From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2] i2c: mux: create proper topology in sysfs
Date: Sat,  8 Nov 2014 18:50:19 +0100
Message-ID: <1415469019-7608-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>, Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The current implementation creates muxed i2c-<n> busses as immediate
children of their i2c-<n> parent bus. In case of multiple muxes on one
bus, it is impossible to determine which muxed bus comes from which mux.

Change the topology so that they are created under the corresponding mux
device. This way, multiple muxes on the same segment can coexist and
children busses are grouped accordingly.

So for instance, by adding a pca9547 device with address 0x70 to
bus i2c-0, instead of:

/sys/class/i2c-dev/i2c-0/device/i2c-1
...
/sys/class/i2c-dev/i2c-0/device/i2c-8

we get:

/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-1
...
/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-8

Symlinks for backward compatibility are provided.

Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

[wsa: Ported to top-of-tree (1 line left :)) and added the compatibility
links.]
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
Cc: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

In this version, the code snipplet I sent Guenter is already folded in.

 drivers/i2c/i2c-mux.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 2d0847b6be62..d05208232b07 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -138,7 +138,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
-	priv->adap.dev.parent = &parent->dev;
+	priv->adap.dev.parent = mux_dev;
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 
@@ -183,6 +183,12 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 		return NULL;
 	}
 
+	/* If necessary, create symlink to match old mux name scheme */
+	if (mux_dev != &parent->dev)
+		WARN(sysfs_create_link(&parent->dev.kobj, &priv->adap.dev.kobj,
+					dev_name(&priv->adap.dev)),
+					"can't create compatibility link for old mux name scheme\n");
+
 	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
 		 i2c_adapter_id(&priv->adap));
 
@@ -194,6 +200,8 @@ void i2c_del_mux_adapter(struct i2c_adapter *adap)
 {
 	struct i2c_mux_priv *priv = adap->algo_data;
 
+	if (adap->dev.parent != &priv->parent->dev)
+		sysfs_remove_link(&priv->parent->dev.kobj, dev_name(&adap->dev));
 	i2c_del_adapter(adap);
 	kfree(priv);
 }
-- 
2.1.1
