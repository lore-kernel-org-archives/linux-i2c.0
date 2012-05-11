From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V2 01/11] dma: imx-sdma: make channel0 operations atomic
Date: Fri, 11 May 2012 08:22:56 +0530
Message-ID: <1336704776.15424.1354.camel@vkoul-udesk3>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
	 <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
	 <1336622038.1540.285.camel@vkoul-udesk3>
	 <20120510063446.GA17875@S2101-09.ap.freescale.net>
	 <20120510123749.GO17875@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120510123749.GO17875-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2012-05-10 at 20:37 +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 02:34:49PM +0800, Shawn Guo wrote:
> > On Thu, May 10, 2012 at 09:23:58AM +0530, Vinod Koul wrote:
> > > On Wed, 2012-05-09 at 19:33 +0800, Richard Zhao wrote:
> > > > device_prep_dma_cyclic may be call in audio trigger function which is
> > > > atomic context, so we make it atomic too.
> > > > 
> > > >  - change channel0 lock to spinlock.
> > > >  - Use polling to wait for channel0 finish running.
> > > > 
> > > > Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > > Acked By: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > 
> > Applied on imx/dt branch with Vinod's ack.  Thanks.
> > 
> Hi Vinod,
> 
> Since Mark wouldn't like to have sound tree pulled into arm-soc to help
> a couple of patches in the series get merged in the coming window, I can
> not take the series as a whole to go with arm-soc.  It makes less sense
> to have this patch go arm-soc then, so please take the patch.
Sure, care to give an ACK before I apply.

-- 
~Vinod
