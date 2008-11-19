From: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Date: Wed, 19 Nov 2008 01:51:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
 <200811181401.34809.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200811181401.34809.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 18 Nov 2008, David Brownell wrote:
> ---
> drivers/i2c/busses/i2c-gpio.c |   10 ++
> drivers/i2c/i2c-core.c        |  155 ++++++++++++++++++++++++++++++++++++++++
> include/linux/i2c.h           |   14 +++
> 3 files changed, 179 insertions(+)

Can this be made optional?  Seeing as nothing uses it yet and it increases a
brunch of core structs' sizes.

> +	smbalert = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
> +			"smbalert#");

The handler for this irq uses the name "smbus_alert", maybe the resource and
the handler should use the same name?
