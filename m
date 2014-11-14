From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Fri, 14 Nov 2014 16:00:30 +0800
Message-ID: <1415952030.17958.129.camel@mtksdaap41>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
	 <20141113183122.GH1275@katana>  <1415934752.2152.58.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415934752.2152.58.camel@mhfsdcap03>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: xudong chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, flora.fu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-11-14 at 11:12 +0800, xudong chen wrote:
> On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > > MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> > > registers in MT8135 side.
> > 
> > I still didn't get this, even after reading the mail thread of old
> > series. Can someone maybe draw me a nice ASCII picture showing the setup
> > which is going on here?
> > 
> 
> 1. The DIR_PATH register is in MT8135.
> 2. All the registers used in the driver are in MT8135.
> 3. If want I2C wave go/from PMIC need to set the DIR_PATH register bit^0
> to 1 extra.

Hi,

Some supplemental, I hope this make it more clear.

    +---------------+
    |     MT8135    |
    |               |
    |    +----------|
    |    |I2C       |___SDA
    |    |controller|___SCL
    |    +----------|
    |               |      +-------+
    |    +----------|      | MT6397|
    |    |  pwrap   |      |       |___SDA_pmic
    |    |          |<---->|       |___SCL_pmic
    +---------------+      +-------+

This is the simplified block diagram of mt8135 and mt6397. MT8135 can
works with MTK PMIC MT6397. On MT8135, it use pwrap module to control
/communicate with the PMIC. Pwrap is a hardware communicate with pmic
through MTK proprietary interface.

There are several PMIC functionality that is controlled by registers
and controllers on MT8135, I2C is one of them.

On MT8135, I2C controller can control I2C pins on MT8135 and MT6397.
When you set I2C DIR_PATH register on MT8135, i2c controller will
control PMIC pins(through pwrap) to send i2c signal. Because the
i2c controllers are on 8135, it can still do DMA from system memory.
So it kinds of like these 2 works like a virtual SoC.

Joe.C
