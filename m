From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: mux-gpio: Remove redundant of_match_ptr
Date: Thu, 3 Oct 2013 22:14:03 +0200
Message-ID: <20131003201402.GA13596@katana>
References: <1380732680-2408-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380732680-2408-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2013 at 10:21:19PM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSTdAKAAoJEBQN5MwUoCm2jZcP/RK7xAAz4ejYVpBz5gUVsmBQ
BcHbUlcR0YD/7Bod1wI1u5y5hs8wFVdeVPiNuRz94V13qa2N+xcVo5GotUvCiaWZ
aaPRZq0JEfgZyNxB/P4CXRN2qOz9kmGUiobopdbzOutX99YAAX6m6EHMkGbACfPU
frrRT0PPfJ9d/cHWdGbTRMnqWUX0VfShyv5vHF1j4Insbf+msKYdyv4lG01To+bt
GLMuoiyzDadCpuMhgDULRdqpihaDG4gbjdzU9FLC83yos257NHNm5Mg+LSLLQ14n
SyQU32hX1PlxASGLOSFotG/ByIJRuWknV+Mo2TeBRy3+Q4Ae3gbW6iIx1tDmmuaJ
/pFMfLk4vKKeo72+FdvIvmdum6OfXjZ8+kUfvO27iGXos2pyVE2eD+5XmVFiQZOt
DlN0wQvcWyqeTi7TTkYWWy6ibWDGagc8EKZvRbB5owlFCrjRVT2FSapl0Np7TX5g
i2elROaagxZ1Skf6Yb7SjJwui2J5H12bwG3CL8bYYCBP8tKlvGWCVNrUy1lsIm9F
qknwdUeOAfTZM6vVvsH5bqe2SyBUoAeHN0YekZ8IPEDhIP0ZEZ6uUkH4PO7yUtRn
9LbVbFVlXsNaf5QjQuC+81bZkOoIkQkWWEjjUblPcXOpUJnIFHrcsxWj1A7xbuFz
PkgczB1Q9EBVeU91iPDw
=E5iK
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
