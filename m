From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
Date: Tue, 13 Jan 2015 16:29:30 +0200
Message-ID: <20150113142930.GT1386@lahna.fi.intel.com>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
 <20141219104315.0ccbba9c@xhacker>
 <20150113115205.GE7660@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150113115205.GE7660@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 13, 2015 at 12:52:05PM +0100, Wolfram Sang wrote:
> On Fri, Dec 19, 2014 at 10:43:15AM +0800, Jisheng Zhang wrote:
> > Dear all,
> > 
> > Is there any issue I need to resolve so that the patch can be merged?
> 
> Adding Mika to the loop. He uses the driver a lot (and knows other
> people who do)...

I don't see problems with this patch.

On x86 we have readl_relaxed() the same as readl() so this patch does
not change anything there.

Feel free to add,

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
