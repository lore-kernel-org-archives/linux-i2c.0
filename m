From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Wed, 15 Jun 2016 16:43:03 +0100
Message-ID: <20160615154303.GN4948@dell>
References: <20160613150800.6302-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160613150800.6302-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This requires a USB Ack.

> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> Add MFD core support.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---

Where is the change log from v1 =3D> v2?

> Changes from v2:
>  - Add missing dependency on USB, thanks kbuild test robot
>=20
>  drivers/mfd/Kconfig             |   9 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/mfd/ti-smusbdig.c
>  create mode 100644 include/linux/mfd/ti-smusbdig.h

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
