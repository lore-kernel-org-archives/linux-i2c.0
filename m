From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 5/6] i2c: designware: add SLAVE mode functions
Date: Mon, 19 Jun 2017 17:58:58 +0200
Message-ID: <20170619155858.xjs5nvdkg42b73vg@ninjato>
References: <cover.1497025304.git.lolivei@synopsys.com>
 <bef9f237bed23f0ea05499b085103f7eea9058a1.1497025304.git.lolivei@synopsys.com>
 <CAHp75VeHoUrq-PfayNZYGP0f-bbnKQQEN4uMBg6ZASJs46b_PQ@mail.gmail.com>
 <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hkvdimjxnz34c35o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e332d71-1891-21aa-4479-b91a7550f8af@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>, Joao Pinto <Joao.Pinto@synopsys.com>, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--hkvdimjxnz34c35o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hiya,

> Believe me I've looked for mistakes like this but I've read the code so many
> times I don't think I can see the obvious anymore.

Yes, I know this. And you worked hard on this slave feature,
acknowledged.

Patches 1-4 look good to me from what I glimpsed. I largely trust here
the *much* appreciated review from Jarkko and Andy. Thanks a lot, guys!

I wonder if we haven't reached a state where Luis just could fix the
buildbot error (missing 'select I2C_SLAVE') and the thing pointed out by
Andy and we handle further small fixes incrementally during the v4.13
cycle? AFAICS there is no major show-stopper, or am I wrong?

Thanks guys,

   Wolfram

--hkvdimjxnz34c35o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH9L4ACgkQFA3kzBSg
KbZf5xAAhJWFJdNB+a6TtRMt0nwaMekCqy0LTAkA9CyOKVIVAR9MABUF29Gg67BN
OvNawL/RACjrA3Dv+VsoY4aTZ+irhmCzBDI+BhRzs4BWN1fbqnHngzjYvvVnowFX
GFCNYux4dllWsBxOZ8XvcjG6A5QpfsP/0/juYpQlauflJEJD0h0zqZyOOj6VSFMc
FRRRrDzs7YY8IiLDAm97fwxolOzu9/wpCIyVMejwDYMWVjehRqN/BFAU9ou0Krmx
1VfWmYck8DZDa34noQtDojamhvbjbO4VifayV+F4X5VYULj0TCqDdco1txZUxDHt
szgq4eFX2LnDh/+0hGIN3ZghZhqcjIGCibasPjuA5/GEWLlGcN2bS/n+JL1Ot6Lw
y2HL2P68ERMQ4lba9zbQfG5dD2pc2cVB64WnjFmABO4WNsz5xmCOSLvfSiGSQqhN
ZpHY8lUUVoBZRHQICFkbf9Omnf7itoEYSFj6oAbe6KLRoC7vx0fDY/XsMBIX6iQI
HefGHdaVic+jR4KFGjRe4lIo05lV0rLd5S4TuYLGSnZ1LkyJTl4BsMUFHnR2leXs
i311vurVPhI+fJZm0XZBMUOvTyQUOrsPSfzLM+LNfSRqBdvfgknNkF35adAyEp6q
S4vktP8VbUZNSbroviW/9VQhJK1I8ZBv8AAk+X1drII6XbTM8hI=
=RULi
-----END PGP SIGNATURE-----

--hkvdimjxnz34c35o--
