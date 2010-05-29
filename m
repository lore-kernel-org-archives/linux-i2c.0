From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PMBus support in Linux
Date: Sat, 29 May 2010 09:39:29 +0200
Message-ID: <20100529093929.38e03e06@hyperion.delvare>
References: <1275063391.2631.137.camel@groeck-laptop>
	<20100529023401.GB12507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100529023401.GB12507-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 29 May 2010 04:34:01 +0200, Wolfram Sang wrote:
> 
> CCing lm-sensors and David...
> 
> On Fri, May 28, 2010 at 09:16:31AM -0700, Guenter Roeck wrote:
> 
> > does anyone know if there is an effort to add infrastructure for PMBus
> > support (or support for specific PMBus devices) to Linux ?
> 
> I found this:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022969.html
> 
> Hmm, sitting ontop of SMBus, it makes perfect sense to use i2c-dev (David knows
> what he is doing, of course ;)). But having no repo and all, it is hard to
> maintain this utility. Is there any chance to pick it up in the kernel-tree?
> tools/i2c/ or such? Hmm, it's GPL v3...

There is an i2c-tools package for user-space utilities, I see no point
to add such code to the kernel tree.

-- 
Jean Delvare
