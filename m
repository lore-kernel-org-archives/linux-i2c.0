From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V1] i2c: xgene: Add support for I2C_FUNC_I2C functionality
Date: Tue, 16 May 2017 23:36:41 +0200
Message-ID: <20170516213640.2t57hdumkzxcdw5o@ninjato>
References: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ypm2ylkhqbhhzahf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493181705-18531-1-git-send-email-tnhuynh@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tnhuynh@apm.com
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com
List-Id: linux-i2c@vger.kernel.org


--ypm2ylkhqbhhzahf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 11:41:45AM +0700, tnhuynh@apm.com wrote:
> From: Tin Huynh <tnhuynh@apm.com>
>=20
> Certain I2C slave drivers, such as the pca95xx, require
> only I2C operations instead of SMBus extensions.
> This patch adds I2C_FUNC_I2C functionally to support those drivers.

No Signed-off, please run checkpatch on your patches!

> -	return I2C_FUNC_SMBUS_BYTE |
> +	return I2C_FUNC_I2C |
> +		I2C_FUNC_SMBUS_BYTE |

Does this really work? You don't have a master_xfer function, so I think
it cannot work. You don't seem to have I2C_FUNC_I2C support in your driver.

>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA |
>  		I2C_FUNC_SMBUS_BLOCK_DATA |
> --=20
> 1.7.1
>=20

--ypm2ylkhqbhhzahf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkbcOgACgkQFA3kzBSg
KbbI5Q//bPZE6w8qHalrxhRN2knyxxx9LU5r61HOEE3eEu6uR1l2JnbBLs6uCVf6
VVl0O/nb1oq0pxYTEeZDEP1G27rh0imiWC/Ai0B1ikGQVUatsKl0fkl63RyMFeiE
9M95uwj353/nDYYgVb01MDvb0R9INhnDv4cHIVaRFstdq7QXxIul7CJsjL5DyRqw
gNKmEZ1lmjT+LUTViHW+8w/qfpIPwUr4pLtkXPLpbOanIp+poLQj7+4gnLCfBkR7
Q69yz8OkOsOYdTqYqjm+m59x2HMmvXvJuBcjmfcdlNVKkgbesJ8M2Yfu6W7rqMah
qYWag8ek6rTB9dX/bp0SaQ87hEd+jq8sNqyM5QCqmnuaBSgwbmXjU/FE4ZHtlUFk
17dEoiP6ktrTjRKxpzY1AnIcyFK91MKx0SqX+3YNMR4OkG+lPuiZn0lkXQ+yAKoc
M2KuqUEhmU8/H+BL73SsiQC9MceqpRVi8g5LZoIFjnKUvuVwQVVSJlF9utBluXPq
tJEqA2d6hl6AUYnUxU79e6C8dQ6MigBo0QKTFmdCtl/0t8eDTLBLucK2okIsxtx2
XCHbgvPhRlnaVoyenKu+Nsu8/z7oIiyDVAUzHcO+bvVw9WoYx9IZgUTlrbrmRkel
sV5h6cXvdghfROsW3xdPyqe03CSrhKiT/to/sV8acfew++cG7lg=
=/XJB
-----END PGP SIGNATURE-----

--ypm2ylkhqbhhzahf--
