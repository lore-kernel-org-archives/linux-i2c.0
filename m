From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mpc: cleanup clock API use
Date: Wed, 28 Aug 2013 10:47:42 +0200
Message-ID: <20130828084742.GB4086@katana>
References: <1377273704-7474-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377273704-7474-1-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 06:01:44PM +0200, Anatolij Gustschin wrote:
> From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
>=20
> make the MPC I2C driver get, prepare and enable the gated clock item for
> register access during probe; disable and unprepare the clock upon
> remove(), put is done by the devm approach; hold a reference to the
> clock over the period of use
>=20
> clock lookup is non-fatal in this implementation as not all platforms
> may provide clock specs in their device tree, but failure to enable a
> clock when specified is considered fatal
>=20
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
> Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>

Applied to for-next, thanks!


--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHbkuAAoJEBQN5MwUoCm2T/8P/RdKHY3Bm7fXfBhFMHc+qzv0
FV77VNw819p5vi9xfbKvXwHWrf6f4GOQJ2eWjcizDU/Bl+lLnrnZsBbt+vpqawCH
YyODyrDZ38TZFLajqiZeb3ApDK3zrhUa1dLvsLV1ZL6N0EvS2AHnNIByd8WveLlR
LZlIw3lULnLVihGUfHkwPk0+MGODzPASmgjtLHo+VlcLeSHtnENqBuLhc7sK9l8R
5AkgqYZPGurvGAZDaTa/p/g12GQZOW57FPhWpfMubRd3+qUWsiTJ82FzPc3Jra6A
ts3R/uGm28nFGVA3wBkfONjDyjjwpvhlEba2QNFDXfGv5MN8/H2E8Ks1eHCs2FO7
pUQZ5m5toIOfYR1FjTR5RXW/XjHaJunpcl62LmMkSStPUbabIuEUnMZC4U8dh4cd
9jOyD42/6QStsLC0JLIQ9romUdrRavtWSzZjw5EYTT5vtcQQAMHMxTmeKIJ9Dufl
k8wmUHa0pdrdz7+AKUu9wR2T8vjWCYIn3o6l1yH8qKrebAzEwFnOxcUuZMeAlGoA
jwMHFxkmidY43k02Pn//Fcj3WVJ4TucbOHpUJHxB7eGjMSMRK7K3F0Uyk6kM4bq4
kiQR3SfqrTULCb6HWB0AlK2Kc3XcC6+THZ6zGCiP0ywGaVeog53b7cYPeB4LKdRA
pTBZrUoOIiE9SWvN+CiN
=4vYB
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
