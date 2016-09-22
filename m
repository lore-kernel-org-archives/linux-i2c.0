From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c / ACPI: Do not touch an I2C device if it belongs
 to another adapter
Date: Thu, 22 Sep 2016 10:59:24 +0200
Message-ID: <20160922085924.GB1433@katana>
References: <874m5ax3o4.fsf@gmail.com>
 <20160920135925.45450-1-mika.westerberg@linux.intel.com>
 <20160921054834.GC1484@katana>
 <20160921084502.GV1811@lahna.fi.intel.com>
 <20160921161435.GA1432@katana>
 <20160922084930.GI1218@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160922084930.GI1218@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Nicolai Stange <nicstange@gmail.com>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Huh? It doesn't apply on top of rc7 here? What did you base it on?
>=20
> It is based on linux-next as it is on top of Jarkko's I2C ACPI namespace
> cleanup patches. I'm wondering if I make an updated patch on top of
> v4.8-rc7 does it conflict with the I2C stuff in linux-next? What's your
> preference?

I see. I'll add it to for-next, then. If someone wants it backported, it
needs to be rewritten and re-tested.


--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX451sAAoJEBQN5MwUoCm254sQAICw1KUc6ifBkcCV5fvT95LJ
l+uO2qwuQFCc5qI9Uz227W83w9Naz/LG3rst8quih8s9p/c73/nLD70AhI6re80f
Ufz1zHc4uROZqOjGQuENG644OHxx6t68zz0HFURPrNJKxLMIoCviDjMPtdsrkP+Q
Uw+V5QIYvJU/BtaV4HzqWK4Q18XKDvTGaaCpscQD0HH8RA5G3ktduxE43ROhBmhd
aSrDWeSpBMNvT43UmzRJ6NwRlWoutN5VqfZORfAqQDUHNZbscyp+66tb3AOXNL4F
Jh6T5fYma05LhVyVKtqIgKmAIbAsvXVD5W5U85F9dhSXptN0tlqtQZ3B6koRzVEJ
NVZYBGAsecepamerEOVtj3kXY5iuiapNGhARLS6KS9k+udWRDwYqpHyNHyX+hjo7
8Bg+NCVOMyjczDLmGIHFYvKGxXr3SUJDDeus7gN+c0EBTz16UMFFrZEa8Zmcm19K
xcRc35ekH6gqOCpvbnBDdzY+Gz4u7TcA+EQ4UZIQs6h1MrgiOXufgHTHqZMW9PS1
TBVeCzrn/a7qfQOt56prE/y0xheBvyrY9wQWTw2XNS/0neIE3YTF4QIwBBk2fe0D
9QWoFdPLH0YRXJZw5+XMoRmWE+TxAch+WhuCKXjJcL6rLIdbNaii2ljcIKOV0JiN
90lX505ZLR9SJh6GzqNG
=mX+4
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
