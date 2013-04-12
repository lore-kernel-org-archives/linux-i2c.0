From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: I2C_M_RECV_LEN for i2c-mxs
Date: Fri, 12 Apr 2013 11:30:03 +0200
Message-ID: <20130412093003.GE30416@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

I'm currently trying to teach the i2c-mxs driver to handle the
I2C_M_RECV_LEN flag but failed up to now. Maybe someone has an good ide=
a
how to make it running?

My current patch looks as follows:

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  * Freescale MXS I2C bus driver
  *
@@ -289,14 +290,23 @@ write_init_pio_fail:
 static int mxs_i2c_pio_wait_dmareq(struct mxs_i2c_dev *i2c)
 {
 	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
+	u32 reg, reg_old;
+	int first =3D 1;
=20
-	while (!(readl(i2c->regs + MXS_I2C_DEBUG0) &
+	while (!(reg =3D readl(i2c->regs + MXS_I2C_DEBUG0) &
 		MXS_I2C_DEBUG0_DMAREQ)) {
+		if (first || reg !=3D reg_old) {
+			pr_debug("%s: I2C_DEBUG =3D 0x%08x\n", __func__, reg);
+			first =3D 0;
+			reg_old =3D reg;
+		}
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 		cond_resched();
 	}
=20
+	pr_debug("%s: I2C_DEBUG =3D 0x%08x\n", __func__, reg);
+
 	writel(MXS_I2C_DEBUG0_DMAREQ, i2c->regs + MXS_I2C_DEBUG0_CLR);
=20
 	return 0;
@@ -338,6 +348,9 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapte=
r *adap,
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_CLR);
=20
 	if (msg->flags & I2C_M_RD) {
+		int readlen =3D msg->len;
+		size_t buf_offset =3D 0;
+
 		addr_data |=3D I2C_SMBUS_READ;
=20
 		/* SELECT command. */
@@ -354,19 +367,39 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adap=
ter *adap,
 		if (ret)
 			return ret;
=20
+		if (msg->flags & I2C_M_RECV_LEN) {
+			pr_debug("read first byte\n");
+			writel(MXS_I2C_CTRL0_RUN | MXS_I2C_CTRL0_MASTER_MODE |
+				MXS_I2C_CTRL0_XFER_COUNT(1),
+				i2c->regs + MXS_I2C_CTRL0);
+
+			ret =3D mxs_i2c_pio_wait_dmareq(i2c);
+			if (ret)
+				return ret;
+
+			data =3D readl(i2c->regs + MXS_I2C_DATA) & 0xff;
+			if (data > I2C_SMBUS_BLOCK_MAX)
+				return -EPROTO;
+
+			msg->len +=3D data;
+			readlen +=3D data - 1;
+		}
+
+		pr_debug("%s: data =3D %u, msg->len =3D %u, readlen =3D %u\n", __fun=
c__, data, msg->len, readlen);
+
 		/* READ command. */
 		writel(MXS_I2C_CTRL0_RUN | MXS_CMD_I2C_READ | flags |
-			MXS_I2C_CTRL0_XFER_COUNT(msg->len),
+			MXS_I2C_CTRL0_XFER_COUNT(readlen),
 			i2c->regs + MXS_I2C_CTRL0);
=20
-		for (i =3D 0; i < msg->len; i++) {
+		for (i =3D 0; i < readlen; i++) {
 			if ((i & 3) =3D=3D 0) {
 				ret =3D mxs_i2c_pio_wait_dmareq(i2c);
 				if (ret)
 					return ret;
 				data =3D readl(i2c->regs + MXS_I2C_DATA);
 			}
-			msg->buf[i] =3D data & 0xff;
+			msg->buf[buf_offset + i] =3D data & 0xff;
 			data >>=3D 8;
 		}
 	} else {
@@ -438,6 +471,9 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *ada=
p, struct i2c_msg *msg,
 	 * is set to 8 bytes, transfers shorter than 8 bytes are transfered
 	 * using PIO mode while longer transfers use DMA. The 8 byte border i=
s
 	 * based on this empirical measurement and a lot of previous frobbing=
=2E
+	 *
+	 * Note that only mxs_i2c_pio_setup_xfer has support for I2C_M_RECV_L=
EN.
+	 * That is OK as msg->len is <=3D 2 when that flag is set.
 	 */
 	if (msg->len < 8) {
 		ret =3D mxs_i2c_pio_setup_xfer(adap, msg, flags);
@@ -497,6 +533,8 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *=
dev_id)
 	struct mxs_i2c_dev *i2c =3D dev_id;
 	u32 stat =3D readl(i2c->regs + MXS_I2C_CTRL1) & MXS_I2C_IRQ_MASK;
=20
+	pr_debug("%s: stat =3D 0x%08x\n", __func__, stat);
+
 	if (!stat)
 		return IRQ_NONE;
=20
The problem is that mxs_i2c_pio_wait_dmareq that is called in the if
(msg->flags & I2C_M_RECV_LEN) block times out, i.e. the hardware doesn'=
t
set MXS_I2C_DEBUG0_DMAREQ after the read request for the length byte.
The same problem happens when I use the dma path to implement
I2C_M_RECV_LEN support. In that case mxs_i2c_isr is called, but the dma
callback is not.

On the wire the following happens for a i2c_smbus_read_block_data call
(from userspace):

	S $clientaddr W A $command A Sr $clientaddr R A 0x01

as expected and then the i.MX28 starts sending an ack:

	SDA ..____________/=C2=AF=C2=AF=C2=AF\____
	SCL .._/=C2=AF\_/=C2=AF\_/=C2=AF\_/=C2=AF\_/=C2=AF=C2=AF=C2=AF
	    ..  5   6   7   8   9
              slave sending   | mxs starts
	      length byte (1) | to send A

but MXS_I2C_DEBUG0 stays 0 while mxs_i2c_pio_wait_dmareq waits. After
that a P is put on the wire. That fits to what I see when using dma:
HW_APBX_CH6_DEBUG1.STATEMACHINE =3D=3D 0x15 meaning:

	WAIT_END =E2=80=94 When the Wait for Command End bit is set, the state
	machine enters this state until the DMA device indicates that
	the command is complete.

So the problem seems to be that the i2c core fails to tell the dma core
that it's done.

Other things I wonder about in the i2c-mxs driver:

 - I don't understand why RETAIN_CLOCK is added to MXS_CMD_I2C_SELECT.
   From my understanding of i2c and the hardware manual I'd say this is
   only relevant for slave mode? Setting RETAIN_CLOCK for the cycle tha=
t
   reads the length byte is broken in a different way. (After reading
   the 1 the mxs pulls low SDA for acking but doesn't pulse SCL. Then
   another 9 clock pulses are sent with SDA high. After the 9th falling
   edge SDA is pulled low by the i.MX28 and then both lines go back to =
1
   at the same time. I will debug a bit more here.)
   So it seems RETAIN_CLOCK has a meaning for master mode, too. If you
   have a more concrete perception of its meaning it would be great if
   you could share it.

 - Is it correct to have I2C_FUNC_SMBUS_EMUL in .functionality without
   supporting I2C_M_RECV_LEN?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
