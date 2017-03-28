From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller
 for Aspeed
Date: Tue, 28 Mar 2017 20:12:55 +1100
Message-ID: <1490692375.3177.119.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-3-brendanhiggins@google.com>
         <49a13bbc-aec3-a349-4323-3c8d2728c62f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49a13bbc-aec3-a349-4323-3c8d2728c62f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-03-28 at 09:32 +0100, Marc Zyngier wrote:
> I'm a bit concerned by this. It means that you can't even mask an
> interrupt. Is that really what you intend to do? Or all that the HW can
> do? If you cannot mask an interrupt, you're at the mercy of a screaming
> device...

This is not really an interrupt controller. It's a "summary" register
that reflects the state of the 14 i2c controller interrupts.

This approach does have the advantage of providing separate counters in
/proc/interrupts which is rather nice, but it does have overhead. On
those shittly little ARMv9 400Mhz cores it can be significant.

I would personally have some kind of trick to register a single
interrupt handler that calls directly the handlers of the respective
i2c busses via a simple indirection for speed, maybe adding my custom
sysfs or debugfs statistics. But that's just me trying to suck the last
cycle out of the bloody thing ;-)

Cheers,
Ben.
