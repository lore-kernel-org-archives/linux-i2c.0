From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Power up/down of an I2C client?
Date: Tue, 16 Nov 2010 12:51:03 +0000
Message-ID: <20101116125103.GI3338@sirena.org.uk>
References: <AANLkTinjBBxiq4K6wn8raOgooKtBhF3sW-k2FUSWNDzY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinjBBxiq4K6wn8raOgooKtBhF3sW-k2FUSWNDzY-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 15, 2010 at 08:44:10PM -0800, Bill Gatliff wrote:

> I have several boards that can control the power supply to their i2c
> chips, and I need to power down/up those chips when the boards go
> through suspend/resume.  The problem is, I'm using the same chip on
> all of the boards but the mechanism for controlling the power supply
> to each one is different on each board.

The current way of doing this is to abstract away via the regulator API,
though that doesn't cover reset GPIOs.

> Trouble is, I can't come up with an equivalent approach for i2c
> devices.  The i2c system uses both parents and buses itself, leaving
> me without a convenient hook for catching events.  Is there no way to
> "wrap" i2c devices the way you can for platform devices?

I'm working on an approach to this based on using notifiers.  Currently
we have notifiers from the driver model for driver probe, and we have
system-wide notifiers for PM events (but no per device stuff so runtime
PM can't be supported yet).  Not sure when I'll have something to show
but the idea is that you enable the device on BUS_NOTIFY_BIND_DRIVER,
disable it on BUS_NOTIFY_UNBOUND_DRIVER and do similar things on some
future notifiers for per-device suspend and resume.

This should work for all buses without any per-bus or per-device
modifications.
