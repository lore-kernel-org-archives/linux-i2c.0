From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: mux: Remove redundant of_match_ptr
Date: Wed, 2 Oct 2013 00:19:03 +0200
Message-ID: <20131001221903.GA5028@katana>
References: <1380512066-23681-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380512066-23681-1-git-send-email-sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 09:04:25AM +0530, Sachin Kamat wrote:
> The data structure of_match_ptr() protects is always compiled in.
> Hence of_match_ptr() is not needed.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSS0pXAAoJEBQN5MwUoCm2+d4P/i3mxtqlK6oCDX+UVRMir5Iy
k+IMoMOO6/mLpIJuG2fdVuT7dyZFPzjFkx7k2Kbplxa9mKPvO93aE758Oc1DFSCT
02uZrPMOkpWaFG6Zycht28MIWJaVIDPChJQxYY3yIGpp3dk61xkw4izezl7Hj7nq
HJygPNR4OyeMa5pOucIxRk60TBIXbMQ91xfLPFM1Ab2RucIgKb4R3xQTpOZBGjXT
Sz2IqIDDm+Nqmxg2L1/hyT+EDZkdxQudaQLpd0QjBN1Evez8vXsZ3TLrbGUKCy4L
HFoIGbh+cx4lciIK5KYmicYZsK8aHjcns8AQX78HUcENMs7yo4od27T/G4TXhjiz
jkyBoJ9Kfgbf4/+puUr5JDIVDTP/+qrejKuEngYrMlYCIw9i9OnWo19zhuHALGm+
l1YbugCsyTWP0CYEXmTmkoKZPMlwH53+vUsm5B9tcONjH433lI5kqRaYId+/PAhG
mRQHjL/9hsTvF9uBlyPv/sNKdT2dw4M1q4B11lHxjQBst1dsP3vM2+uK+PRsBT8W
4Li9ipbyZL7KOF31AJ6h6SEY85pXYOpnnCNdkg3vVP6ktUXeMho6q4NIgUIvIFiz
Gu7ySepQT4MU+WcgvlZgkD/K3hdif6RbE5BfNSvdOL3IesTug4LAJJrjBaWyewXN
PNb0bFoje40NiGHmpr9F
=76VM
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
