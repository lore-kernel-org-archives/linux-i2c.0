From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: separate ops for system_sleep_pm and
 runtime_pm
Date: Wed, 20 May 2015 15:15:06 +0300
Message-ID: <20150520121506.GU1490@lahna.fi.intel.com>
References: <1431693099-2292-1-git-send-email-jszhang@marvell.com>
 <20150518082823.GH1490@lahna.fi.intel.com>
 <20150519203242.74617ad6@xhacker>
 <20150519131516.GO1490@lahna.fi.intel.com>
 <20150520193422.73de7d90@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150520193422.73de7d90@xhacker>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 07:34:22PM +0800, Jisheng Zhang wrote:
> Sorry for confusion. Considering one platform which doesn't support power off
> the i2c host but it can disable the host's clock. So in such platform, when
> the host is runtime suspended, its clock is disabled, then i2c_dw_disable() will
> hang when s2ram.

Right. This happens also when the platform powers off the device.

> Except using the runtime pm API to ensure the host is in
> a correct state, is there any other solution? AFAIK, 'dev->power.direct_complete'
> doesn't help such case.

What I had in mind is something like below:

static int i2c_dw_prepare(struct device *dev)
{
	return pm_runtime_suspended(dev);
}

static void i2c_dw_complete(struct device *dev)
{
	if (dev->power.direct_complete)
		pm_request_resume(dev);
}

In other words it checks if the device is already runtime suspended and
prevents ->suspend() etc. from being called.

If that does not work (I didn't try as this problem does not exist on
ACPI platforms because we have PM domain handling things) then we do not
have much of a choice than do what you suggest and runtime resume the
device on ->suspend()
