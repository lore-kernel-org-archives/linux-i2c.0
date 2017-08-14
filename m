From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix oops from i2c_dw_irq_handler_slave
Date: Mon, 14 Aug 2017 21:12:52 +0200
Message-ID: <20170814191252.eoejgycv7t6ezqku@ninjato>
References: <20170811114455.26950-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k6t36pbahlw45frd"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50471 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbdHNTMy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 15:12:54 -0400
Content-Disposition: inline
In-Reply-To: <20170811114455.26950-1-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Luis Oliveira <Luis.Oliveira@synopsys.com>


--k6t36pbahlw45frd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 02:44:55PM +0300, Jarkko Nikula wrote:
> When i2c-designware is initialized in slave mode the
> i2c-designware-slave.c: i2c_dw_irq_handler_slave() can hit a NULL
> pointer dereference when I2C slave backend is not registered but code is
> accessing the struct dw_i2c_dev.slave without testing is it NULL.
>=20
> We might get spurious interrupts from other devices or from IRQ core
> during unloading the driver when CONFIG_DEBUG_SHIRQ is set. Existing
> check for enable and IRQ status is not enough since device can be power
> gated and those bits may read 1.
>=20
> Fix this by handling the interrupt only when also struct dw_i2c_dev.slave
> is set.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Applied to for-current, thanks!


--k6t36pbahlw45frd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmR9jQACgkQFA3kzBSg
KbZwkg/5AVUthkhIZnX+HMrmw/7b7h7294+dyvq33pSODmQAzT7Br1M/3R5JVK61
jTjk+//G+2m5t30EVg1yH6WIUv6rPBA5LTmp1UclI/s52TQVRykBXuKLRh3CUcfR
n2mUc5p6TJ7/WsNzlfUhqhTeUNsPi6XnlT3uCg5WpgU9Tpaj/jNGVVj/P7cfYsIW
zAA1O/Uj4Ns1EYfX0Tc5xYpgEq94aTC1OER6It0yLXKuydawR18bZOVTTrb1gBtF
AfzRdD1MEqEfl845zPeofF+K3JOPY3+pcZ25bDw3HFSGQkigKYWhOE+hLu21C3rm
hMiOnnDskYHmABjwp6tCR15ERzUMNDsOu8SQdsRtfBoO46yYRg0cIXZt7Na5HyGh
FBq8RueltnOzfy9H5FPAVmZWq0qKs5ePJpFpdfKXv0L89CYJCo3Rmt94UQRadNuy
b8DuxM2YaQcllb01CDxvLkCCFCgtSmG4DU1eWZMGN+XR8vGdfofRmnsNAZtbDwEC
FSymQfOO91XXk5DhJjm4wq25IASmZ9xBBnMdFexs3CM7m2vYs7tqzwL2C+gGeKgt
AXCwQLBTZo9DbaoADuVfnFvlGn0qTTPDr/q/tgBArTR5CrQ5UbY+JbdzmqE/zIBX
72rT2wm3CWoXm9AZdH0CtmNOqQKwQa+iGKp5HrFqlCc57Mr6Eos=
=VTSX
-----END PGP SIGNATURE-----

--k6t36pbahlw45frd--
