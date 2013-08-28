From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c-designware: get SDA hold time, HCNT and LCNT
 configuration from ACPI
Date: Wed, 28 Aug 2013 11:10:38 +0200
Message-ID: <20130828091038.GE4086@katana>
References: <1376914074-31103-1-git-send-email-mika.westerberg@linux.intel.com>
 <1376914074-31103-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376914074-31103-2-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 03:07:54PM +0300, Mika Westerberg wrote:
> Some Intel LPSS I2C devices make the SDA hold time and *CNT parameters
> available via SSCN (standard mode) and FMCN (fast mode) ACPI methods.
>=20
> Implement support for this so that we check whether an ACPI method exists
> and if it does, fill in the SDA hold time and *CNT values to the device
> private structure for core to use.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHb6OAAoJEBQN5MwUoCm2B8EP/jSUjMjSYopuQQ6smFUbnIEL
aykxSV/oucdNSTSvyDwdb7VUp6U7GDwZs+szM7yUp0HwM1clRyPsxx7AeDgpAYAo
+RnZnIN/zQBUagLoPDaQRVUVbG/c7c0sptDq/UiFamzTo1vKaWPCbsZAyPCvYHd4
KB2NzZsVYdpYm1sz54Pxrv25Npf7J9uEPktmxAz1lvpCiDuBC+3PCU0LQ3uXZkvx
M+LsI5VHb1RaC+r9BU8/HKOoAjhls4n00oml2Pt7oUJDLhKGySN0sQgZhPSlv1WX
CncS0Ygdr1ysfKIXVTPI8vtwuA/bYWJLPiwnOKzEdcBsqKfX+zok/A2stU/DbnIW
CCkXDyO/09w4gv/7UlP41O1FVBfZ6zL+rTvUoz2ewm+dQ7jiVi2LMSHhBpVs8U80
x+mh+/Cs5yQYse/5g45FpF3zvDCEpVKdMs53amIB0KY8/P89GrI3tpYUilkre8SW
7IguE7J4cnZiJO5KzbQnN9Ci6WMqfSP4HZIStVw30HRXhX8SANkHwu8oTnT/5QLK
bnnTmNaTRa1Rg2KOoVq2d/MfPuG5BP6Mibio5o0WwQv3TKSXpVzk/AtpItgMw8IP
AqgQPI82vzDotD2C62s94rCHdRjjQu/SfjSFed9+f7lBoufVyY7JlsViO1wUB3S3
1vz6oeG3wz4eE9B0nGut
=3deA
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
