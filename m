From: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/4] i2c: i2c-ibm-iic: cleanup.
Date: Fri, 22 Nov 2013 09:58:03 +0100
Message-ID: <1385110686-4226-2-git-send-email-jean-jacques.hiblot@jdsu.com>
References: <1385110686-4226-1-git-send-email-jean-jacques.hiblot@jdsu.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385110686-4226-1-git-send-email-jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jean-jacques hiblot <jean-jacques.hiblot-qU79poH1Kb0@public.gmane.org>, jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

* removed unneeded 'volatile' qualifiers and casts
* use the dev_dbg, dev_err etc. instead of printk
* removed unneeded members for the driver's private data

Signed-off-by: jean-jacques hiblot <jjhiblot-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 109 ++++++++++++++++++++-------------------
 drivers/i2c/busses/i2c-ibm_iic.h |   9 ++--
 2 files changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index ff3caa0..9cdef65 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -69,21 +69,23 @@ MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
 #endif
 
 #if DBG_LEVEL > 0
-#  define DBG(f,x...)	printk(KERN_DEBUG "ibm-iic" f, ##x)
+#  define DBG(dev, f, x...)	dev_dbg(dev->adap.dev.parent, f, ##x)
 #else
-#  define DBG(f,x...)	((void)0)
+#  define DBG(dev, f, x...)	((void)0)
 #endif
 #if DBG_LEVEL > 1
-#  define DBG2(f,x...) 	DBG(f, ##x)
+#  define DBG2(dev, f, x...)	DBG(dev, f, ##x)
 #else
-#  define DBG2(f,x...) 	((void)0)
+#  define DBG2(dev, f, x...)	((void)0)
 #endif
 #if DBG_LEVEL > 2
 static void dump_iic_regs(const char* header, struct ibm_iic_private* dev)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
