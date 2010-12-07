From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c-algo-bit: Complain about masters which can't read
 SCL
Date: Tue, 7 Dec 2010 11:07:05 +0100
Message-ID: <20101207110705.69792a1a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The I2C specification explicitly describes both SDA and SCL as
bidirectional lines. An I2C master with a read-only SCL is thus not
compliant. If a slow slave stretches the clock, errors will happen,
so the bus can't be considered as reliable.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-2.6.37-rc5.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-07 11:02:38.000000000 +0100
+++ linux-2.6.37-rc5/drivers/i2c/algos/i2c-algo-bit.c	2010-12-07 11:03:23.000000000 +0100
@@ -604,9 +604,10 @@ static int __i2c_bit_add_bus(struct i2c_
 			     int (*add_adapter)(struct i2c_adapter *))
 {
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
+	int ret;
 
 	if (bit_test) {
-		int ret = test_bus(bit_adap, adap->name);
+		ret = test_bus(bit_adap, adap->name);
 		if (ret < 0)
 			return -ENODEV;
 	}
@@ -615,7 +616,16 @@ static int __i2c_bit_add_bus(struct i2c_
 	adap->algo = &i2c_bit_algo;
 	adap->retries = 3;
 
-	return add_adapter(adap);
+	ret = add_adapter(adap);
+	if (ret < 0)
+		return ret;
+
+	/* Complain if SCL can't be read */
+	if (bit_adap->getscl == NULL) {
+		dev_warn(&adap->dev, "Not I2C compliant: can't read SCL\n");
+		dev_warn(&adap->dev, "Bus may be unreliable\n");
+	}
+	return 0;
 }
 
 int i2c_bit_add_bus(struct i2c_adapter *adap)


-- 
Jean Delvare
