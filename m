From: "Fillod Stephane" <stephane.fillod-Omk3PdybHIaN9aS15agKxg@public.gmane.org>
Subject: [PATCH/RFC] I2C host adapter slave support and ppc/mpc driver
Date: Mon, 26 Jul 2010 16:46:58 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A02087BAA@rennsmail04.eu.thmulti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

For anyone interested, I have implemented i2c slave mode transfers.

The i2c-dev subsystem is extended with a new flag I2C_M_SLAVE.
Basically, a struct i2c_msg holding flag I2C_M_SLAVE will wait
in slave mode for a write request on specified target address,
and will report the received content to the user application.

An example of driver implementation has been done for i2c-mpc. 
There's no support for read request yet, and I'm wondering whether
it would make sense. The patch has been tested on powerpc MPC8313E. 
Note: the present i2c-mpc implementation may be improved,
esp. regarding current timing issues.

The need for I2C host adapter slave support is quite uncommon.
Last question was raised 2 years ago[1].
This kind of support can prove useful in multi-master based
protocols like found in IPMI. With appropriate hacking,
FreeIPMI[2] software can nicely make use of such subsystem. 

Talking about i2c-dev, does the I2C_M_SLAVE flag is the appropriate 
way of modelling the API extension? Is there any interest for
this extension to be accepted in the linux kernel?

Any comments, advices are welcome.

[1] http://thread.gmane.org/gmane.linux.drivers.i2c/43/focus=43
[2] http://www.gnu.org/software/freeipmi/



Signed-off-by: Stephane Fillod <stephane.fillod-Omk3PdybHIaN9aS15agKxg@public.gmane.org>

