From: Matej Kupljen <matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org>
Subject: RE: Add restart support to i2c-pnx
Date: Wed, 02 Feb 2011 22:23:42 +0100
Message-ID: <1296681822.15861.3.camel@orion>
References: <acc33abdeea1fb1dd33f6919e7a4c4e4@imap.raing.si>
	 <AANLkTimrs02v70OMkExsfBKhdOU1pxoFoAEn780qj_v-@mail.gmail.com>
	 <aeed818a0cfb7836e7599aad4ffb9874@imap.raing.si>
	 <20110202134102.1fd5b68d@endymion.delvare>
	 <cd08bef3d940dd8ede1abc5bee93b190@imap.raing.si>
	 <083DF309106F364B939360100EC290F80B0E17D10F@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eid762Rh+R0aVBwc9rB+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <083DF309106F364B939360100EC290F80B0E17D10F-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--=-eid762Rh+R0aVBwc9rB+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Kevin,

> Thanks for posting this patch. See comments below..
> I'll be happy to test your changes once the following items
> are clarified.
> 
> > The pathch is against 2.6.28.2, but it should apply to the
> > cureent GIT version as well.
> 
> This patch needs to be re-based against the latest version
> of the driver as it has changes that this patch will revert
> or won't apply to.

I re-based it against latest version of the kernel in GIT and 
also included your comments in the mail.

Is it O.K. now?

Regards,
Matej

P.S.: Changed the email client. I now attached the file as 
well as pasted it in-line.

-------------------------------------------------------------------
Current code in i2c-pnx.c doesn't support sending messages
with restart condition in it, for example:
S - (address | W) - Sr - (address | R) - ... - P

This patch adds this to the current code. It has been
tested on a custom board with LPC3152 CPU (similar to
Embedded Artists EA313x board) with uBlox GPS receiver
connected to I2C bus. It has been running over the night
without errors. 

Signed-off-by: Matej Kupljen <matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org>

--- i2c-pnx-orig.c	2011-02-02 21:30:19.000000000 +0100
+++ i2c-pnx.c	2011-02-02 21:49:02.000000000 +0100
@@ -78,7 +78,7 @@
  * Generate a START signal in the desired mode.
  */
 static int i2c_pnx_start(unsigned char slave_addr,
-	struct i2c_pnx_algo_data *alg_data)
+	struct i2c_pnx_algo_data *alg_data, int repeated)
 {
 	dev_dbg(&alg_data->adapter.dev, "%s(): addr 0x%x mode %d\n", __func__,
 		slave_addr, alg_data->mif.mode);
@@ -91,8 +91,8 @@
 		return -EINVAL;
 	}
 
