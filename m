From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
Date: Sat, 9 Jun 2012 12:34:47 +0200
Message-ID: <201206091234.47309.marex@denx.de>
References: <1339181689-22573-1-git-send-email-marex@denx.de> <CAM=Q2cuv0NQTYJH=+d6Na+JK5rGYsLiSmuX7g8T-_Ry7bs3fRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2cuv0NQTYJH=+d6Na+JK5rGYsLiSmuX7g8T-_Ry7bs3fRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shubhrajyoti Datta,

> On Sat, Jun 9, 2012 at 12:24 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > This patch configures the I2C bus timing registers according
> > to information passed via DT. Currently, 100kHz and 400kHz
> > modes are supported.
> >=20
> > Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> > CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> > Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> > CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    1 +
> >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >  drivers/i2c/busses/i2c-mxs.c                      |   54
> > +++++++++++++++++++++ 3 files changed, 57 insertions(+)
> >=20
> > V2: Use clock-frequency instead
> >=20
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 1bfc02d..d2bf750 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > @@ -4,6 +4,7 @@ Required properties:
> >  - compatible: Should be "fsl,<chip>-i2c"
> >  - reg: Should contain registers location and length
> >  - interrupts: Should contain ERROR and DMA interrupts
> > +- clock-frequency: desired I2C bus clock frequency in Hz.
> >=20
> >  Examples:
> >=20
> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28=
=2Edtsi
> > index a89da5a..714e63c 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
> > @@ -398,6 +398,7 @@
> >                                compatible =3D "fsl,imx28-i2c";
> >                                reg =3D <0x80058000 2000>;
> >                                interrupts =3D <111 68>;
> > +                               clock-frequency =3D <400000>;
> >                                status =3D "disabled";
> >                        };
> >=20
> > @@ -407,6 +408,7 @@
> >                                compatible =3D "fsl,imx28-i2c";
> >                                reg =3D <0x8005a000 2000>;
> >                                interrupts =3D <110 69>;
> > +                               clock-frequency =3D <400000>;
> >                                status =3D "disabled";
> >                        };
> >=20
> > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-=
mxs.c
> > index 04eb441..b4d083f 100644
> > --- a/drivers/i2c/busses/i2c-mxs.c
> > +++ b/drivers/i2c/busses/i2c-mxs.c
> > @@ -46,6 +46,10 @@
> >  #define MXS_I2C_CTRL0_DIRECTION                        0x00010000
> >  #define MXS_I2C_CTRL0_XFER_COUNT(v)            ((v) & 0x0000FFFF)
> >=20
> > +#define MXS_I2C_TIMING0                (0x10)
> > +#define MXS_I2C_TIMING1                (0x20)
> > +#define MXS_I2C_TIMING2                (0x30)
> > +
> >  #define MXS_I2C_CTRL1          (0x40)
> >  #define MXS_I2C_CTRL1_SET      (0x44)
> >  #define MXS_I2C_CTRL1_CLR      (0x48)
> > @@ -97,6 +101,24 @@
> >  #define MXS_CMD_I2C_READ       (MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
> >                                 MXS_I2C_CTRL0_MASTER_MODE)
> >=20
> > +struct mxs_i2c_speed_config {
> > +       uint32_t        timing0;
> > +       uint32_t        timing1;
> > +       uint32_t        timing2;
> > +};
> > +
> > +const struct mxs_i2c_speed_config mxs_i2c_95kHz_config =3D {
>=20
> You are using 95k?

Yes

> Didnt understand this.

What exactly, it's running (according to the datasheet) at 95kHz.

> > +       .timing0        =3D 0x00780030,
> > +       .timing1        =3D 0x00800030,
> > +       .timing2        =3D 0x0015000d,
> > +};
> > +
> > +const struct mxs_i2c_speed_config mxs_i2c_400kHz_config =3D {
> > +       .timing0        =3D 0x000f0007,
> > +       .timing1        =3D 0x001f000f,
> > +       .timing2        =3D 0x0015000d,
> > +};
> > +
>=20
> How are these values calculated?

They're not calculated, they're presented in the datasheet. There's no =
formula,=20
even though I believe one could be derived given enough effort.

Best regards,
Marek Vasut
