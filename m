From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 05/15] i2c: octeon: Enable High-Level Controller
Date: Mon, 25 Apr 2016 23:44:29 +0200
Message-ID: <20160425214429.GE1550@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-6-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461594824-7215-6-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>
List-Id: linux-i2c@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:34PM +0200, Jan Glauber wrote:
> From: David Daney <ddaney@caviumnetworks.com>
>=20
> Use High-Level Controller (HLC) when possible. The HLC can read/write
> up to 8 bytes and is completely optional. The most important difference
> of the HLC is that it only requires one interrupt for a transfer
> (up to 8 bytes) where the low-level read/write requires 2 interrupts
> plus one interrupt per transferred byte. Since the interrupts are costly
> using the HLC improves the performance. Also, the HLC provides improved
> error handling.
>=20
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!

I can recommend using --strict with checkpatch. It found some issues:

total: 0 errors, 0 warnings, 18 checks, 427 lines checked

CHECK: No space is necessary after a cast
#327: FILE: drivers/i2c/busses/i2c-octeon.c:563:
+		ext |=3D (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;

I fixed all 14 of those.

CHECK: braces {} should be used on all arms of this statement
#325: FILE: drivers/i2c/busses/i2c-octeon.c:561:
+	if (msgs[0].len =3D=3D 2) {
[...]
+	} else
[...]

and 2 of those.


--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHo+9AAoJEBQN5MwUoCm2NhUQAJRq+FOidw4QZh+ai2wL1BAs
f34UEpUT8AGAQytmDM6tjX1fi+WKkQzb5O163ZJECOq0YtQmq5Ae8h8rnYSdGWfr
XE4UlqKIRwQxurjN+TJOPNvl3nT9FyThQ3sHXuPEtLol/SFoboDTc94kPb5ykj6/
Y+XO1N0iPaLUJ955ryjUCZ1IIqT11cppQ0TvBoQD30f7yecbtkv47BthS3iD8YiE
f+FaBOYoJrtlaiHRDDCj+k2RN8s1cgAxeizahOPruOPVQcWxFxZLUhIk1k8c7Wdv
OYZHabtruwbRVpSOXRSPJ8Ty9c/u6iBTv8nalfnHE5n2YuYiuQv56wpuhQRqJluZ
VL0DfAsE08lsCPabOanb/qIFq7ipaU4zA65ffctPRbeMopITtW/AtXsh7fd30BH6
ESQI/PiEFTqxzdhzLVHIBDW2QPqIA6rYsOxEiHhDI6J6wI2iAryrdFjCPVWFZVNl
8GqAhrP2ymgho1X4zsI735X5lZBwE/cs0WqS/GOKutQVyBzL9JI1krfD7J2/1akh
V1iF+AOhh9N/xVXelj0WBAGtGZJ/LDtErXwEsj/75aVat6tzpz741pi5n+b/O7sP
Qj4xp5B7Qfgjd2wBkW8oNART0tpCb0KMXAHevhxBHYWBrTgzklItcBAPGarEC56c
5H95OvWYOB3Q/RwUCn+0
=eKTH
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--
