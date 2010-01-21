From: Valentin Longchamp <valentin.longchamp-p8DiymsW2f8@public.gmane.org>
Subject: [PATCH] mxc i2c: let time to generate stop bit
Date: Thu, 21 Jan 2010 18:55:32 +0100
Message-ID: <1264096532-23580-1-git-send-email-valentin.longchamp@epfl.ch>
References: <20100121114216.GA3738@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100121114216.GA3738-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Valentin Longchamp <valentin.longchamp-p8DiymsW2f8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

After generating the stop bit by changing MSTA from 1 to 0,
the i2c_imx->stopped was immediatly set to 1. The second test
on i2c_imx->stopped then is correct and the controller never
waits if the bus is busy. This patch corrects this.

On mx31moboard, stop bit was not generated on single write transfers.
This was kept unnoticed as other transfers are made afterwards that
help the write recipient to resynchronize.

Thanks to Philippe and Michael for the debugging.

Signed-off-by: Valentin Longchamp <valentin.longchamp-p8DiymsW2f8@public.gmane.org>
Signed-off by: Philippe R=C3=A9tornaz <philippe.retornaz-p8DiymsW2f8@public.gmane.org>
Reported-by: Michael Bonani <michael.bonani-p8DiymsW2f8@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index e3654d6..602b30e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -226,7 +226,6 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c=
_imx)
 		temp =3D readb(i2c_imx->base + IMX_I2C_I2CR);
 		temp &=3D ~(I2CR_MSTA | I2CR_MTX);
 		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
-		i2c_imx->stopped =3D 1;
 	}
 	if (cpu_is_mx1()) {
 		/*
@@ -236,8 +235,10 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2=
c_imx)
 		udelay(i2c_imx->disable_delay);
 	}
=20
-	if (!i2c_imx->stopped)
+	if (!i2c_imx->stopped) {
 		i2c_imx_bus_busy(i2c_imx, 0);
+		i2c_imx->stopped =3D 1;
+	}
=20
 	/* Disable I2C controller */
 	writeb(0, i2c_imx->base + IMX_I2C_I2CR);
--=20
1.6.3.3
