From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: rtc-ds3232 driver
Date: Thu, 1 Mar 2012 20:12:00 +0100
Message-ID: <20120301191200.GB2538@pengutronix.de>
References: <61_2012_11913_GON@news.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <61_2012_11913_GON-2AO0Uh8ossnZ+VzJOa5vwg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anthony Drake <agmotorsvc-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I've built and insmod'd rtc-ds3232.ko, but I do not know how to access=20
> the functionality of the driver.  I think there should be a device
> special file such as /dev/rtc1 or something like it, but I don't know
> what it is. I suspect that since this is a type of i2c driver there
> must be a way to access the driver at a higher level but I do not know
> how.  Is there any information to help?

Documentation/rtc.txt

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9PygAACgkQD27XaX1/VRuPywCgn5XWRpoLc3nFuwyxs6tGyQ+z
u70An0vzGpJASfqjDto2rq6QXvtQh5MM
=oF/c
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
