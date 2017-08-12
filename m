From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware-slave: constify i2c_algorithm structure
Date: Sat, 12 Aug 2017 13:25:48 +0200
Message-ID: <20170812112548.mn5on2vcv3pzvb6z@ninjato>
References: <20170709213517.GA31846@embeddedgus>
 <1499682392.22624.320.camel@linux.intel.com>
 <4bcd6609-963b-e64c-8c77-8badde089e6e@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rufheo7v5bat4cew"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:42698 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbdHLLZv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 12 Aug 2017 07:25:51 -0400
Content-Disposition: inline
In-Reply-To: <4bcd6609-963b-e64c-8c77-8badde089e6e@embeddedor.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--rufheo7v5bat4cew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I don't think it's a good idea to copy'n'paste patch to each change
> > where you fixing the issue. Can you create a github repository of the
> > coccinelle recipes and give just a link?
>=20
> I will take note of that, thanks for the suggestion.

I took the liberty to squash the 4 patches into one commit and fixed the
commit message by removing the semantic patch.

Applied to for-next, thanks!


--rufheo7v5bat4cew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmO5bwACgkQFA3kzBSg
KbbfjQ/+IWvMxazXesqfxlQnJzx7RlElFKrWB6UqXnfGR9hdFnUHDZCOUV+7VPUz
IJuu9cZCRg3BfE0dY9OzC/i+P+N8e+fPh2VJ15dh7xgY7LePLyOf+oGWc3H7S9WJ
FiyL36QRvtFuOPQ4O8W5XBlK6Y20ywYBRF5pTQ8OAN/BJNPVb580FMr1qaRCuUao
nFdYG6V5hi4bsLMHp1qb0zo5YJrUfJ8SmnUzYZ+EzjLjzmJnVaL4AJTpAnYSll6U
3CAsPSbYTtrMIf4bR7OYGRL0VAMJMr9C61AL8GtTyvCNmxFi1RI6IPvjsw2zYUrC
dOK+uORRGis7dMR3FWlJFat5qLdWgn7qsCXy2903xUyIIx82vi2fiwPLP2iY6mwH
uj1OMUqzb8wt3opPNU5M76nhaFPMVGib//J8ecd/M4BDCazLj0bcBHL+F8OmCsiX
Vslnd4caD6yXxk3bKs5xoxzRHeW7Cr7Pya7Ijhb+opURWLAklx1G/AhBUn/mnJGl
9gJHC6AGmetb9pjpbq+eMV1u44U45eCnWhmOGoltSJKo/fILvPIuQFTIZxk5BPFn
mOzpQGMJ5/+UDapU9YSZ3jzOczZYipXL1kMW+AUjhS1IoY2rRn86XNsQjz0Mgn55
VooYBVotsK75iI1StyahfyBTMn5DqwWOYzhKgYuKkGTyv/uthgU=
=twKX
-----END PGP SIGNATURE-----

--rufheo7v5bat4cew--
