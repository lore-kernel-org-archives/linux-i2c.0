From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/4 V5] add 88pm80x mfd driver
Date: Mon, 9 Jul 2012 15:21:23 +0200
Message-ID: <20120709132123.GQ15345@sortiz-mobl>
References: <1341815855-13522-1-git-send-email-zhouqiao@marvell.com>
 <20120709105551.GK15345@sortiz-mobl>
 <20120709105533.GA3934@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120709105533.GA3934-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>
Cc: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, yu.tang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, wilbur.wang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

On Mon, Jul 09, 2012 at 11:55:33AM +0100, Mark Brown wrote:
> On Mon, Jul 09, 2012 at 12:55:51PM +0200, Samuel Ortiz wrote:
> 
> > I applied the first 2 patches, I'd like to get an ACK from the respective
> > maintainers for the rtc and the input ones. They can even take it as both
> > drivers are protected by the MFD symbol.
> 
> Alessandro's been mostly offline recently so it might be as well to
> apply the RTC patch anyway.
Fair enough, applied now. Neither Alessandro nor the rtc ml wer not cc'ed on this
thread, but that's another problem.
Zhou, could you please send at least the rtc patch to Alessandro so that he
could have a look at it if time permits ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
