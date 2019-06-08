From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 5.2
Date: Sat, 8 Jun 2019 10:54:10 +0200
Message-ID: <20190608085406.GA1746@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has a driver bugfix and a MAINTAINERS fix.

Please pull.

Thanks,

   Wolfram


The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 8f77293cca1f5116edc98d7a0e36c6da3917fc08:

  MAINTAINERS: Karthikeyan Ramasubramanian is MIA (2019-06-08 00:32:50 +0200)

----------------------------------------------------------------
Robert Hancock (1):
      i2c: xiic: Add max_read_len quirk

Wolfram Sang (1):
      MAINTAINERS: Karthikeyan Ramasubramanian is MIA


with much appreciated quality assurance from
----------------------------------------------------------------
Michal Simek (1):
      (Rev.) i2c: xiic: Add max_read_len quirk

 MAINTAINERS                   | 1 -
 drivers/i2c/busses/i2c-xiic.c | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlz7d6kACgkQFA3kzBSg
KbbNzBAAkTwbbglUamLuV1jUGB9KzuTIyXY7XkQpYo02ksw8X2b66Ipdfc59KVfW
LJxm8efPLOVx+rlvZ/eB4J1vu7OQqHHvihV8G6GTM/9GAmSusnkITNLpGJ645Gc4
s9hy0Wbq2rrLMVNCJnxsr3njediP/y766RfzHQhxS7b9UtwQu05mr9cyrE+XQCs2
MdJNDEZeN+J6lbhjj3ErSBKiKenlrz6FAggKazP3fhD/5Yhv1Uh6InigL/b6XuEc
MbAbiNuwy7OPeMLZPi7AzP67yTRAd6NR7wI9Twx1llyqfcYakm+dFER4HHNEqdi3
j/SSPIfZeNJakz/CYr0xoKBPUwsHmdAe/vNmCDgsF6n5K3v9CXmPv52ycjmby1zy
Qq0WQWq12ELCoUZozxJPqjNDaAuXvyII57hJu6UciIE0shWqHUsClPvveZCR88kX
r+XHNiE+xSab1OfIIHNAqxKq4jvBcPyo40jQK1oWVrJWoJM4KUdspNWnAKnPHLoI
YgbbeOx+w8OlT2WNw8rywOvMmpqSSQS/qiIjdXe7PuKw9zBa42KQRwwxPKgNjccZ
ubI/nVv0Y+aSd+HOnoypkHCO8ZTdGEkt/MQ2leF02DWMfcNX/AUYJyMmd87lv7aA
jH06Eg/6+x9vAV87zPgrOqJOfkTO9Ygqa6Z+I0K9LNIBdVsTk4E=
=8khH
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
