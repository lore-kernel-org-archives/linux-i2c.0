From: xudong chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Fri, 14 Nov 2014 11:12:32 +0800
Message-ID: <1415934752.2152.58.camel@mhfsdcap03>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
	 <20141113183122.GH1275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113183122.GH1275@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > MTK I2C HW has some limitation.
> > 1. If the i2c_msg number is more than one, STOP will be issued instead of
> > RS(Repeat Start) between each message.
> > 
> > 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> > mode the Repeat Start will be issued between 2 messages.
> > In this driver if 2 messages is first write then read, the driver will
> > combine 2 messages using Write-Read mode so the RS will be issued between
> > the 2 messages.
> > Ex: W/R/R, driver will combine first W/R and then R.
> > 
> > 3. Due to HW limitation, in this version the max transfer data length is 255
> > in one message.
> 
> This looks to me more like an SMBUS controller instead of I2C. Maybe you
> should populate smbus_xfer rather than master_xfer?

This is the HW limitation, we will try to workaround this in the
separate patch.

> 
> > MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> > registers in MT8135 side.
> 
> I still didn't get this, even after reading the mail thread of old
> series. Can someone maybe draw me a nice ASCII picture showing the setup
> which is going on here?
> 

1. The DIR_PATH register is in MT8135.
2. All the registers used in the driver are in MT8135.
3. If want I2C wave go/from PMIC need to set the DIR_PATH register bit^0
to 1 extra.

>From the picture:
If MT8135 connected to PMIC(MT6397), when set the DIR_PATH register
bit^0 to 1, the HW will transfer the i2c wave from pins(SDA4_pmic &
SCL4_pmic) on MT6397 side.
If want use pins(SDA4 & SCL4) on 8135 side directly, we should set the
DIR_PATH register bit^0 to 0.

_______       ________
|      |______|       |
|      |      |  PMIC |
| 8135 |______| (6397)|___SDA4_pmic
|      |      |       |___SCL4_pmic
!______!      !_______!
  |   |
SDA4 SCL4


Thanks!







--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
