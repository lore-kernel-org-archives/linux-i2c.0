From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: versatile: Make i2c_algo_bit_data const
Date: Tue, 29 Aug 2017 22:34:34 +0200
Message-ID: <20170829203434.fhmpcacxb4jzuqyt@ninjato>
References: <1503322117-25860-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhoijir3nt6whslv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503322117-25860-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--mhoijir3nt6whslv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 06:58:37PM +0530, Bhumika Goyal wrote:
> Make this const as it is only used in a copy operation.
> Done using Coccinelle.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied to for-next, thanks!


--mhoijir3nt6whslv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlz9oACgkQFA3kzBSg
KbbwcQ/8CkDmnumEGHjXHjZZDP1RnYgc70DsnL62/su0IIGhAJG/ouNwm7TKj+QG
WV0clYW0niEjWCNSngo/scyzcd3uTy89DxfUXEVq5MAjYWhFIeN4kyedxwRcFWvs
B6low8bqdoacCE2Yz+tSSN+DfYqssnw3edSLvxmKMK/0Mhn+r6OPRq2zQZLNoez1
Ii4nECmhkhOFHG+eFUPja3edNOT9835ulFn2EfXH2ZFDVVqip9xLBHy1H1CojUeF
Fp279y8EDnqST+Ko5WNLFpdLsqEENgrNd4OXUiedN3NGG7A0TGbMnkxOrpkZ7rcQ
IOn4bkG0Hd4MLUrVswCiARQVsSIjlMuc9gSn1g34/4/eEmyMCNwb9xcKBgguBx89
G7hEgBtAeqITqTxzJuTehx58x3o392vcfP0Dj0DJMwWXypV5hQsg0soH1X4YuOdN
/sGhRegR/ZsBFGnvQ5Uqwgqq43qsd3UBtjBLuoR+UkC3WU8orY1NivWQCXRAIw6M
IvNXaQATU6aFPCJF+TPfhfAUCpyzT5FzCzv8U8gq2i7R0wjmCWpASbD4auNCufZE
Mqi6zqsklizSRoF2rUVjCjnMGiDQN6Y8l6xYiTnK+TvpkKy68ZaifF8YRbdEO7jV
50Zfjhhv+MFwvmLa+R9gQsSZ3imAs/4FZyY/rzSXCqq63gwENiM=
=i4u0
-----END PGP SIGNATURE-----

--mhoijir3nt6whslv--
