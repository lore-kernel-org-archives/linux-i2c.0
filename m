From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] [REGRESSION] i2c-acpi: Fix NULL Pointer dereference
Date: Wed, 24 Sep 2014 23:27:51 +0200
Message-ID: <20140924212751.GB1947@katana>
References: <1410548987-3558-1-git-send-email-peterhuewe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410548987-3558-1-git-send-email-peterhuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2014 at 09:09:47PM +0200, Peter Huewe wrote:
> If adapter->dev.parent =3D=3D NULL there is a NULL pointer dereference in
> acpi_i2c_install_space_handler and acpi_i2c_remove_space_handler.
>=20
> This is present since introduction of this code:
> 366047515c6e "i2c: rework kernel config I2C_ACPI" or even
> da3c6647ee08 "I2C/ACPI: Clean up I2C ACPI code and Add CONFIG_I2C_ACPI"
>=20
> The adapter->dev.parent =3D=3D NULL case is valid for the i2c_stub,
> so loading i2c_stub with ACPI_I2C_OPREGION enabled results in an oops.
> This is also valid at least for i2c_tiny_usb and i2c_robotfuzz_osif.
>=20
> Fix by checking whether it is null before calling ACPI_HANDLE.
>=20
> Signed-off-by: Peter Huewe <peterhuewe-Mmb7MZpHnFY@public.gmane.org>

Applied to for-current, thanks!


--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIzdXAAoJEBQN5MwUoCm2OTQQAKJ0941rmfFm3+tOic0u/Shy
lLxFULNHQ/q2scOWcAqTN1+iN8CgBRoUJ3zVP+LZaZo95MQQfwJRfwXG2Xh6WbU8
V+N7+DdGL0dODGdp+P6f0wNOocGhGA6K8ykafSsTMnvLrkfIwjzBesgHH5+h+h4b
6ObLr9F/77UfZJWsp+DII25MzzpmMI7SLOPYO2tzogFY/Bld4S5B8f/+WGlfBIaK
H0zb3jjBircMKpy+6WNlyWqmWKuHHWnBarW4N3stfvKJgRD8sikMgR7XbkFbdjLH
4IZubAh6KwahruJOiufvjQTOp9kdY0TDWrf1PnJkJU/JTgckg587ZqF5VXcQWs9O
0tLuNyj4reGgrvW66itQDPVxk5fiTPfVQb1vuASGEkY8Zo0Ww/IBKYyqAhWIwyLG
+icgiZlbDZTdstCcmCTiRMcHZfyiCx3JkuE3H0Tm7kelVZGW17PDRK6VKvWlFLbs
ZXg0765imkwuSi62QlTdUZiVxJveAVTmThiwvXznjVFSTu5R7+4TL+CYbcW3XWyV
Pw742M0UJXEB+rgqZmiv3ZUUTvB7QZgWj0HYx/TVGHY+tiKNAmx9ghWgOxtn4+J0
kKZkBf22Ph0YKDIqIgH5jNH2jq0HTYLBCIoAE5D9iWvs+pi8Jxq2ZuR0JSx/nhJz
n2XmZtQFSdkC48hKKfdg
=DHEV
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
