From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 3/3] i2c: Mark i2c_adapter.id as deprecated
Date: Fri, 5 Nov 2010 21:10:01 +0100
Message-ID: <20101105211001.1cc93ac7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>, LMML <linux-media@vger.kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Jarod Wilson <jarod@redhat.com>
List-Id: linux-i2c@vger.kernel.org

It's about time to make it clear that i2c_adapter.id is deprecated.
Hopefully this will remind the last user to move over to a different
strategy.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Jarod Wilson <jarod@redhat.com>
---
 drivers/i2c/i2c-mux.c |    1 -
 include/linux/i2c.h   |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.37-rc1.orig/include/linux/i2c.h	2010-11-05 13:55:17.000000000 +0100
+++ linux-2.6.37-rc1/include/linux/i2c.h	2010-11-05 15:41:20.000000000 +0100
@@ -353,7 +353,7 @@ struct i2c_algorithm {
  */
 struct i2c_adapter {
 	struct module *owner;
-	unsigned int id;
+	unsigned int id __deprecated;
 	unsigned int class;		  /* classes to allow probing for */
 	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
 	void *algo_data;
--- linux-2.6.37-rc1.orig/drivers/i2c/i2c-mux.c	2010-11-05 16:06:18.000000000 +0100
+++ linux-2.6.37-rc1/drivers/i2c/i2c-mux.c	2010-11-05 16:06:33.000000000 +0100
@@ -120,7 +120,6 @@ struct i2c_adapter *i2c_add_mux_adapter(
 	snprintf(priv->adap.name, sizeof(priv->adap.name),
 		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
 	priv->adap.owner = THIS_MODULE;
-	priv->adap.id = parent->id;
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;


-- 
Jean Delvare
