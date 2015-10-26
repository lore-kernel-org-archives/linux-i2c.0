From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PULL REQUEST] i2c for mfd for 4.4
Date: Mon, 26 Oct 2015 14:45:17 +0000
Message-ID: <20151026144517.GM597@x1>
References: <20151026143802.GA6946@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151026143802.GA6946@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> these are the MFD patches I picked up via I2C. Tagged as
> quark-for-mfd-151026.

Perfect.  Pulled, thanks.

> The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c=
698b46:
>=20
>   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/qua=
rk-for-mfd
>=20
> for you to fetch changes up to 40d8edc9bf056ea83e50152a4ccd33048d26cc=
de:
>=20
>   at24: enable ACPI device found on Galileo Gen2 (2015-10-26 15:25:56=
 +0100)
>=20
> ----------------------------------------------------------------
> Andy Shevchenko (4):
>       mfd: core: redo ACPI matching of the children devices
>       mfd: intel_quark_i2c_gpio: load gpio driver first
>       mfd: intel_quark_i2c_gpio: support devices behind i2c bus
>       at24: enable ACPI device found on Galileo Gen2
>=20
>  Documentation/acpi/enumeration.txt | 11 +++++---
>  drivers/mfd/intel_quark_i2c_gpio.c | 33 ++++++++++++++++--------
>  drivers/mfd/mfd-core.c             | 52 ++++++++++++++++++++++++++--=
----------
>  drivers/misc/eeprom/at24.c         | 22 +++++++++++++---
>  include/linux/mfd/core.h           | 10 ++++++--
>  5 files changed, 94 insertions(+), 34 deletions(-)



--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
