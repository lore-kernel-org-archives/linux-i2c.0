From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-xii.c: Use OF instead of platform bus
Date: Tue, 18 May 2010 10:45:48 +0200
Message-ID: <20100518084548.GB4572@pengutronix.de>
References: <1274117574-1485-1-git-send-email-ricardo.ribalda@gmail.com> <4BF18D47.2030809@pelagicore.com> <AANLkTik9hCEhCFd9ku6m1SkTz45q6JwxxLUgBjLMOV-0@mail.gmail.com> <4BF252F1.3090301@pelagicore.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BF252F1.3090301-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?iso-8859-15?Q?R=F6jfors?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>> Of course we can have a more flexible patch, let me think about the
>> best (clean) way to implement it.
>
> I did something similar to the xilinx_spi driver. It was OF only, I=20
> splitted it into a generic part, and OF part, and write a platform driver=
=20
> part.

Wasn't Grant Likely about to post a patch-series getting rid of the of_plat=
form
bus for this merge window?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvyU7wACgkQD27XaX1/VRswLACghJXHJmP8t93q6euaj4TH4mIl
7cUAnRcQIb1lqMyt5X8dalaD5mS787U0
=c0Tj
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
