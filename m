From: xudong chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
Date: Tue, 18 Nov 2014 18:07:01 +0800
Message-ID: <1416305221.4982.23.camel@mhfsdcap03>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
	 <20141113183122.GH1275@katana> <1415934752.2152.58.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415934752.2152.58.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Nathan Chung <nathan.chung-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YH Chen <yh.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-11-14 at 11:12 +0800, xudong chen wrote:
> On Thu, 2014-11-13 at 19:31 +0100, Wolfram Sang wrote:
> > > MTK I2C HW has some limitation.
> > > 1. If the i2c_msg number is more than one, STOP will be issued instead of
> > > RS(Repeat Start) between each message.
> > > 
> > > 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> > > mode the Repeat Start will be issued between 2 messages.
> > > In this driver if 2 messages is first write then read, the driver will
> > > combine 2 messages using Write-Read mode so the RS will be issued between
> > > the 2 messages.
> > > Ex: W/R/R, driver will combine first W/R and then R.
> > > 
> > > 3. Due to HW limitation, in this version the max transfer data length is 255
> > > in one message.
> > 
> > This looks to me more like an SMBUS controller instead of I2C. Maybe you
> > should populate smbus_xfer rather than master_xfer?
> 
> This is the HW limitation, we will try to workaround this in the
> separate patch.
> 
Except limited RS and limited length support, our HW follow I2C protocol
spec.
The length is compatible with most I2C devices, only a few I2C devices
need transfer more than 255 bytes.
The future Mediatek IC will fix the RS and length limitation.

Thanks!
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
