From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: rk3x: fix divisor calculation for SCL frequency
Date: Sat, 20 Sep 2014 14:19:05 +0200
Message-ID: <20140920121904.GB3850@katana>
References: <1409884333-3544-1-git-send-email-addy.ke@rock-chips.com>
 <1410147505-5930-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410147505-5930-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2014 at 11:38:25AM +0800, Addy Ke wrote:
> I2C_CLKDIV register descripted in the previous version of
> RK3x chip manual is incorrect. Plus 1 is required.
>=20
> The correct formula:
> - T(SCL_HIGH) =3D T(PCLK) * (CLKDIVH + 1) * 8
> - T(SCL_LOW) =3D T(PCLK) * (CLKDIVL + 1) * 8
> - (SCL Divsor) =3D 8 * ((CLKDIVL + 1) + (CLKDIVH + 1))
> - SCL =3D PCLK / (CLK Divsor)
>=20
> It will be updated to the latest version of chip manual.
>=20
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Applied to for-next, thanks!


--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXC4AAoJEBQN5MwUoCm2k6wP/3rszLRMlUQ6OUaFHAW0hniL
DCYZ3sRBBAWWH3IV7SjA0aq2b1+A7WW/++J373bLbGM3axE1BS6Is7O/4otEe/Vd
sSCkMEuycNzO09Xd5W0t003DfRZaDAt8GbcWPtcZP7hqOndBcx16eUf89VU/HEH2
9tARFcwGaE0K2/518PBXg0WUHI25yX3JAHry5AWs4GKhZKJny1c4ZPBggcnanlPL
KpaUXrP4xMWwSi0ypgfIwaabJ4JLH9SaHblTRBdVHgX2/rb39VLRDb2eplwvaB+w
a4U5R97HjUWs+UYRrGDLEd431UiH7QQVLfblmBZtXGuNPdOvt8ghK/KoqIb0PPv5
qJ64I3rxvVm4lZR0nX4ZnfuLM92AvcgDStTIZGnWc4Ae9LG4g9ASdTaeAupGtPJh
8LY5TL1YsF6TCzTM58RjClR1418UaKB9IxdlgtYwI8XiskY+Jvtjafu8BV9WwhTH
rm9FigGBf5b38r7NAjhJF8/+mtJaMdjg/2hhT19ZMXWB+EFq5CMESemWaPz6KLxB
F/4fPpRU+ITWAC4nYy/TLqDXPIXMhNkXrlbDTdI8FsdsSqR2NYSr3cwbCrINQ5hB
gz+gjRpBYFZlLe0vjuFnwBvzvhELIVJ2qAvFGrWlNJIz1RccKtVxVyubsaqP50jt
nb6Zj5cyyYdCTSJI0A4Y
=l0aq
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
