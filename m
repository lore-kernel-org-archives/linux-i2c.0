From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] at24: add i2c_driver struct member for
 at24_driver, and reduce the priority of at24_init
Date: Tue, 21 Sep 2010 08:38:28 +0200
Message-ID: <20100921063828.GA3168@pengutronix.de>
References: <1285049243-17058-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1285049243-17058-1-git-send-email-jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 21, 2010 at 02:07:23PM +0800, jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> The following changes are ensure at24 driver can be probed successfully,
> which are based on Linux 2.6.36-rc5.
> 1. Add class, detect and address_list member in at24_driver because they
>    will be check in i2c_detect().

NAK. You would be attaching the driver to every chip in that address
list. Most EEPROMs are simply not probable, that's why it is not done in
the driver.

> 2. Since the at24 driver are tightly coupled with i2c bus driver, make
>    sure it's init priority is lower than i2c bus.

Can you describe a scenario where the current method fails?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyYUuQACgkQD27XaX1/VRtEawCfTa8RvGLZORLHcKenURAoh3ah
dYgAoLQefee3u6QyVqvoOg4a+KzQYqyi
=WmLw
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
