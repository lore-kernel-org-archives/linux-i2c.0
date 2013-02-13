From: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] i2c-mux: create mux busses under a different parent device
Date: Wed, 13 Feb 2013 23:28:31 +0100
Message-ID: <1360794512-6338-2-git-send-email-gerlando.falauto@keymile.com>
References: <1360794512-6338-1-git-send-email-gerlando.falauto@keymile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360794512-6338-1-git-send-email-gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: giometti-k2GhghHVRtY@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Current implementation creates i2c-<n> busses as immediate children of their
i2c-<n> parent bus.
Change the topology so that they are created under the corresponding
mux device. This way, multiple muxes on the same segment can coexist
and children busses are grouped accordingly.

So for instance, by adding a pca9547 device with address 0x70 to
bus i2c-0, instead of:

/sys/class/i2c-dev/i2c-0/device/i2c-1
...
/sys/class/i2c-dev/i2c-0/device/i2c-8

you get:

/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-1
...
/sys/class/i2c-dev/i2c-0/device/0-0070/i2c-8

Signed-off-by: Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/i2c-mux.c           |    3 ++-
 drivers/i2c/muxes/gpio-i2cmux.c |    2 +-
 drivers/i2c/muxes/pca9541.c     |    2 +-
 drivers/i2c/muxes/pca954x.c     |    2 +-
 include/linux/i2c-mux.h         |    1 +
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index d7a4833..01b8f8e 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -87,6 +87,7 @@ static u32 i2c_mux_functionality(struct i2c_adapter *adap)
 }
 
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				struct device *parent_device,
 				void *mux_dev, u32 force_nr, u32 chan_id,
 				int (*select) (struct i2c_adapter *,
 					       void *, u32),
@@ -122,7 +123,7 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
-	priv->adap.dev.parent = &parent->dev;
+	priv->adap.dev.parent = parent_device;
 
 	if (force_nr) {
 		priv->adap.nr = force_nr;
diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/gpio-i2cmux.c
index 7b6ce62..c93046e 100644
--- a/drivers/i2c/muxes/gpio-i2cmux.c
+++ b/drivers/i2c/muxes/gpio-i2cmux.c
@@ -105,7 +105,7 @@ static int __devinit gpiomux_probe(struct platform_device *pdev)
 	for (i = 0; i < pdata->n_values; i++) {
 		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
 
-		mux->adap[i] = i2c_add_mux_adapter(parent, mux, nr, i,
+		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr, i,
 						   gpiomux_select, deselect);
 		if (!mux->adap[i]) {
 			ret = -ENODEV;
diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/pca9541.c
index ed699c5..4867d43 100644
--- a/drivers/i2c/muxes/pca9541.c
+++ b/drivers/i2c/muxes/pca9541.c
@@ -353,7 +353,7 @@ static int pca9541_probe(struct i2c_client *client,
 	force = 0;
 	if (pdata)
 		force = pdata->modes[0].adap_id;
-	data->mux_adap = i2c_add_mux_adapter(adap, client, force, 0,
+	data->mux_adap = i2c_add_mux_adapter(adap, &client->dev, client, force, 0,
 					     pca9541_select_chan,
 					     pca9541_release_chan);
 
diff --git a/drivers/i2c/muxes/pca954x.c b/drivers/i2c/muxes/pca954x.c
index 6f89536..5c6ecc7 100644
--- a/drivers/i2c/muxes/pca954x.c
+++ b/drivers/i2c/muxes/pca954x.c
@@ -226,7 +226,7 @@ static int pca954x_probe(struct i2c_client *client,
 		}
 
 		data->virt_adaps[num] =
-			i2c_add_mux_adapter(adap, client,
+			i2c_add_mux_adapter(adap, &client->dev, client,
 				force, num, pca954x_select_chan,
 				(pdata && pdata->modes[num].deselect_on_exit)
 					? pca954x_deselect_mux : NULL);
diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index 34536ef..5c0e8d6 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -33,6 +33,7 @@
  * mux control.
  */
 struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
+				struct device *parent_device,
 				void *mux_dev, u32 force_nr, u32 chan_id,
 				int (*select) (struct i2c_adapter *,
 					       void *mux_dev, u32 chan_id),
-- 
1.7.10.1
