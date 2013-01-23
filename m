From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: imx51-babbage: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 08:55:25 +0100
Message-ID: <20130123075525.GV1906@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <1358922764-31654-2-git-send-email-Ying.Liu@freescale.com>
 <20130123073059.GP1906@pengutronix.de>
 <CA+8Hj80ceGEUtzfvvEuH7ZftWGydzd9pHK_FxfE59WBxOst4rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+8Hj80ceGEUtzfvvEuH7ZftWGydzd9pHK_FxfE59WBxOst4rQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liu Ying <liu.y.victor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 23, 2013 at 03:51:12PM +0800, Liu Ying wrote:
> 2013/1/23 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> > On Wed, Jan 23, 2013 at 02:32:44PM +0800, Liu Ying wrote:
> >> This patch adds at24c512b i2c device to the device tree
> >> along with the necessary i2c device node and pinctrl
> >> settings for i2c bus.
> >> The eeprom chip is populated on the accessory board of
> >> the imx51-babbage board.
> >
> > Given that it's optional should the binding be here anyway? I don't have
> > this accessory board and this may conflict with the boards other people
> > have connected on this port.
> >
> > Sascha
> 
> Understand your concern. Is there any way to handle this? How can we support
> the present accessory board correctly? More generally, not all main boards can
> figure out what kind of accessory board is attached to them, at least, some main
> boards can only figure out limited number of accessory boards by using some ways
> of board ID check.

We don't have support for such things atm. We'll have to wait for

OF: Introduce DT overlay support.

Pantelis Antoniou is working on this currently.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
