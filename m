From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH v6 09/24] [media] m88ds3103: convert to use an explicit i2c mux core
Date: Sun,  3 Apr 2016 10:52:39 +0200
Message-ID: <1459673574-11440-10-git-send-email-peda@lysator.liu.se>
References: <1459673574-11440-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459673574-11440-1-git-send-email-peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
 drivers/media/dvb-frontends/m88ds3103.c      | 18 +++++++++---------
 drivers/media/dvb-frontends/m88ds3103_priv.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index 76883600ec6f..bf5ffcda7797 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -1251,9 +1251,9 @@ static void m88ds3103_release(struct dvb_frontend *fe)
 	i2c_unregister_device(client);
 }
 
-static int m88ds3103_select(struct i2c_adapter *adap, void *mux_priv, u32 chan)
+static int m88ds3103_select(struct i2c_mux_core *muxc, u32 chan)
 {
-	struct m88ds3103_dev *dev = mux_priv;
+	struct m88ds3103_dev *dev = i2c_mux_priv(muxc);
 	struct i2c_client *client = dev->client;
 	int ret;
 	struct i2c_msg msg = {
@@ -1374,7 +1374,7 @@ static struct i2c_adapter *m88ds3103_get_i2c_adapter(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	return dev->i2c_adapter;
+	return dev->muxc->adapter[0];
 }
 
 static int m88ds3103_probe(struct i2c_client *client,
@@ -1467,13 +1467,13 @@ static int m88ds3103_probe(struct i2c_client *client,
 		goto err_kfree;
 
 	/* create mux i2c adapter for tuner */
-	dev->i2c_adapter = i2c_add_mux_adapter(client->adapter, &client->dev,
-					       dev, 0, 0, 0, m88ds3103_select,
-					       NULL);
-	if (dev->i2c_adapter == NULL) {
-		ret = -ENOMEM;
+	dev->muxc = i2c_mux_one_adapter(client->adapter, &client->dev, 0, 0,
+					0, 0, 0, m88ds3103_select, NULL);
+	if (IS_ERR(dev->muxc)) {
+		ret = PTR_ERR(dev->muxc);
 		goto err_kfree;
 	}
+	dev->muxc->priv = dev;
 
 	/* create dvb_frontend */
 	memcpy(&dev->fe.ops, &m88ds3103_ops, sizeof(struct dvb_frontend_ops));
@@ -1502,7 +1502,7 @@ static int m88ds3103_remove(struct i2c_client *client)
 
 	dev_dbg(&client->dev, "\n");
 
-	i2c_del_mux_adapter(dev->i2c_adapter);
+	i2c_mux_del_adapters(dev->muxc);
 
 	kfree(dev);
 	return 0;
diff --git a/drivers/media/dvb-frontends/m88ds3103_priv.h b/drivers/media/dvb-frontends/m88ds3103_priv.h
index eee8c22c51ec..c5b4e177c6ea 100644
--- a/drivers/media/dvb-frontends/m88ds3103_priv.h
+++ b/drivers/media/dvb-frontends/m88ds3103_priv.h
@@ -42,7 +42,7 @@ struct m88ds3103_dev {
 	enum fe_status fe_status;
 	u32 dvbv3_ber; /* for old DVBv3 API read_ber */
 	bool warm; /* FW running */
-	struct i2c_adapter *i2c_adapter;
+	struct i2c_mux_core *muxc;
 	/* auto detect chip id to do different config */
 	u8 chip_id;
 	/* main mclk is calculated for M88RS6000 dynamically */
-- 
2.1.4
