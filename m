From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [i2c: dev] d6760b14d4:  BUG: KASAN: slab-out-of-bounds in
 of_device_uevent at addr ffff8800091b4c49
Date: Sat, 28 May 2016 09:12:34 +0200
Message-ID: <20160528071234.GA1714@katana>
References: <57493af0.akIr4abjopweDkBu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51876 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcE1HMu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 28 May 2016 03:12:50 -0400
Content-Disposition: inline
In-Reply-To: <57493af0.akIr4abjopweDkBu%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kernel test robot <fengguang.wu@intel.com>
Cc: Erico Nunes <erico.nunes@datacom.ind.br>, LKP <lkp@01.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, wfg@linux.intel.com


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> 0day kernel testing robot got the below dmesg and the first bad commit is
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

So, I got a success message from buildbot "[wsa:i2c/for-next]
72a71f869c95dc11b73f09fe18c593d4a0618c3f BUILD SUCCESS".

I assume now that the above message covers only compile-testing while
linus master tree also gets boot testing? Correct?

I was under the impression before that the above message also covers
simple boot tests.

Thanks,

   Wolfram


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSUTiAAoJEBQN5MwUoCm2NgYQAIS3JU1eCzIoKUG0dhkj8Ol7
wfO1NwdF1rerwO77y1BkRhMdWST6BMaOmNGerXOZHrUtYTL6YDmKIIu4oQYZnItf
PgRksNQ5+wZwyUjVr6HFIBVaEuIs/rqgFT6uhJpIafeZAxQv2xpW41qZK6r3E6W2
IVeHYNI3aMQnrE6B3X/MkDdki0cMBKhcOmPk/PCtM+G+UjZJ51w/xAJL+gIaDx2O
stqMoPKk1G6g2zIX2pmljc7U/w2tQFYfs6laqIv3BFXcXp4zt0XBJci0REfbsX0B
hYv3d72pukeEJG8ab4y7y3gHKdS/Vd/xlUYFVfYIo22YMTAt3kyCskcRn31iR77u
Iai29yTk/y9KeQb4NJ0T9sJ0CoSmEu/2rzqScEKaljsLmHI1dzWQMIL16zWeTBlJ
wE5rJjh8rl5Yyr0cNYPW1BHupg1toT3IrVQPWV43yQxCNKbBRAF2qw7m3yn6BOAy
7F3ecQj2slH+YQfcuI1HqG4z/a9DfVZaeDwL4szsc2kQJkmpK8+9JMALoQKKLCVh
J6/e+Zes0uBheq83MlYdMyHrIqCaHT+fSaEbaqbuz+4zhSgxio0J40OFHfk8lAje
Eo3QfnhEsGH7E2plqbXqj0h/o+oq+UuF2hxpMZNhM2RzJRe8abyify0wpdgdnew4
BEw4wpgRVTcMM1Wn4Wdu
=b9EL
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
