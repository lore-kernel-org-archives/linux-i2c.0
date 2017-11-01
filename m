From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 09/15] hwmon: (w83781d) Remove duplicate NULL check
Date: Thu, 2 Nov 2017 00:07:34 +0100
Message-ID: <20171101230734.6zsxizhcwazffhrx@ninjato>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-9-andriy.shevchenko@linux.intel.com>
 <4b621f23-f251-7fa6-c79c-059b48f27345@roeck-us.net>
 <1509542817.10233.156.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zmbhu7jk2ohctori"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59356 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933530AbdKAXHg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:07:36 -0400
Content-Disposition: inline
In-Reply-To: <1509542817.10233.156.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org


--zmbhu7jk2ohctori
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I'll keep the hwmon patches from this series on hold until the changes
> > to i2c_unregister_device make it into the tree. Ok with me if the
> > patches
> > are merged through some other tree.
>=20
> Wolfram, what do you think?
>=20
> At least we have couple of options:
> - apply i2c core patch now and wait until rc1
> - apply everything through i2c tree
> - ...

I just applied patches 1-3 to my for-4.15 branch. So, other subsystems
could pick it at rc1 time. If you are going to resend, you can add my

Acked-by: Wolfram Sang <wsa@the-dreams.de>

to all of the remaining patches.


--zmbhu7jk2ohctori
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6U7YACgkQFA3kzBSg
KbaIYg/+NwIVFwmU2IgcVS8Xn4l3bjFJ9PAzMeO1Tza4GXNQmdRu7LARsDRoLgcI
DBChpINhJJU6PNHbsOo+rOkdHeDqGt2YUWHZtzoCeqdfU8zJI1FM69p7lG+l/bb1
5UneSQzHc9oKxwcqbv8pnM50uWkzOB9/PR+1VC+RsKGb+vH4rrdVd/0IPBearj+W
2WUNjM0P3CBdvbKmczBt9L/Z8eTT3OjYEtez8SFqVgjyXdnLovJlSetagKnwrMua
nNd5+Lxki5uGfz/so8mcr1VMQkfDMYEyKQw0P1hWgcl8xA2FgMmzKXDVqtwi+6Q9
zyyDHe+3c0kZPxuruuCdeh/cq/ixh7Mr+ioauCet3RstoWXkbF0Xh7PbMbWDEjyI
WQtI7TXgfQxGJQ4lTgYl5bVTJE06SERf971B/vfQ+OFmuUufDzd7au6BHK05CVr6
bnmOZtlQJd/swOIuuVILtIoLnaNkaAvOqMZMEUVIVg9/QHQ59EJdSy1cDgFNwtYC
p8vnWFWJ5xGOTqGUeakPH6GahTlfZS2KvXntEM3FDLl0P4cdKg4o7NjMKJo/AOoZ
LA5WY8jGa/xrsqBOpVpXbp+Stbkll5/8pUSAehZ5k8Eb/y74Qddfb8oVunlUmmcl
yt0n9FU+AhS5GgwxIiC9zcnHRnCBhSdZB/YJhn867Hmes/wfOlQ=
=XIAS
-----END PGP SIGNATURE-----

--zmbhu7jk2ohctori--
