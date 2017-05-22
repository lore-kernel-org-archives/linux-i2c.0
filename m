From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.12
Date: Mon, 22 May 2017 22:14:21 +0200
Message-ID: <20170522201421.zq6ao54uzubjfiiy@ninjato>
References: <20170519204014.jumojwrdw6lfnycw@ninjato>
 <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ccy5v62gzlfzvb23"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--ccy5v62gzlfzvb23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Gaah. I hadn't tested this on my laptop, and instead of beign a
> regression fix, this looks like a new regression. My touchpad on the
> xps 13 9350 no longer works after this.

Can you try e2c824924cdb41 ("i2c: designware: Fix bogus sda_hold_time
due to uninitialized vars") from my for-current branch? I am waiting for
buildbot results before I send out the pull request.


--ccy5v62gzlfzvb23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkjRpkACgkQFA3kzBSg
KbZ3/g/5AYeF271qPB/HVIlKhoIpJotHiRdIXqMHtiUE3fxKapluDykZ8kV1tzq4
wVCXQyXQZIgubTPHpvpUEYu9BgQ5FICmCuIYHCUvGBa9Lg97G3g1l8WSH0NgabvF
CIOvcddaKDTSsVZFvMhhgpThjv5JqaQAh9JEQTopHrBhCs2tS73SEaYe7RDUE5Q4
mzwWvxl3B3ZnRRGYwK/s1y2FG8SVhNIWLkvQhS3q+AT9Vrp/JgZID2d5E+Qyvwgw
VggBdTn+s3KUPTu8gpJdzJYjjbtADRM2TLuAYjQrk9DoXraDrx8QHGvurwljOfis
SCqErodGnODkanTN9mNJNdA9U8xzmdkRZt312vYKD+tLBQ8o2GiU49pJY3wwFkQD
g3Zp6mTEvPD7U6QtyXKtvZbVLzQdjTSXwJz0vYuRVruJACjskMVkdvvAuFSCkqer
XTbARwBdC55yuIsiGeboerVo3hCEN8LVIaBPwmTnYceu7T3LB/4ulbyKvKp0qX5S
iU5bYMA+OUBwaGrRdVrj4H2fAwsEKh72KySxkKg4EdnYV+oR8lIpiTv65BAoTv/F
1gdwLIFWFfVNXhdnGCYwX188Nj8kRz2Ag3oFuxCPSRpD3gxMyuIo16a1vYTmUidw
p4ZUQtAEkZ9x2nyOkr6U/kWAFRbX/a+H+42E9ZHwB1X0UBqyNtg=
=DT9p
-----END PGP SIGNATURE-----

--ccy5v62gzlfzvb23--
