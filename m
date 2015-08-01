From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: core: fix leaked device refcount on
 of_find_i2c_* error path
Date: Sat, 1 Aug 2015 12:09:44 +0200
Message-ID: <20150801100944.GB4379@katana>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1438007451-8553-2-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438007451-8553-2-git-send-email-vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 05:30:48PM +0300, Vladimir Zapolskiy wrote:
> If of_find_i2c_device_by_node() or of_find_i2c_adapter_by_node() find
> a device by node, but its type does not match, a reference to that
> device is still held. This change fixes the problem.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

Applied to for-current, thanks!


--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvJroAAoJEBQN5MwUoCm2YZMQAKO0SDVSSC9lrKPJJtRev1GG
Egu7u01BnVj1uwH30pDlL83cHNKXDVYQstSEm1btDwUI1j1gCM4yF+6Dfetz9MK5
7Wqt4v++Bqr7OAZsYIivMGuYJdtOxARCjtq9Pc42oaA4YHRT0B/pCxkviszOpNcx
CwmFtjDFHPgPjPhkEGl8OJBXnXqPfxJxVSfiZldQwKedFa3Pir6OnkPT/hKvRFHx
xn0jtlSXSFlG0Y0ZKCyeq40pLE3vihbD8NnRlWXmDlZuiAR/vxgZY1vhlFaaP80f
GYIi1WhpI1TLRm3xykFhoOCgHj8LdJUtGz8B+jQcSDfGLxFxJhsRDJvpOit90VQH
8ab3DSpXNhgI//vBVUd+xtgYsGGW34ViBcOwayi1e1RCe6bQ6fwxPD+UdgUVB2AZ
388ZI3lcMNxkYRzElJ9AuGkDXRD8yARuLu8vkJTAc4q74cQv7I2o6A0f7SL39gUW
Tf1vKUlsJNw2XV4/AZQWRUwf7hp0dJs3w9yzkyaDDCQhf5QxNh5ssx2bSvQz4j/R
/KiGlzVr6JvMLRagEccPsstsjr10PsUCcrzM4aXL0zxUQy/Jikx3WiqnBQGQHgCM
hhV/zVP1vDjcyki5p6PGINZ/wqiZAoZaMoWHh2Rhz0YqfMhP8mvbGlcr33/4V/dJ
aOhcXbEZIjUIFngUjUaY
=jgwG
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
