From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-st: Use %pa to print 'resource_size_t' type
Date: Thu, 17 Jul 2014 15:32:14 +0200
Message-ID: <20140717133214.GJ2740@katana>
References: <1405034605-21757-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405034605-21757-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: maxime.coquelin-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2014 at 08:23:25PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> When building multi_v7_defconfig with CONFIG_ARM_LPAE=3Dy the following w=
arning
> is seen:
>=20
> drivers/i2c/busses/i2c-st.c:818:2: warning: format '%x' expects argument =
of type
> 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat=3D]
>=20
> Use %pa to print 'resource_size_t' type to fix the warning.
>=20
> Reported-by: Olof's autobuilder <build-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to for-current, thanks!


--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTx9BeAAoJEBQN5MwUoCm2CYQQAJIo6c/8Rl5Ymv4UbcXhvPbs
eJhSEwR2h2M4Vt2gnYmjJ2dRMa86wzad8RuSLLReumZT+5nPQltymsr5w5QvoYIC
HvjmMR3EFlBw//u3hc10aRbavJrIeiHsjQ09zzDVXrlyOwtnxD9W2Dl8SGTRTft6
lD6S181qOQYP19GLR750KZRI2PnpReRl0ahy+o4kz5mZyXoxn1Ty7PaL8XvKtoL5
BN3i77gwrQjeINx2sJFBqCGPLZjELk4CmOP7sHFwuZXwBQBlRXfj4SuPD9+wr46w
5TBJnZWpd3ea88vPgHoakLTgMezKg78saB539pc74zB2bGx92cYv7oFX4CnSP5xD
XNPoGBOHnLrlhAfoFUBkyKJIN2573Wbs+9HAmsCjsERwJ3Gon561vyHv/JLUmfRN
UeyozPyh9YpLzD5BbT7dHW9rSMQBpb50/yOLNvQgG8BhsRM7/iTXFYVQ3PgKe+co
sDVwbZmejymw+GxSP4pIQLF5ibQQeq0eLgTjt/vhzy5JoOh9O0UKFvRs7YDZPusY
4ogERi60+UR9SmY2MOFwwgAfRY7B6NuXOh6VaIhdCnCueWQ+DF1uOQIRgIH+0loM
v1PBvPKipJ0JLlvSg6ErutA16JVr8SitQqklN9+NLc4ILp1bXfVAh0qJ3VI4sggR
Upa5iLGxwBzn14aVwwmt
=DXif
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
