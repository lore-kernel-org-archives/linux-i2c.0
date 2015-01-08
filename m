From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:i2c/quirks 8/11] drivers/i2c/busses/i2c-dln2.c:184:27:
 sparse: symbol 'dln2_i2c_quirks' was not declared. Should it be static?
Date: Thu, 8 Jan 2015 19:37:48 +0100
Message-ID: <20150108183748.GB29629@katana>
References: <201501090243.rmSyDkOe%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201501090243.rmSyDkOe%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>, Octavian Purdila <octavian.purdila@intel.com>, Johan Hovold <johan@kernel.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 02:02:00AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/quirks
> head:   b1d39af8ae21f4930854b0656aa83a83fd38049e
> commit: dfd33ddaa80259918c200cfacb9076c75cf1da82 [8/11] i2c: dln2: make u=
se of the new infrastructure for quirks
> reproduce:
>   # apt-get install sparse
>   git checkout dfd33ddaa80259918c200cfacb9076c75cf1da82
>   make ARCH=3Dx86_64 allmodconfig
>   make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/i2c/busses/i2c-dln2.c:184:27: sparse: symbol 'dln2_i2c_quirks'=
 was not declared. Should it be static?
>=20
> Please review and possibly fold the followup patch.

Development branch noise, please ignore.


--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrs58AAoJEBQN5MwUoCm2c7MP/jMJz0KRfcvRj/OPbi1w8aEK
i8TrDwOf1tH/1qWBCgRyGWtd1n33iLaZ3u7v/Om4+hpZUXrOV6gDzMBo+B0jmmwL
yFTNirPMv2tzZzFgs6YmlcqnX9SCGMBJWJaRFfn8W62z0axsjiKfBpDzfmAX1cqe
p2gFhHtINiVL7k8qrQWw+GcoZp0hXxNElhfmbvtGZ/DvfoKLHrZoVZbDgHtDQMeq
+iNBZ0lpGjpoUrxEbS0679sXiaTkuqLyge7DOOPY04qHOYD4aC0OmpbVRjJKYCQF
pkCrHULQ4bNK0QOcB9y5PzAcyZkflh5333Ow0u5geV/4LK40AmwadOV0q81a16iZ
eI4m4gRZrAwvu5aFwMcvWu8ZMiUFPtuhvOGfnbSHi7jB5wfbDEFdRwoQrpdBqjDn
qLi9E4I/6o9FSSnVQtzYx97IzNa3aWoRdyKVOOF3KZgnJK34imlheM5UB6/fkC8D
HxoxNZLmFzgfLB2MK8Gkx1YHL4ivaaZ7xiRPkuYZq0Gpif4gIlQEokzTBDtKbS2r
nOH65Fzb8n9kiv8iyaq7KYtSa/cwIKb7XhH8T9ZqomLmEBc3806K6WmPS1kybpjc
0OrP9J+CnyNpx2M/rWVin8ea1Uh9/EbHQI/pacW4qrSO5WJDQbOusRZX/JwUGJi4
X+GOlGgQOuKd+H6ltD6Z
=k13d
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