-	/* First, make sure bus is idle */
-	if (wait_timeout(I2C_PNX_TIMEOUT, alg_data)) {
+	/* First, make sure bus is idle, if we are not doing repeated start */
+	if ((!repeated) && (wait_timeout(I2C_PNX_TIMEOUT, alg_data))) {
 		/* Somebody else is monopolizing the bus */
 		dev_err(&alg_data->adapter.dev,
 			"%s: Bus busy. Slave addr = %02x, cntrl = %x, stat = %x\n",
@@ -441,7 +441,7 @@
 i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
-	int rc = 0, completed = 0, i;
+	int rc = 0, completed = 0, i, repeated;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 	u32 stat = ioread32(I2C_REG_STS(alg_data));
 
@@ -457,6 +457,7 @@
 
 		pmsg = &msgs[i];
 		addr = pmsg->addr;
+		repeated = 0;
 
 		if (pmsg->flags & I2C_M_TEN) {
 			dev_err(&alg_data->adapter.dev,
@@ -481,16 +482,23 @@
 		/* initialize the completion var */
 		init_completion(&alg_data->mif.complete);
 
-		/* Enable master interrupt */
-		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
-				mcntrl_naie | mcntrl_drmie,
-			  I2C_REG_CTL(alg_data));
+		/* 
+		 * If this is not the only message, then we need to
+		 * send repeated start, but only if the flag allows it
+		 */
+		if((i > 0) && !(pmsg->flags & I2C_M_NOSTART))
+			repeated = 1;
 
 		/* Put start-code and slave-address on the bus. */
-		rc = i2c_pnx_start(addr, alg_data);
+		rc = i2c_pnx_start(addr, alg_data, repeated);
 		if (rc < 0)
 			break;
 
+		/* Enable master interrupt */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
+				mcntrl_naie | mcntrl_drmie,
+			  I2C_REG_CTL(alg_data));
+
 		/* Wait for completion */
 		wait_for_completion(&alg_data->mif.complete);
 

--=-eid762Rh+R0aVBwc9rB+
Content-Disposition: attachment; filename=i2c-pnx-restart-git.patch
Content-Type: text/x-patch; name=i2c-pnx-restart-git.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Current code in i2c-pnx.c doesn't support sending messages
with restart condition in it, for example:
S - (address | W) - Sr - (address | R) - ... - P

This patch adds this to the current code. It has been
tested on a custom board with LPC3152 CPU (similar to
Embedded Artists EA313x board) with uBlox GPS receiver
connected to I2C bus. It has been running over the night
without errors. 

Signed-off-by: Matej Kupljen <matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org>

--- i2c-pnx-orig.c	2011-02-02 21:30:19.000000000 +0100
+++ i2c-pnx.c	2011-02-02 21:49:02.000000000 +0100
@@ -78,7 +78,7 @@
  * Generate a START signal in the desired mode.
  */
 static int i2c_pnx_start(unsigned char slave_addr,
-	struct i2c_pnx_algo_data *alg_data)
+	struct i2c_pnx_algo_data *alg_data, int repeated)
 {
 	dev_dbg(&alg_data->adapter.dev, "%s(): addr 0x%x mode %d\n", __func__,
 		slave_addr, alg_data->mif.mode);
@@ -91,8 +91,8 @@
 		return -EINVAL;
 	}
 
-	/* First, make sure bus is idle */
-	if (wait_timeout(I2C_PNX_TIMEOUT, alg_data)) {
+	/* First, make sure bus is idle, if we are not doing repeated start */
+	if ((!repeated) && (wait_timeout(I2C_PNX_TIMEOUT, alg_data))) {
 		/* Somebody else is monopolizing the bus */
 		dev_err(&alg_data->adapter.dev,
 			"%s: Bus busy. Slave addr = %02x, cntrl = %x, stat = %x\n",
@@ -441,7 +441,7 @@
 i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
-	int rc = 0, completed = 0, i;
+	int rc = 0, completed = 0, i, repeated;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 	u32 stat = ioread32(I2C_REG_STS(alg_data));
 
@@ -457,6 +457,7 @@
 
 		pmsg = &msgs[i];
 		addr = pmsg->addr;
+		repeated = 0;
 
 		if (pmsg->flags & I2C_M_TEN) {
 			dev_err(&alg_data->adapter.dev,
@@ -481,16 +482,23 @@
 		/* initialize the completion var */
 		init_completion(&alg_data->mif.complete);
 
-		/* Enable master interrupt */
-		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
-				mcntrl_naie | mcntrl_drmie,
-			  I2C_REG_CTL(alg_data));
+		/* 
+		 * If this is not the only message, then we need to
+		 * send repeated start, but only if the flag allows it
+		 */
+		if((i > 0) && !(pmsg->flags & I2C_M_NOSTART))
+			repeated = 1;
 
 		/* Put start-code and slave-address on the bus. */
-		rc = i2c_pnx_start(addr, alg_data);
+		rc = i2c_pnx_start(addr, alg_data, repeated);
 		if (rc < 0)
 			break;
 
+		/* Enable master interrupt */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
+				mcntrl_naie | mcntrl_drmie,
+			  I2C_REG_CTL(alg_data));
+
 		/* Wait for completion */
 		wait_for_completion(&alg_data->mif.complete);
 

--=-eid762Rh+R0aVBwc9rB+--
