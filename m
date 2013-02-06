From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH RFC] misc/at24: distinguish between eeprom and fram chips
Date: Wed, 6 Feb 2013 19:19:18 +0100
Message-ID: <201302061919.18501.poeschel@lemonage.de>
References: <201212041758.38600.poeschel@lemonage.de> <201212051043.07460.poeschel@lemonage.de> <20121205164153.GA5011@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121205164153.GA5011-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 05 December 2012 at 17:41:53, Wolfram Sang wrote:

> > > The method of accessing EEPROMs is used by way more chips than FRAMs.
> > > So, I'd prefer to have the text updated more generic like "EEPROMs and
> > > similar devices like RAMs, ROMs, etc...". Describing setting .flags in
> > > Kconfig is overkill.
> > 
> > A patch updating Kconfig is below.
> 
> Looks good from a glimpse, will apply it later.

Hello Wolfram,

what happend to this one ? It was a patch updating Kconfig help for at24.

https://patchwork.kernel.org/patch/1840591/

Regards,
Lars
