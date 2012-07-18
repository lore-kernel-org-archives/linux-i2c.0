From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: MXS i2c PIOQ/DMA mode selection via DT
Date: Wed, 18 Jul 2012 14:38:54 +0200
Message-ID: <201207181438.54721.marek.vasut@gmail.com>
References: <201207161605.44379.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201207161605.44379.marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Hello,
> 
> There's been this patch going on, which adds DMA mode into MXS i2c driver:
> https://patchwork.kernel.org/patch/1174051/
> 
> Recent nitpick was about toggling the PIOQUEUE (almost like PIO, only
> transfer mode in current implementation) vs. DMA mode (newly added) on a
> per-bus basis.
> 
> Current implementation in the patch adds a DT property, "fsl,use-pio"
> (shall be changed to "fsl,use-pioqueue", but that's irrelevant) to select
> between the PIOQUEUE and DMA mode on per-bus basis.
> 
> There was now a suggestion to dump this property and use kernel module
> parameter instead. This obviously disallows to configure this behavior on
> per-bus basis. Consider a scenario where small transfers happens on one
> bus (possibly from a sensor) and large transfers on the other bus (eg. i2c
> EEPROM). In such scenario, it's beneficial to enable PIOQUEUE mode for the
> sensor and DMA mode for the EEPROM to minimize the overall overhead.
> 
> The mixed mode (PIOQ for small data and DMA for large data transfers) isn't
> supported yet.
> 
> Please advise.
> 
> Best regards,
> Marek Vasut

BUMP?
