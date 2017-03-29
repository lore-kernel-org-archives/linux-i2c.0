From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for
 Aspeed
Date: Wed, 29 Mar 2017 11:55:17 +0100
Message-ID: <75ef2cc1-44d7-0137-96e5-77ba68ee071f@arm.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-3-brendanhiggins@google.com>
 <49a13bbc-aec3-a349-4323-3c8d2728c62f@arm.com>
 <1490692375.3177.119.camel@kernel.crashing.org>
 <91936f1a-0a0d-4091-b981-976503a6f7cd@arm.com>
 <1490734216.3177.140.camel@kernel.crashing.org>
 <CAFd5g46TAGHWtH7p1o=AJqy8_SygpJZ4RJkJpUwDD3nKxpB5YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFd5g46TAGHWtH7p1o=AJqy8_SygpJZ4RJkJpUwDD3nKxpB5YQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, Joel Stanley <joel@jms.id.au>, Vladimir Zapolskiy <vz@mleia.com>, Kachalov Anton <mouse@mayc.ru>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>
List-Id: linux-i2c@vger.kernel.org

On 29/03/17 10:59, Brendan Higgins wrote:
> The main reason I took this approach is just because I thought it was
> cleaner from the perspective of the busses which are totally
> independent (except for the fact that they share a single hardware
> interrupt).
> 
> I did not make any measurements, so I doubt that I have anything to
> add that you don't already know. I saw other usages of chained
> interrupts that do the same thing (scan a "status" register and use
> them to make software interrupts) and I thought that is basically what
> the dummy irq chip code is for. The only thing I thought I was doing
> that was novel was actually breaking out the dummy irqchip into its
> own driver; it is not my idea, but I do think makes it a lot cleaner.
> Nevertheless, it should be cheap in terms of number of instructions;
> the most expensive part looks like looking up the mapping. In any
> case, I think the low hanging fruit here is supporting buffering or
> DMA, like Ben suggested.
> 
> To address the comment on being over engineered: outside of the init
> function (which would exist regardless of how we do this, if not here
> then in the I2C driver); the code is actually pretty small and
> generic.
> 
> All that being said, it would not be very hard to do this without
> using the dummy irqchip code and it would definitely be smaller in
> terms of indirection and space used, but I think the code would
> actually be more complicated to read. We would be going back to having
> an I2C controller along with the I2C busses; where all the I2C
> controller does is read the IRQ register and then call the appropriate
> bus irq handler, which looks a lot like a dummy irqchip.

As long as you're happy with the performance and the restrictions that
come attached to the HW, I'm happy to take the irqchip patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
