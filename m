From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Date: Sun, 13 Dec 2015 10:09:59 +0100
Message-ID: <20151213090959.GB1570@katana>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel>
 <20151212162057.GA1530@katana>
 <2157023.1Ftpc9ZciN@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49541 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692AbbLMJKI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 13 Dec 2015 04:10:08 -0500
Content-Disposition: inline
In-Reply-To: <2157023.1Ftpc9ZciN@wuerfel>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > The slave_cb callback function is supposed to set the 'value'
> > > here,
> >=20
> > Only if a master wants to READ from us.
>=20
> Right, and can this never fail?

Exactly. The slave can stretch the clock if the value to be sent to the
master needs some processing first, but it must deliver something.

> With my current code to turn i2c_slave_event() into an empty inline funct=
ion
> in case of !CONFIG_I2C_SLAVE, the compiler knows that "value" is uninitia=
lized
> at the point where we write it to the register, and warns about it.

I overlooked that your first patch changed this code, sorry. Now I see
the problem.

What about not ifdeffing the inline function and keep the build error
whenever someone uses it without I2C_SLAVE being selected?

Thanks,

   Wolfram


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbTXnAAoJEBQN5MwUoCm2JSUP/3zxkZo5+Uljav7NSKhh2YK1
kg6F0qAVA/fgCKZBZX7tabgTypQns8F4Wyvy+5xhZmw442q220jTAhPuo4N4Jxtn
qHuaYOzF8xrpet23SmXoRuxB9LKTVuqh5KQkz2dvr/Y8O4+KQWKKN1eXflqEelCk
lIaCjTUnTLgQshCC05dCIAnTbLXp8akH12xAx0m+4EbKb+t4a6R+A+TGBKq2QgNx
I5+/I4jtF8shIlvCmLOpObcYAnT9kuubSmUbEjj26JoiIfpwsngMm6/BBkxgGENB
DAMAlUoUWHC/t9ajg4G+Fp8ZIp1e+BmMsB3S97VwtQf8TAugopXXS87V6pjo9jxU
vBwo/CGFpMyPRK0GJNOZIo9gnPiLzSTCEgbjj8zmqNA1wJxcRRBeHouJ2CCkSjKS
MwfNboXFIDm0YYN9M87ajx7fo58e0w1ZuD+0fTnNjDLGY5654sJIr3y7IhwyuYex
Xnoxl5bI5aUunAb92PRIz3msEYEU6p4XbgYZ5m2xeJ8sd5sAVbC6gBm8GNGXEbdF
zk6xL9Rq5bOKrJnSSaER96xslUqFjKd2qlfFLRs0cTxk1AmWWIQg69B8UALm+TOk
lKU2VFXHco0INbTXvPSf3yCZcOLovpNiVq5nnzJ5EZQaRhC9Hjx0fTyZGgy3uDhD
bwGNqwA3LQZu15CNoHXL
=Nep7
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
