From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Date: Fri, 30 Aug 2019 15:18:30 +0200
Message-ID: <20190830131830.GH2870@ninjato>
References: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
 <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
 <20190829205752.GL21922@piout.net>
 <20190830124554.GB2870@ninjato>
 <20190830125338.GP21922@piout.net>
 <20190830130035.GF2870@ninjato>
 <20190830130603.GQ21922@piout.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830130603.GQ21922@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Nope, they should be incremental, aren't they?
> >=20
> No, your patches don't apply on top of rtc-next

Looks like you edited some whitespaces to match opening parens before
applying? I'll resend to match these.


--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1pIiYACgkQFA3kzBSg
Kbb8+w/+KeHiboloZaBCltc5NV0fDqJrg2IAVmShtJSlHmG1CHEo6Hro1TfcvlvI
d3FkVVAxbfs0c/rA9LhX0yEj4/XuLniDWcXJyGkP3bh+qrS/I71565M4plMZpBQk
6r+phpCTBvLOpE11ChaL4/fXQz+oSCliqfm81h4rBEkcUaCIbqMCgOe1XMRuKlTj
IKGI8o/qqREb3tARm/1WB9RUacuL3rzUVwXrBzYokDzkD0Jod+X7UErVjVx+698B
gEuaC54u/q+ixhLkwot69kQL07/ad/UNlQFh9yU7C3XC2cNXF74d46KTvrLO7tev
sS3WsFaeVPE/CzQeQS2lN5lWK9K8EG5F+9x85Pb2snOsAFTRCrtkKKMPu1TLBa9R
uXI6dyQV2hyTzGgCuqJ6FDu/NvVXyuSqNzRmgw9SqwpWYWKglHxxmQo0aj6t5iq2
jbw/G6RqrNZTXQznx7FMYufW5mkBSV1Jw4/1QnVDV0bzRC84Gn3uIBTjMri1u/lj
zRr5nxZalvfFP5eBBToxoBY8As4xvFH1PC5+/K4LYAStkqS1Zoq//+xKfK4LIo3a
hz7zUNxc967DDVTZZohEDiJlytpevoc091df+SER/3L1rfgqNQGH3v1IXnrHS6MV
5TW8KmvKKxVRMD1i1HxJkJm6CrkWOMiko4jZSTsWu9Js/tnsFX8=
=QJMY
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
