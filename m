From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Wed, 8 Jan 2014 16:21:39 +0100
Message-ID: <20140108152139.GB15182@katana>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389193589-18485-4-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 04:06:28PM +0100, Gregory CLEMENT wrote:
> The first variants of Armada XP SoCs (A0 stepping) have issues related
> to the i2c controller which prevent to use the offload mechanism and
> lead to a kernel hang during boot.
>=20
> The commit introduces a new the compatible string
> marvell,mv78230-a0-i2c for the i2c controller. When this compatible
> string is used the driver disables the offload mechanism and the
> kernel no more hangs on these SoCs.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reported-by: Andrew Lunn <andrew@lunn.ch>
> Cc: stable@vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 8be7e42aa4de..f424c0f89946 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -692,6 +692,10 @@ static const struct of_device_id mv64xxx_i2c_of_matc=
h_table[] =3D {
>  	{ .compatible =3D "allwinner,sun4i-i2c", .data =3D &mv64xxx_i2c_regs_su=
n4i},
>  	{ .compatible =3D "marvell,mv64xxx-i2c", .data =3D &mv64xxx_i2c_regs_mv=
64xxx},
>  	{ .compatible =3D "marvell,mv78230-i2c", .data =3D &mv64xxx_i2c_regs_mv=
64xxx},
> +	{
> +		.compatible =3D "marvell,mv78230-a0-i2c",
> +		.data =3D &mv64xxx_i2c_regs_mv64xxx
> +	},

I think a oneliner entry like the entries above is easier to read, but
that is very minor...

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzW0DAAoJEBQN5MwUoCm2emkP/3Mt1rGpURsY3wA8qXJ97bQC
djXE2BrZ2TQHLjDRX8OftGTU8P2Oh/1Y0x2WBon3OD8dBs1aia3AFMcLLMmajVBf
Z/Tqa+t3XHsSbcKW6di3GkIYAFFAbu017G9oQPU80f7iQHprVHtMxykfFNRTRpdr
AgEnRUAbRbLtCsUE83F4/Ycp6zDp7viGBOXzSFb9e8xPnKRb/lLJ8XgG3NwkWYz6
1dnE4oDd5w7+yoi5NDHfGXCM53Xuil3qU0YwTSAwwxQA8BApOEZlEsGSXIcT3fQm
qnww+XeFL8yuYQcDoco1ao/ngAgdPCY50kB0ys/Mz+lC0fiqWyiv3yMO/CnUfC1v
fGqyTpxt1se5+KvHXFIjhljFLmYjSAHc+RhAkMTha9sxUm9Lxnso+NUfkrvMUVEm
tIgh8jTi00d+0RSEYuaT0R/RopX256zG/qegZOtjitzzgDbx5ILYxuB1TWipU3X/
8FJmcNq80OStM8K/I8j1BEktdQIMTy5z+te8FVHSf7oMimsg8Uowf9yfJ3O3WpEg
Y+qrNLVVpNfHWbJk9Ozy90Ji5MZYf7YasxTCr3kub6R8nzh8Ml3NuHYgNS4RBjVQ
O1qstLgItwuYX8byUgDFwcPVyo6RUkVnhyTpvCxC7AIxrB359vEz5bbzAuPsw4+9
Z7CRq7fcuUqKW6ETeN7b
=dUwZ
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
