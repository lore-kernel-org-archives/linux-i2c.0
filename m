From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.17
Date: Thu, 25 Sep 2014 20:41:11 +0200
Message-ID: <20140925184111.GA1924@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

this is probably not the kind of pull request you want to see that late
in the cycle. Yet, the ACPI refactorization was problematic again and
caused another two issues which need fixing. My holidays with limited
internet (plus travelling) and the developer's illness didn't help
either :(

The details:

- ACPI code was refactored out into a seperate file and as a
  side-effect, the i2c-core module got renamed. Jean Delvare rightfully
  complained about the rename being problematic for distributions. So,
  Mika and I thought the least problematic way to deal with it is to move
  all the code back into the main i2c core source file. This is mainly a
  huge code move with some #ifdeffery applied. No functional code changes.
  Our personal tests and the testbots did not find problems. (I was
  thinking about reverting, too, yet that would also have ~800 lines
  changed)

- The new ACPI code also had a NULL pointer exception, thanks to Peter
  for finding and fixing it.

- Mikko fixed a locking problem by decoupling clock_prepare and
  clock_enable.

- Addy learnt that the datasheet was wrong and reimplemented the
  frequency setup according to the new algorithm.

- Fan fixed an off-by-one error when copying data

- Janusz fixed a copy'n'paste bug which gave a wrong error message

- Sergei made sure that "don't touch" bits are not accessed

Please pull.

Thanks,

   Wolfram


The following changes since commit 9e82bf014195d6f0054982c463575cdce24292be:

  Linux 3.17-rc5 (2014-09-14 17:50:12 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-curre=
nt

for you to fetch changes up to 0aef44e84ad16cd87a88df78773fd81ecca34f11:

  i2c: acpi: Fix NULL Pointer dereference (2014-09-25 16:08:15 +0200)

----------------------------------------------------------------
Fan Du (1):
      i2c: ismt: use correct length when copy buffer

Janusz U=C5=BCycki (1):
      i2c: mxs: fix error message in pio transfer

Mikko Perttunen (1):
      i2c: tegra: Move clk_prepare/clk_set_rate to probe

Peter H=C3=BCwe (1):
      i2c: acpi: Fix NULL Pointer dereference

Sergei Shtylyov (1):
      i2c: rcar: fix RCAR_IRQ_ACK_{RECV|SEND}

Wolfram Sang (1):
      i2c: move acpi code back into the core

addy ke (1):
      i2c: rk3x: fix divisor calculation for SCL frequency

 MAINTAINERS                    |   1 -
 drivers/i2c/Makefile           |   5 +-
 drivers/i2c/busses/i2c-ismt.c  |   4 +-
 drivers/i2c/busses/i2c-mxs.c   |   2 +-
 drivers/i2c/busses/i2c-rcar.c  |   4 +-
 drivers/i2c/busses/i2c-rk3x.c  |  11 +-
 drivers/i2c/busses/i2c-tegra.c |  57 +++++--
 drivers/i2c/i2c-acpi.c         | 364 -------------------------------------=
----
 drivers/i2c/i2c-core.c         | 364 +++++++++++++++++++++++++++++++++++++=
++++
 include/linux/i2c.h            |  16 --
 10 files changed, 420 insertions(+), 408 deletions(-)
 delete mode 100644 drivers/i2c/i2c-acpi.c

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJGHHAAoJEBQN5MwUoCm20soP/1XnqM4R3cFr3q914HONuPb1
CEmsJH1cifWwk7ubknoScaVXglnomSWlT4fwl1KsqNEBbg27Ps0EhREi+o/SHlzD
7K8RDa6/3qwcHyGcHaHRrHlmk2QsE4e2yO7avGwzONo22L7VB11XTMQ6hGFB6wEH
Gw2UtqzScHHkSfp7j6U0BK8gKDCKPXNIyhwuoZYXQyC9cJw7vL94ib2KM4OzED7Y
+wg9UZ5nPvi7qxIj4EAqv7u+1Vr6tIyieVR1QLH4pi82W90D/paKwSMRHZQ4rRZS
x2b0PMunwywFkkTpkf+1BlvhJyPRdabs8UGdrdwSJy1Mg19gLdqx28eiJqePKilP
uw9+yakMyJXSlqN9J9n2NIJKyKCR369KfHEXdoOYwj+qAVyHWVUSyzzCpAeuCBsf
XkMGdO05M23/8CBXSUS9wR2KbKfFzIHUSyb/9tHRRBReOqVgLPxBrff+hfzlGX5h
zZTMmEmEzv3m+vN9EfJEkeM8R6VbGyQuztpVCdNSBk8o/wwoOiNCvhD5Ezt5mIGn
18bu/tAhNomVTOFm8OzmMtTidhbgSyNcsXzVUSmy4DghkNTug0suTGalYSNlXpfT
4oTBLp5IBpniGbNc9cFqkBW69TNVm88zmLfhQX1rLmSmW7ulx9Z0Ir6EXyVgl3ed
0WXnZDhAhK6wq/28b2aV
=yk+G
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
