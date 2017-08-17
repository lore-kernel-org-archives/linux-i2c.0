From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: designware: Remove needless
 pm_runtime_put_noidle() call
Date: Thu, 17 Aug 2017 17:57:08 +0200
Message-ID: <20170817155708.iakoglf7qrdf66bc@ninjato>
References: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6uo77eyu4mijgow6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60288 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751620AbdHQP5K (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 11:57:10 -0400
Content-Disposition: inline
In-Reply-To: <20170815143445.26167-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>


--6uo77eyu4mijgow6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 05:34:44PM +0300, Jarkko Nikula wrote:
> I guess pm_runtime_put_noidle() call in i2c_dw_probe_slave() was copied
> by accident from similar master mode adapter registration code. It is
> unbalanced due missing pm_runtime_get_noresume() but harmless since it
> doesn't decrease dev->power.usage_count below zero.
>=20
> In theory we can hit similar needless runtime suspend/resume cycle
> during slave mode adapter registration that was happening when
> registering the master mode adapter. See commit cd998ded5c12 ("i2c:
> designware: Prevent runtime suspend during adapter registration").
>=20
> However, since we are slave, we can consider it as a wrong configuration
> if we have other slaves attached under this adapter and can omit the
> pm_runtime_get_noresume()/pm_runtime_put_noidle() calls for simplicity.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks! Not really a bugfix, but 2/2 is, so,
well... BTW, Luis, are you still there? Holiday season?


--6uo77eyu4mijgow6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVvNQACgkQFA3kzBSg
KbaWCg/6AzKuexNoTb4MCQ6deSjAwBpz27CpjxbtULt/L8k//08rYysx6NRJNkg7
8fTPwFH9l2XHp4sI6GnHsY/4WDQhx7rah31T/82+q3oMASi1GdeJTc4lWeQ2oOoK
zqq2SPPyzcgWZonjk/PItOap/nqDqYbdacl5dw+Uzz/8Y0qBmSTxVTHcZXpL7Nnv
HaxGCAuM41PMRa2LRcT5J1vbPcahRDpBRdIRTXisVEC9QKqn6+saG/gNolzTLSk3
4ySOf3L9uuguBSfKpDb1Bp6iYrT2T5vlWAHL4zt2IEX9paiQmdSB4rVt6mR9JFnH
8+cOmh4BQmmlF161JMeb7+KBQ7nh0lVarZfHF2SmKbYgQcM1wu7g4DVQUzJ2wupi
9F+cYUT0zoNNT6nCDwJ9vBsd/eREKF18lqLDeYhVG0MOyRt+Alogc+oIrqGhvUdD
HGXFGvSHE/tpCHJOtq3JGxZTpjosKn5/w2x2Mg/lakN2eEWLu2pyyCEXaWcxzX+I
Qe5pbMy1Uml+3uKJQLkirhBviw3ZD/smEfr2IR/pjrPqrI5vu0UF5DI4m0hkQcFM
gP1zguXfp4lVW0ZVi0PD+cv6frK3DZ19mGTHpp/G0Zmf/MANzJ5KzMoVUk6Dtsaj
XdSV8hMYdJt6ZzpGZkjsbcvV7W9oZfV/UTyNekQ4ysgj0tQ7H3Q=
=q86H
-----END PGP SIGNATURE-----

--6uo77eyu4mijgow6--
