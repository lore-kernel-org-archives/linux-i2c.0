From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Sensor with 7 bit address above 0x77
Date: Mon, 27 Jun 2016 17:46:17 +0200
Message-ID: <20160627154617.GB3505@katana>
References: <17002e23-eaf4-125c-9402-4def2bf13e51@sigma-star.at>
 <20160627121319.GA1648@katana>
 <dafe2d59-1a23-67cc-6a2a-50a43d0325f1@sigma-star.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41487 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcF0PqV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 11:46:21 -0400
Content-Disposition: inline
In-Reply-To: <dafe2d59-1a23-67cc-6a2a-50a43d0325f1@sigma-star.at>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: linux-i2c@vger.kernel.org, Richard Weinberger <richard@sigma-star.at>


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The way it is written in the spec (1111 0XX) probably caused people to
> confuse it for 0xF0-0xF3 which I found in some messages on the mailing
> list.

Yes, it always causes confusion if the R/W bit is part of the address or
not.

> But that still leaves the question of where the 0xA... in the kernel docs
> came from.

less Documentation/i2c/ten-bit-addresses

> Section 3.1.12 ends with some musings about the assignment of addresses in
> "local systems". More specifically, it ends with the sentence "If it is k=
nown
> that the reserved address is never going to be used for its intended purp=
ose,
> a reserved address can be used for a slave address."
>=20
> I _do_ know that there are no 10 bit addressed slaves in my application, =
so
> the spec allows me to use at those 4 slave address. Apparently it is not =
my
> device that is broken.

For your specific case, I agree. For the generic case, I don't. Maybe
the word "broken" is too much, though, how about calling it "risky"?
That being said, as I mentioned before, I think patches adding support
for using "risky" addresses in i2c-tools are acceptable, so no
show-stopper here.

Can you share which device uses the address 0x78? I'd like to add it to
my list of "interesting I2C devices".


--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcUpJAAoJEBQN5MwUoCm2whwP/02f3OaIUpEmHrxWgmgODFoA
h9j/x2FPGCv/sAgrTdhC0jyGNoiiHW3wvxX+qtgzwG50KLtkAUoG6moRKjTe+kPP
udz84u0flpQNxalAMRJL0/6V+I6fVOSYZkgycYrYkZE2dPKIxebt6NkM+e3OORNe
YCMGIOTzJWfl+P522JTHlraI5fyaKucvaPF6bftH8jboujotNYJceL2PuUcl+gdv
5UHgYabYUwfmv8HjQ5TqFDaOuofZUqJYuwdKoZgKXERYBP6Il2fE6aDBJVgsGGuO
PVsg+zkPpPpFGb0LIWw2ytqFvp5UuTJ5MkypHVWiHo33Mha7Rl+I6YYJn+dC+yXg
WiQnbCNj38Ttwbmcm8NUUbWo1w8luE0KveRj0/kRnsdIwtrjZ4Ybp8r2lMgIHGMa
oLQfvYofTU6PeJ99siwWotExVhwpXwHV4x/CYg19rY0hSyXTz+HrXepX/CRuH16l
POmBl3IIDOMpVfDmXDcmVN0Qshm1osJKOP0LwL1QM5B9gLeinI07GXAknC49RUz3
YNAO7Kf8vM6m/wosAsmi/8TSPpkOrCb+myYsfwTbATv/FZCPyal1s1R6qxOAHxzQ
KXOTzrQZo6b/yjjabKzmtLfRCPAcwZXaw1oHPZATym3yyqfF/gHgqlrt/pEK82vX
19jaFOtMPuk6nFnduUmM
=g/KG
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
