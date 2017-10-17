From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: davinci: Add PM Runtime Support
Date: Tue, 17 Oct 2017 23:46:17 +0200
Message-ID: <20171017214617.a7ewlkhbpgze76bq@ninjato>
References: <20170911201145.31257-1-fcooper@ti.com>
 <20170911201145.31257-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fouwsg2lmturjcu4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170911201145.31257-2-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--fouwsg2lmturjcu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 03:11:44PM -0500, Franklin S Cooper Jr wrote:
> 66AK2G has I2C instances that are not apart of the ALWAYS_ON power domain
> unlike other Keystone 2 SoCs and OMAPL138. Therefore, pm_runtime
> is required to insure the power domain used by the specific I2C instance =
is
> properly turned on along with its functional clock.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>

Applied to for-next, thanks!


--fouwsg2lmturjcu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmeikACgkQFA3kzBSg
KbYTtQ//REk6v8yA4KzT0trkpLMU4ax+3RINzRejCSkL/c+SF3X8hSvH7yxrYura
aj4aLBS5bmXZkGCtcW+nCDRVBKt56xmDJsT56FrBQ4422hxyT2/Nzgt2qXcFdJ+g
plvtoHMrHRVTa3Hln4TOUh1eR2WbWdrSV6xD4sKl3xgOcfO4vPjDIGzCAn3T4daU
NH0JP70gUa7Obw4IyEL9E11/lmJR+O0YhY9wbm92uL73/cYr9GHoHd+JJL6C6UFM
Smh0fOFkydf31FBz+jxCaoSVCer9tDfB0VBlSLXh4ea0Kw9ZL8FmlJ6tt+uYmlqF
9e45ACm5tUO98L/MgbsMg2/Af99Buas4JmD0n2H0Ieye4mnIpK8nnqxv9vmiZQ3p
mo1kbBgEooAq0OUp9VgrqbUAcXwNPMzsKlDbAc6ZF/OV+YsDK9F699ydAllJHoWZ
5WDinrDW0YyczTcG20CYxUT8UA7YtuzEwjrfd0jndklkts8vxbYY/GyMtaKM21mR
UldX/5WnSASXXIk5m7xa+ZLMOv4A8fDqhqPIeJWUrwQQXJc+9nSVav5zAqVsg2js
McHnk8AhsZzc54MVLWwVvBFG/ExzQumoqVqWtCQNCUYG6eCBUMjR3GUHewocwXJg
jHYwQMUfpbYn0pLmKj7qGs+jz2dG0N9jJo/Tfli6kAuJVIgMS/g=
=6Iti
-----END PGP SIGNATURE-----

--fouwsg2lmturjcu4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
