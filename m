From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: How to use kernel driver from API
Date: Tue, 23 Jun 2009 17:56:29 +0200
Message-ID: <20090623155629.GK29236@buzzloop.caiaq.de>
References: <B58E802D256349F0869077707DC18A22@ISKRAMEDICAL.SI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B58E802D256349F0869077707DC18A22-WSjMtQqgRZmL4CcANOAtMQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Klemen Omejc <klemen10-K/Me5RvSL+peoWH0uzbU5w@public.gmane.org>
Cc: linux-kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

(cc linux-i2c)

On Tue, Jun 23, 2009 at 08:51:16AM +0200, Klemen Omejc wrote:
> I using trizepsIV module with PXA27x and ConXs board, kernel 2.6.20.
> 
> I would like to have access to driver for RTC PCF8593 (PCF8583) on I2C bus
> from my FLTK application. What is the easy way to do that.

You need to have an i2c_board_info struct to instanciate the driver from
your board support code. Pass in the driver's names and the addresses,
then call i2c_register_board_info(). You can also have a look at how
others do that in arch/arm/mach-pxa/*.

However, I'm not quite sure whether that mechanism is also valid for
kernel 2.6.20. If it isn't, you should consider updating to something
more recent.

> Probably than I could also connect to EEPROM and temperature sensors on
> the same way.

Yes, that works for all devices connected to I2C.

Daniel
