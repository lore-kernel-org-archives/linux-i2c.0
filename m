From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 2/7] arm/pxa2xx: reorganize I2C files
Date: Fri, 26 Nov 2010 15:11:49 +0100
Message-ID: <4CEFC025.2040804@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de> <1290633617-15311-3-git-send-email-bigeasy@linutronix.de> <20101125235520.GC15948@trinity.fluff.org> <20101126000341.GB9310@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101126000341.GB9310-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Russell King - ARM Linux wrote:
> On Thu, Nov 25, 2010 at 11:55:20PM +0000, Ben Dooks wrote:
>>> diff --git a/arch/arm/include/asm/pxa_i2c.h b/arch/arm/include/asm/pxa_i2c.h
>>> new file mode 100644
>>> index 0000000..f6da8a1
>>> --- /dev/null
>>> +++ b/arch/arm/include/asm/pxa_i2c.h
>> Anyone an opinion on whther to alter all arch-arm machine includes
>> or add a re-direct of plat/i2c.h to linux/i2c/pxa-i2c.h
> 
> We're not going to litter arch/arm/include/asm with SoC specific includes.
> If we start doing this, we'll end up with thousands of files in
> arch/arm/include/asm which have no real business being there.
> 
> So there's not much option but to NAK this patch before it gets out of
> hand.
> 
> The reason for this change seems to be because x86 has a different register
> layout, and x86 doesn't have the clk API. 

And I need to access structs / defines which are defined in arch/arm.

> For the former, that can be
> dealt with an ifdef along side the register definitions.
Sure. The register definition was moved outside the driver into
arch/../include/asm. So I keep them within the driver and ifdef it.

> For the latter, why not just implement a simple clk API implementation
> which always returns success, rather than requiring special headers
> for various ARM drivers?
This has been done. Patch 3/7 creates arch/x86/include/asm/pxa_i2c.h
which defines clk_get(). So it does not require special header files in 
regard to the clk api.

So I'm eliminating arch/./arm/inclide/asm/ files which I introduced.

Sebastian
