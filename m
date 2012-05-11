From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH Rebase 1/1] dma: imx-sdma: make channel0
 operations atomic
Date: Fri, 11 May 2012 14:03:57 +0530
Message-ID: <1336725237.15424.1840.camel@vkoul-udesk3>
References: <1336717928.15424.1597.camel@vkoul-udesk3>
	 <1336720467-29770-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336720467-29770-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2012-05-11 at 15:14 +0800, Richard Zhao wrote:
> device_prep_dma_cyclic may be call in audio trigger function which is
> atomic context, so we make it atomic too.
> 
>  - change channel0 lock to spinlock.
>  - Use polling to wait for channel0 finish running.
> 
> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Thanks, Applied to slave-dma -next.

-- 
~Vinod
