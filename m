From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Registering I2C devices on X86
Date: Wed, 2 Jun 2010 13:04:08 +0200
Message-ID: <20100602130408.1e732a0a@hyperion.delvare>
References: <4C062E70.3090409@pelagicore.com>
	<20100602103650.GA4876@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100602103650.GA4876-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Richard =?UTF-8?B?UsO2amZvcnM=?= <richard.rojfors.lists-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2 Jun 2010 12:36:50 +0200, Wolfram Sang wrote:
> > Any ideas or suggestions?
> 
> Do it in userspace, or is this too late?

The user-space interface only works for simple cases: you can't pass
platform data or irq numbers. If someone needs to do this, we need an
extended interface, probably using configfs.

> Documentation/i2c/instantiating-devices lists all options you have.

Richard, look at drivers/i2c/busses/i2c-i801.c, function i801_probe():
you'll see an example of per-platform I2C device instantiation on x86.
I'm not claiming it is elegant, but it works.

-- 
Jean Delvare
