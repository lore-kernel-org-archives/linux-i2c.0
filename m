From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6] I2C: add CSR SiRFprimaII on-chip I2C controllers
 driver
Date: Fri, 24 Feb 2012 13:25:24 +0100
Message-ID: <20120224122524.GG2479@pengutronix.de>
References: <1328714915-12287-1-git-send-email-21cnbao@gmail.com>
 <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2ct7EHht06uCHVpR_HoO39WZjO2+N6DhxuMthRQRQBRnyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Barry,

On Thu, Feb 16, 2012 at 10:24:00PM +0530, Shubhrajyoti Datta wrote:

please consider these comments.

Thanks,

   Wolfram

> Hello,
>=20
> On Wed, Feb 8, 2012 at 8:58 PM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
> >
> > SiRFprimaII is the latest generation application processor from CSR=E2=
=80=99s
> > multi-function SoC product family.
> > The SoC support codes are in arch/arm/mach-prima2 from Linux mainline
> > 3.0.
> > There are two I2C controllers on primaII, features include:
> > * Two I2C controller modules are on chip
> > * RISC I/O bus read write register
> > * Up to 16 bytes data buffer for issuing commands and writing data
> > =C2=A0at the same time
> > * Up to 16 commands, and receiving read data 16 bytes at a time
> > * Error INT report (ACK check)
> > * No-ACK bus protocols (SCCB bus protocols)
> >
> > Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
> > Signed-off-by: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>
> > Signed-off-by: Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>
> > Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> > ---
> > =C2=A0-v6:
> > =C2=A0fix/cleanup lots of minor issues pointed out by wolfram;
> > =C2=A0add OF property clock-frequency to support freq setting by DT;
> > =C2=A0add lost devicetree binding document;
> >
> > =C2=A0Documentation/devicetree/bindings/i2c/sirf-i2c.txt | =C2=A0 19 +
> > =C2=A0drivers/i2c/busses/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +
> > =C2=A0drivers/i2c/busses/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> > =C2=A0drivers/i2c/busses/i2c-sirf.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0459 ++++++++++++++++++++
> > =C2=A04 files changed, 489 insertions(+), 0 deletions(-)
> > =C2=A0create mode 100644 Documentation/devicetree/bindings/i2c/sirf-i2c=
=2Etxt
> > =C2=A0create mode 100644 drivers/i2c/busses/i2c-sirf.c
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/sirf-i2c.txt b/Docum=
entation/devicetree/bindings/i2c/sirf-i2c.txt
> > new file mode 100644
> > index 0000000..7baf9e1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/sirf-i2c.txt
> <snip>
>=20
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_stat & SIRFS=
OC_I2C_STAT_NACK)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&siic->adapter.dev, "ACK not received\n");
> Could we send stop here?
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 dev_err(&siic->adapter.dev, "I2C error\n");
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 complete(&siic->done=
);
> <Snip>
>=20
> > +static int i2c_sirfsoc_resume(struct device *dev)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platform_dev=
ice(dev);
> > + =C2=A0 =C2=A0 =C2=A0 struct i2c_adapter *adapter =3D platform_get_drv=
data(pdev);
> > + =C2=A0 =C2=A0 =C2=A0 struct sirfsoc_i2c *siic =3D adapter->algo_data;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 clk_enable(siic->clk);
> > + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_RESET, siic->base + SIRFSOC_I=
2C_CTRL);
> Could you explain why is a reset needed.
> Or am I missing something.
>=20
> > + =C2=A0 =C2=A0 =C2=A0 writel(SIRFSOC_I2C_CORE_EN | SIRFSOC_I2C_MASTER_=
MODE,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siic->base + SIRFSOC=
_I2C_CTRL);
> > + =C2=A0 =C2=A0 =C2=A0 writel(siic->clk_div, siic->base + SIRFSOC_I2C_C=
LK_CTRL);
> > + =C2=A0 =C2=A0 =C2=A0 writel(siic->sda_delay, siic->base + SIRFSOC_I2C=
_SDA_DELAY);
> > + =C2=A0 =C2=A0 =C2=A0 clk_disable(siic->clk);
> > + =C2=A0 =C2=A0 =C2=A0 return 0;
> > +}
> > +
> > +static const struct dev_pm_ops i2c_sirfsoc_pm_ops =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .suspend =3D i2c_sirfsoc_suspend,
> > + =C2=A0 =C2=A0 =C2=A0 .resume =3D i2c_sirfsoc_resume,
> Could we use simple dev_pm ops here?
>=20
> > +};
> > +#endif
> > +
> > +static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst=
 =3D {
> > + =C2=A0 =C2=A0 =C2=A0 { .compatible =3D "sirf,prima2-i2c", },
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9HgbQACgkQD27XaX1/VRuRgACfZk79s/N7O5/XTEdrgNkPAZyY
HYoAn0iRiVqk0xg1tiPDJ4M0wwn0weNf
=VBsB
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
