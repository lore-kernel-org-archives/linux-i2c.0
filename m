From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PMBus support in Linux
Date: Sat, 29 May 2010 12:03:27 +0200
Message-ID: <20100529120327.43e4f856@hyperion.delvare>
References: <1275063391.2631.137.camel@groeck-laptop>
	<20100529023401.GB12507@pengutronix.de>
	<20100529093929.38e03e06@hyperion.delvare>
	<20100529081633.GA7428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100529081633.GA7428-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 29 May 2010 10:16:33 +0200, Wolfram Sang wrote:
> 
> > There is an i2c-tools package for user-space utilities, I see no point
> > to add such code to the kernel tree.
> 
> Obviously correct. Are there any problems picking up GPL3 code?

No problem, we already have a mix of licenses in this package, and I
don't mind adding one more.

-- 
Jean Delvare
