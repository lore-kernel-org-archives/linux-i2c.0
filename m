From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: at91: remove legacy DMA support
Date: Fri, 21 Nov 2014 19:08:00 +0100
Message-ID: <20141121180800.GB3754@katana>
References: <1416577472-24542-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416577472-24542-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2014 at 02:44:31PM +0100, Ludovic Desroches wrote:
> From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
>=20
> Since at91sam9g45 is now DT-only, all DMA capable users of this driver
> are using the DT case, and the legacy support can be removed.
>=20
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb3+AAAoJEBQN5MwUoCm2Y/UP/0M12niXeTR1I9eIspmshgwO
JxjuJ2gjbETQU0OkSL71hv/831lwsQm9sg5AAA7o9insm2S6FdsIQ3CYtLPR8naj
O+yoRDClRY15GqIZsbTdVaby7NVT3D0ymcL2ZJXA8nyFDMuJFopu2TFmMNvG4zVe
aqD7XWRQH76Yvr3An9ibiD9bIXGyXsJ0+4iXEr3r68yU0a9+C9jjAfCRg1hiauBi
eBsnir8lbXasw7zIQ30NqI9P5Ea1snAFlpbmRijUo7XTKsIp4VqnKZ1mQ56e3TzS
hZAz9kKZs/OI4pP57U4VG0LJyznOPjPDsrBnBS5PxOBAqE8/H5CMq0ttLF9cXfn1
ecud9aKBVy0OSNo+ks+gKsAFz4yYzQ95F46y1V6Qjo88g2VpvBezkXMMkWa43ci0
cmv9m2tuGjJB+/QgUKZGhZq26TGrhL2S9FAP8Qf0lBIl63Tro+TgkJUMg0IyFtpD
S6PRaBeEMkJskDaZKkiTdsXdESaHt/kJ6TRXuc9n7Ezz/z9bhiycmZdJXKyRUoZR
fZtpnNqmwSkHnnUiY70viBdcOX0zXp3Ub3as85aPCfctfPlYqh02a0fIF0fO8Q83
O0S2X3ufeh0ke9uwwMU4Rf28tMLmy7NnwO1enkXhScT8bYwKxYnB0dPeHqhLS/Vk
mCmI48Str4tCOsywojZ/
=D/OE
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
