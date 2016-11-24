From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [patch v9 1/1] i2c: add master driver for mellanox systems
Date: Thu, 24 Nov 2016 15:52:02 +0100
Message-ID: <20161124145201.GD4271@katana>
References: <1479660974-143713-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47920 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965569AbcKXOwF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 09:52:05 -0500
Content-Disposition: inline
In-Reply-To: <1479660974-143713-1-git-send-email-vadimp@mellanox.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: vadimp@mellanox.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 20, 2016 at 04:56:14PM +0000, vadimp@mellanox.com wrote:
> From: Vadim Pasternak <vadimp@mellanox.com>
>=20
> Device driver for Mellanox I2C controller logic, implemented in Lattice
> CPLD device.
> Device supports:
>  - Master mode
>  - One physical bus
>  - Polling mode
>=20
> The Kconfig currently controlling compilation of this code is:
> drivers/i2c/busses/Kconfig:config I2C_MLXCPLD
>=20
> Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Applied to for-next, thanks!


--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYNv6RAAoJEBQN5MwUoCm2dDUP/iCCBQOY4FSgIbMYJxoc+bWo
3H+0MwfeSy32Bh0RnexHFueunMeVqAfLDOGU1oA7WWusOv5rqBjYdj3f3rc6HiEt
T811P5pd4hJqOIX6V6bOsCswXM7i7H5Ek4RotiIuFkaMpX03VE6og8dlQpyfyBvg
hPyz+FdSStiKNsqHx7x36cSky0qMbpVnOq4Ljcyu1fOPzvmiilemjmyaq3cfXD6m
kn1QIx9qroYZrjW0adOyYGMI71tanG1W6P5Zct0wrjoTBMS14xrmLIbTJ4g+UeyO
xfnfaHGYUKAiT5CW5Ma20Rt9lHMFKtLwOwX5hNkrhsDHRZcDk/t+yDLrbhiqoQmn
0uH5nsfvWCbpX5U4458SKSV0OTDfP0eoUm6bM2CmyRKIeyhKGWQrknLVmmID9oWo
0Bd07Qc3H2zbTsDYfVLdKWNXUuQRV2ZIbdIAG++jXDwVCWLplw7mhOFsvuz5Drk/
0201B2GjOUxFHz8PVh/s8MowA4nY66ztjI0eCkxdCVNa5rGIy228JQTBowNc590C
x77VjGQIBS4lG6KaSZ6wwFI/d/nKDoukhpm4gVz97Pszm4OcOHBY1RJsE4VaaOqi
Ql0WHezJuEv5wpOyySi/jCzyjsuuiPCkLC01iw/zy9tQr6a6ekoBxDou4fubBF+x
W+InPN4Q6IBrW4qXXXM5
=fadl
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
