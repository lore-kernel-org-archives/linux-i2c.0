From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: Remove unlikely() annotations
Date: Sat, 20 Sep 2014 14:17:42 +0200
Message-ID: <20140920121740.GA3850@katana>
References: <1408729424-11433-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408729424-11433-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2014 at 10:43:44AM -0700, Doug Anderson wrote:
> Having a transfer more than 32 bits is not all that unlikely.  Remove
> the annotation.
>=20
> The unlikely in the IRQ handler can't gain us much.  It's not in a
> loop, so at most it would save 1 instruction per IRQ, which isn't
> much.  In fact on the compiler I tested it produced the exact same
> code.  Remove it too.
>=20
> Suggested-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Applied to for-next, thanks!


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXBkAAoJEBQN5MwUoCm2yeEP/08xQJz08DFlMJWNeNxPiPqs
1QoGsBVeeXUB5aNUeG4j4t0DHHPTJ4VMFBRax8zJcyn+aL2Nq1TwU9477glLDnai
WHwL0PbZWhswSbcTvx2su+YMeOSPQNLTm49XsH4pifCuZgW9t2iT2y4F+68GoVwN
ZhIon/rC99bLKHdeOhj9hljW2q2wUYmgPqSzrmHsBOZ1KjAYZnHRF4Vfnv0cc4P/
zqPH/LtODfuKMDI3c30hv8aQRfZbTMuDLtjnTQ0qi8fxzllEj5eUTY1G9uCCMVWq
JXb3CrzLGiE2UvFDB++tFZG16ecAm++Mv26Cs+46wM1hdMPX2CTHqNLoRjA0gSzC
+X1w2D3gG6u9EFBrXvkcypVg2rpzGAZZH7VU7NlQyTDrrp6/+sDJvfcJ1dgvbuHH
g4LIr7GOU5AY9YHJxsRyN7Ti33v7UfnMmyZEiOCWT+TM7+bo9TIkhpaWhRi2KXE+
7+vuvNeYp3oafoLy7fENwpzmFmTlToICHjnNri4X5s1gzYkry5yfBNNb/yT36od0
CGY048ub9ejPhX2GqEjqoArdg+cmO0cTY6k2KS7dGo2jWJF0/eQp/SvsxiknBTyR
ILkwtQxDafuS/6FScLKxEfy1NwKKXCpjjNxnsmLzw4G4KBt2v6qwQ5Hck5LxGIex
afFskL4ZdYaidrwOOXzk
=0u/z
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
