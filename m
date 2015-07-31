From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
Date: Fri, 31 Jul 2015 13:21:12 +0200
Message-ID: <20150731112111.GM1522@katana>
References: <1436539214-21536-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KSyhVCl2eeZHT0Rn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436539214-21536-1-git-send-email-anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--KSyhVCl2eeZHT0Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 08:10:14PM +0530, Anurag Kumar Vulisha wrote:
> Cadence 1.0 version has bugs which have been fixed in the cadence 1.4 ver=
sion.
> This patch removes the quirks present in the driver for cadence 1.4 versi=
on.
>=20
> Signed-off-by: Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--KSyhVCl2eeZHT0Rn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1onAAoJEBQN5MwUoCm2T3kQAJHvDqJHwXDYLWG9Dc0Vm5AE
zUb9hw9D5yP1xDC4vg3GnVoM3EjrwswFzN2iFmSTeu95N8kbpRwBPc1dxqzdnpdI
KWij2j9uHqRJTkOKlBFlZk4dZNOA60gaREqInia9CKOPP/AaaCDnwdcXLHa7iz3G
lD0fPXOu7QZio6ZC56IU57Vly7YAyZXbU8myIEhm5YzYq5nqV5LHx1Fd/0jGAIPa
XaC8dO8FVHjT4Acu1HoUj5YRVjGkc49nMOlyrCwnSvUb5DxLgxHHfg0UcLwTTNSH
D/bq9yxn+47Nn5Suipp7V8VCCBIAitcItuUd/k9krTpk1mte3ft4RR8BTD8zj9Eb
yMcuI+ts3118Hp1gMKBE93jw+tfyy8Bz1tNFgZ5ANhKlekr99V3XI/jb70U80lAS
lNA9SDFTbXBUhEEUSE8N5kGZDBQnvzIUiK0FI5IVITn0j+R6ngh8F+qUYI8f36Rn
uF4Ypaab9gw49m1hSLXxD+/KouOyb6I2pBUGT+eTdzYVGdaQZlPYrJ3fqxW28769
bZEuAAQB0CR3UY6UjkkWiFzGOvPZGu9KDrbdKtnyx77KltP/lvZepxEJU0EUguft
AtNiKjKMCHGQ+hIDKTHicXCQuf51RMzUQX18xnMRljC9c05/CEnGJx6kuGMzMzJW
KA14lp4z/Vu+JvR7Ks2F
=8z7V
-----END PGP SIGNATURE-----

--KSyhVCl2eeZHT0Rn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
