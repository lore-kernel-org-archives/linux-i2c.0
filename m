From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: rockchip: add dts file for RK3328 evaluation board
Date: Tue, 21 Mar 2017 09:57:44 +0100
Message-ID: <4463099.tv8gYSJGZa@diego>
References: <1489572237-6649-1-git-send-email-cl@rock-chips.com> <4559383.EsY2O1vJ7P@phil> <58D0DD76.8090909@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58D0DD76.8090909-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?6ZmI5Lqu?= <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org, tony.xie-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, paweljarosz3691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, yhx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.wu@rock-chips
List-Id: linux-i2c@vger.kernel.org

Hi,

Am Dienstag, 21. März 2017, 15:59:50 CET schrieb 陈亮:
> Hi Heiko：
> 
>          Is there any advice about the big dtsi?
>          I would like to send next version , thanks.

I did comment on your v2 dtsi though :-) .

Heiko

> 在 2017年03月17日 16:45, Heiko Stuebner 写道:
> > Am Freitag, 17. März 2017, 10:26:13 CET schrieb 陈亮:
> >> 在 2017年03月17日 00:18, Andre Przywara 写道:
> >>> Hi Chen,
> >>> 
> >>> On 16/03/17 01:45, cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org wrote:
> >>>> From: Chen Liang <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >>>> 
> >>>> This patch add rk3328-evb.dts for RK3328 evaluation board.
> >>>> Tested on RK3328 evb.
> >>>> 
> >>>> Signed-off-by: Chen Liang <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> >>>> ---
> >>>> 
> >>>>    arch/arm64/boot/dts/rockchip/Makefile       |  1 +
> >>>>    arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 57
> >>>>    +++++++++++++++++++++++++++++ 2 files changed, 58 insertions(+)
> >>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>> 
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> >>>> b/arch/arm64/boot/dts/rockchip/Makefile index 3a86289..853fc7d 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >>>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=
> >>>> rk3368-orion-r68-meta.dtb
> >>>> 
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-px5-evb.dtb
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-r88.dtb
> >>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-evb.dtb
> >>>> 
> >>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
> >>>> 
> >>>>    always		:= $(dtb-y)
> >>>>    subdir-y	:= $(dts-dirs)
> >>>> 
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>> b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts new file mode 100644
> >>>> index 0000000..cf27239
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
> >>>> @@ -0,0 +1,57 @@
> >>>> +/*
> >>>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd
> >>>> + *
> >>>> + * This file is dual-licensed: you can use it either under the terms
> >>>> + * of the GPL or the X11 license, at your option. Note that this dual
> >>>> + * licensing only applies to this file, and not this project as a
> >>>> + * whole.
> >>>> + *
> >>>> + *  a) This library is free software; you can redistribute it and/or
> >>>> + *     modify it under the terms of the GNU General Public License as
> >>>> + *     published by the Free Software Foundation; either version 2 of
> >>>> the
> >>>> + *     License, or (at your option) any later version.
> >>>> + *
> >>>> + *     This library is distributed in the hope that it will be useful,
> >>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>> + *     GNU General Public License for more details.
> >>>> + *
> >>>> + * Or, alternatively,
> >>>> + *
> >>>> + *  b) Permission is hereby granted, free of charge, to any person
> >>>> + *     obtaining a copy of this software and associated documentation
> >>>> + *     files (the "Software"), to deal in the Software without
> >>>> + *     restriction, including without limitation the rights to use,
> >>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>>> + *     sell copies of the Software, and to permit persons to whom the
> >>>> + *     Software is furnished to do so, subject to the following
> >>>> + *     conditions:
> >>>> + *
> >>>> + *     The above copyright notice and this permission notice shall be
> >>>> + *     included in all copies or substantial portions of the Software.
> >>>> + *
> >>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> >>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> >>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>>> + *     OTHER DEALINGS IN THE SOFTWARE.
> >>>> + */
> >>>> +
> >>>> +/dts-v1/;
> >>>> +#include "rk3328.dtsi"
> >>>> +
> >>>> +/ {
> >>>> +	model = "Rockchip RK3328 EVB";
> >>>> +	compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
> >>>> +
> >>>> +	chosen {
> >>>> +		stdout-path = "serial2:1500000n8";
> >>> 
> >>> Is that really 1.5MBit/s?
> >> 
> >> Yes, the RK3328 EVB board use 1.5MBit/s baud rate.
> >> 
> >>>> +	};
> >>>> +};
> >>>> +
> >>>> +&uart2 {
> >>>> +	status = "okay";
> >>>> +};
> >>> 
> >>> I don't have the board, but would expect to see more peripherals
> >>> mentioned in the .dtsi enabled here.
> >>> For sure the board has an (micro)SD card slot, possibly even Ethernet?
> >> 
> >> The codes for other peripherals are not ready now for new kernel, so i
> >> push a base dtsi, and other configration will be pushed later if it is
> >> ok.
> > 
> > for me that approach is fine in general, but here, you could enable at
> > least the watchdog as well?
> > 
> > But no need to resend just now, I still need to look at the big dtsi.
> > 
> > 
> > Heiko
