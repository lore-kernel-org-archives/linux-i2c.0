From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/5] i2c: pca-platform: use dev_warn/dev_info instead
 of printk
Date: Wed, 28 Jun 2017 14:01:08 +0200
Message-ID: <20170628120108.GA2782@katana>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Ve-JFBMofDwoKKENL-AggXqMpKd7CbRZwJuPKWML13apA@mail.gmail.com>
 <20170628093717.wryvtbsxisilo3a2@ninjato>
 <CAHp75VcSe641XecqUMCHgrDo9=iQgX-Ywt6TQBbTC5RvRD3rEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VcSe641XecqUMCHgrDo9=iQgX-Ywt6TQBbTC5RvRD3rEg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 01:57:01PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 28, 2017 at 12:37 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> >> Not a chance! Where is the commit message?
> >
> > Don't you think $subject is clear enough?
>=20
> I would add the comment at least on how the output is changed since
> pr_*("%s:"..., i2c->adap.name,...)  to dev_*(&pdev->dev, ...)
> replacement.

Yes, that could have been done.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTmoAACgkQFA3kzBSg
Kbby2g//a604goYvpnePxtOeWDH5IveKS9zn7xc+VVdP24VCxUSmhg2cXC4JjzU8
BXFniIitaD2gkZJ8vOZ187lcyM9TIt+xR6FlWxe64c/y6yRWy5P9sftsQFnE4O+4
rGEEvlPzv97JhEqu6sIaQwEiBtirfUu7w87OwYjM6b8m+nQ7J2qaBQvmZKXf0Wr3
q58OfjVjtdE8/bqmZcZOlqndx7OJ2rclVbb+ioiFpwbU5WyVJtqFpLoz5CBOoilS
HQWGs3fcZPhWBpqCM3vD2heZZo1w09m2nxvTMRcE+A1w4d18uxqJ7wyRo5W6rqRr
YAdKwIZneoI/wbXdKfeWvfWZUS4rb7H9UoMHLHnfOb0PshwFInlQDG/RcDNreSxO
ToT/3T8jNZNJH1aGlJNnXjLy5TqaBrIfkozl4U00Ro0E6HQtCxVE29fqtuOHyhPE
4Lh7kUeCG4bQpuMa0xpygDxNcPzBP5FBn9QS7zhog8417Rj6PZ7qf3Cab5JZwDWA
CaH4jyq4kfrGsfNIHl1/2UWLf7lMuysROB39UNLnJU5cgwfFKehm0GSHDr8J5V93
z4z58RaqXn79XZ58b8sc9Cru+MLwT5a+zz1fG2+X6njeoxfMZsf3koUoro7ovN3s
E+vmbcqjKwSbk2FoymqjJfqtxf/f+hrCCUSNREiYpIbLPnnAaq8=
=FwrZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
