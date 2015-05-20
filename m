From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
Date: Wed, 20 May 2015 20:05:40 +0800
Message-ID: <20150520200540.58b1230b@xhacker>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
	<20150518082823.GH1490@lahna.fi.intel.com>
	<20150519203242.74617ad6@xhacker>
	<20150519131516.GO1490@lahna.fi.intel.com>
	<20150520193422.73de7d90@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150520193422.73de7d90@xhacker>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Mika,

On Wed, 20 May 2015 19:34:22 +0800
Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:

> Dear Mika,
> 
> On Tue, 19 May 2015 16:15:16 +0300
> Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> 
> > On Tue, May 19, 2015 at 08:32:42PM +0800, Jisheng Zhang wrote:
> > > > I can see that this fixes the issue with the platform driver (as the
> > > > platform bus core doesn't power on the device automatically as opposed
> > > > to other buses, like PCI). However, I'm thinking that can we do better
> > > > here.
> > > > 
> > > > Instead of powering the device on again, can't we leave it in low power
> > > > state? Recently added 'dev->power.direct_complete' may be used to
> > > > achieve that, I think.
> > > 
> > > how to handle runtime suspended via just being clock gated?
> > 
> > As far as I can tell driver's suspend hook does the clock gating so why
> > would you need to handle it differently? Once the device is runtime
> > suspended, it is both clock and power gated depending on the platform.
> 
> Sorry for confusion. Considering one platform which doesn't support power off
> the i2c host but it can disable the host's clock. So in such platform, when
> the host is runtime suspended, its clock is disabled, then i2c_dw_disable() will
> hang when s2ram. Except using the runtime pm API to ensure the host is in
> a correct state, is there any other solution? AFAIK, 'dev->power.direct_complete'
> doesn't help such case.

I misunderstood the direct_complete flag usage. I think it can help such case
will investigate and provide new patch if necessary.

Thanks a lot
