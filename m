From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Remove adapter name from debug
 print in i2c_dw_isr()
Date: Fri, 7 Aug 2015 13:10:29 +0200
Message-ID: <20150807111029.GB12206@katana>
References: <1438944208-16276-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1438944208-16276-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438944208-16276-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 01:43:28PM +0300, Jarkko Nikula wrote:
> Printing adapter name is irrelevant from this debug print and makes output
> needlessly long. Having already device and functions names printed here is
> enough for debugging.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

So much about the double space :) I think I'll squash those two.


--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxJIlAAoJEBQN5MwUoCm2xHUP/1yIbJ2k0BHFav/h7dt7lfSE
1vvMcQ5A32kDXQWTTDLaA9UMlkjD8+BysbZ51Lv3O2HJvsRv0KDcoOBeucssicVz
RtMW022d3P6AnmUIbRm2O38O3lm/v28m5toKMC4u375/3N5gUrIne5qrLkQ2Qfk1
ZN1qIJZetKv3LHt9at3CltBCO+SyK5iEyQdRBLpjlOtRoiwgKDLKDjsAb/ByTDuw
gCLdgPxlGrSrSxwyqINK+rEPujK2fezSE5Sz7oTu77dRCqxkvoXHOB4ah0C6rew3
y2WfDm2E3X+xEbqLKzZt8uJ0Odpt4U+/+mnf0ZB2mP2qUbESvokSB+yp8pqFcLGN
eeqlWAgTNq1lJK1yQ146oXaca3kvu7cLNYcGqnda5ZZ812MS87z8NshR2pevAs08
lJoc1Cg2LD3oSEETDULOoKPD3PudfOOUAIYn5vzh9DgU21U9KBHpNLgzjGjWm5j7
o7HJ71nZ0H1RTmHZSalm11NyqDZjnbcBsJuICagVMl0GJUXrN2PnHzsOmoCBH98L
F/7amy5l6VsNc89ShesNk8NtcUsP8Kx0iKCB2eSHohZ55HpzF9N3HXSZ12SKRNO+
wX1VmDDD/paXyhnzY9bSxPPRzkOlxN32d2eqUxdt5/XSgf4r0/eQofPtNOc2d9+P
anvu+wHv7B/LKGe9FxxW
=kqwi
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
