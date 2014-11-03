From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [RFC] i2c: mux: add mux device to the adapter name
Date: Mon,  3 Nov 2014 22:00:56 +0100
Message-ID: <1415048456-13456-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If there are multiple muxes on one bus, then specifying the channel only
is not sufficient for a distinguishable name. We need the actual device,
too.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
---

This is probably the least "ABI" breaking solution? RFC for now...

 drivers/i2c/i2c-mux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 5b482ea32faf..26aa84902ada 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -134,7 +134,8 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
 
 	/* Now fill out new adapter structure */
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
-		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
+		 "i2c-%d-mux (chan_id %d) (mux_device %s)",
+		 i2c_adapter_id(parent), chan_id, dev_name(mux_dev));
 	priv->adap.owner = THIS_MODULE;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
-- 
2.1.1
