From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v16] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Thu, 28 Feb 2019 11:12:37 +0100
Message-ID: <20190228101237.GA1010@kunai>
References: <20190226161243.GA21539@syn-yoga530>
 <CAC_JBqrE_g-neObMMvsdAG4USDqgc+oqAs2y6WYRdrT6PBAiSQ@mail.gmail.com>
 <20190226165001.GD839@kunai>
 <360a227c-68f9-81f8-bcf4-9aeefa837cc0@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <360a227c-68f9-81f8-bcf4-9aeefa837cc0@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Elie Morisse <syniurge@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Singh, Sandeep" <Sandeep.Singh@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 09:56:16AM +0000, Shah, Nehal-bakulchandra wrote:
> Hi Elie,
>=20
> On 2/26/2019 10:20 PM, Wolfram Sang wrote:
> > Hi Elie,
> >=20
> >> My apologies for the time it took to apply those changes.
> >=20
> > No worries. I am super happy that you are still around and willing to
> > continue the work!
> >=20
> >> I will also start working on an alternate (v17?) version with only one
> >> module and replacing the platform driver by an ACPI lookup as
> >> requested by Bjorn Helgaas, unless Nehal clarifies how AMD plans to
> >> expand the platform driver.
> >=20
> > Sounds really good to me.
>=20
> Thanks for the patch. For our upcoming sensor hub design we need MP2-PCIE=
 as independent driver.Hence i am requesting to keep the two separate modul=
es.

CCing Bjorn on this one because he expressed in the past that there
might be other possible designs, too. But I don't know PCIE, so I'd like
to have his expertise at the table.


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlx3tBEACgkQFA3kzBSg
KbZrlw//fsaZttlyI6OhS7d3zPRegWG8DUNWkNUh61QZue3stD82AdG8rEqkfKqE
ImAJD6PvLbKtlUum4GJbu25+9vYOJVt5kAh8Hc2liNQrayfCaJog25hK6LiIe8HU
r/W+OMBw8THhbFw+1hajrw/ISu8O6i4ZDYtAiDhbjcyKgDhdiJKiwWpueq6fwbIZ
/yh0oiK4Cl99kHpnE0uvuAHH5ZRWNWYuJo5Sy+dCoVyD5lTfDeKkJsUr6uIY9t+l
Zo1gRL3ndZr5C4EwjyrpJ6Vfec2m1kpP4VwCoe36aYW6+uUqKlol9wDqw1wv45Cn
0+t0zgP7jygB45GZn/37rje9pqcedE9uzJvrg7inZLQoM2sFt+IjOz8+eiajPXP2
JSDRl07Wyzda7VUpVOWErkKh0c08clWRB4rMZkesvLNDi3RcXEMaE0CuLgYl/pDg
uR+lqtr1bO7+D30azpOEdLdNKltWOLjeFUolKRL4zu69spjMsp+W7MOj2xo9cs78
lpwubJv/MNDllW4ts3Wc7BqBXiujRT4+OqxMP+4MX/PQORCGO3V5Lf+/1Xt0tzPd
DoChWBnth6t+M5AYvjSOcrzeYV+15wgiOYjLvnrHKiaM5+AgYR5WgJrNggBQWk9d
OmbKzJNiLk8dgK/d37bzY+8v4GHhIg+3b7Vt8QQ9LdBYilKh1LA=
=JJ4A
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
