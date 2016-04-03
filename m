From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH v6 10/24] [media] rtl2830: convert to use an explicit i2c mux core
Date: Sun,  3 Apr 2016 10:52:40 +0200
Message-ID: <1459673574-11440-11-git-send-email-peda@lysator.liu.se>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459673574-11440-1-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mat
List-Id: linux-i2c@vger.kernel.org

From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Allocate an explicit i2c mux core to handle parent and child adapters
etc. Update the select op to be in terms of the i2c mux core instead
of the child adapter.

Reviewed-by: Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>
Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 drivers/media/dvb-frontends/rtl2830.c      | 17 +++++++++--------
 drivers/media/dvb-frontends/rtl2830_priv.h |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/dvb-frontends/rtl2830.c b/drivers/media/dvb-frontends/rtl2830.c
index 3f96429af0e5..ab02c3a07194 100644
--- a/drivers/media/dvb-frontends/rtl2830.c
+++ b/drivers/media/dvb-frontends/rtl2830.c
@@ -677,9 +677,9 @@ err:
  * adapter lock is already taken by tuner driver.
  * Gate is closed automatically after single I2C transfer.
  */
-static int rtl2830_select(struct i2c_adapter *adap, void *mux_priv, u32 chan_id)
+static int rtl2830_select(struct i2c_mux_core *muxc, u32 chan_id)
 {
-	struct i2c_client *client = mux_priv;
+	struct i2c_client *client = i2c_mux_priv(muxc);
 	struct rtl2830_dev *dev = i2c_get_clientdata(client);
 	int ret;
 
@@ -712,7 +712,7 @@ static struct i2c_adapter *rtl2830_get_i2c_adapter(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	return dev->adapter;
+	return dev->muxc->adapter[0];
 }
 
 /*
@@ -865,12 +865,13 @@ static int rtl2830_probe(struct i2c_client *client,
 		goto err_regmap_exit;
 
 	/* create muxed i2c adapter for tuner */
-	dev->adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
-			client, 0, 0, 0, rtl2830_select, NULL);
-	if (dev->adapter == NULL) {
-		ret = -ENODEV;
+	dev->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0, 0,
+					0, 0, 0, rtl2830_select, NULL);
+	if (IS_ERR(dev->muxc)) {
+		ret = PTR_ERR(dev->muxc);
 		goto err_regmap_exit;
 	}
+	dev->muxc->priv = client;
 
 	/* create dvb frontend */
 	memcpy(&dev->fe.ops, &rtl2830_ops, sizeof(dev->fe.ops));
@@ -903,7 +904,7 @@ static int rtl2830_remove(struct i2c_client *client)
 	/* stop statistics polling */
 	cancel_delayed_work_sync(&dev->stat_work);
 
-	i2c_del_mux_adapter(dev->adapter);
+	i2c_mux_del_adapters(dev->muxc);
 	regmap_exit(dev->regmap);
 	kfree(dev);
 
diff --git a/drivers/media/dvb-frontends/rtl2830_priv.h b/drivers/media/dvb-frontends/rtl2830_priv.h
index cf793f39a09b..da4909543da2 100644
--- a/drivers/media/dvb-frontends/rtl2830_priv.h
+++ b/drivers/media/dvb-frontends/rtl2830_priv.h
@@ -29,7 +29,7 @@ struct rtl2830_dev {
 	struct rtl2830_platform_data *pdata;
 	struct i2c_client *client;
 	struct regmap *regmap;
-	struct i2c_adapter *adapter;
+	struct i2c_mux_core *muxc;
 	struct dvb_frontend fe;
 	bool sleeping;
 	unsigned long filters;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
