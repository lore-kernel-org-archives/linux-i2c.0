From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 09/15] i2c: acpi: Introduce
 i2c_acpi_get_i2c_resource() helper
Date: Fri, 30 Nov 2018 12:49:50 +0100
Message-ID: <20181130114950.av6pnedcqu27jyjc@ninjato>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-10-andriy.shevchenko@linux.intel.com>
 <20181130095533.GC1079@kunai>
 <20181130105759.GK10650@smile.fi.intel.com>
 <20181130110652.ckj75wrxxaez2sq2@ninjato>
 <20181130114543.GM10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6gjjnir427zmfyyw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130114543.GM10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6gjjnir427zmfyyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Is this something we have to live with or which can be cleaned up
> > somewhen?
>=20
> My opinion that we might need something like
> drivers/acpi/acpi_i2c_lib.c
> drivers/acpi/acpi_gpio_lib.c
> etc.
>

Collect all of them in drivers/acpi/acpi_libs.c?

> But better to ask Rafael and Mika what they think about this.

Sure!


--6gjjnir427zmfyyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwBI90ACgkQFA3kzBSg
KbY75RAAg+ixCqXr69OL6aIb6Ji3HNoXn8t/ztlQsaYfvgulytbqf6/ux7S/6bk3
3rkDWINLSyTT/lxAQuZncFLBqqqkoRNF9jACaqOiX7tHc/tPOjaoGKRLc0cvQz+C
gvDCGVHi3Dx8vysXvX3/WAADa+2rEvrg1OjWBlR0bLh+Y0ONfqEnbWRnAj7TDA0x
m1PDTFkshdArH6y2Qx/HDctKPA279ZPaVojLLpQJJ1ResABa+4tpYgRR55ED/3R1
vwZU+KVSVIQhexjUmqW+gfKYT3MLJYHD3uKB5bU+k11gpbRp3c6Odozb3d2xvY9k
5LoAYZ38Jd7lgoaHl2pQJzpm3KzU5OvPcz3p5IvpUHf0E37rrnfBHjigTYqixVGr
czVTxxJvbn0gKRaB51XBJoynG3hFXj5LOAOHKlLe+xOcHgLqAj3K3Axr1Iqfh0tn
O9G3EwKT6o5AgxnaP3AL14sZ8v5CGfd+LH2OIf4gfddgM7mON1HwXZSXqFD1qFqO
hUsnfAu/ewi/wF0aWuo8i0eQkfYgVxxZwmdgqDFEFzcRUOaT0K92Dd3uQ1H7/1Ic
czQafctql4NBi/w0h1VLJIxOeW4Cp8kKslWNyb9CFDRXRvIf3GAt/lvoorF1LOCB
tHB25A37P+6x89RwRYts3UnXE0VYvAx/1PBmYlvh4H7gOLXQ9h4=
=bd2p
-----END PGP SIGNATURE-----

--6gjjnir427zmfyyw--
