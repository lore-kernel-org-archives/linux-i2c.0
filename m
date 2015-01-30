From: Amit Tomar <Amit.Tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c/mpc: Fix ISR return value
Date: Fri, 30 Jan 2015 10:24:10 +0000
Message-ID: <BL2PR03MB449C87445D2FD1F15E9D33483310@BL2PR03MB449.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

ISR should not return IRQ_HANDLED for not handling anything.=20
This patch fixes the return value of ISR for the same case.


Signed-off-by: Amit Singh Tomar <amit.tomar-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
drivers/i2c/busses/i2c-mpc.c |=A0=A0=A0 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.=
c index 0edf630..7a3136f 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -95,8 +95,9 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
=A0=A0=A0=A0=A0=A0=A0 i2c->interrupt =3D readb(i2c->base + MPC_I2C_SR);
=A0=A0=A0=A0=A0=A0=A0 writeb(0, i2c->base + MPC_I2C_SR);
=A0=A0=A0=A0=A0=A0=A0 wake_up(&i2c->queue);
+=A0=A0 =A0=A0  return IRQ_HANDLED;
=A0=A0=A0 }
-=A0 return IRQ_HANDLED;
+ =A0return IRQ_NONE;
}

/* Sometimes 9th clock pulse isn't generated, and slave doesn't release
--
1.7.9.5
=20
