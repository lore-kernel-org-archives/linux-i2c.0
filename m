From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [5/6] drivers/i2c: Remove caller signal_pending branch
 predictions
Date: Tue, 27 Nov 2018 13:01:56 +0100
Message-ID: <20181127120156.GH1107@kunai>
References: <20181116002713.8474-6-dave@stgolabs.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116002713.8474-6-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 04:27:12PM -0800, Davidlohr Bueso wrote:
> This is already done for us internally by the signal machinery.
>=20
> Cc: linux-i2c@vger.kernel.org
> Cc: peda@axentia.se
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to for-next, thanks!

Would have been nice if the cover letter was also sent to the
i2c-mailing list.


--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlv9MjAACgkQFA3kzBSg
Kbb8QhAAqwKxOKbj5GfXU8eW52HTh3H7K799qQAfEhc4Qn/1kUUIuvX6et29lEy5
6bJWcPjCORAMJ5qxHHSR0jGqkZq+z8Fl8cp98U8v2R0PZiGgB2+n6mOQsMH879SW
IyrgK/NBfFiEeI/FvCdxN8Z+I/vFa5LugyNhV9UKIUbz26tHdZVHcrRvvZd1OVNq
bdR+mJXxfr4Ik8NeppKUypjpxbU6nh1azIoY2/JSjq4GXt2/pZiaEyEUQDipcvet
Bre7p+O1s9qnT+6avsWq90zlXVFZq9gq2VdwJ0kevezjWi/Xqv8xgPQNcZKNjC2g
+kWQK1kC5S9HLRor+6Xek5jucj9wuXtoe1rCKCbCxn2pTrNYI+BaRLYzcw6Q8jTm
T8BsgqkyynSP8HxCm2lc5zMH5TpsTvR87gRiRh9lgtayGCc9cHUqnrHJTB+rtFSK
g1cCE7R97QWK3ct6AGrVbBAt6B/26ZMPYHP+jUFfHGtf01jQYnRtve6pITnOg2wl
wWbj5Ow5dRpcbOoSfQNZwkHzEiV99D466bWbfur6JTYmiHc5uXcMI3kaW5m8htmx
x0dretQVFR5FT5nTfDh5j3ONpJJzXaVvDyLtiPdkqunc0FSk07kAF0n4/ko7NQFe
2t9wVLIGMGhOhXBupysxBjN2fGQ8lsnwsIsbc7v8Wzs7ht9y/os=
=cYZ+
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
