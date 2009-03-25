From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/4] imxmmc: add MX1 support
Date: Wed, 25 Mar 2009 12:59:29 +0100
Message-ID: <20090325115929.GD3029@pengutronix.de>
References: <49C8BE24.6000608@gmail.com> <5d5443650903240531l1158d323t4c10575e9b350d43@mail.gmail.com> <20090324134655.GL25436@pengutronix.de> <49C8EFB3.803@teltonika.lt> <20090324155908.GO25436@pengutronix.de> <49C90DFD.1040107@teltonika.lt> <20090324170134.GP25436@pengutronix.de> <20090325085223.GG4697@n2100.arm.linux.org.uk> <gqcv9q$q04$1@ger.gmane.org> <20090325113108.GC31464@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090325113108.GC31464-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Regarding the I2C-driver, I will try to clean up things as I see them.

> Is there some reason why Jean or the I2C mailing list couldn't have been
> sent this driver instead of just Ben (or was it, and they didn't respond)?

It was sent to the I2C list a couple of times (although sometimes Darius
made two posts, one to alkml and one to linux-i2c; probably a forgotten
CC, but it makes things a bit hard to track). It got quite some comments
there and the latest version, from what I can see, is here:

http://article.gmane.org/gmane.linux.drivers.i2c/2962

(which is _not_ the version Darius was posting in the last two days).

As you can see, it was already reviewed and tested here at Pengutronix,
and it works for us with MX1/2/3. IMHO, it just needs one to pick it up,
preferably via an I2C-tree. Now, as Ben volunteered to be the
I2C-embedded-maintainer, we were all waiting for him to put it into his
tree (for 6 weeks now; we were nagging). As he really seems to have
disappeared I wonder if Jean can pick it up this time?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknKHKEACgkQD27XaX1/VRtjMgCeMJQ9jg6hX2AUrcH00JgLt3Ep
Wy0AoK//DJkUXgN7GyLQ8KpvBuPprGtW
=V6xG
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
