From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 0/7] Add support for MSCC Ocelot i2c
Date: Sat, 1 Sep 2018 14:43:53 +0200
Message-ID: <20180901124353.GB1196@kunai>
References: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180831151114.25739-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microchip.com>
List-Id: linux-i2c@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and th=
en add
> i2c on ocelot boards.
>=20
> I would expect patches 1 to 5 to go through the i2c tree.

Applied to for-next, thanks!

> Pathces 6-7 can go through the mips tree now that the bindings have been
> reviewed.

They have been reviewed by Rob and are applied now to my tree.


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluKiYkACgkQFA3kzBSg
KbbGAw/+KrZJqSfDSLRIptY2cwjI826Eg8PnYKu7uwuPeazt6dBpVv8you4CZmj4
RJCFzhkC2iNa+ziA+97IIa6b+U7RpYcYvyh/Hkaju6iS0294D8fMHwplJMDlVoWF
H0B3PrhCN8+s1jruyFKJaIIuYU8CHDuFAoGP/osZQ48qqlTgVw92069znUqieTPl
rqKqWl3WTDnekvtjhtyVJRMDl0JLsUbJk0W6I5jk9rPN9CLb/42ktfaebwjYWiti
Exfd+QO2e6ExR3xMqaDLqsOY4GcbD3kPle51Z3TZZ4h1PIzX39/UP0tR6c90K0iw
/bhCpdRI9vXuKPSIQSVT9MXdFaCgNxPG+WQXUd7eCzfil2VSJan08GzM6nJQx0tS
7+TKQce0teDvC3OgZTi9pVusHheBKSmCbBQuX7kFr03GLNZCFiKhr4O7c70TzPLW
qzD5VasjqZI2FPAoa1ZPpQgjCTXAg8ip5FOa6kaH3giEf6sJHrBeQ441QxY3i6X+
ky3rvj1PcgUBCWT50szyuYlNadn7QY6ANNshU8qKMrOFb1YJajVmD+7niYIdF5US
MTNpAsd7PrJruMak9eLXoaWdOUxzvSXzzI8as9okJo1u24V5tfFkAxkVV3Y5HyVa
vD4gzMgwByG/+Sz4nnsutSGpnD8R8a9KePVJSzU2Rw8RFbmSkdw=
=fVHo
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
