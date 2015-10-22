From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] i2c: uniphier: add bindings for UniPhier I2C
 controllers
Date: Thu, 22 Oct 2015 23:00:39 +0200
Message-ID: <20151022210039.GB1516@katana>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438243942-26401-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 05:12:22PM +0900, Masahiro Yamada wrote:
> Device Tree bindings for two I2C controllers embedded in
> UniPhier SoCs.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Please split this into two files with filenames matching those of the
drivers. I know they will be very similar but I'd like to keep
consistent.


--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKU53AAoJEBQN5MwUoCm2D6wP/RJBHbdytX8I5HvQ80klf3M4
UyJamv5ai+taZBjVQL0egBR8uhKP8eaIB5t2dvQTbpiCM88cVLznl4kFUHL7wHVF
ogpvAtuvhv5B+pwwX4fWi3/mU3MwzTmA+t5wVk2pUHiS3CevZrOX5NUWLny0C1vn
Yup+uUHpSaapkYx/gK2ehEg1sMYicWjxCCFhdVGTuJxVDpE7NXMk3RAAZi8AffyU
xGHBANuDHCy/5P536Z8VylS6C025W+MObVri+Uye6yAM2xgZ5orDcQrCVHhWETN4
aDlJfsjbUICD+wEH4cgGrpEF9KtVA7z48NNzgN/HaDYRmHW/LKawQ6Pl+1jNBj81
xcmQvuXjWK0i5fWK+SGN9VQwy+Ch6BVtgrE/nMBF2JLXWAY4DDDHIG0/Apc2GXnU
LnK4OupMcGZNiioy2e6c5B0JEgn0bC5uLoCSHpM17x0uLri2BK+1Zy+bvxs9Gj1d
0fx11bUUHDKyrXmiwB0VXcurugj0Dg2sRMMAw36JR121dAGtPXq8Tow6WImjKlfd
PwL3bAFylrf3BxObKzdxsXAk0OWGq9D2ePVFwQVnNTBZ2RdocAksuH8NE2HU8UW+
z2eyseV5tJSTgrUTS+L20xS/RDGtFA0togMqbnqBl7jH9/9oLgf3vgy747pxNyq5
zn3zsMhsFioZ7jdStn7m
=s1Kg
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
