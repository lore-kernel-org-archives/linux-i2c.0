From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V2] mach-pxa/viper: Fix timeout usage for I2C
Date: Tue, 20 Apr 2010 03:03:52 +0200
Message-ID: <20100420010352.GB19957@pengutronix.de>
References: <20100412213235.1688dda8@hyperion.delvare> <1271591309-22567-1-git-send-email-w.sang@pengutronix.de> <z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <z2xf17812d71004191720o3f8660a4kdd31ef9cdb6beae9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2010 at 08:20:46AM +0800, Eric Miao wrote:
> On Sun, Apr 18, 2010 at 7:48 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wro=
te:
> > The timeout value is in jiffies, so it should be using HZ, not a plain
> > number. Assume with HZ=3D100 '100' means 1s here and adapt accordingly.
> >
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> > Cc: Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>
> > Cc: Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Cc: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> >
> > Changes since V1:
> >
> > * Don't assume 100 means 100ms
> >
> > Thanks for the comments!
> >
> > Admitted, the first try was a really bad guess. Maybe I got distracted =
=66rom the
> > previous patch for another arch where the value was 10000.
> >
> > While this may still not be the favoured solution for Eric, I think it =
is at
> > least better than before, so it might be worth applying after all?
>=20
> Ack. The clearest fix would involve more code to be updated, which
> can be postponed. This fix, at least, makes the time quantity clearer.

Thanks. Can you pick it up? Because it is a change to a board-file.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvM/XgACgkQD27XaX1/VRvgBACfZd/J+qqOiwOJEwTpW0yeW+av
8JsAoINITfFm+xnajAVOQN54xsdnK0jq
=aLlQ
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
