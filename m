From: <matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org>
Subject: Re: Add restart support to i2c-pnx
Date: Wed, 02 Feb 2011 13:59:20 +0100
Message-ID: <cd08bef3d940dd8ede1abc5bee93b190@imap.raing.si>
References: <acc33abdeea1fb1dd33f6919e7a4c4e4@imap.raing.si> <AANLkTimrs02v70OMkExsfBKhdOU1pxoFoAEn780qj_v-@mail.gmail.com> <aeed818a0cfb7836e7599aad4ffb9874@imap.raing.si> <20110202134102.1fd5b68d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110202134102.1fd5b68d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

>> >> To all,
>> >>
>> >> this patch adds support for restart to the i2c-pnx.c code.
>> >>
>> > 
>> > Sorry, can't see the patch itself :)
>> 
>> Hit send to quick :D
>> 
>> I hope now you can see it.
> 
> No, we still can't.

Something is removing my attachments :(

This time in-line:
---------------------------------------------------------------

Current code in i2c-pnx.c doesn't support sending messages
with restart condition in it, for example:
S - (address | W) - Sr - (address | R) - ... - P

This patch adds this to the current code. It has been
tested on a custom board with LPC3152 CPU (similar to
Embedded Artists EA313x board) with uBlox GPS receiver
connected to I2C bus. It has been running over the night
without errors. 
Also, the patch extends the timeout value, but this was
only needed, because there are a lot of data to be transferred
and the timeout occurred before all the data was transferred.

The pathch is against 2.6.28.2, but it should apply to the
cureent GIT version as well.

Signed-off-by: Matej Kupljen <matej.kupljen-nWYkTt+LGLL1KXRcyAk9cg@public.gmane.org>

--- i2c-pnx-orig.c	2010-12-14 17:48:40.000000000 +0100
+++ i2c-pnx.c	2011-02-01 23:48:42.000000000 +0100
@@ -54,7 +54,8 @@
 {
 	struct i2c_pnx_algo_data *data = adap->algo_data;
 	struct timer_list *timer = &data->mif.timer;
-	int expires = I2C_PNX_TIMEOUT / (1000 / HZ);
+	// We should probably take into account, how many bytes we need to
transfer!
+	int expires = I2C_PNX_TIMEOUT * 10 / (1000 / HZ);
 
 	del_timer_sync(timer);
 
@@ -74,7 +75,7 @@
  *
  * Generate a START signal in the desired mode.
  */
-static int i2c_pnx_start(unsigned char slave_addr, struct i2c_adapter
*adap)
+static int i2c_pnx_start(unsigned char slave_addr, struct i2c_adapter
*adap, int repeated)
 {
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 
@@ -89,8 +90,8 @@
 		return -EINVAL;
 	}
 
-	/* First, make sure bus is idle */
-	if (wait_timeout(I2C_PNX_TIMEOUT, alg_data)) {
+	/* First, make sure bus is idle, if we are not doing repeated start */
+	if ((!repeated) && (wait_timeout(I2C_PNX_TIMEOUT, alg_data))) {
 		/* Somebody else is monopolizing the bus */
 		dev_err(&adap->dev, "%s: Bus busy. Slave addr = %02x, "
 		       "cntrl = %x, stat = %x\n",
@@ -439,7 +440,7 @@
 i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
-	int rc = 0, completed = 0, i;
+	int rc = 0, completed = 0, i, repeated;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
 	u32 stat = ioread32(I2C_REG_STS(alg_data));
 
@@ -454,6 +455,7 @@
 
 		pmsg = &msgs[i];
 		addr = pmsg->addr;
+		repeated = 0;
 
 		if (pmsg->flags & I2C_M_TEN) {
 			dev_err(&adap->dev,
@@ -479,16 +481,22 @@
 		/* initialize the completion var */
 		init_completion(&alg_data->mif.complete);
 
-		/* Enable master interrupt */
-		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
-				mcntrl_naie | mcntrl_drmie,
-			  I2C_REG_CTL(alg_data));
+		/* If this is not the only message, then we need to
+		 * send repeated start, but only if the flaga allow us
+		 */
+		if((i > 0) && !(pmsg->flags & I2C_M_NOSTART))
+			repeated = 1;
 
 		/* Put start-code and slave-address on the bus. */
-		rc = i2c_pnx_start(addr, adap);
+		rc = i2c_pnx_start(addr, adap, repeated);
 		if (rc < 0)
 			break;
 
+		/* Enable master interrupt */
+		iowrite32(ioread32(I2C_REG_CTL(alg_data)) | mcntrl_afie |
+				mcntrl_naie | mcntrl_drmie,
+			  I2C_REG_CTL(alg_data));
+
 		/* Wait for completion */
 		wait_for_completion(&alg_data->mif.complete);
 
