From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 4/5] i2c: pca-platform: use device managed allocations
Date: Wed, 28 Jun 2017 11:38:44 +0200
Message-ID: <20170628093844.vmstyotgjaotbsnh@ninjato>
References: <20170620011837.14010-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-1-chris.packham@alliedtelesis.co.nz>
 <20170626004434.2757-5-chris.packham@alliedtelesis.co.nz>
 <CAHp75VfE=gCO3EDvadxar=qdnqMHKAZg2TSvXBtYebx+Y_agEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jwvudaa34sdpflg2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55872 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdF1Jiq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Jun 2017 05:38:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VfE=gCO3EDvadxar=qdnqMHKAZg2TSvXBtYebx+Y_agEw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Rob Herring <robh+dt@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--jwvudaa34sdpflg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >         if (i2c_pca_add_numbered_bus(&i2c->adap) < 0) {
> > -               ret =3D -ENODEV;
> > -               goto e_adapt;
> > +               return -ENODEV;
>=20
> This is still shadows the actual error code.

Nice catch. But since it fixes a seperate issue, I'd prefer an
incremental change here.


--jwvudaa34sdpflg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllTeSQACgkQFA3kzBSg
KbYppBAAjR4loC1XFadGKLRuBDp7ymJMOJ2CFT7gB6WIn1gO79SwO4WuMvSLYCwJ
HLY8AZr6DvWziQ9VrDcxa0/VPt2XvE0GAl8EJqRCsgS3Een0lXXrCcCNmMHxK4wq
Q668PQFu/LMgKya2S+rYAFtxADXrecM2GL4gIfsn7FIudFT+NKxhfy1iOPAuhYui
U6crEBWwrizjJjMTKEGEyZ9DRRqFhLtkDYyDLqX96BtBtXKsTwBfwzeBJT7rs1Vh
6G1qoKM+8iVRpfUJdRlOUQQvWMWbA0+5uxI/MGG6COfLAqOCDpHQvn22RsfBcc3f
P/xMhhU1rpcwdXsL3hKz7wJemWFOjNsgOf0m2gkqOE10IQo4T5NUhUaB52/KX3vX
nsbntqa+5aRljWGrm/TQz1prwjW1N61nfYak/z8r/2Lwc8z3H5oegAtPzJn3E7jU
RGel7lLL+MI74KetcYdOD63XwmDsrB/RuPWuMBI8kwLWw2aHYJU1xSoV06BjpBG8
j/3H2guNhTeJB+bWLe/mB5j5NOgJ6rzKt6d7zIaxi7Mukp1sEiWG7kJrp1+1lPX3
5QVycDxJ/fDnbgr0keJkrlwvnIKmpr8NVfBDnzJab7lPUupl6Ei9/IV78/7wqh+S
O04W9RJAEZovDXtmHXIl7NrjMxtq3QIwc1T41xPBuNFDsXrbfdg=
=PtDQ
-----END PGP SIGNATURE-----

--jwvudaa34sdpflg2--