--- a/include/linux/i2c.h	24 Feb 2010 18:52:17 -0000
+++ b/include/linux/i2c.h	26 Feb 2010 15:50:46 -0000
@@ -492,6 +492,7 @@ struct i2c_msg {
 	__u16 flags;
 #define I2C_M_TEN		0x0010	/* this is a ten bit chip
address */
 #define I2C_M_RD		0x0001	/* read data, from slave to
master */
+#define I2C_M_SLAVE		0x0002	/* from master client to slave
adap */
 #define I2C_M_NOSTART		0x4000	/* if I2C_FUNC_PROTOCOL_MANGLING
*/
 #define I2C_M_REV_DIR_ADDR	0x2000	/* if I2C_FUNC_PROTOCOL_MANGLING
*/
 #define I2C_M_IGNORE_NAK	0x1000	/* if I2C_FUNC_PROTOCOL_MANGLING
*/
--- a/drivers/i2c/i2c-dev.c	24 Feb 2010 18:52:17 -0000
+++ b/drivers/i2c/i2c-dev.c	26 Feb 2010 15:49:51 -0000
@@ -270,12 +270,18 @@ static noinline int i2cdev_ioctl_rdrw(st
 
 	res = i2c_transfer(client->adapter, rdwr_pa, rdwr_arg.nmsgs);
 	while (i-- > 0) {
-		if (res >= 0 && (rdwr_pa[i].flags & I2C_M_RD)) {
+		if (res >= 0 && (rdwr_pa[i].flags &
(I2C_M_RD|I2C_M_SLAVE))) {
 			if (copy_to_user(data_ptrs[i], rdwr_pa[i].buf,
 					 rdwr_pa[i].len))
 				res = -EFAULT;
 		}
 		kfree(rdwr_pa[i].buf);
+		if (res >= 0 && (rdwr_pa[i].flags & I2C_M_SLAVE)) {
+			struct i2c_msg __user *umsgs;
+			umsgs = ((struct i2c_rdwr_ioctl_data __user
*)arg)->msgs;
+			if (put_user(rdwr_pa[i].len, &umsgs[i].len))
+				res = -EFAULT;
+		}
 	}
 	kfree(data_ptrs);
 	kfree(rdwr_pa);
--- a/drivers/i2c/busses/i2c-mpc.c	3 Dec 2009 03:51:21 -0000
+++ b/drivers/i2c/busses/i2c-mpc.c	27 Apr 2010 11:01:47 -0000
@@ -4,7 +4,7 @@
 
  * This is a combined i2c adapter and algorithm driver for the
  * MPC107/Tsi107 PowerPC northbridge and processors that include
- * the same I2C unit (8240, 8245, 85xx).
+ * the same I2C unit (8240, 8245, 83xx, 85xx).
  *
  * Release 0.8
  *
@@ -31,6 +31,7 @@
 
 #define DRV_NAME "mpc-i2c"
 
+#define MPC_I2C_ADDR  0x00
 #define MPC_I2C_FDR   0x04
 #define MPC_I2C_CR    0x08
 #define MPC_I2C_SR    0x0c
@@ -73,6 +74,11 @@ struct mpc_i2c_match_data {
 	u32 prescaler;
 };
 
+static inline void writeaddr(struct mpc_i2c *i2c, u32 x)
+{
+	writeb(x, i2c->base + MPC_I2C_ADDR);
+}
+
 static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 {
 	writeb(x, i2c->base + MPC_I2C_CR);
@@ -428,6 +434,68 @@ static int mpc_read(struct mpc_i2c *i2c,
 	return length;
 }
 
+static int mpc_slave_xrecv(struct mpc_i2c *i2c, int target,
+		    u8 *data, int length, int restart)
+{
+	unsigned timeout = i2c->adap.timeout;
+	int i, result, srw;
+	int readlen = 0;
+	u32 flags;
+
+	/* Listening address */
+	writeaddr(i2c, target);
+	/* Start with MEN */
+	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MTX);
+
+	/* Give I2C signals sufficent time to settle */
+	udelay(30);
+
+	result = i2c_wait(i2c, timeout, 1);
+	if (result < 0) {
+		writeccr(i2c, 0);
+		return result;
+	}
+#if 0
+	srw = readb(i2c->base + MPC_I2C_SR) & CSR_SRW;
+#else
+	/* TODO: handle and test SRW!=0 */
+	srw = 0;
+#endif
+	flags = srw ? CCR_MTX : 0;
+
+	if (length) {
+		if (length == 1)
+			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK |
flags);
+		else
+			writeccr(i2c, CCR_MIEN | CCR_MEN | flags);
+		/* Dummy read/write */
+		if (srw)
+			writeb(0, i2c->base + MPC_I2C_DR);
+		else
+			readb(i2c->base + MPC_I2C_DR);
+	}
+
+	for (i = 0; i < length; i++) {
+		result = i2c_wait(i2c, timeout, 0);
+		if (result < 0)
+			return i > 0 && result == -ETIMEDOUT ? i-1 :
result;
+		/* Generate stop on last byte */
+		if (i == length - 1)
+			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK |
flags);
+		data[i] = readb(i2c->base + MPC_I2C_DR);
+		readlen++;
+		/* check early STOP after 2 clock cycles at 100 kHz */
+		udelay(20);
+		if (!(readb(i2c->base + MPC_I2C_SR) & CSR_MBB))
+			break;
+	}
+	/* clear I2CSR register */
+	out_8(i2c->base + MPC_I2C_SR, 0);
+	/* hang up */
+	writeccr(i2c, CCR_MEN);
+	return readlen;
+}
+
 static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int
num)
 {
 	struct i2c_msg *pmsg;
@@ -459,9 +527,14 @@ static int mpc_xfer(struct i2c_adapter *
 		pmsg = &msgs[i];
 		dev_dbg(i2c->dev,
 			"Doing %s %d bytes to 0x%02x - %d of %d
messages\n",
-			pmsg->flags & I2C_M_RD ? "read" : "write",
+			pmsg->flags & I2C_M_SLAVE ? "recv" :
+				pmsg->flags & I2C_M_RD ? "read" :
"write",
 			pmsg->len, pmsg->addr, i + 1, num);
-		if (pmsg->flags & I2C_M_RD)
+		if (pmsg->flags & I2C_M_SLAVE) {
+			ret = mpc_slave_xrecv(i2c, pmsg->addr,
pmsg->buf, pmsg->len, i);
+			if (ret >= 0)
+				pmsg->len = ret;
+		} else if (pmsg->flags & I2C_M_RD)
 			ret =
 			    mpc_read(i2c, pmsg->addr, pmsg->buf,
pmsg->len, i);
 		else


Regards
-- 
Stephane Fillod
