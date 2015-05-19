From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
Date: Tue, 19 May 2015 20:32:42 +0800
Message-ID: <20150519203242.74617ad6@xhacker>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
	<20150518082823.GH1490@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150518082823.GH1490-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Mika,

On Mon, 18 May 2015 11:28:23 +0300
Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Fri, May 15, 2015 at 08:31:39PM +0800, Jisheng Zhang wrote:
> > Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
> > runtime pm support using the same ops for system sleep and runtime pm.
> > When suspend to ram, the i2c host may have been runtime suspended, thus
> > i2c_dw_disable() hangs.
> 
> It hangs because it has already been powered off, right?

Either be powered off or clock gated or even both.

> 
> > This patch fixes this issue by separating ops for system sleep pm and
> > runtime pm, and in the system suspend/resume path, runtime pm apis are
> > used to ensure the device is at correct state.
> 
> I can see that this fixes the issue with the platform driver (as the
> platform bus core doesn't power on the device automatically as opposed
> to other buses, like PCI). However, I'm thinking that can we do better
> here.
> 
> Instead of powering the device on again, can't we leave it in low power
> state? Recently added 'dev->power.direct_complete' may be used to
> achieve that, I think.

how to handle runtime suspended via just being clock gated? Currently the
only solution is using the runtime pm apis to ensure the device is in a working
state during s2ram. What's your opinion?

Thanks,
Jisheng
