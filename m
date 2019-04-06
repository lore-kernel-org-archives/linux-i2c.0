From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 5.1
Date: Sat, 6 Apr 2019 23:30:43 +0200
Message-ID: <20190406213039.GA8502@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

I2C has a simple but wanted driver bugfix.

Please pull.

Thanks,

   Wolfram


The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt-fixed

for you to fetch changes up to 3ace6891ce8bb9e1267358cb58f93b4fd8b72b69:

  i2c: imx: don't leak the i2c adapter on error (2019-04-06 17:54:28 +0200)

----------------------------------------------------------------
Laurentiu Tudor (1):
      i2c: imx: don't leak the i2c adapter on error


with much appreciated quality assurance from
----------------------------------------------------------------
Mukesh Ojha (1):
      (Rev.) i2c: imx: don't leak the i2c adapter on error

Uwe Kleine-K=C3=B6nig (1):
      (Rev.) i2c: imx: don't leak the i2c adapter on error

 drivers/i2c/busses/i2c-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlypGnoACgkQFA3kzBSg
KbbT1BAAjoGxYdEZE/C+ggKvU5vvWvN5wtQlj+h/GIGPbO2JYLAjmjShmwY5xLTc
O+Q35yCUag2VP73KKPUg/fEHOt5b/kK1UzsJOTGWwQUg+Aj162mwLsLD+qC7RcpA
z54rrca+ur0rVLWnAWMl0HOWx8uWHC54NdsqDBIDOyd++mX/XeevawrRMLt4PqSS
D1L+75pGNv38H+MveA9pP32CpCM7F4fAWG+QjCEGsRBLcpfdxKKXLYyXaCEUR0cp
RZg/2kcGgig+0dkomEuy9yyv4vfQirlC83Vmbbi+4KclVGCl9aVOWwCtpsCot85x
gcoTeAh6Wp1CAjaJ4drZLoqRUtueGHDboIRmMGyfuLPk+xwXSalp7Jb5B634B4G9
KZLKBkCNF3YcKnPF2uQmh4dzKb/M2TDNkrKj+QqLsjuPkk+mrmPfM326ubKEjHLw
ZKj32+ozsmBHs+hUph2r0U+PeeaLeS/Zn4Sz0xSmiQcoBJpLvsIpUYY8nBxYB65u
HLWZObLnuLKa1xOZGJLOy9V6C3XonT1dJ+ScFa+x7QV5zhObOVz1/5Mr1V+ef/s0
y/9wvCzQH1JDaVpgR++emsg8l+4dKIRg8B9mZAJzDEG2uzekcMvpICCrDvx6BXpB
7kwVX+uERfEkH38VTu473UU3ev/e3De1W/EO/Rh+wlg9PnEgEio=
=RUS6
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
