From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Make debug print in i2c_dw_isr() shorter
Date: Fri, 7 Aug 2015 18:02:27 +0200
Message-ID: <20150807160227.GB25357@katana>
References: <1438948383-20646-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438948383-20646-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 02:53:03PM +0300, Jarkko Nikula wrote:
> Printing adapter name is irrelevant from this debug print and makes output
> needlessly long. Having already device and functions names printed here is
> enough for debugging.
>=20
> While at it remove extra space from "enabled=3D 0x" and use "%#x" for
> printing "0x" prefixed hexadecimal values.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxNaTAAoJEBQN5MwUoCm2vRkQAJolGZzPYjmF4h79WeKIvshV
4Mg0r4JmTMoxO7yI073VXKY20ImmI3vJT9jE2qxfnpRgjvnUruWRVwUlDWYHwx48
4VxDQyrCUXfIfu4qdXGnA2X8vrDl72UI6OYl0wFTVE+bAHLCHuSjhqT31qgr8xCw
+cY+8llEUDEe5inqPMrgulezQPhK9L/ItAP58wrgiZmyfbaiAwy2rzaotBcp6ku8
EZ46AmkDcQ3dBOVVE6fp27f3Ow+0MM2nkHzBiLAz+J2ZyuWw8lbI1bFEnro6cJmX
X1EDLz2JKFCFvhUfXHAu9WRHTi855TwVmWF5aCt/DpkrzLE0ruG8tyv5K0/6a5aR
L1NVEiiP2CWSZfpyfn3uURHeCW2+wlKEyc7XfTmc3c/qG83vGrFxsbU52vgAPcQR
4LqahMl1sVR3tTGaAbR0mKtEKu4d6AcgZpR1ZNj8tm6jnJ4qmZLajTZmq89h8JUj
Gg/0mJsUM+OwiSFs5mwjDdjrpO2FGYh0ZonmwcWUleEwkTPoTZk9u5Y3C+dqeCd8
ebS+2+VHC/fAYU6AlIkfE46fihDwjwniujTe+obdmprifzOMY7Y/NHMVl/plPyE5
J0bGPbx0/d0Ekz1P59aQP7BMrrNxP64pSomh0mQCZmy3SldBJoi0MqOOhII1LN+X
tcmRNy73WNwV78v9BtGL
=0K8n
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
