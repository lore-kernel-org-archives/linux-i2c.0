From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: bfin: turn to Resource-managed API in probe
 function
Date: Thu, 22 May 2014 13:13:00 +0200
Message-ID: <20140522111300.GC2573@katana>
References: <1400751219-7943-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400751219-7943-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 05:33:39PM +0800, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> No need to free managed resources any more.
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> ---
> v2-changes:
> - Remove resource checking. devm_ioremap_resource will do it.
> - Remove cast of the return value.
> - Remove free_irq from the module remove function.

How did you test it?


--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfdu8AAoJEBQN5MwUoCm2iVYP/0oojePXQ/sly93HYxlN7KSV
ZLHXPrJYl1uNkFlyXG9SzBqhm/KGz871fvU6AQ15PEl/ikIp1aKi5l2nSlqk57P4
3fcSly/lY93loPYmJqXUpJwJ05at74/mhuAZxLcd8yu3DFCBrIwU4RAVwn4anbhZ
LUuYB5yoNWf/CY1/O5xRETN5XTQ8VCz2QahKezWl92+k1Mst+rLKr3Bwd8JwTERU
ddzqEu6tjgbQVm1Iy/sy7zf0GQaz0vZfl4HC7jS5NZxidQjoTxpvFPo/stsq8xng
7k/+HCePyYvUl5HsvD7NFdgXlaBJwLl8BElPt7wP6RQGAMO4s0e0A1aM+O3arZdk
MblsWERZa1dVfph9zpxmE5twRNkZBuMD6EH3xrJQEtwtdaCtm1A5vCEuixqYMQiK
r6XQKaYYjw0/E+qiSNkKqUq9Q9hrJfyYAXxpoYoHWzTPKJcA6QA7kxQ5gFV8w5KE
LPa6rHisjdmlCt3QKMb2byJtBr88lJsqsjk9jyVDmWKSGmfx5sqf75/cy7/abLZC
3AuBV7zkslZREN4MdwAK2T+C7AWees6XUSU5q+PIEMxLw5ew8f0Cj85GAPATupHy
oGlMc1LurKQAzvcb2K3Nx7rwqzU7LVmL0tyUij8yptlOoRqnQEK8XIHIkGtKh86g
lfV/sXOdxzbTKUv0Tis9
=g7ed
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
