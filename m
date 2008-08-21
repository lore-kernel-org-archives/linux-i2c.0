From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: [PATCH 6/6]: i2c-pcf: Add bus addressing support.
Date: Thu, 21 Aug 2008 02:43:33 -0700 (PDT)
Message-ID: <20080821.024333.137538181.davem@davemloft.net>
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


i2c-pcf: Add bus addressing support.

Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>

diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
index b8e34b0..8031e92 100644
--- a/drivers/i2c/algos/i2c-algo-pcf.c
+++ b/drivers/i2c/algos/i2c-algo-pcf.c
@@ -312,7 +312,7 @@ static int pcf_doAddress(struct i2c_algo_pcf_data *adap,
 	unsigned short flags = msg->flags;
 	unsigned char addr;
 
-	addr = msg->addr << 1;
+	addr = I2C_ADDR_GET_ADDR(msg->addr) << 1;
 	if (flags & I2C_M_RD)
 		addr |= 1;
 	if (flags & I2C_M_REV_DIR_ADDR)
@@ -342,6 +342,18 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
 		goto out;
 	}
 	
+	/* We must set the I2C bus after waiting for bus-busy, otherwise
+	 * STOP bits from previous transfers will not propagate and the
+	 * bus will hang.
+	 *
+	 * Currently we assume that we will not switch busses during a
+	 * single xfer request.  If that were possible we'd have to add
+	 * complicated START/STOP logic below, and extra wait_for_bb()
+	 * calls.
+	 */
+	if (adap->set_bus && num)
+		adap->set_bus(adap->data, I2C_ADDR_GET_BUS(msgs[0].addr));
+
 	for (i = 0;ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
@@ -431,7 +443,7 @@ static const struct i2c_algorithm pcf_algo = {
 /* 
  * registering functions to load algorithms at runtime 
  */
-int i2c_pcf_add_bus(struct i2c_adapter *adap, int support_smbus_quick)
+int i2c_pcf_add_bus(struct i2c_adapter *adap, int flags)
 {
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 	int rval;
@@ -440,8 +452,10 @@ int i2c_pcf_add_bus(struct i2c_adapter *adap, int support_smbus_quick)
 
 	pcf_adap->func_flags = (I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
 				I2C_FUNC_PROTOCOL_MANGLING);
-	if (!support_smbus_quick)
+	if (!(flags & I2C_PCF_SUPPORT_SMBUS_QUICK))
 		pcf_adap->func_flags &= ~I2C_FUNC_SMBUS_QUICK;
+	if (flags & I2C_PCF_SUPPORT_BUS_ADDRESSING)
+		pcf_adap->func_flags |= I2C_FUNC_BUS_ADDRESSING;
 
 	/* register new adapter to i2c module... */
 	adap->algo = &pcf_algo;
diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
index 2be6b5b..d200b3a 100644
--- a/drivers/i2c/busses/i2c-elektor.c
+++ b/drivers/i2c/busses/i2c-elektor.c
@@ -281,7 +281,7 @@ static int __devinit elektor_probe(struct device *dev, unsigned int id)
 	if (pcf_isa_init())
 		return -ENODEV;
 	pcf_isa_ops.dev.parent = dev;
-	if (i2c_pcf_add_bus(&pcf_isa_ops, 1) < 0)
+	if (i2c_pcf_add_bus(&pcf_isa_ops, I2C_PCF_SUPPORT_SMBUS_QUICK) < 0)
 		goto fail;
 
 	dev_info(dev, "found device at %#x\n", base);
diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
index 388776a..bb68d07 100644
--- a/include/linux/i2c-algo-pcf.h
+++ b/include/linux/i2c-algo-pcf.h
@@ -36,6 +36,8 @@ struct i2c_algo_pcf_data {
 	void (*xfer_begin)(void *data);
 	void (*xfer_end)(void *data);
 
+	void (*set_bus)(void *data, int addr);
+
 	u32 func_flags;
 
 	/* Multi-master lost arbitration back-off delay (msecs)
@@ -45,6 +47,9 @@ struct i2c_algo_pcf_data {
 	unsigned long lab_mdelay;
 };
 
-int i2c_pcf_add_bus(struct i2c_adapter *adap, int support_smbus_quick);
+int i2c_pcf_add_bus(struct i2c_adapter *adap, int flags);
+
+#define I2C_PCF_SUPPORT_SMBUS_QUICK		0x00000001
+#define I2C_PCF_SUPPORT_BUS_ADDRESSING		0x00000002
 
 #endif /* _LINUX_I2C_ALGO_PCF_H */
-- 
1.5.6.5.GIT


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
