From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Tue, 18 May 2010 11:41:55 +0200
Message-ID: <20100518094155.GC4572@pengutronix.de>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com> <4BF18D47.2030809@pelagicore.com> <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0@mail.gmail.com> <4BF252F1.3090301@pelagicore.com> <20100518084548.GB4572@pengutronix.de> <AANLkTinZrIhPMJ8En09PUXc5tbFzls3nYLXZPlfemY0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinZrIhPMJ8En09PUXc5tbFzls3nYLXZPlfemY0c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 18, 2010 at 11:24:07AM +0200, Ricardo Ribalda Delgado wrote:
> Hello Wolfram:
>=20
>   First news about it.... Then lets wait to see how this goes, there
> are not so many people using this hw.... IMHO If finaly we move from
> of_platform to platform we would be doing a bad mistake, of_platform
> is much more clean and useful

The busses are going to be merged; the of infrastructure will still be ther=
e.
Anyway, this is not the right place to discuss this topic...

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvyYOMACgkQD27XaX1/VRucZQCeJwqGfi2PTAZcNVK1i2yUXtLl
wi0AoKjWfECvwiKh6SJ5CtNxoJQDHmLJ
=7cty
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
