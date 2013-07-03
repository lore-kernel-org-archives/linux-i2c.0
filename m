From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Use DMA mode even for small transfers
Date: Wed, 3 Jul 2013 06:37:05 +0200
Message-ID: <201307030637.05324.marex@denx.de>
References: <1372713261-20551-1-git-send-email-festevam@gmail.com> <1372752969.4277.8.camel@weser.hi.pengutronix.de> <201307030438.50069.marex@denx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xp60R/GMxpzOFIE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307030438.50069.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--Boundary-00=_xp60R/GMxpzOFIE
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

> Dear Lucas Stach,
> 
> > Am Montag, den 01.07.2013, 18:14 -0300 schrieb Fabio Estevam:
> > > From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > 
> > > Recently we have been seing some reports about PIO mode not working
> > > properly.
> > > 
> > > - http://www.spinics.net/lists/linux-i2c/msg11985.html
> > > - http://marc.info/?l=linux-i2c&m=137235593101385&w=2
> > > - https://lkml.org/lkml/2013/6/24/430
> > > 
> > > Let's use DMA mode even for small transfers.
> > > 
> > > Without this patch, i2c reads the incorrect sgtl5000 version on a
> > > mx28evk when touchscreen is enabled:
> > > 
> > > [    5.856270] sgtl5000 0-000a: Device with ID register 0 is not a
> > > sgtl5000 [    9.877307] sgtl5000 0-000a: ASoC: failed to probe CODEC
> > > -19 [    9.883528] mxs-sgtl5000 sound.12: ASoC: failed to instantiate
> > > card -19 [    9.892955] mxs-sgtl5000 sound.12: snd_soc_register_card
> > > failed (-19)
> > > 
> > > Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> > > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > ---
> > > Applies against 3.10
> > > 
> > > Changes since v1:
> > > - Keep the PIO code
> > > 
> > >  drivers/i2c/busses/i2c-mxs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > b/drivers/i2c/busses/i2c-mxs.c index 2039f23..6d8094d 100644
> > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > @@ -494,7 +494,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter
> > > *adap, struct i2c_msg *msg,
> > > 
> > >  	 * based on this empirical measurement and a lot of previous
> > >  	 frobbing. */
> > >  	
> > >  	i2c->cmd_err = 0;
> > > 
> > > -	if (msg->len < 8) {
> > > +	if (0) {	/* disable PIO mode until a proper fix is made */
> > > 
> > >  		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
> > >  		if (ret)
> > >  		
> > >  			mxs_i2c_reset(i2c);
> > 
> > I still plan to take another look at the PIO mode, but higher priority
> > things keep popping up in front of me. So this patch is:
> > Acked-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Ok, update. So far I arrived at a point where I can avoid the PIO trouble.
> 
> If I only do transfers shorter or equal in length to 3 bytes via PIO, it
> works as expected. If the transfer is longer, the LA shows very long
> transfer happening actually. Therefore, the pumping of data in loop
> to/from PIO via the DATA register doesn't work.
> 
> I will update you more later, once I figure out something else. Now I need
> some sleep.

I'm attaching a patch. Alex, please give it a go and see if it fixes your issue. 
It is _VERY_ ugly.

The basic idea behind the the patch is that, as (attempted to be) explained 
above, subsequent writes to DATA register in PIO mode cause constant generation 
of clock on the bus and therefore a very long transfer of zero data. This 
confuses the I2C peripherals of course.

The patch implements clock stretching for PIO writes (maybe we need this for 
reads too) by making the controller blast out only 4 (or less) bytes of data in 
each write into the DATA register. To prevent interruption of the transfer 
between writes into the DATA register, the SCK is held low using the 
RETAIN_CLOCK bit.

But (!) here comes the caveat. The PIO was introduced to speed up small 
transfers. Introducing clock stretching into PIO mode operation might completely 
remove this advantage. This has to be measured again.

I will continue once I sleep a little. Pardon my {language, code}, it's too 
early in the morning already.

Best regards,
Marek Vasut

--Boundary-00=_xp60R/GMxpzOFIE
Content-Type: text/x-patch;
  charset="UTF-8";
  name="ugly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ugly.patch"

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index df8ff5a..b125183 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -35,6 +35,7 @@
 
 #define MXS_I2C_CTRL0		(0x00)
 #define MXS_I2C_CTRL0_SET	(0x04)
+#define MXS_I2C_CTRL0_CLR	(0x08)
 
 #define MXS_I2C_CTRL0_SFTRST			0x80000000
 #define MXS_I2C_CTRL0_RUN			0x20000000
@@ -123,6 +124,32 @@ struct mxs_i2c_dev {
 	bool				dma_read;
 };
 
+static void mxs_i2c_dump(struct mxs_i2c_dev *i2c, int rd)
+{
+	pr_err("=====================================\n");
+
+	pr_err("0x000: %08x %08x %08x %08x\n",
+		readl(i2c->regs + 0x00),
+		readl(i2c->regs + 0x10),
+		readl(i2c->regs + 0x20),
+		readl(i2c->regs + 0x30));
+	pr_err("0x040: %08x %08x %08x %08x\n",
+		readl(i2c->regs + 0x40),
+		readl(i2c->regs + 0x50),
+		readl(i2c->regs + 0x60),
+		readl(i2c->regs + 0x70));
+	pr_err("0x080: %08x %08x %08x %08x\n",
+		readl(i2c->regs + 0x80),
+		rd ? readl(i2c->regs + 0x90) : 0,
+		rd ? readl(i2c->regs + 0xa0) : 0,
+		readl(i2c->regs + 0xb0));
+	pr_err("0x0c0: %08x %08x\n",
+		readl(i2c->regs + 0xc0),
+		readl(i2c->regs + 0xd0));
+
+	pr_err("=====================================\n");
+}
+
 static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 {
 	stmp_reset_block(i2c->regs);
@@ -366,6 +393,7 @@ static void mxs_i2c_pio_trigger_cmd(struct mxs_i2c_dev *i2c, u32 cmd)
 	writel(reg, i2c->regs + MXS_I2C_CTRL0);
 }
 
+#include <linux/delay.h>
 static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
@@ -401,6 +429,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		mxs_i2c_pio_trigger_cmd(i2c,
 					MXS_CMD_I2C_READ | flags |
 					MXS_I2C_CTRL0_XFER_COUNT(msg->len));
+//		mxs_i2c_dump(i2c, 0);
 
 		for (i = 0; i < msg->len; i++) {
 			if ((i & 3) == 0) {
@@ -418,38 +447,66 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		addr_data |= I2C_SMBUS_WRITE;
 
 		/* WRITE command. */
-		mxs_i2c_pio_trigger_cmd(i2c,
-					MXS_CMD_I2C_WRITE | flags |
-					MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1));
+//		mxs_i2c_pio_trigger_cmd(i2c,
+//					MXS_CMD_I2C_WRITE | flags |
+//					MXS_I2C_CTRL0_XFER_COUNT(msg->len + 1));
 
 		/*
 		 * The LSB of data buffer is the first byte blasted across
 		 * the bus. Higher order bytes follow. Thus the following
 		 * filling schematic.
 		 */
+
 		data = addr_data << 24;
 		for (i = 0; i < msg->len; i++) {
 			data >>= 8;
 			data |= (msg->buf[i] << 24);
 			if ((i & 3) == 2) {
-				ret = mxs_i2c_pio_wait_dmareq(i2c);
-				if (ret)
-					return ret;
+				mxs_i2c_pio_trigger_cmd(i2c,
+					MXS_CMD_I2C_WRITE /*| flags*/ | (1 << 21) |
+					MXS_I2C_CTRL0_XFER_COUNT(4));
+
+	//			ret = mxs_i2c_pio_wait_dmareq(i2c);
+	//			if (ret)
+	//				return ret;
+
+//				mxs_i2c_dump(i2c, 0);
+//				pr_err("writing %08x\n", data);
+
 				writel(data, i2c->regs + MXS_I2C_DATA);
-				writel(MXS_I2C_DEBUG0_DMAREQ,
-				       i2c->regs + MXS_I2C_DEBUG0_CLR);
+//				writel(1 << 21, i2c->regs + MXS_I2C_CTRL0_SET);
+
+	//			writel(MXS_I2C_DEBUG0_DMAREQ,
+	//			       i2c->regs + MXS_I2C_DEBUG0_CLR);
+//				mdelay(20);
+//				mxs_i2c_dump(i2c, 0);
+
 			}
 		}
 
 		shifts_left = 24 - (i & 3) * 8;
 		if (shifts_left) {
 			data >>= shifts_left;
-			ret = mxs_i2c_pio_wait_dmareq(i2c);
-			if (ret)
-				return ret;
+			if (msg->len <= 3)
+				flags |= MXS_CMD_I2C_WRITE;
+			mxs_i2c_pio_trigger_cmd(i2c,
+				MXS_I2C_CTRL0_MASTER_MODE | MXS_I2C_CTRL0_DIRECTION | flags |
+				MXS_I2C_CTRL0_XFER_COUNT((i & 3) + 1));
+
+	//		ret = mxs_i2c_pio_wait_dmareq(i2c);
+	//		if (ret)
+	//			return ret;
+
 			writel(data, i2c->regs + MXS_I2C_DATA);
-			writel(MXS_I2C_DEBUG0_DMAREQ,
-			       i2c->regs + MXS_I2C_DEBUG0_CLR);
+
+//			mxs_i2c_dump(i2c, 0);
+//			pr_err("writing %08x %i\n", data, (i & 3) + 1);
+
+	//		writel(MXS_I2C_DEBUG0_DMAREQ,
+	//		       i2c->regs + MXS_I2C_DEBUG0_CLR);
+//			mdelay(20);
+//			mxs_i2c_dump(i2c, 0);
+
 		}
 	}
 
@@ -480,8 +537,10 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	flags = stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
 
-	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
-		msg->addr, msg->len, msg->flags, stop);
+	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x [%c], stop: %d\n",
+		msg->addr, msg->len, msg->flags, msg->flags & I2C_M_RD ? 'R':'W', stop);
+//	if (msg->len)
+//		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 1, msg->buf, msg->len, false);
 
 	if (msg->len == 0)
 		return -EINVAL;
@@ -497,6 +556,7 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 		ret = mxs_i2c_pio_setup_xfer(adap, msg, flags);
 		if (ret)
 			mxs_i2c_reset(i2c);
+		i2c->cmd_err = ret;
 	} else {
 		INIT_COMPLETION(i2c->cmd_complete);
 		ret = mxs_i2c_dma_setup_xfer(adap, msg, flags);

--Boundary-00=_xp60R/GMxpzOFIE--
