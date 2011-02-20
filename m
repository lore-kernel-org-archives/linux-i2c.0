From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Minor fixes to upgrading-clients document
Date: Sun, 20 Feb 2011 18:01:31 +0100
Message-ID: <20110220180131.6683e2d2@endymion.delvare>
References: <20110220150408.03e9a674@endymion.delvare>
	<20110220140837.GA14786@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110220140837.GA14786-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, 20 Feb 2011 15:08:38 +0100, Wolfram Sang wrote:
> On Sun, Feb 20, 2011 at 03:04:08PM +0100, Jean Delvare wrote:
> 
> > * Typical legacy drivers implemented method .detach_client, not
> >   .detach_adapter.
> > * Drop all references to __devexit, as i2c drivers shouldn't use it.
> 
> Even not in remove()? 40 out of 84 drivers are doing so.

Well, unless I am seriously mistaken, this isn't always safe.

Consider the case where !CONFIG_HOTPLUG and your i2c device driver is
built into the kernel (not as a module). The __devexit function will be
stripped at link time. If the i2c _bus_ driver is built as a module, it
can be inserted and removed at any time. When the bus driver is
removed, the .remove() method of every I2C device on this bus should be
called, except that your driver won't have any, so the clean-up won't
happen and you end up with a half-registered device.

So __devexit on the remove function on an i2c device driver is only
safe if the i2c bus driver is built into the kernel. Unfortunately,
unless !CONFIG_MODULES, the i2c device drivers have no way to tell if
this will be the case.

-- 
Jean Delvare
