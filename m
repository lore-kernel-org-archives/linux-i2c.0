From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: use {readl|writel}_relaxed instead of readl/writel in
 i2c-designware-core ?
Date: Fri, 14 Feb 2014 19:14:47 +0800
Message-ID: <20140214191447.7b283568@xhacker>
References: <20140214155438.4f749a79@xhacker>
	<8705989.qzo882Ldx0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8705989.qzo882Ldx0@wuerfel>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Arnd,

On Fri, 14 Feb 2014 01:09:44 -0800
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> On Friday 14 February 2014 15:54:38 Jisheng Zhang wrote:
> > Hi all,
> > 
> > The writel/readl is too expensive especially on Cortex A9 w/ outer L2
> > cache. This introduce i2c read/write error on Marvell Berlin SoCs when
> > there are L2 cache maintenance operations at the same time.
> > 
> > In our internal berlin bsp, we just replaced readl/writel with the relaxed
> > version. But AFAIK, the "relaxed" version doesn't exist on all
> > architectures. How to handle this issue? 
> 
> In case of i2c-designware, this is safe because that driver does not perform
> DMA. In other drivers, you may have to be more careful, to ensure that all
> MMIO is serialized with DMA operations performed by the driver.
> 
> > Any suggestions are appreciated.
> 
> I would definitely welcome a patch that adds a default  _relaxed
> implementation to include/linux/io.h, like this:
> 
> #ifndef readb_relaxed
> #define readb_relaxed(p) readb(p)
> #endif
> 
> and then adds "#define readb_relaxed(p) readb_relaxed(p)" etc. to all
> architectures that have a non-macro definition for readb.

Thanks for the suggestions. I'll try to send out one RFC patch.

Thanks,
Jisheng
