From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c: bfin: turn to Resource-managed API in probe
 function
Date: Tue, 3 Jun 2014 10:29:33 +0200
Message-ID: <20140603082933.GD2653@katana>
References: <1401771726-4717-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401771726-4717-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2014 at 01:02:06PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> No need to free managed resources any more.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20

Applied to for-next, thanks!


--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTjYdtAAoJEBQN5MwUoCm23ysQAKxQ21vdMh6ypl/3G+DGoTjy
xZZztds8YQ1rll1/20vGGjGXNR1UltEL9QY1WogPCJeg9O7YlJAdh0LSnNdkaGsf
Hq8K0/RZ2VgCpvQJEaBqfqiNpSRNguQd8NgVQoFlgYbWlit/gXlu7fCWppIhXwNz
Zp5hU8CGMTcmzaIEc2x7Qspb/+ZsHUORDjnNMWd7+qF3dRX9X/5n6XItHafx/hO8
FiIDq/dlVfErBOcZx3EP7vW3c+NwQEyAi3D3jFf6P/86PMmYO7eF/WM1VOTLqYGJ
Vmaq0JFNDkA6N1lzISl7DWaACpi4lQaY8SqsCviEr1elApf+9NTSko09yss6+jdH
FPZjagB74K70hGp6DbLx//RiL7DzusWHtklVrOen5byDOWK8BPZktjhCx7cieAoq
coxR2tpmRaLPQqpm5EbSuFb68MG3Su832PK5RHvTKRzf9p12icJyXtvUx12ivv9v
l0qmkCdLwYL261Cv7prelT9e6Mv9zIlZHnKvW0c4gW7xz9pFBR/NJNkgE2WpQ9Cc
OOr+yroWsvxIPJwnazQvYgShqLy4Vd9OueKW4QLud6YGYG6Ch7fu54NoJbdUSMxF
2jy+pdXIM+qBl1hfaQm7Q1rkYderVMMffWJTJgDpxnvxIiCBWS1qpTQyVPRF2Tou
zLmGqhWLNq7hry9m9LZz
=K2YK
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
