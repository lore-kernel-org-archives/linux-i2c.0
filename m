From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: zynq: dt: Add I2C nodes to Zynq device tree
Date: Mon, 07 Apr 2014 07:47:56 +0200
Message-ID: <53423C0C.6050308@monstr.eu>
References: <1396646876-27336-1-git-send-email-soren.brinkmann@xilinx.com> <1396646876-27336-3-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="p8bsXLsKiuUrJUtiaswMo2LuPJXrHE5aa"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396646876-27336-3-git-send-email-soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p8bsXLsKiuUrJUtiaswMo2LuPJXrHE5aa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/04/2014 11:27 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> Tested-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>=20
> Changes in v5:
>  - use lower case hex digits in 'reg' property
>=20
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
>  - replace 'pmbus' with 'ti' in compatibility strings of UCD devices
>=20
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++=
++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 68 ++++++++++++++++++++++++++++++++=
+++
>  3 files changed, 166 insertions(+)

Applied to zynq-dt branch.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--p8bsXLsKiuUrJUtiaswMo2LuPJXrHE5aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNCPAwACgkQykllyylKDCFuIACfW6FjWlMzosUcfWOUH3s13ylR
qD4AoJT9Jkx61X4OHweHaL4u5tX4Xkt8
=hafe
-----END PGP SIGNATURE-----

--p8bsXLsKiuUrJUtiaswMo2LuPJXrHE5aa--
