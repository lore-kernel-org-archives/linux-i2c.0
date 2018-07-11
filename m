From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 5/8] i2c: fsi: Add transfer implementation
Date: Wed, 11 Jul 2018 09:34:14 +0200
Message-ID: <20180711073414.r27x3qgn3tmpnuic@ninjato>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1530816030-13010-6-git-send-email-eajames@linux.vnet.ibm.com>
 <20180709224114.4h47enyt4tucqcou@ninjato>
 <d7128886-148f-d255-fb33-3727cad01569@linux.vnet.ibm.com>
 <20180710185042.x3slnms5wzocobqu@ninjato>
 <cda1b231-eeff-626d-5c79-a07c9bc5a9ec@linux.vnet.ibm.com>
 <20180710193944.34phe4zafzvwjm5v@ninjato>
 <479b3c82-ffe7-9e6a-569c-64fcb1b43d32@linux.vnet.ibm.com>
 <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xx7t7u7eyooak2jg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACPK8Xf7mCuksfgH4jfxcgbT2h0-WH236=pWchzbucrrVsLF3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Eddie James <eajames@linux.vnet.ibm.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org


--xx7t7u7eyooak2jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joel,

> >> An EEPROM ist at 0x50 in Linux. There is no write addr 0xa0 and read
> >> addr 0xa1.
> >
> > OK, I understand! Will test and resend with conforming addressing. Than=
ks
> > for all the feedback!
>=20
> Nice one Wolfram. I wondered why the standard tools didn't work, but
> hadn't gotten around to working out what was going on.

Still, a report that the standard tools don't work with the driver would
have been very helpful already. We can then work together what is the
reason. Please do next time.

> Thanks for taking a close look.

You are welcome.

Kind regards,

   Wolfram


--xx7t7u7eyooak2jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltFsvIACgkQFA3kzBSg
KbZXcg//XMNWYGtX/B4mjcFNEFQPpjIBU2a3ihkxZHAF56GDZ86x2CQtLVW1cg87
FkMKMqMewP4dR7qrc9CmuRBCJrJ8g6evQuYjiC0FQU5rRGXoN8BCty5IazEoG3V1
AV/9s9B2JCgSapPFVvyU5G3BYvKwf2RLECHEsh3StDHyDe9HzOEGHSbEYBQXedXE
UPFBYSC+EAdrpvMA6QRX9Qa7nbh7Mj4UbibBByQ1JmvXG1TupOmaLmFzvGxyshn1
GwShilQFg2bGBoESFe9GoY60qbC8N0ixW37LGqmPFybonOqlZasQtyxikHarVEsy
9IFevIe8Nt3Jrzcdu3J4Bl8Ozz0+s//bwNPxBRWOyhoucQ0dNQhFPWujsID2Y7RK
MGIDRYjKmKfEhaDzksxsu+HZf7lz35Zvk7zC282grh2lXAL+24vYXoquqJNz4Wjs
uTnbdwg0Hm1y/21DjfwvsARkQlVUzl6oTcjwxfb8idrYbp8DTmS7mxZM6BlMYZRK
AkGdza0hISWNupvGIx1HmP0t+P9OGHYYXAk/LHYS450wjSQAjgt2ryIf8S4m9D7B
vToczy7jPyEqPyAqfj23B9/hm14NPRojVgPIzAQqkjgJAkPXHSgxwo44AUIQl0sS
EIJuYZVaFw38tjzYYiyXWvfj96cEFIeDtODAjpdgud5kWZf7YW4=
=hVNR
-----END PGP SIGNATURE-----

--xx7t7u7eyooak2jg--
