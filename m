From: xudong chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Wed, 29 Oct 2014 14:26:20 +0800
Message-ID: <1414563980.24175.6.camel@mhfsdcap03>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414561058-23803-1-git-send-email-xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Sirs,

Missed the first paragraph, sorry for extra mail.

This series is the first version of Mediatek SoCs I2C controller common
bus driver, it is Request for Comment.
Because the clock driver for mediatek SoC is not ready yet(still work in
progress), so I delete the related clock code in dtsi file for now.

Best Regards,
	Xudong
 
On Wed, 2014-10-29 at 13:37 +0800, Xudong Chen wrote:
> This driver is based on 3.18-rc1 & Hongzhou's gpio patch.
> 
> MTK I2C HW has some limitation.
> 1. If the i2c_msg number is more than one, STOP will be issued instead of
> RS(Repeat Start) between each message.
> Such as: "START + ADDR + DATA_n + STOP + START + ADDR + DATA_n + STOP ..."
> 
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
> Ex: W/R/R, driver will combine first W/R and then R.
> The data series will be:
> "START + WriteADDR + DATA + RS + ReadADDR + DATA + STOP + START + ReadADDR +
> DATA + STOP".
> 
> 3. Due to HW limitation, in this version the max transfer data length is 255
> in one message. If want to transfer more than 255 bytes, HW needs the SW
> driver to split the data. Take 600 bytes for example, the data need to be
> divided into 3 parts 255 + 255 + 90. The data series will be:
> "START + ADDR + DATA_255 + RS + ADDR + DATA_255 + RS + ADDR +  DATA_90 + STOP"
> instead of "START + ADDR + DATA_900 + STOP".
> We haven't implement this yet, we will do this in the separate patch.
> 
> MT8135 can control I2C pins on PMIC(MT6397) by setting the i2c registers in
> MT8135 side. In this case, driver should set OFFSET_PATH_DIR bit first, the
> operation on other registers are still the same.
> 
> Xudong Chen (3):
>   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
>   ARM: mediatek: Add I2C node for mt8135 and mt8127
>   I2C: mediatek: Add driver for MediaTek I2C controller
> 
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  37 ++
>  arch/arm/boot/dts/mt8127.dtsi                      |  27 +
>  arch/arm/boot/dts/mt8135.dtsi                      |  51 ++
>  drivers/i2c/busses/Kconfig                         |   9 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c                    | 728 +++++++++++++++++++++
>  6 files changed, 853 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> 
> --
> 1.8.1.1.dirty
> 
