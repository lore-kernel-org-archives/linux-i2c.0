From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: mxs: only flag completion when queue is completely done
Date: Fri, 20 Jan 2012 13:56:20 +0100
Message-ID: <1327064180-23540-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The hardware generates an interrupt for every completed command in the
queue while the code assumed that it will only generate one interrupt
when the queue is empty. So, explicitly check if the queue is really
empty. This patch fixed problems which occurred due to high traffic on
the bus. While we are here, move the completion-initialization after th=
e
parameter error checking.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index 7e78f7c..3d471d5 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -72,6 +72,7 @@
=20
 #define MXS_I2C_QUEUESTAT	(0x70)
 #define MXS_I2C_QUEUESTAT_RD_QUEUE_EMPTY        0x00002000
+#define MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK	0x0000001F
=20
 #define MXS_I2C_QUEUECMD	(0x80)
=20
@@ -219,14 +220,14 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *a=
dap, struct i2c_msg *msg,
 	int ret;
 	int flags;
=20
-	init_completion(&i2c->cmd_complete);
-
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
=20
 	if (msg->len =3D=3D 0)
 		return -EINVAL;
=20
+	init_completion(&i2c->cmd_complete);
+
 	flags =3D stop ? MXS_I2C_CTRL0_POST_SEND_STOP : 0;
=20
 	if (msg->flags & I2C_M_RD)
@@ -286,6 +287,7 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void *=
dev_id)
 {
 	struct mxs_i2c_dev *i2c =3D dev_id;
 	u32 stat =3D readl(i2c->regs + MXS_I2C_CTRL1) & MXS_I2C_IRQ_MASK;
+	bool is_last_cmd;
=20
 	if (!stat)
 		return IRQ_NONE;
@@ -300,9 +302,14 @@ static irqreturn_t mxs_i2c_isr(int this_irq, void =
*dev_id)
 	else
 		i2c->cmd_err =3D 0;
=20
-	complete(&i2c->cmd_complete);
+	is_last_cmd =3D (readl(i2c->regs + MXS_I2C_QUEUESTAT) &
+		MXS_I2C_QUEUESTAT_WRITE_QUEUE_CNT_MASK) =3D=3D 0;
+
+	if (is_last_cmd || i2c->cmd_err)
+		complete(&i2c->cmd_complete);
=20
 	writel(stat, i2c->regs + MXS_I2C_CTRL1_CLR);
+
 	return IRQ_HANDLED;
 }
=20
--=20
1.7.8.3
