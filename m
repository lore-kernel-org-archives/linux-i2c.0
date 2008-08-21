From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask for no
 smbus quick mode support.
Date: Thu, 21 Aug 2008 02:43:27 -0700 (PDT)
Message-ID: <20080821.024327.144744678.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


i2c-pcf: Add a way for bus driver to ask for no smbus quick mode support.

Some PCF bus implementations have precise knowledge of the i2c
devices sitting on the bus, using things such as firmware device
trees, and do not want any of the auto I2C device probing to
occur.

Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index c171ee6..b8e34b0 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -416,8 +416,9 @@ out:
 
 static u32 pcf_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
+	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
+
+	return pcf_adap->func_flags;
 }
 
 /* -----exported algorithm data: -------------------------------------	*/
@@ -430,13 +431,18 @@ static const struct i2c_algorithm pcf_algo = {
 /* 
  * registering functions to load algorithms at runtime 
  */
-int i2c_pcf_add_bus(struct i2c_adapter *adap)
+int i2c_pcf_add_bus(struct i2c_adapter *adap, int support_smbus_quick)
 {
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 	int rval;
 
 	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
+	pcf_adap->func_flags = (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
+				I2C_FUNC_PROTOCOL_MANGLING);
+	if (!support_smbus_quick)
+		pcf_adap->func_flags &= ~I2C_FUNC_SMBUS_QUICK;
+
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
 	adap->timeout = 100;
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 37bb528..2be6b5b 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -281,7 +281,7 @@ static int __devinit elektor_probe(struct device *dev, unsigned int id)
 	if (pcf_isa_init())
 		return -ENODEV;
 	pcf_isa_ops.dev.parent = dev;
-	if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+	if (i2c_pcf_add_bus(&pcf_isa_ops, 1) < 0)
 		goto fail;
 
 	dev_info(dev, "found device at %#x\n", base);
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index 78c62ed..388776a 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -36,6 +36,8 @@ struct i2c_algo_pcf_data {
 	void (*xfer_begin)(void *data);
 	void (*xfer_end)(void *data);
 
+	u32 func_flags;
+
 	/* Multi-master lost arbitration back-off delay (msecs)
 	 * This should be set by the bus adapter or knowledgable client
 	 * if bus is multi-mastered, else zero
@@ -43,6 +45,6 @@ struct i2c_algo_pcf_data {
 	unsigned long lab_mdelay;
 };
 
-int i2c_pcf_add_bus(struct i2c_adapter *);
+int i2c_pcf_add_bus(struct i2c_adapter *adap, int support_smbus_quick);
 
 #endif /* _LINUX_I2C_ALGO_PCF_H */
-- 
1.5.6.5.GIT


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
