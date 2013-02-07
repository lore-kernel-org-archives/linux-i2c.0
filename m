From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 37/77] i2c: convert to idr_alloc()
Date: Thu, 7 Feb 2013 08:32:47 -0800
Message-ID: <20130207163247.GL2875@htj.dyndns.org>
References: <1360179649-22465-1-git-send-email-tj@kernel.org>
 <1360179649-22465-38-git-send-email-tj@kernel.org>
 <20130207152831.GA14797@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130207152831.GA14797-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Feb 07, 2013 at 03:28:31PM +0000, Mark Brown wrote:
> On Wed, Feb 06, 2013 at 11:40:09AM -0800, Tejun Heo wrote:
> > Convert to the much saner new idr interface.
> > 
> > Only compile tested.
> 
> This broke I2C for me in -next today, I saw a spinlock bad magic error
> calling pm_runtime_enable().  

Hmmm... weird, can't see where the difference in behavior would come
from.  The only material difference would be if id < 0 && id != -1 in
i2c_add_numbered_adapter(), which now would trigger WARN_ON_ONCE()
inside idr_alloc() instead of silently returning -EINVAL.

Can you please elaborate the failure?  I can't see how the idr
conversion would lead to spinlock bad magic error.  Does reverting
this patch make the problem go away?

Thanks.

--
tejun