-	printk(KERN_DEBUG "ibm-iic%d: %s\n", dev->idx, header);
-	printk(KERN_DEBUG
+	struct iic_regs __iomem *iic = dev->vaddr;
+	struct device *device = dev.adap.dev.parent;
+
+	dev_dbg(device, ": %s\n", header);
+	dev_dbg(device,
 	       "  cntl     = 0x%02x, mdcntl = 0x%02x\n"
 	       "  sts      = 0x%02x, extsts = 0x%02x\n"
 	       "  clkdiv   = 0x%02x, xfrcnt = 0x%02x\n"
@@ -133,9 +135,9 @@ static inline void iic_interrupt_mode(struct ibm_iic_private* dev, int enable)
  */
 static void iic_dev_init(struct ibm_iic_private* dev)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 
-	DBG("%d: init\n", dev->idx);
+	DBG(dev, "init\n");
 
 	/* Clear master address */
 	out_8(&iic->lmadr, 0);
@@ -178,11 +180,11 @@ static void iic_dev_init(struct ibm_iic_private* dev)
  */
 static void iic_dev_reset(struct ibm_iic_private* dev)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	int i;
 	u8 dc;
 
-	DBG("%d: soft reset\n", dev->idx);
+	DBG(dev, "soft reset\n");
 	DUMP_REGS("reset", dev);
 
     	/* Place chip in the reset state */
@@ -191,7 +193,7 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
 	/* Check if bus is free */
 	dc = in_8(&iic->directcntl);
 	if (!DIRCTNL_FREE(dc)){
-		DBG("%d: trying to regain bus control\n", dev->idx);
+		DBG(dev, "trying to regain bus control\n");
 
 		/* Try to set bus free state */
 		out_8(&iic->directcntl, DIRCNTL_SDAC | DIRCNTL_SCC);
@@ -226,7 +228,7 @@ static void iic_dev_reset(struct ibm_iic_private* dev)
  */
 
 /* Wait for SCL and/or SDA to be high */
-static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
+static int iic_dc_wait(struct iic_regs __iomem *iic, u8 mask)
 {
 	unsigned long x = jiffies + HZ / 28 + 2;
 	while ((in_8(&iic->directcntl) & mask) != mask){
@@ -239,19 +241,18 @@ static int iic_dc_wait(volatile struct iic_regs __iomem *iic, u8 mask)
 
 static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	const struct i2c_timings* t = &timings[dev->fast_mode ? 1 : 0];
 	u8 mask, v, sda;
 	int i, res;
 
 	/* Only 7-bit addresses are supported */
 	if (unlikely(p->flags & I2C_M_TEN)){
-		DBG("%d: smbus_quick - 10 bit addresses are not supported\n",
-			dev->idx);
+		DBG(dev, "smbus_quick - 10 bit addresses are not supported\n");
 		return -EINVAL;
 	}
 
-	DBG("%d: smbus_quick(0x%02x)\n", dev->idx, p->addr);
+	DBG(dev, "smbus_quick(0x%02x)\n", p->addr);
 
 	/* Reset IIC interface */
 	out_8(&iic->xtcntlss, XTCNTLSS_SRST);
@@ -304,7 +305,7 @@ static int iic_smbus_quick(struct ibm_iic_private* dev, const struct i2c_msg* p)
 
 	ndelay(t->buf);
 
-	DBG("%d: smbus_quick -> %s\n", dev->idx, res ? "NACK" : "ACK");
+	DBG(dev, "smbus_quick -> %s\n", res ? "NACK" : "ACK");
 out:
 	/* Remove reset */
 	out_8(&iic->xtcntlss, 0);
@@ -314,7 +315,7 @@ out:
 
 	return res;
 err:
-	DBG("%d: smbus_quick - bus is stuck\n", dev->idx);
+	DBG(dev, "smbus_quick - bus is stuck\n");
 	res = -EREMOTEIO;
 	goto out;
 }
@@ -325,10 +326,10 @@ err:
 static irqreturn_t iic_handler(int irq, void *dev_id)
 {
 	struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 
-	DBG2("%d: irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
-	     dev->idx, in_8(&iic->sts), in_8(&iic->extsts));
+	DBG2(dev, "irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
+	     in_8(&iic->sts), in_8(&iic->extsts));
 
 	/* Acknowledge IRQ and wakeup iic_wait_for_tc */
 	out_8(&iic->sts, STS_IRQA | STS_SCMP);
@@ -343,10 +344,10 @@ static irqreturn_t iic_handler(int irq, void *dev_id)
  */
 static int iic_xfer_result(struct ibm_iic_private* dev)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 
 	if (unlikely(in_8(&iic->sts) & STS_ERR)){
-		DBG("%d: xfer error, EXTSTS = 0x%02x\n", dev->idx,
+		DBG(dev, "xfer error, EXTSTS = 0x%02x\n",
 			in_8(&iic->extsts));
 
 		/* Clear errors and possible pending IRQs */
@@ -362,7 +363,7 @@ static int iic_xfer_result(struct ibm_iic_private* dev)
 		 * state, the only way out - soft reset.
 		 */
 		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-			DBG("%d: bus is stuck, resetting\n", dev->idx);
+			DBG(dev, "bus is stuck, resetting\n");
 			iic_dev_reset(dev);
 		}
 		return -EREMOTEIO;
@@ -376,10 +377,10 @@ static int iic_xfer_result(struct ibm_iic_private* dev)
  */
 static void iic_abort_xfer(struct ibm_iic_private* dev)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	unsigned long x;
 
-	DBG("%d: iic_abort_xfer\n", dev->idx);
+	DBG(dev, "iic_abort_xfer\n");
 
 	out_8(&iic->cntl, CNTL_HMT);
 
@@ -390,7 +391,7 @@ static void iic_abort_xfer(struct ibm_iic_private* dev)
 	x = jiffies + 2;
 	while ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
 		if (time_after(jiffies, x)){
-			DBG("%d: abort timeout, resetting...\n", dev->idx);
+			DBG(dev, "abort timeout, resetting...\n");
 			iic_dev_reset(dev);
 			return;
 		}
@@ -408,7 +409,7 @@ static void iic_abort_xfer(struct ibm_iic_private* dev)
  */
 static int iic_wait_for_tc(struct ibm_iic_private* dev){
 
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	int ret = 0;
 
 	if (dev->irq >= 0){
@@ -417,9 +418,9 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 			!(in_8(&iic->sts) & STS_PT), dev->adap.timeout);
 
 		if (unlikely(ret < 0))
-			DBG("%d: wait interrupted\n", dev->idx);
+			DBG(dev, "wait interrupted\n");
 		else if (unlikely(in_8(&iic->sts) & STS_PT)){
-			DBG("%d: wait timeout\n", dev->idx);
+			DBG(dev, "wait timeout\n");
 			ret = -ETIMEDOUT;
 		}
 	}
@@ -429,13 +430,13 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 
 		while (in_8(&iic->sts) & STS_PT){
 			if (unlikely(time_after(jiffies, x))){
-				DBG("%d: poll timeout\n", dev->idx);
+				DBG(dev, "poll timeout\n");
 				ret = -ETIMEDOUT;
 				break;
 			}
 
 			if (unlikely(signal_pending(current))){
-				DBG("%d: poll interrupted\n", dev->idx);
+				DBG(dev, "poll interrupted\n");
 				ret = -ERESTARTSYS;
 				break;
 			}
@@ -448,7 +449,7 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 	else
 		ret = iic_xfer_result(dev);
 
-	DBG2("%d: iic_wait_for_tc -> %d\n", dev->idx, ret);
+	DBG2(dev, "iic_wait_for_tc -> %d\n", ret);
 
 	return ret;
 }
@@ -459,7 +460,7 @@ static int iic_wait_for_tc(struct ibm_iic_private* dev){
 static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 			  int combined_xfer)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	char* buf = pm->buf;
 	int i, j, loops, ret = 0;
 	int len = pm->len;
@@ -475,14 +476,14 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 
 		if (!(cntl & CNTL_RW))
 			for (j = 0; j < count; ++j)
-				out_8((void __iomem *)&iic->mdbuf, *buf++);
+				out_8(&iic->mdbuf, *buf++);
 
 		if (i < loops - 1)
 			cmd |= CNTL_CHT;
 		else if (combined_xfer)
 			cmd |= CNTL_RPST;
 
-		DBG2("%d: xfer_bytes, %d, CNTL = 0x%02x\n", dev->idx, count, cmd);
+		DBG2(dev, "xfer_bytes, %d, CNTL = 0x%02x\n", count, cmd);
 
 		/* Start transfer */
 		out_8(&iic->cntl, cmd);
@@ -493,8 +494,8 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 		if (unlikely(ret < 0))
 			break;
 		else if (unlikely(ret != count)){
-			DBG("%d: xfer_bytes, requested %d, transferred %d\n",
-				dev->idx, count, ret);
+			DBG(dev, "xfer_bytes, requested %d, transferred %d\n",
+				count, ret);
 
 			/* If it's not a last part of xfer, abort it */
 			if (combined_xfer || (i < loops - 1))
@@ -506,7 +507,7 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
 
 		if (cntl & CNTL_RW)
 			for (j = 0; j < count; ++j)
-				*buf++ = in_8((void __iomem *)&iic->mdbuf);
+				*buf++ = in_8(&iic->mdbuf);
 	}
 
 	return ret > 0 ? 0 : ret;
@@ -517,10 +518,10 @@ static int iic_xfer_bytes(struct ibm_iic_private* dev, struct i2c_msg* pm,
  */
 static inline void iic_address(struct ibm_iic_private* dev, struct i2c_msg* msg)
 {
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	u16 addr = msg->addr;
 
-	DBG2("%d: iic_address, 0x%03x (%d-bit)\n", dev->idx,
+	DBG2(dev, "iic_address, 0x%03x (%d-bit)\n",
 		addr, msg->flags & I2C_M_TEN ? 10 : 7);
 
 	if (msg->flags & I2C_M_TEN){
@@ -553,10 +554,10 @@ static inline int iic_address_neq(const struct i2c_msg* p1,
 static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
     	struct ibm_iic_private* dev = (struct ibm_iic_private*)(i2c_get_adapdata(adap));
-	volatile struct iic_regs __iomem *iic = dev->vaddr;
+	struct iic_regs __iomem *iic = dev->vaddr;
 	int i, ret = 0;
 
-	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
+	DBG2(dev, "iic_xfer, %d msg(s)\n", num);
 
 	if (!num)
 		return 0;
@@ -565,7 +566,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	 * Uhh, generic i2c layer is more suitable place for such code...
 	 */
 	if (unlikely(iic_invalid_address(&msgs[0]))){
-		DBG("%d: invalid address 0x%03x (%d-bit)\n", dev->idx,
+		DBG(dev, "invalid address 0x%03x (%d-bit)\n",
 			msgs[0].addr, msgs[0].flags & I2C_M_TEN ? 10 : 7);
 		return -EINVAL;
 	}
@@ -578,19 +579,19 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 				 */
 				return iic_smbus_quick(dev, &msgs[0]);
 			}
-			DBG("%d: invalid len %d in msg[%d]\n", dev->idx,
+			DBG(dev, "invalid len %d in msg[%d]\n",
 				msgs[i].len, i);
 			return -EINVAL;
 		}
 		if (unlikely(iic_address_neq(&msgs[0], &msgs[i]))){
-			DBG("%d: invalid addr in msg[%d]\n", dev->idx, i);
+			DBG(dev, "invalid addr in msg[%d]\n", i);
 			return -EINVAL;
 		}
 	}
 
 	/* Check bus state */
 	if (unlikely((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE)){
-		DBG("%d: iic_xfer, bus is not free\n", dev->idx);
+		DBG(dev, "iic_xfer, bus is not free\n");
 
 		/* Usually it means something serious has happened.
 		 * We *cannot* have unfinished previous transfer
@@ -603,7 +604,7 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		iic_dev_reset(dev);
 
 		if ((in_8(&iic->extsts) & EXTSTS_BCS_MASK) != EXTSTS_BCS_FREE){
-			DBG("%d: iic_xfer, bus is still not free\n", dev->idx);
+			DBG(dev, "iic_xfer, bus is still not free\n");
 			return -EREMOTEIO;
 		}
 	}
@@ -635,15 +636,17 @@ static const struct i2c_algorithm iic_algo = {
 /*
  * Calculates IICx_CLCKDIV value for a specific OPB clock frequency
  */
-static inline u8 iic_clckdiv(unsigned int opb)
+static inline u8 iic_clckdiv(struct ibm_iic_private *dev, unsigned int opb)
 {
+	struct device *device = dev->adap.dev.parent;
+
 	/* Compatibility kludge, should go away after all cards
 	 * are fixed to fill correct value for opbfreq.
 	 * Previous driver version used hardcoded divider value 4,
 	 * it corresponds to OPB frequency from the range (40, 50] MHz
 	 */
 	if (!opb){
-		printk(KERN_WARNING "ibm-iic: using compatibility value for OPB freq,"
+		dev_warn(device, "iic_clckdiv: using compatibility value for OPB freq,"
 			" fix your board specific setup\n");
 		opb = 50000000;
 	}
@@ -652,7 +655,7 @@ static inline u8 iic_clckdiv(unsigned int opb)
 	opb /= 1000000;
 
 	if (opb < 20 || opb > 150){
-		printk(KERN_WARNING "ibm-iic: invalid OPB clock frequency %u MHz\n",
+		dev_warn(device, "iic_clckdiv: invalid OPB clock frequency %u MHz\n",
 			opb);
 		opb = opb < 20 ? 20 : 150;
 	}
@@ -733,7 +736,7 @@ static int iic_probe(struct platform_device *ofdev)
 		}
 	}
 
-	dev->clckdiv = iic_clckdiv(*freq);
+	dev->clckdiv = iic_clckdiv(dev, *freq);
 	dev_dbg(&ofdev->dev, "clckdiv = %d\n", dev->clckdiv);
 
 	/* Initialize IIC interface */
diff --git a/drivers/i2c/busses/i2c-ibm_iic.h b/drivers/i2c/busses/i2c-ibm_iic.h
index fdaa482..1efce5d 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.h
+++ b/drivers/i2c/busses/i2c-ibm_iic.h
@@ -25,8 +25,10 @@
 #include <linux/i2c.h>
 
 struct iic_regs {
-	u16 mdbuf;
-	u16 sbbuf;
+	u8 mdbuf;
+	u8 reserved1;
+	u8 sbbuf;
+	u8 reserved2;
 	u8 lmadr;
 	u8 hmadr;
 	u8 cntl;
@@ -44,9 +46,8 @@ struct iic_regs {
 
 struct ibm_iic_private {
 	struct i2c_adapter adap;
-	volatile struct iic_regs __iomem *vaddr;
+	struct iic_regs __iomem *vaddr;
 	wait_queue_head_t wq;
-	int idx;
 	int irq;
 	int fast_mode;
 	u8  clckdiv;
-- 
1.8.4.2
