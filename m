From: Peter Rosin <peda-SamgB31n2u5IcsJQ0EH25Q@public.gmane.org>
Subject: [PATCH v6 14/24] of/unittest: convert to use an explicit i2c mux core
Date: Sun,  3 Apr 2016 10:52:44 +0200
Message-ID: <1459673574-11440-15-git-send-email-peda@lysator.liu.se>
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

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---
 drivers/of/unittest.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e986e6ee52e0..84a65b711e8c 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1692,13 +1692,7 @@ static struct i2c_driver unittest_i2c_dev_driver = {
 
 #if IS_BUILTIN(CONFIG_I2C_MUX)
 
-struct unittest_i2c_mux_data {
-	int nchans;
-	struct i2c_adapter *adap[];
-};
-
-static int unittest_i2c_mux_select_chan(struct i2c_adapter *adap,
-			       void *client, u32 chan)
+static int unittest_i2c_mux_select_chan(struct i2c_mux_core *muxc, u32 chan)
 {
 	return 0;
 }
@@ -1706,11 +1700,11 @@ static int unittest_i2c_mux_select_chan(struct i2c_adapter *adap,
 static int unittest_i2c_mux_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	int ret, i, nchans, size;
+	int ret, i, nchans;
 	struct device *dev = &client->dev;
 	struct i2c_adapter *adap = to_i2c_adapter(dev->parent);
 	struct device_node *np = client->dev.of_node, *child;
-	struct unittest_i2c_mux_data *stm;
+	struct i2c_mux_core *muxc;
 	u32 reg, max_reg;
 
 	dev_dbg(dev, "%s for node @%s\n", __func__, np->full_name);
@@ -1734,25 +1728,23 @@ static int unittest_i2c_mux_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	size = offsetof(struct unittest_i2c_mux_data, adap[nchans]);
-	stm = devm_kzalloc(dev, size, GFP_KERNEL);
-	if (!stm) {
-		dev_err(dev, "Out of memory\n");
+	muxc = i2c_mux_alloc(adap, dev, 0, 0,
+			     unittest_i2c_mux_select_chan, NULL);
+	if (!muxc)
 		return -ENOMEM;
-	}
-	stm->nchans = nchans;
+	ret = i2c_mux_reserve_adapters(muxc, nchans);
+	if (ret)
+		return ret;
 	for (i = 0; i < nchans; i++) {
-		stm->adap[i] = i2c_add_mux_adapter(adap, dev, client,
-				0, i, 0, unittest_i2c_mux_select_chan, NULL);
-		if (!stm->adap[i]) {
+		ret = i2c_mux_add_adapter(muxc, 0, i, 0);
+		if (ret) {
 			dev_err(dev, "Failed to register mux #%d\n", i);
-			for (i--; i >= 0; i--)
-				i2c_del_mux_adapter(stm->adap[i]);
+			i2c_mux_del_adapters(muxc);
 			return -ENODEV;
 		}
 	}
 
-	i2c_set_clientdata(client, stm);
+	i2c_set_clientdata(client, muxc);
 
 	return 0;
 };
@@ -1761,12 +1753,10 @@ static int unittest_i2c_mux_remove(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct device_node *np = client->dev.of_node;
-	struct unittest_i2c_mux_data *stm = i2c_get_clientdata(client);
-	int i;
+	struct i2c_mux_core *muxc = i2c_get_clientdata(client);
 
 	dev_dbg(dev, "%s for node @%s\n", __func__, np->full_name);
-	for (i = stm->nchans - 1; i >= 0; i--)
-		i2c_del_mux_adapter(stm->adap[i]);
+	i2c_mux_del_adapters(muxc);
 	return 0;
 }
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
