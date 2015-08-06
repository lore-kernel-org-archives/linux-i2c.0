From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: core: manage i2c bus device refcount in
 i2c_[get|put]_adapter
Date: Thu, 6 Aug 2015 02:50:17 +0200
Message-ID: <20150806005017.GB1743@katana>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1438007451-8553-3-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438007451-8553-3-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 05:30:49PM +0300, Vladimir Zapolskiy wrote:
> In addition to module_get()/module_put() add get_device()/put_device()
> calls into i2c_get_adapter()/i2c_put_adapter() exported
> interfaces. This is done to lock I2C bus device, if it is in use by a
> client.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwq9JAAoJEBQN5MwUoCm2QtYQALHqJUdpmP2LCGHlaMr9bVCH
yCmPkVpSIUz7Yg+u0uJOu6kK8Mkg2MjvtxRvr1eHuIBtkSnNetzj0IDvgNU/g5hl
RgY4shLlqNWM05cVHS9r+1n3XOQhw7O+cgntw+9JGU3kgdyAYumFpccfUVj8SsWw
gmAF3PSiyajPKK6Zyo7PAf/DUbcDsNIzFrb5Cm/QcsG0nqlY/cVsJapScHO005ol
2f7IGBv9Y9wJW2NGQ+N061c+GfTvAtTApQLxtd7dejCfhUphZOI+nN9yp0gHvky5
3TtzwXT3b+fnOpCNOQ9BLrkFTdokJCInL+0qlA9sPgqCzjkC9fiTedIRMjD0S5Ng
IF+OQ1OSNrPLeDIu9AB/Jbmxuece3xuyJpIHst1pkhcC4j0ScaGxGREqZ412xyx2
FNgJYXgdjY2UFsYEX2nfkX3Pe5WMnmWEgLzJ91mruz+89sswzDrDJ3bbzv5Ea1k/
5Y2GRAQcjCqM1qj5/RUPwItFSivjauKQuNBaAMnNy0uAlphdHSEuB8eyi0AieZNB
v+KAs4iQH28voMxkweMuyelm9mDQzvatRQOjWRA3hDiA09d5H5LUlUTAhdTy7Twe
7ssLzIDZd4s0ZlbdCd8dHVX2nW12Br0ON3SnLlyqgBCZbTJP4vmzuYXEHlTRn5ex
QF/l1EZaTz1JBniog6KU
=pZJ1
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
