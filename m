From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/6] i2c: add identifier in declarations for
 i2c_bus_recovery
Date: Tue, 9 Jan 2018 12:17:39 +0100
Message-ID: <20180109111738.4owgwmndd7bqmvbn@ninjato>
References: <20171204123640.3382-1-wsa+renesas@sang-engineering.com>
 <20171204123640.3382-3-wsa+renesas@sang-engineering.com>
 <1513178582.7000.38.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mzybk2sxdmi4y3g7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513178582.7000.38.camel@linux.intel.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phil Reid <preid@electromag.com.au>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Claudio Foellmi <claudio.foellmi@ergon.ch>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: linux-i2c@vger.kernel.org


--mzybk2sxdmi4y3g7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 05:23:02PM +0200, Andy Shevchenko wrote:
> On Mon, 2017-12-04 at 13:36 +0100, Wolfram Sang wrote:
> > No reason to have them undefined, so let's add them.
> >=20
>=20
> >  	int (*recover_bus)(struct i2c_adapter *);
> > =20
> > -	int (*get_scl)(struct i2c_adapter *);
> > -	void (*set_scl)(struct i2c_adapter *, int val);
> > -	int (*get_sda)(struct i2c_adapter *);
> > +	int (*get_scl)(struct i2c_adapter *adap);
> > +	void (*set_scl)(struct i2c_adapter *adap, int val);
> > +	int (*get_sda)(struct i2c_adapter *adap);
> > =20
> >  	void (*prepare_recovery)(struct i2c_adapter *);
> >  	void (*unprepare_recovery)(struct i2c_adapter *);
>=20
> It seems inconsistent with the rest of the members even from this
> visible piece.

Agreed. Either overlooked, or lost during rebase. Any way, will fix!


--mzybk2sxdmi4y3g7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpUpNIACgkQFA3kzBSg
KbYImw//fJ22BUIChPdXWvG7pUnvOQP2E17h6wzjOpq/sC/w5YFD+i5kYiXNUgzw
TEHrnD4MzpMKY+/M6qYdwBam4b/B1jFPRQqTuEokrxSV998vaA8wE8Rvqj6xp1tu
7CGtsISdDmqgUlza57x5K+G27shB3cm4uvt3PxiZab3aaoBWqBmmz9A9kdWdPyX5
TVFa+2e4AcFRXat+CV/kU+Sb6ASNuRamHTNX/ESALlfXA9q/2oqCQt9a/u91ztmb
W/aXxdobH7ircQhS39YH0YKNMaIb9Hu5d0+bTI+dZGbxHrY3UxTwl/2pUDZsZY2N
3aDdu4nJtlmenhTd0OWljLz7VfKD6+tDhaaIclInVEjYA5rW2DNcraCdDVDJYETE
q2ZJKPvw4Y3Qq5O6dfuRKT52CERDgacV3STje8a7vQT7k21SadN1q3j6EdB3sZjd
0qb485oCDhva8/u85Yd7s3+ufBwsozllEDObuPLT/Ds5ZnQrd31r4+7pQInDfIOm
4wffPq7NTN+4lraV+BQYXhGsy6BOFOy/BNCHRRzrMqCL9Fr4gvBX4aejIbkaNApa
wWhIDs60xETntg5bVli7PzDHcbIReGFyLMVypszN5OAmeGUiyGTzRmGjevxGKzHC
fyJqUJPsvxQZifROWmmltXsAJ1Mo4dabhyyIwCWuKE8Aapw4SRE=
=FK+L
-----END PGP SIGNATURE-----

--mzybk2sxdmi4y3g7--
