From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v5] I2C: add CSR SiRFprimaII on-chip I2C controllers
 driver
Date: Tue, 7 Feb 2012 16:11:58 +0100
Message-ID: <20120207151117.GJ2539@pengutronix.de>
References: <1327846668-3053-1-git-send-email-21cnbao@gmail.com>
 <20120205223757.GA10680@nekote.pengutronix.de>
 <CAGsJ_4yHn1M3s6CPezaW_jwOcsX6NuaZRHcNWX0qnSfhx30AHQ@mail.gmail.com>
 <20120206224714.GB25703@pengutronix.de>
 <CAGsJ_4yJOg8XNfD=tgwPU_57BroBOBGvA428tG6_eUnYX2v8OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yJOg8XNfD=tgwPU_57BroBOBGvA428tG6_eUnYX2v8OQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Xiangzhen Ye <Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Yuping Luo <Yuping.Luo-kQvG35nSl+M@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Barry,

> if ACK is not received, an interrupt will be got and related register
> status can show this error. that is just a common feature in almost
> all i2c controllers? so the naming is confused. i just copied it from
> the spec.

Yes, this is common and yes, the naming is confusing :) This is why I
asked if it really does what I believed it does. All is fine, no need
for a change.

> the mail webpages and clients really fails to show the difference. i

Not all of them. gmane looks OK both in web-interface and via NNTP.

> >> >> + =A0 =A0 siic->irq =3D platform_get_irq(pdev, 0);
> >> >> + =A0 =A0 if (siic->irq < 0) {
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> >> + =A0 =A0 }
> >> >
> >> > return the error code here?
> >>
> >> out lable will free resources and return error code.
> >
> > Sorry, I meant the error code you received which is in siic->irq.
>=20
> ok. err =3D -ENXIO

err =3D ssic->irq?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8xPz4ACgkQD27XaX1/VRtvIQCfUDOCGPPEhesRQazh6CNNr5wi
mr8Anj7klqW5JeTitLkjfMnm8eHVm7Km
=ogoc
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
