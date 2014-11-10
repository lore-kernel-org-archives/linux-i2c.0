From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, GPIO and I2C
Date: Mon, 10 Nov 2014 16:04:26 +0000
Message-ID: <20141110160426.GK24004@x1>
References: <1415281685-14866-1-git-send-email-octavian.purdila@intel.com>
 <20141110151226.GD24004@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141110151226.GD24004@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org, gnurou@gmail.com, wsa@the-dreams.de, sameo@linux.intel.com, arnd@arndb.de, johan@kernel.org, daniel.baluta@intel.com, laurentiu.palcu@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Please don't pull this -- it is missing a patch.

Will fix.

> [Subject change -- in case you miss it]
>=20
> Linus, Wolfram,
>=20
> Enjoy!
>=20
> The following changes since commit f114040e3ea6e07372334ade75d1ee0775=
c355e1:
>=20
>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-m=
fd-gpio-i2c-v3.19
>=20
> for you to fetch changes up to e7d146b11a8a33b6033220b0f4fc4de2ab2921=
8a:
>=20
>   gpio: add support for the Diolan DLN-2 USB GPIO driver (2014-11-10 =
15:05:49 +0000)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD, GPIO and I2C
>=20
> ----------------------------------------------------------------
> Daniel Baluta (1):
>       gpio: add support for the Diolan DLN-2 USB GPIO driver
>=20
> Laurentiu Palcu (1):
>       i2c: add support for Diolan DLN-2 USB-I2C adapter
>=20
> Octavian Purdila (1):
>       mfd: Add support for Diolan DLN-2 devices
>=20
>  drivers/gpio/Kconfig          |  12 +
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-dln2.c      | 553 ++++++++++++++++++++++++++++++
>  drivers/i2c/busses/Kconfig    |  10 +
>  drivers/i2c/busses/Makefile   |   1 +
>  drivers/i2c/busses/i2c-dln2.c | 267 +++++++++++++++
>  drivers/mfd/Kconfig           |  10 +
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/dln2.c            | 763 ++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/dln2.h      | 103 ++++++
>  10 files changed, 1721 insertions(+)
>  create mode 100644 drivers/gpio/gpio-dln2.c
>  create mode 100644 drivers/i2c/busses/i2c-dln2.c
>  create mode 100644 drivers/mfd/dln2.c
>  create mode 100644 include/linux/mfd/dln2.h
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
