From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Make sure the device is suspended
 before disabling runtime PM
Date: Sun, 21 Jun 2015 21:31:03 +0200
Message-ID: <20150621193103.GC6286@katana>
References: <1434532118-119906-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434532118-119906-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-Yycd8EPnGM5BDgjK7y7TUQ@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2015 at 12:08:38PM +0300, Mika Westerberg wrote:
> The driver calls pm_runtime_put() right before pm_runtime_disable() in its
> ->remove() hook to make sure clock is gated etc. However, it turns out th=
at
> pm_runtime_put() only calls ->idle() hook without actually suspending
> anything. The following pm_runtime_disable() will prevent the driver from
> suspending thus leaving it "active".
>=20
> It is better to suspend the device synchronously to make sure it is
> actually suspended before disabling runtime PM from it.
>=20
> While there, undo call to pm_runtime_use_autosuspend().
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVhxD3AAoJEBQN5MwUoCm24vkQAI+sPGDRnk1E6f04L28mEfQp
0Qk+vG6wX/gmtYsGf8czBiYa/kYNbssQH3yp6KJV1u8t+oigOKzlM2fEoGaB+99Z
fC5amwdFXBOwR3q9qa3n5QXNyGIcnwg8FXStgeESPv8yPQAjAkwC5luZRygBEIuC
nTLgnrlddc9pc1ii2BMTr2JSJDHIP1PFh8PNH5byrLMZHfC45Di2hDvgPwsUfdKx
nXv5WEdFX/VU8UNG/VTtCKRfYH5aihxKBHittelqjf2VxaOyExwf06LSckHg6eT8
+D3G+DmQwXxeI1wJRGZMz8v7kR5ETZnfQtCSsQbsyLNL+ewYXQ63DuJ8ssXaLkIQ
eRciYs1iXuew4QbHZl/3O3zOjFT31e/YbbGX6v36Ea974a7XH9TfE2CUffcm+v9h
ujhUV4CIAkCxgIbHzFE/RbFv/cZjUo4fTk5UqTCFfjdSs7VON3NNrYXyY1iq5m5Y
DemYYwysbDTUOgFeabj78FFHeEU52OY4EJCPwDCvs1oUcKOeL9V0ZivZXM3irh+4
ctVu1cW7cVpZqNbZEyfBtwi3f1ukiekZE+579yZat0ij3tGtbDC3adhzDhEKiUsk
2lWJX3Zet5ZVyMnRPaZ2oLRg5ZcWqW7v2E9cY75lhd/3xCcNuC/IuioMKfswg1SW
ZX/SFe7h/bq5DrOVpj/T
=m1lc
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
