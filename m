From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 13/24] mfd: fix dangling pointers
Date: Sat, 20 Mar 2010 21:25:01 +0100
Message-ID: <20100320212501.138b1644@hyperion.delvare>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
	<1269094385-16114-14-git-send-email-w.sang@pengutronix.de>
	<20100320172241.GD1549@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100320172241.GD1549-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 20 Mar 2010 17:22:41 +0000, Mark Brown wrote:
> On Sat, Mar 20, 2010 at 03:12:54PM +0100, Wolfram Sang wrote:
> > Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> > structure it points to. Also fix drivers which do this _after_ the structure
> > was freed already.
> 
> Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> 
> but it really does seem like this is something that the I2C core ought
> to handle - the assignment to null is boiler plate code that's getting
> added to the overwhelming majority of I2C devices in their teardown
> path, it'd seem a lot more sensible for the core to just trash driver
> data after the driver is unbound if it's important that this happens.

This is an interesting point. Do you know of any other subsystem doing
this? The core touching private data seems wrong to me, but I have to
agree that it would avoid a lot of duplication across drivers.

Can someone find a reasonable use case for client data surviving the
driver's .remove() call?

-- 
Jean Delvare
