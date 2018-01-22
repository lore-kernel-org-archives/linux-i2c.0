From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 15:08:24 +0100
Message-ID: <20180122140824.ox2ljc3kvrkgipq7@ninjato>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
 <20180122114026.uqozk4cbhfrjwqmd@katana>
 <KL1PR06MB170270EA30591C7636941361B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
 <20180122122204.n25jf2rtaoxmi2yq@katana>
 <KL1PR06MB170262934FD5C3B9D422A134B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n62v57qnrooeoc6c"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <KL1PR06MB170262934FD5C3B9D422A134B8EC0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--n62v57qnrooeoc6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > On top of renesas-dev branch, I am using the below i2c-rcar driver re=
lated
> > patches.
> > >
> > > https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg2227
> > > 8.html
> >
> > Those should be enough. They are not?
>=20
> Yes. I have tested without demuxer patches, I confirm, it can recover the=
 bus.

That is great news! Thanks for the additional testing. I was a little
worried that the 'bus stalled' detection might have failed for you, but
it seems it works for your case as well.

With that put aside, it is still valid, to add the demuxer to the DTS
file in case you want to switch to bitbanged GPIO at runtime for some
reason. Only the commit message would need updating then, however,
because it is not relevant for bus recovery.


--n62v57qnrooeoc6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpl8FQACgkQFA3kzBSg
KbYoFQ/9FY90kAEt6ENU3JW+y3hqihH/sg/ClFryXaeeAkSaIPyz1T6DR2eoKF7+
CIAEnUBWLq2xSLLhcTnwmHw28rV98znsTdJ2ISuMF7ZdnW77IHJBJy0asL6HIabt
KEaCF2oqflCvJWdesC6AznScPIoPzNrU4gB0wCtQtj9xMyNWjuYkxe3CHThLijm/
vXsT063REUGZk5WByIBpygTARzC8ukTWfdB48p1r7UGJKd3ZQA8dTtl7uOEJl6kz
NX5FTzT+swOK+1vIUKj2GDu0UHRSnkPkNuZwOfcwO0vRQLkXsynvq9uE47bYnejI
8cmkpEgXpfu5RWIAZ6z+NbeEYtZQTV4f95s41wRo/XLZwzFgfyQEi8ecwjePULbz
pSznA10DwMA6dQWSbWYEuWZpquCwARhTcX/rvYFBACClkyVkufLVc1Kuem1yK82A
n4larEhUx4ehgqV1N2rI/osUzqcGg5d0df/69uf3XgT500Miu/wKWGeGeGi9zjcY
ud9k/FJ3/6zPnaUWbjp6RBO45T3CcrjtWSQrdlzm9ztC0GxFXIhG8LYsZg0/hBzP
do3csPgiutd6+/nxY2qGsVrjIWv3NVhdeeFO0XkjbZCNVGxtjJBwev/jJ3chRva2
h4zwr2UO1YuNtUGnqXnUTdgTjZ0agixxvOv4Ezh3fefFVaCKHo4=
=mhqY
-----END PGP SIGNATURE-----

--n62v57qnrooeoc6c--
