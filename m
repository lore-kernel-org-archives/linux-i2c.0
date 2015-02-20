From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: rework clk code to handle NULL cookie
Date: Fri, 20 Feb 2015 17:43:58 +0100
Message-ID: <20150220164358.GB12246@katana>
References: <1424363824-6093-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424363824-6093-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 05:37:04PM +0100, Wolfram Sang wrote:
> For, !HAVE_CLK the clk API returns a NULL cookie. Rework the
> initialization code to handle that. If clk_get_rate() delivers 0, we use
> the fallback mechanisms. The patch is pretty easy when ignoring white
> space issues (git diff -b).
>=20
> Suggested-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

Applied to for-next so this gets larger build-testing ASAP. Then, it can
be in my pull request today or tomorrow. We need it to avoid regressions
for !HAVE_CLK configs. HW tests would be really appreciated!


--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU52ROAAoJEBQN5MwUoCm2H3EP/1ClYa38hNksjQClXVuGLEWb
uYpwfrgzKDU+4G/PnGK9JI7e+yXnzzvM8kwKADSbD7nNbzRBDa0/eRTFlJA9C0CW
xNtkEiWT/su7Rc7yZiKm5m7wK7BsPEEaN69CWykiRpJ1Ly5YRisCqoMjFQLFS0rg
6huXqxJz0R6Za0HvsKMgqu9rXOm9tW5mb452qWYBHSF370oCF22GCSzq2xBgM4Rh
AV1gBtLIkaOZxvtTgT6E57zbyVlMHRVgmt+C960Tpety47nNmJXFdJEBQibZ2yuh
HLuBInOxOfdh2jxcIQE024S+Q1fBzImVEd6oIcXZCOtMjzF+vYfNRd+huHg1Bwix
SjLjPmInEPUwNEScwI85aE3uo9DxU5G2GSiYJv6QJh7NBukZaH0WkRYVDxBOhyh1
+ZHYmRGYvFbL1a0XIFcZwu35BaacHLwNDGmmCw5QkLJI3AsHQTZsCSxxFfMU+0zs
shNVMlw+NVCFyu0U07k543pB9GZ8fIykurDYbYm/1sQazMaiE8Ceo1Awzx0Xajl4
xHj7KYK/OQiwesYeaJUr5djH6oqq+VDQHjcjyYoEZIMTrcj4EFB5GQcPNAtW7R6q
uN86tUU4MtxMGGywGtF5B/9v6mtGwq8aqgar4Q6QuFKl5dycmxO/trFZYG9+Tvcv
0C1OFwOqKv4GHrY8nBmv
=cBWD
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
