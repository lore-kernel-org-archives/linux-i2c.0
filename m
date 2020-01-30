From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c: i2c-stm32f7: add PM_SLEEP suspend/resume support
Date: Thu, 30 Jan 2020 09:38:10 +0100
Message-ID: <20200130083810.GG2208@ninjato>
References: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
 <1578317314-17197-5-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1578317314-17197-5-git-send-email-alain.volmat-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 02:28:32PM +0100, Alain Volmat wrote:
> Backup/restore I2C registers as part of the suspend/resume
> handlers. The device is marked as suspended to ensure that
> transfers are rejected during the suspended period.
>=20
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>

Applied to for-next, thanks!


--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4yle4ACgkQFA3kzBSg
KbY32g/+MsJU/Mz6bHmAAS9cTmzSotAvgy/o+WUUunotmJ7EHIyl25iZjMCFrs2z
Xi3Gk59qbPt4oMVu1wQNhT7NDbvjyyfltJPFyRjevxMfBKwcMGdd6lI4W+jsogCk
JtzOEIkiDrSXFqrC58/zjxbTV6vxpR0gtvbhnvVUvhtcAaVEWtrKm+f3NE7XoDt3
E4IhMehFrxlHxaBtzJUzlEyUrv0rRav4knChHnpAgtCHIh5wOVdj2PAMTibteAJ2
56Mt6MvU+W+vs6enYkDcFCtEu9sgOZF1RM3ozUurkI98Efqn/21M2fP7WtxZMDih
Ai/bVREnuAeJWI8LA65h9diLll6Wfi+QKlgh8Lq1XQmIfsPtv9kZGD3jCLZ9AEcJ
Gv//iQpUstLg728O+atN0pTYLyQ0Tuync+LxYnqyFHclpqFb4nwe37zF2gzVMkY8
H5Xaz+I7jqzG+I42img+kcLYIYbmT7Wjq/LJdivpAA8EzETeLzxX0QVroIDXzcOs
vGrk26aCR8xAfST/6KAb7AC8G5HSIDYFzsfbGhYMYm6jVvXw2pZYBXGsxtxTOXJ8
S8GsbiiY+3sND5foLLbEAtqpNgDNnJsPxS3R8MwES/2MiuPp+yEk1oinnS8cY6li
lom0Vqb3JaX8OQjZDu6uYyPAvhm2ED4jCCSMSvdMJNZtojtASKo=
=yyQ3
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--
