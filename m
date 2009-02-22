From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Set a default timeout value for all adapters
Date: Sun, 22 Feb 2009 12:25:45 +0100
Message-ID: <20090222122545.3c62f8b0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Setting a default timeout value on a per-algo basis doesn't make any
sense. Move the default value setting to i2c-core. Individual adapter
drivers can specify a different (non-zero) value if they wish.

Also express the timeout value in a way which results in the same
duration regarless of the value of HZ.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    4 +---
 drivers/i2c/algos/i2c-algo-pcf.c |    1 -
 drivers/i2c/i2c-core.c           |    5 +++++
 3 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.29-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2009-01-06 20:21:24.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/algos/i2c-algo-bit.c	2009-02-20 15:27:02.000000000 +0100
@@ -604,9 +604,7 @@ static int i2c_bit_prepare_bus(struct i2
 
 	/* register new adapter to i2c module... */
 	adap->algo = &i2c_bit_algo;
-
-	adap->timeout = 100;	/* default values, should	*/
-	adap->retries = 3;	/* be replaced by defines	*/
+	adap->retries = 3;
 
 	return 0;
 }
--- linux-2.6.29-rc5.orig/drivers/i2c/algos/i2c-algo-pcf.c	2009-02-20 13:55:28.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/algos/i2c-algo-pcf.c	2009-02-20 15:26:30.000000000 +0100
@@ -441,7 +441,6 @@ int i2c_pcf_add_bus(struct i2c_adapter *
 
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
-	adap->timeout = 100;
 
 	if ((rval = pcf_init_8584(pcf_adap)))
 		return rval;
--- linux-2.6.29-rc5.orig/drivers/i2c/i2c-core.c	2009-02-20 09:12:42.000000000 +0100
+++ linux-2.6.29-rc5/drivers/i2c/i2c-core.c	2009-02-20 15:39:40.000000000 +0100
@@ -459,6 +459,11 @@ static int i2c_register_adapter(struct i
 		pr_debug("I2C adapter driver [%s] forgot to specify "
 			 "physical device\n", adap->name);
 	}
+
+	/* Set default timeout to 1 second if not already set */
+	if (adap->timeout == 0)
+		adap->timeout = HZ;
+
 	dev_set_name(&adap->dev, "i2c-%d", adap->nr);
 	adap->dev.release = &i2c_adapter_dev_release;
 	adap->dev.class = &i2c_adapter_class;


-- 
Jean Delvare
