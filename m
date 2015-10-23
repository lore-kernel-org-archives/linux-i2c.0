From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V8] i2c: imx: implement bus recovery
Date: Fri, 23 Oct 2015 11:22:14 +0200
Message-ID: <20151023092213.GC13380@katana>
References: <1445221022-6991-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34335 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbbJWJWS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 05:22:18 -0400
Content-Disposition: inline
In-Reply-To: <1445221022-6991-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, u.kleine-koenig@pengutronix.de, kernel@pengutronix.de, hkallweit1@gmail.com, s.hauer@pengutronix.de


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 10:17:02AM +0800, Gao Pan wrote:
> Implement bus recovery methods for i2c-imx so we can recover from
> situations where SCL/SDA are stuck low.
>=20
> Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> pinctrl to gpio mode by calling pinctrl sleep set function, and then
> use GPIO to emulate the i2c protocol to send nine dummy clock to recover
> i2c device. After recovery, set i2c pinctrl to default group setting.
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Can't apply this one. Which one is this against? Should be at least 4.2.


--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKfxFAAoJEBQN5MwUoCm2C10P/1S9VvCys+pAYg9ztH0m6Ee0
4LcVnSsv/XpFjoSeeZYF5zCYObYm3jFkxOB/5q64eHSirJ57wFR9HSGKEVfrDlb1
1X2MK2WmX6A7LLn+Udmp9D++X09chrUmoledkoN9ZQOFEi2FIuFLxrt8euyjj0M9
VwTZ6UQA1nGOsproScVtcRi/Zh1yuspWkDdxtwlLylWmhQ0yRzJPPNF7IAW571IU
yuCLbwC8tHB6BqqY6ywrg8tAKJ4HiupW7MBMWI0aOYw/xDZuiTCzcvb1tDOfwv0+
r1yunAy/HSmSJlqx5t0aaL8I7UlAN/KD/gBwNGuLXAJWxRVp/uPJo6lOQ58HvzLP
dx+2fw7yiJKPZPtJltv0oKq90AvA4/wuQPlOIy0o7QLEfaAIzB3FdOWaK7NyHZbD
9iDmjpoKXOAhXmkSdnUeIKtX9tL0B3jHZQ/KcHvOVu60yUc98yix26ADt4yJoORq
6lG3/8p/qR0B/a9nv3CGp4vxIAV3i7T7z/b2u/gRcWlK6i+rULc/syQE1UpiM9sT
l1MxsUGpJVK2IGhZMHWIbyEVloMA/cRYgeNrz5Zm4k+I/M+UiA0KOvlLJW7hgFq2
aTUstWQg9bH99Gyi+Ytgvjo3yJk4v6XxOemBKcJJKnZqOnn84bynJSuDqTXI0XVI
vScV0UYBvQNNU0/WhF6W
=28eF
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
