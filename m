From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Date: Tue, 23 Apr 2019 23:36:29 +0200
Message-ID: <20190423213629.GF5659@kunai>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190403210535.32236-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2019 at 02:05:35PM -0700, Ray Jui wrote:
> Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
> bit operations to get rid of compiler warning and improve readability of
> the code
>=20
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Applied to for-next, thanks!


--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly/hV0ACgkQFA3kzBSg
KbYSSQ//U28cZhOdvdRpOtnjksOrWPT0G7du60YMy/1ypLWNaFg2Nt/c+EOEhyiM
ACPJIPzeM2AEP753ce42qnqFKdzvszUJQ4pMoTL0WYwjmc/6ocYee+fLLAgKOWQb
jMcMpOJVSJBzLcc9HDYkF+Lz370WRmdW6cIayFUxysleTnBM4PVGY+e1cDiR3rjv
t55jRtWEjfszyPZqiIAHgVuUumfZp0MZykrJawwY2y2RadP7TlpM29bD6om97pcl
q4cJfmckD74RZi/fD45qWzxDwPOH1wAshwj5z/sOBorzuJbPLB/d3+iexsk3Uu+T
HxkxhmNtLnyYhNnPQmAtcsJJB5PvMPmnT6Lu3zxz5cuGvXv3PKBsHanHE1LXeVxD
ZcejqDuW+j0fzhC9CrCb2/IF6zFBIc2M/PIG2LOp+MlE0mDcwJ7HKvVfSrGdTWV2
eHH4zycZIgyjwSHeNcTklZbCFnAqmpnnqPsftsEatJYjBZRw0kktn6Wd+anWrT1v
wMXHFauJ7n7OTdEBOJ2IvgpbswdqoM6T30kZRZH7fsWyitHfOiwIO7cHhjeYKTYE
iA6zACp28KQaxaMf1SDVbDGrVgYYikwyi5qQmWleS1VhVWcuB64/FigXaHqwCWOe
rZNSu8mfgZvMTVKbp1aZy++mhYr1LQNscuLWOgvdbwaymmJqJQo=
=/key
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
