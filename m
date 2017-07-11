From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:i2c/for-4.13 15/51] warning: __mcount_loc already exists:
 drivers/i2c/algos/i2c-algo-bit.o
Date: Tue, 11 Jul 2017 08:54:31 +0200
Message-ID: <20170711065431.GA2342@katana>
References: <201707111232.THY3DhFS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46802 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753946AbdGKGye (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Jul 2017 02:54:34 -0400
Content-Disposition: inline
In-Reply-To: <201707111232.THY3DhFS%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 12:16:34PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c=
/for-4.13
> head:   8f1a357d41a22009150cf404b5aa5876efdb59b1
> commit: d44005672d83f89d7d797efc490a751a696e7d91 [15/51] i2c: stub: fix b=
uild warning regression
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout d44005672d83f89d7d797efc490a751a696e7d91
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> warning: __mcount_loc already exists: drivers/i2c/algos/i2c-algo-bit.o
> --
> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-emev2.o
> --
> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-xlp9xx.o
> --
> >> warning: __mcount_loc already exists: drivers/i2c/busses/i2c-rcar.o

False positive? How can a commit that only touches the DEBUG define in
i2c-algo-bit have effects on the latter three drivers?


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllkdiIACgkQFA3kzBSg
Kbba6g/+NdRJlrivfH43fdB/beoxu3G6i2jsadbGulZGSHi2pwHXelL6ZMQxoArJ
ZRCBjC0r6mj/E5sE8l8yCfVDvH7YhWgSvTJyx+Y5J+pNnUReaFDmPuLR9/cYEXvW
9EHWQto2wOYfsSu2NixHfc1QNoA7My5Dd+SYXKPCuPvFUwan4jjjUXPsxUpiwDiL
nBkFWsxvE3E6ppiR/mdzg9ZHVhVQNgna9LtpHO4GBgwXlK2+e+k+5VqW8KAtGSSH
C49Ur1nc/axgeW84Ien8Z9H8zei5x7aBvANBLXiKJmu8aq6vmd3cyyxUB67qHIzh
GG6H9i9MAveeYfsvv2gn/ILO2Fkjh2SA+K3ZywiXINMb4S/d4qKckN/ARUvSwYDN
xdU5b/AFPrd4gCGfT9LS+EBDJYnW6Ihby5fRvqGO8PkkWOH0MWydpNI6jD4iThy/
ZcKo+KSEZ1qRl9Qq3nQJHfYbSs62xWJyc5PQ19gLfwy46mJOOjp/GtBDcFWl4FDq
CxI8pmDFkEJnEEezoDRem1/DoW8Hb6bsYxz2Lc7EMDkICk4HoSMLlYoGf9C6ausb
Ywbz1Lae3Eb89rp5zkp0ID/L7yx4RP8aor4eDkuoa50bv6b8F40oyOGB2SQeysxr
8EEo21R0ssAqpHU0OtFEg26Y+T5WuvII0O8ZVLv4Gq8bS5eiwQ8=
=C/i9
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
