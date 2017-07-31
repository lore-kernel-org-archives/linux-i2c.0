From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Date: Mon, 31 Jul 2017 17:30:09 +0200
Message-ID: <20170731153009.xkjknygpmckv2pfp@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tmgaaihqw6wuchny"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49712 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752227AbdGaPaL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 31 Jul 2017 11:30:11 -0400
Content-Disposition: inline
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Florian Larysch <fl@n621.de>, David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>, Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, Masahiro


--tmgaaihqw6wuchny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Patches can be applied independently since the DTS changes without driver
> changes are no-op and the OF table won't be used without the DTS changes.

But there is a dependency, no? If I apply the driver patch,
non-converted device trees will not find their eeproms anymore. So, I
need to wait until all DTS patches are upstream, right? I can pick patch
1, though. We can already document it.


--tmgaaihqw6wuchny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/TQEACgkQFA3kzBSg
Kba4yg//e6f7nkiP0EUFnWwlCuI3vv/wOK8dnxuRAdk7CXiK5V+4M+FQD/vPm+/G
2tJtL+nrpJnBO1pm8bqFElzwnmFBUOFCqMBz0Zmk+q3iKGndilyu7BgNDcaL6W81
ILWxtkYEt+tI/lfwUsXfRtbAhJCVrZUDdvGSY3VCbEFmhiPNsIa8UttGG1jR6OWk
PWvMF6ec4Vrpl8WPwVglsH6VynHm2C9D3DoP2pRqngozLFN3Q8rD3WZSXXnYh5Mp
zCAkeroEEUhZVtrL1SAi1a5fwa+nRAJOHpA7vgNG7RAIRx1hIj0KIWl5BJZ2zfDN
8+ndLIWWn7OHT6glOSUz4otPnhHnwd9YsyvdLOzh6MysUwz+LwV9+e74iX1iFbpT
z/CX0hhTZyGnCh0zSp5FIEKnS3PUWwSAxFVAQ4SJtXyj32QVEtbKGocA1UJHMKl7
XovixRc9nJcbr9RgRnQWBZL1bZDcfPRmtOg+02wMRppwXjaKlafIVe60KRYhEr7B
tHKATSU7et2Qwzi+8jdQZfry4q+Yb3Ri7EAU8WwdkgTgw15i+Hg5UNOyQugJnxtF
rEBquXpHSh1rd1Z4vmFHmg5Rh8J8uptSwbEcyprLqEPT8irfcYwPkS7MmyN9vFlW
2p4Gty8FvoZH4w4drSWctN/hTBusdjQiSv9pXw7xt9Nr6rvYkW4=
=T9r7
-----END PGP SIGNATURE-----

--tmgaaihqw6wuchny--
