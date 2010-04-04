From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] power/ds2782: fix clientdata on removal
Date: Sun, 4 Apr 2010 16:13:36 +0200
Message-ID: <20100404141336.GA10176@pengutronix.de>
References: <1270117664-29099-1-git-send-email-w.sang@pengutronix.de> <20100401104021.GA30121@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100401104021.GA30121-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2010 at 02:40:21PM +0400, Anton Vorontsov wrote:
> On Thu, Apr 01, 2010 at 12:27:44PM +0200, Wolfram Sang wrote:
> > Probably due to a copy & paste bug, clientdata was set again to the data
> > structure (which is freed immediately afterwards) when it should be
> > NULLed. Just remove the calls as the i2c-core does this automatically
> > now.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Ryan Mallon <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>
> > Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> > Cc: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > ---
> >
> > Anton: If it is okay with you, I think this should go via the I2C-tree =
to
> > ensure it comes after the needed modification of the i2c-core.
>=20
> Sure thing.
>=20
> Acked-by: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Sorry, I misunderstood Jean. Would be nice if you could pick it up. Sorry f=
or
the noise.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku4npAACgkQD27XaX1/VRvsegCeIoetMb5GVUlQ8O1vxuY3V9nY
NWgAoJk9wtdhvTNRtPJJV3cw9/Q0a3G+
=NQyl
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
