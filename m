From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] misc: apds990x: move header file out of I2C realm
Date: Mon, 22 May 2017 17:56:49 +0200
Message-ID: <20170522155649.wuf2rcdtywa7e667@ninjato>
References: <20170521204233.6745-1-wsa@the-dreams.de>
 <20170521204233.6745-2-wsa@the-dreams.de>
 <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byuztooyzdux2gzl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2CfOPNe5KnSWb=xf_0YTtN6aQRwNthQXEDb9YgOrLMaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--byuztooyzdux2gzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

> > -#include <linux/i2c/apds990x.h>
> > +#include <linux/platform_data/apds990x.h>
>=20
> The new location is clearly better than the old, but I notice that in both
> patches, there is not a single definition for the platform_data structure
> in the kernel and both drivers refuse to load when they do not get
> passed valid platform_data.

Yes, this is true for quite some drivers I am moving around. I think
there are two reasons: a) the board code never made it upstream
b) DT conversion happened and platform_data is now cruft. As mentioned
in the cover-letter, I didn't dive deeper for all the drivers.

> Should we also remove the drivers or move them into staging?

I'd prefer to keep them. If they are needed again, DT conversion is
likely and easier than restarting from scratch. Guenter Roeck also
prefers to not unnecessarily annoy people who might have out-of-tree
board code. So, as long as they are not painful, let's keep them?

Regards,

   Wolfram


--byuztooyzdux2gzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkjCkEACgkQFA3kzBSg
KbYieQ/+JfpNtl0iDvxJ72BMTgPAnJFY30xcluTKQ2CK+4+cicEMKtwEdjqptwgR
52Ye77b9wUEGvHN5JAKdM6+wYpMl0d59y65cOBXkdp/q5KssUsqof/U6d5FQPVAK
7cKxRJnYRTcaDONZs7JalemTNqAg3N0hPHH9pRjhOz82tul24M56aE3vcS95i3t+
c85VjEtp5KOeQC2k24F72dm4k8+8hF9ZzL1v7jVVksMyZbASztlLQnzC1v010EGl
y85NYOjaAoOTUtb5qrchCFiYVta1OIH/tYPcHgrAfaCWBlCFNeA+pMHq+1Ge93Gu
U+GAobOj+Qhtj/bMZBJEW2OIV30fZELRjAdEoBjAx42S1XnAtFm4Rxbr3CiqmQ+r
abfcBZvKIxPCDsliaZUOrdglVv0O0VBDNetp9qP9aK/oYTPN0qB+mV0I+5RHU1mY
iW38OaO0IOujRc9im4+jdyF59fTi/LcRQNm35MFi55rj//+5q9GyrJdKvIqjdmYF
eKmhZD/MO/f1ih32xdbxjqJw+CUlYRkeyWt+iXLbpQzqD1Zgvx6N79s6jtcri4uf
yoddkG0xfSnnvtVWXjlM/C4jmBHa7UePnqhqkZ65bUxbfs+QSC9rOtDzAMBJGcMq
27qu0MW4wL3BA6EVcHnOY/eP2B1OntPDsujxzCgg0orlN3dM4LQ=
=gzvP
-----END PGP SIGNATURE-----

--byuztooyzdux2gzl--
