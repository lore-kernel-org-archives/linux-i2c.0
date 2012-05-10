From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
Date: Thu, 10 May 2012 19:49:58 +0800
Message-ID: <20120510114956.GI17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
 <20120510093444.GI2982@b20223-02.ap.freescale.net>
 <20120510094113.GG17875@S2101-09.ap.freescale.net>
 <20120510094508.GN3908@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120510094508.GN3908-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, May 10, 2012 at 10:45:08AM +0100, Mark Brown wrote:
> On Thu, May 10, 2012 at 05:41:15PM +0800, Shawn Guo wrote:
> 
> > The "Mic Bias" here is really a SGTL5000 internal supply.
> 
> If it is then what's providing the bias to the mic?  It's common for
> chips to have a micbias supply which comes out of the chip and is used
> by mics, this is my understanding of what this circuit is.

I did not make myself clear, but you made :)  Yes, this is exactly the
thing on my mind, and the circuit will look like:

     STGTL5000        BOARD
		|
      MIC_IN ---+--- JACK
	^	|     ^
	|	|     |
	|	|     |
    MIC_BAIS----+-----/
		|

Isn't you helped me create this understanding? [1]

Regards,
Shawn

[1] http://article.gmane.org/gmane.linux.alsa.devel/96351
