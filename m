From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Fix bogus sda_hold_time due to
 uninitialized vars
Date: Mon, 22 May 2017 10:36:21 +0200
Message-ID: <20170522083621.upovyjqo56ywqdrl@ninjato>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
 <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wnugnsi7xjbpmcgy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57215 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbdEVIgX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 22 May 2017 04:36:23 -0400
Content-Disposition: inline
In-Reply-To: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--wnugnsi7xjbpmcgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 07:46:55AM +0200, Jan Kiszka wrote:
> We need to initializes those variables to 0 for platforms that do not
> provide ACPI parameters. Otherwise, we set sda_hold_time to random
> values, breaking e.g. Galileo and IOT2000 boards.
>=20
> Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by A=
CPI from clock rate")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Applied to for-current, thanks!


--wnugnsi7xjbpmcgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkiowUACgkQFA3kzBSg
KbZ8GQ/7BWw7Brn8F/rLTaqj/n/lwh0nsg10n7u73/BMg3jtY9g9w74fu7goW73y
/sun+tD7FEtNT/qha5vQnTny2uHt6DcMRrVXY3dykvqnOtLgzcN5YxtvlQjYR7di
Ya5HpYreNnxInR+kmQg1C1+3tuFWVH+k5QUueFQvGOdKYWRLngiqtcS8Hsk+JRrl
l5pmF3aGsJkaywY0UdQECc5rYUakl+eQBhUK1lumUZEZ5AriDnWfZjuE9SxwZEEs
DqnOJYqpouLe/hu4D2yOnITCDqwjmiUKqihoNz8P8iF/rWQfgn2Frgi/537uS/y1
mFlxfwUxGb7BAheFjj9hfHdjxtvWkgAxFVKVNNWULfhYfTKuohNIU7JMMEnf2ucf
2SGJ2HYXoOsTTm1V/YG0mL33d6BL8KksT5Pb3ADbFnSsXQk0O29Vym4Sxxa3EIM+
P18KNaFV9Iocpi9MLIsq4Q+hrXlHJytvSoEGl1fwFudwlkN1rX9kZ859uYQH1C+8
Ieu4JLfF+Ot5gHuEQMHtwsPB0WA5OD1ApC/axu1RcI5fVI5pNOrXyVkJDIpYp3+N
wfvI9GlyXZp/Jr2GfwwdBfdLRO1Lm3DIlUfBmfzUXuqZRcNjefR7SD2/fsxA544x
NWB3o+JGQpZpNzKLmW9f6EHPW3XlW+bnVr8XM6OHaMv6vMg9s4g=
=nX9B
-----END PGP SIGNATURE-----

--wnugnsi7xjbpmcgy--
