From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] BCM59056 PMU regulator support
Date: Tue, 4 Feb 2014 13:40:43 +0000
Message-ID: <20140204134043.GG13529@lee--X1>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391516352-32359-1-git-send-email-mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> The BCM59056 is a multi-function power management unit used with the
> BCM281xx family of SoCs. This series adds an MFD and voltage regulato=
r
> driver to support the BCM59056. The bcm28155-ap DT support is updated
> to enable use of regulators on the otg and sdhci peripherals.
>=20
> Matt Porter (6):
>   i2c: bcm-kona: register with subsys_initcall
>   regulator: add bcm59056 pmu DT binding
>   mfd: add bcm59056 pmu driver
>   regulator: add bcm59056 regulator driver
>   ARM: configs: bcm_defconfig: enable bcm59056 regulator support
>   ARM: dts: add bcm59056 pmu support and enable for bcm28155-ap
>=20
>  .../devicetree/bindings/regulator/bcm59056.txt     |  37 ++
>  arch/arm/boot/dts/bcm28155-ap.dts                  |  41 ++
>  arch/arm/boot/dts/bcm59056.dtsi                    | 158 ++++++++
>  arch/arm/configs/bcm_defconfig                     |   7 +
>  drivers/i2c/busses/i2c-bcm-kona.c                  |  14 +-
>  drivers/mfd/Kconfig                                |   8 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/bcm59056.c                             | 119 ++++++
>  drivers/regulator/Kconfig                          |   8 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/bcm59056-regulator.c             | 445 +++++++++++=
++++++++++
>  include/linux/mfd/bcm59056.h                       |  35 ++
>  12 files changed, 873 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/bcm59=
056.txt
>  create mode 100644 arch/arm/boot/dts/bcm59056.dtsi
>  create mode 100644 drivers/mfd/bcm59056.c
>  create mode 100644 drivers/regulator/bcm59056-regulator.c
>  create mode 100644 include/linux/mfd/bcm59056.h

=46YI: Mark's email address is not correct. Not sure where you pulled
this one up from, but he doesn't have access to it anymore.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
