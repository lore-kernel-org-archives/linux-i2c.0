From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: taos-evm: constify serio_device_id
Date: Thu, 17 Aug 2017 17:37:24 +0200
Message-ID: <20170817153724.yg33zhmgdnthbxlb@ninjato>
References: <251e9103c373c0b7d9a97917e48f323f2adcf716.1502971448.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m53r4ajhk6bykggs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <251e9103c373c0b7d9a97917e48f323f2adcf716.1502971448.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jdelvare@suse.com, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--m53r4ajhk6bykggs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 05:35:52PM +0530, Arvind Yadav wrote:
> serio_device_id are not supposed to change at runtime. All functions
> working with serio_device_id provided by <linux/serio.h> work with
> const serio_device_id. So mark the non-const structs as const.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-next, thanks!


--m53r4ajhk6bykggs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVuDEACgkQFA3kzBSg
KbZ5OxAAqL+YrZx8DwXBJYDlhtxpMiMMK0Z/FpBwVrMe7xj3uBB5HtqscNZB+ChL
Nw7i6leIEZd6kHH8FJscKGVJWwwagnOffjToZEieoeQ6fFYsHj5wBqU5FS0TxCkz
6XSOeb90g+EMMqy4xVXMaddrx8XxlR0HmW/VqntnZVMswq90skBlt1V3shYVWh66
k13yIF5THTlu7O5EeGs1AdkBOsoa46SnRlEcCK//w1ORz4AsGvGuASrp7YK9d/Uu
n0sqanT1iJemHpGtO+gaE7dMKTeJQ9XPrbe03rxb/Io96YxyQ6JoERSbUnkXiQCq
t4lPQ6SlOVQglqDtqzOPIH8WvaihBUt2LiRd5cvaXRu+wlIjRoji0/7fgmPrleVW
tUfaxh76ZlThuP/S1yvfUKThhQbnmt15Fd/Ti62x5G3QuZgV/zr49I1wMiOwt0sF
ULLFYoNtzsKy+3ePijMYE7orOk12Ro2jRgOJ65nIXE/r+YQTuCpUmh8S3XFqA7uY
rXhEhba44jU5YE1Zy6L8DmoaRx2GepEUfJI3ntM0X4Hn86XGtaQ07i5b9adcCQtg
LDtvlXN1kTLZkCYoX+yzesSBBjVm0Jcqn9wGfyakn9Sz6+pIUs3bNczZWykPvGFQ
hJ1NlSvdL4fBPz8/5edsePlurMHfSN9ANcXd6+l0WkghpTGuUJs=
=6rwk
-----END PGP SIGNATURE-----

--m53r4ajhk6bykggs--
