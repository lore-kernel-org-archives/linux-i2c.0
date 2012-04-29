From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: disable QUEUE when sending is done
Date: Sun, 29 Apr 2012 10:43:24 +0200
Message-ID: <20120429084324.GA3001@pengutronix.de>
References: <1335536631-28202-1-git-send-email-w.sang@pengutronix.de>
 <CAOMZO5A1_Z7T5md61OJWmXbx2qCjFEByjyGvjhxqhfxzwfLEVQ@mail.gmail.com>
 <20120428102601.GO20039@pengutronix.de>
 <201204281533.35277.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204281533.35277.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I am wondering if we should only set QUEUE_RUN bit here.
> >=20
> > I didn't check the manual, but I guess writing to MXS_I2C_QUEUECTRL_CLR
> > just clears the QUEUE_RUN bit and nothing else?!
>=20
> I think the RUN bit will be cleared by the controller anyway, so this pat=
ch is=20
> pointless.

How do you get this idea? Given 27.3.2 and our experiences, I'd be very
surprised. Try putting the system under heavy load without this patch
and you'll see that FIFOs might be sent half filled when interrupted
while filling.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+c/ywACgkQD27XaX1/VRu4dwCguJ1PDIevl0X2dGYbNjnKfS6d
Vl0AnAi/f5M/oIIMaDmT7EpnK99GjN+r
=PTGs
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
