From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: make i2c_parse_fw_timings() always visible
Date: Thu, 17 Dec 2015 20:38:39 +0100
Message-ID: <20151217193839.GB1530@katana>
References: <1450355556-19875-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450355556-19875-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jim Davis <jim.epost@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2015 at 01:32:36PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> This function used to be DT only, so it lived inside a CONFIG_OF block.
> Now it uses device attributes and must be moved outside of it. No
> further code changes.
>=20
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcw8/AAoJEBQN5MwUoCm2ee8QAIQpiX0luieSfSMeIjwZiZao
nnIBydPuoimY5U7+5Fx4k1epHSZ7qQLxfrofUegK3sNFqIzThgfiyQqBz0BDLLi0
pIHGRUottc0Pox2jUZ86sG6Evzp2/5eTJxqexwLmmnsd2Nvj4zWZ7tJs7MHiwSpn
+xUrslkolvzSbpwwF+hyS0VEI9SBfEQ47B0kLenlFJ1zQVcdeCEuDsVuUZVBzFH6
KxQMRNIOw5KRFTCkAuBm4lIP0DZtob2bETHFMZJbWFhLJBvI6QqdATLuJ2WJFXSz
2ZIKDfUJ6wqCCXZA9fAsUhUu5Ix31BHvWaBSGh0bGz0jMtu4kp06zc/TT/xXpE8T
aXHnJRJXh0qX9wgHOSHZAn646qzsoxA/npzBeCaMkT27v7p4j38R5NXZ35J6t9iB
A/PHG8Ng9/SeE1wbkDu7NdzjXZifrlo6wBUXelxTM8ZfsClreytJ9pRz1Ne7KKJS
k5KjmJlNhACTdDHyHhzB0xgHKGigXUl/iXPfPwqskfwtIiatEiBHOEq7bWdRg9er
qye94I9EktcHh3J0d6TnKoWCM4NCpuLCJKzbsOEv4iug3SWJmAezECkMyFQJdxan
yG8giOuUQMVeeV1sYHAvtcj7TCFuBQ0D038z2lj+Hx/XG/HK4IwbEla94wuwf7Oa
EMC8SFpU/auJpPRzdA5w
=LRnF
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
