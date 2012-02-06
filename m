From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers
 driver
Date: Mon, 6 Feb 2012 23:47:14 +0100
Message-ID: <20120206224714.GB25703@pengutronix.de>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
 <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <ninja-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Thanks for your contribution! Is there a free datasheet for this contro=
ller
> > available?
>=20
> sorry. not available to public yet.

:( Can you cite what "SIRFSOC_I2C_NACK" does?
>=20
> >> +struct sirfsoc_i2c {
> >> + =A0 =A0 void __iomem *base;
> >> + =A0 =A0 struct clk *clk;
> >> + =A0 =A0 unsigned long speed; =A0 =A0/* I2C SCL frequency */
> >> + =A0 =A0 int irq;
> >
> > Do you really need those two?
>=20
> irq can be deleted. speed is not really needed if you don't like.

It is not about "like". It is not needed, or?

> >> +static void i2c_sirfsoc_queue_cmd(struct sirfsoc_i2c *siic)
> >> +{
> >> + =A0 =A0 u32 regval;
> >> + =A0 =A0 int i =3D 0;
> >> +
> >> + =A0 =A0 if (siic->msg_read) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 while (((siic->finished_len + i) < siic->msg=
_len)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (siic->cmd_ptr < SIRFSOC_=
I2C_CMD_BUF_MAX)) {
> >
> > Either use a different indentation for the above line or add a newline =
below.
> > It is hard to see where the while() ends and the code block starts.
>=20
> i just want to make sure what you want is:
>=20
>              while (((siic->finished_len + i) < siic->msg_len)
>                      &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)
>                      ) {
> ?
> or something else?

I thought of (which is simpler IMO):

>              while (((siic->finished_len + i) < siic->msg_len)
>                      &&(siic->cmd_ptr < SIRFSOC_I2C_CMD_BUF_MAX)) {
>
>  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D SIRFSOC_I2C_READ | SI=
RFSOC_I2C_CMD_RP(0);


The other solution would be (not sure if it fits the line length):

> >> + =A0 =A0 =A0 =A0 =A0 =A0 while (((siic->finished_len + i) < siic->msg=
_len)
> >> + =A0 	=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (siic->cmd_ptr < SIRFSOC=
_I2C_CMD_BUF_MAX)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regval =3D SIRFSOC_I2C_READ =
| SIRFSOC_I2C_CMD_RP(0);

The idea is to make it easier (visually) what is the while-condition and wh=
ere
is the code of the while-block. I thought that was difficult in original ve=
rsion.

> >> +static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_=
msg *msg)
> >> +{
> >> + =A0 =A0 u32 regval =3D readl(siic->base + SIRFSOC_I2C_CTRL);
> >> + =A0 =A0 int timeout =3D (msg->len + 1) * 50;
> >
> > That looks broken. What is 50 here?
>=20
> just multiple of xfer bytes for defining a timeout. i might have a commen=
t here.

That probably won't help. I'd think you want a *_to_jiffies() here to defin=
e a
proper timeout value in usecs/msecs?

> >> + =A0 =A0 siic->irq =3D platform_get_irq(pdev, 0);
> >> + =A0 =A0 if (siic->irq < 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 }
> >
> > return the error code here?
>=20
> out lable will free resources and return error code.

Sorry, I meant the error code you received which is in siic->irq.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8wWHIACgkQD27XaX1/VRvSVgCfa4p1wkRgC3QuVEiVXn4F2dVS
0qUAoLxPAH5Ujt8sMvSHNAL6Qalc4hMM
=b/gp
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
