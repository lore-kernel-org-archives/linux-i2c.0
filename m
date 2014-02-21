From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: I2C dummy adapter driver ?
Date: Fri, 21 Feb 2014 12:26:43 +0100
Message-ID: <530737F3.5050102@samsung.com>
References: <5305382E.9050902@gmail.com> <5306322C.8030703@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <5306322C.8030703-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 20/02/14 17:49, Stephen Warren wrote:
> On 02/19/2014 04:03 PM, Sylwester Nawrocki wrote:
[...]
>> I was wondering whether it would be reasonable to create a generic
>> Linux dummy I2C bus controller driver. The rationale behind it is
>> there might be hardware configurations where I2C communication is
>> handled by firmware but still it is useful to have I2C slave devices
>              ^^^^^^^^
> 
> That doesn't sound like a dummy driver. Rather, it sounds like a driver
> for the firmware(?) interface that's used to do the I2C transactions.

Hmm, I think you're right. Just to clarify a bit, as the I2C slave device
is part of a more complex data processing chain, it is not exposed by
the firmware on a I2C read/write like command interface.
So the only thing the Linux I2C client does currently is to enable some
voltage regulators and driver reset pin through a GPIO. 

However it depends on the firmware for the MCU controlling the whole
camera data processing chain, currently the I2C slave control transactions
are being handled in an opaque way by the firmware, it just exposes (very 
few) high level commands specifically related to the I2C slave.
It could be also that the firmware leaves out the I2C bus controller and
I2C slave handling solely to the host CPU. In such case a regular I2C
bus controller driver is needed. Hence the exact role of the I2C bus 
controller driver highly depends on the firmware loaded.

I assume the "driver for the firmware interface" is a good definition.
I'm just not sure what best location of such an I2C bus driver, supposedly
drivers/media/i2c would be a good fit, rather than drivers/i2c/busses.
