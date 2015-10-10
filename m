From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 6/6] i2c: designware: Move common probe code into
 i2c_dw_probe()
Date: Sat, 10 Oct 2015 08:57:26 +0100
Message-ID: <20151010075725.GF1619@katana>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1441031493-18938-7-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57346 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbJJH5i (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 10 Oct 2015 03:57:38 -0400
Content-Disposition: inline
In-Reply-To: <1441031493-18938-7-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> - I2C Adapter name will be "i2c-designware". Previously adapter name was
>   "Synopsys DesignWare I2C adapter" for platform and ACPI devices and
>   "i2c-designware-pci" for PCI devices.

I have a small tendency to make it "Synopsys DesignWare I2C adapter" for
all cases. Not much, though.

> - Interrupt name too will be "i2c-designware". Previous it was platform
>   device name, ACPI device name or "i2c-designware-pci".

The device name makes them easier to distinguish in case you have
multiple instantiations.

Rest of the series looks good to me, thanks!


--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGMTlAAoJEBQN5MwUoCm2yj0P/Rw7x61ZhRG9oD5AaZ/liFR3
7w4gUinqHs1sb7Cx3PpxFSMRCGTZ8WL10n4b4AxWGpDJucv2sME2n3UGMk6kH45g
eD8UFmWSnFgJf8baQpidOECLDlksx0u4cIyrXXl9hG+ki8TY9OTXAKT2Qmcbxi9e
VI0DewjNQM6AZ5W32n+NdgVTrk5ghPLkQ3GAco3ZfRPp4J3QrczjzUyi2OEc2Qop
DJM+Q29GKlDKxUVAYQKKfJty5OV9YkLRZGrxAdwhmzFAjBY76VP3GxGtdZi/lS1C
aRZew37ftIcBgMwP3xe0DnFo8tCrUuHtRrqwscTZHbBKeGQOW6VxTV0XUMZjtcZF
Tty3RVg4r8qSSYefIavl3MX6nQITRxXcO+Bv8PL4HjOFViQmdmj5h3Tq76xKcmjc
DG9yVilsyUz6CxQRONOKuXAs2Atk6xh5PXW+5D9HW5StlBLzaQ4J9N3t6wm8a5bg
JNKoFC1y9DzQgbJvUwQ9egNjTEI6UM0Bp+SSLCxyz5hMR+4Pxg8BZBfB2OBnHJwT
5yXUm20HcRBxePBfkZZa2TyK7OELikM/v3H4/lJx2xkde0yhU1T/8iXYrtWRO2IJ
s+liJJSnBlNRP1GQa5jmmAJgyE67zYkTq/T4HXUIKQVw7+j6QEgmGhyrwugHzHWo
MYAIhT43coz+ePm7jg8+
=yjTE
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
