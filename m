From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V1] i2c: xgene: Add support for I2C_FUNC_I2C functionality
Date: Tue, 16 May 2017 23:39:08 +0200
Message-ID: <20170516213908.losif4flmht44rur@ninjato>
References: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3otyohqjdbf2bnm5"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: tnhuynh@apm.com
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org


--3otyohqjdbf2bnm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 11:41:45AM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
>=20
> Certain I2C slave drivers, such as the pca95xx, require
> only I2C operations instead of SMBus extensions.
> This patch adds I2C_FUNC_I2C functionally to support those drivers.

Again, no Signed-off. I can't apply it without one. lso, please add your
full name to the mail header.


--3otyohqjdbf2bnm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbcXwACgkQFA3kzBSg
KbZmhw//SlnTc5jYP9CAk8niUk1fe9oL2KOAdLsBk7JNGHhDmes6tY+RL6lDEnFB
IceAqQtjIKk49CDnmv6n1jvFLH6s8DIb9yVF/wOHKPLxVcjfErjogOOdS2lokvpS
QkcZwAHySp/A9E5vj3mbp5ZmtggVkVdL/eWUwbaaogXTkvkmijj013HP35WBif5U
bjX/Tf5Huiycq/BvYP5RPP+c6kKVttQCRNS+3IPouTIP9hf8lRvFXDiw5q4h6f5m
zEMCgV2NttCaNKTpSYcs1SLepHvZ3GDH89GPcXioxNcKRCnz8ELdx/MzybybZSON
+kOTw5dFp8TKx6kp0J6ZuH0MMuci1K3ThY8d81A7zIlAhCjhH9wHaiJW039QznN9
gwkzqBAUPUcQWGg6hWIxZGr/htLJlBoQ5oAqf4No7B2+py9H4M69P99lRhBcrP4Y
NsxtIaW/QVh6jTShRZRVsmzMDLar31aYdN58tRA140DfkA/1/8jL2+WEMrYUoV7w
qgl7ye3WUJP/zp4bkLonRxCInkMkg0aylSxFqLkFUhG7hHvkQP2lBMknpAccAtxx
Yk6hZ/fBzpsFbgTGKLIkgPQGfi+AAlG0xdL5SAfldS40RCLQgQRfJHoRFEt9FGFY
7PJmwAdCP9cs2nu/sDyOHY0A2CXfUCgfHk1aJsaYAM2+sxUvMjM=
=qtS6
-----END PGP SIGNATURE-----

--3otyohqjdbf2bnm5--
