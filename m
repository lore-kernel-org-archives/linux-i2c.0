From: Mark Brown <broonie@kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Date: Wed, 18 Sep 2019 18:09:52 +0100
Message-ID: <20190918170952.GT2596@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the driver-core tree, today's linux-next build
for arm64 allmodconfig failed like this:

/home/broonie/next/next/drivers/i2c/i2c-core-acpi.c: In function 'i2c_acpi_find_adapter_by_handle':
/home/broonie/next/next/drivers/i2c/i2c-core-acpi.c:352:10: error: 'i2c_acpi_find_match_adapter' undeclared (first use in this function); did you mean 'i2c_acpi_find_bus_speed'?
          i2c_acpi_find_match_adapter);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
          i2c_acpi_find_bus_speed
/home/broonie/next/next/drivers/i2c/i2c-core-acpi.c:352:10: note: each undeclared identifier is reported only once for each function it appears in

Caused by commit

  644bf600889554210 ("i2c: Revert incorrect conversion to use generic helper")

In yesterday's -next that function existed but it appears to have been
removed in Linus' tree as part of the merge:

  4feaab05dc1eda3 ("Merge tag 'leds-for-5.4-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds")

by the commit

  00500147cbd3fc5 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")

(ie, the commit that the failing commit was trying to revert.)  I
suspect this is confusion caused by things going into Linus' tree in
different orders.  I've fixed this up by re-adding the function.

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2CZN8ACgkQJNaLcl1U
h9CK5wf+LSPVgpYCM6eyOPVq2Ck7uZKNd6iI6NX4ELVYJ0TUIsXqhASEQAhKxBqx
aLnwiJOciQQT3G+N81Gv5BbAP3ip4coXMHIp+rL4HN89L6nRzh8s2sUSfxfoG62Y
VAO/TxeyqCujNstzf/TcmkL6ahDoh6nByPoD9hfXlja5feNGUhkPoARpINCRk6bC
tTtFRExjCemrIzMucLbaawpnb0RWUPUSVJaLN0YKhbHflzzrBYLTVorbfkG9hjOF
KYg35WZIJmOEqThrybghmAJ8/e2WkuFFxNpPH4XfQMXS08WJ5Nt0SWrRDdkDBrCQ
/KAGhmjhotCLL/TUTPfJ5erbmYLf3A==
=V/kw
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--
