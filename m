From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 0/5] i2c: img-scb: enchancements to support i2c on
 pistachio
Date: Sat, 2 Jan 2016 22:09:18 +0100
Message-ID: <20160102210917.GD1589@katana>
References: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55289 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcABVJW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 2 Jan 2016 16:09:22 -0500
Content-Disposition: inline
In-Reply-To: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>
Cc: James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 09:35:12AM +0000, Sifan Naeem wrote:
> The following patches are required to enchance the existing driver to
> support i2c on pistachio.
>=20
> This patch series depends on the series of fixes posted earlier[1].
> The features added in this series were tested with the earlier fixes
> in place.
>=20
> Tested on Pistachio bub and on tz1090 using an Adafruit I2C
> Non-Volatile FRAM Breakout (256Kbit / 32KByte) eeprom.
>=20
> Used i2c buildroot tools to test the eeprom and the other i2c blocks.
> Also used dd commands to copy data to and then to dump data from the
> eeprom. i2ctransfer was used to test repeated starts and verified
> using a scope.

Applied to for-next, thanks! And thanks to James and James for the
reviews!


--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiDx9AAoJEBQN5MwUoCm2iLUQAJzLbB6rp0VH7OeIuwZH6jDG
spsrsOa0VLNSnXWz+JC+vX2uENAlGXt7EJTVbPQ0WYffIbN2oSXX9y9ghPiABVAK
96T14Xls0/CmhVvzm2S+D1m1m7LH/0FvS+nN7wWdg9QENrU/4AJZIe20/4LkUWAL
lvpV9kQYCOh+fAoBCoEjx48enI5Q4QqyNd73Qx++xelpnvgseroJGXw3ZvYtEvk7
xp5qRGBAfONlXtMQjH7kuGTcDEOiW0kcAU1wPYObBN3E9I09F6P+QXJlzm3Sz7f8
FwkYQ6oyDDFTUD35R8Vz9RNLH+Db9fpPZkNYy7IUdr+AA1nIkpS0f+weDxOQluRS
/nmxGXy5LI4xcHGm7MGfmuQEVQDiueGk/uH0u7Pd89b8DvwfzYI9JrPwH6Pl0pOb
7YDXwyh9tlXPY6ei46GKmCQClPdFOo01YZN1G6ExZu9yE/Tb34NGEYGVfX/jnPH3
rsnDl3nQ8o507GQEyVC3m0d6uWfed62VuBcJIZq8pF3hCuddbGjiw3pDVLpNZoLT
IA8VslcZaSGh0a5zJaAtZz+pqDnPFMBQW2cjoHqQ9oS+jTZkDBc879APpuEsmdew
30K7vzf531GmVENUNLVS16WwdVkL27YWYDgrzktXOZ9qutWLwdkRESPKyLemn32s
t5DKZVaAtViAKbye4ETv
=ka65
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
