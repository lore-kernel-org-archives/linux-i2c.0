From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: i2c: jz4780: silence log flood on txabrt
Date: Wed, 12 Feb 2020 10:46:28 +0100
Message-ID: <20200212094628.GB1143@ninjato>
References: <cover.1581457290.git.hns@goldelico.com>
 <7facef52af9cff6ebe26ff321a7fd4f1ac640f74.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7facef52af9cff6ebe26ff321a7fd4f1ac640f74.1581457290.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>, Paul Boddie <paul-RlAhfoEKpGHe9xe1eoZjHA@public.gmane.org>, Alex Smith <alex.smith-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, James Hogan <jhogan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andi Kleen <ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz-knWk7/PSn+s@public.gmane.org>, Richard Fontana <rfontana-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Allison Randal <allison-wcfNWazeolPR7s880joybQ@public.gmane.org>, Stephen Boyd <swboyd@chro>
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The printout for txabrt is way too talkative. Reduce it to the minimum,
the rest can be gained by I2C core debugging and datasheet information.
Also, make it a debug printout, it won't help the regular user.

Reported-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---

Sorry, normally I don't do counter patches. Yet, this time I realized
that it would be faster to actually do what I envisioned than to
describe it in words. I hope you don't feel offended. This driver has
way too many dev_err anyhow, so this may be a start.

Obviously, I can't test, does it work for you?

 drivers/i2c/busses/i2c-jz4780.c | 36 ++-------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz478=
0.c
index 16a67a64284a..b426fc956938 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -78,25 +78,6 @@
=20
 #define X1000_I2C_DC_STOP		BIT(9)
=20
-static const char * const jz4780_i2c_abrt_src[] =3D {
-	"ABRT_7B_ADDR_NOACK",
-	"ABRT_10ADDR1_NOACK",
-	"ABRT_10ADDR2_NOACK",
-	"ABRT_XDATA_NOACK",
-	"ABRT_GCALL_NOACK",
-	"ABRT_GCALL_READ",
-	"ABRT_HS_ACKD",
-	"SBYTE_ACKDET",
-	"ABRT_HS_NORSTRT",
-	"SBYTE_NORSTRT",
-	"ABRT_10B_RD_NORSTRT",
-	"ABRT_MASTER_DIS",
-	"ARB_LOST",
-	"SLVFLUSH_TXFIFO",
-	"SLV_ARBLOST",
-	"SLVRD_INTX",
-};
-
 #define JZ4780_I2C_INTST_IGC		BIT(11)
 #define JZ4780_I2C_INTST_ISTT		BIT(10)
 #define JZ4780_I2C_INTST_ISTP		BIT(9)
@@ -576,21 +557,8 @@ static irqreturn_t jz4780_i2c_irq(int irqno, void *dev=
_id)
=20
 static void jz4780_i2c_txabrt(struct jz4780_i2c *i2c, int src)
 {
-	int i;
-
-	dev_err(&i2c->adap.dev, "txabrt: 0x%08x\n", src);
-	dev_err(&i2c->adap.dev, "device addr=3D%x\n",
-		jz4780_i2c_readw(i2c, JZ4780_I2C_TAR));
-	dev_err(&i2c->adap.dev, "send cmd count:%d  %d\n",
-		i2c->cmd, i2c->cmd_buf[i2c->cmd]);
-	dev_err(&i2c->adap.dev, "receive data count:%d  %d\n",
-		i2c->cmd, i2c->data_buf[i2c->cmd]);
-
-	for (i =3D 0; i < 16; i++) {
-		if (src & BIT(i))
-			dev_dbg(&i2c->adap.dev, "I2C TXABRT[%d]=3D%s\n",
-				i, jz4780_i2c_abrt_src[i]);
-	}
+	dev_dbg(&i2c->adap.dev, "txabrt: 0x%08x, cmd: %d, send: %d, recv: %d\n",
+		src, i2c->cmd, i2c->cmd_buf[i2c->cmd], i2c->data_buf[i2c->cmd]);
 }
=20
 static inline int jz4780_i2c_xfer_read(struct jz4780_i2c *i2c,
--=20
2.20.1


--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5DyXAACgkQFA3kzBSg
KbYoahAAtIAAtnnBgAg6FGqt5JLhVswxcJnxfAzMxAk708tbDSluUzpyiEXWCa52
d60BlamWi8++aJOMQ/iZ4k8wdvJX+9AN9JSyLtECMSFGhJVqDygeJGCA7N3qY33S
XBcvEIf2/OjfaWiTH22XXH9Pt6Hyo7ykrfv0LCD9OQwI5B+OvTfaM4WjXiPMP+dT
89R9yTKvQPIpV8G6hhj5BKF4TAbkmn2MKMNG+Z6vWlPToTQAGs732p470xXjSX+t
Oc5fNIt6NchL2pySrVsqDY84+GTRJ6J8by4lKAK3jQUxB3fzYqgri2z+BPBsXUkQ
IuaqB/a1gvmkAFl8JwfHvvgueeisXevGW5RdpPnWhvNPBDNg5BXgeSSjZDRLJCdA
rRO+2IUDoRyCLAnu7hV43GtIqiKQSidH8t9WfjLbspxici/1MISwfJPivPvbTBx3
AVFXKutTSBgR4r3Obtyb5cUZvQbYP+IvKArUHPTcFeVGZPFLhNF1OjgMAd6W/Q05
uZqYud9prhC71Hk9t3jW6rsXvKUfZkMESrMGsCnH0NUayvBkGv89r+B/HqqurLLn
5Hx1cO1AZpIxnO9QYaiQya6mCysTJZE7x3lpHznLBt6skM2JonKiqOUeTN8f3m86
oDJgVd4tkF2kIOweXNSxBWP7K3Xh5tCVqCdeEPz5fG7WlkGdKoI=
=LWAJ
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
