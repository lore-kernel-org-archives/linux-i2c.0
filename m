From: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] misc: (at24) move header to linux/platform_data/
Date: Fri, 23 Aug 2013 15:19:47 -0400 (EDT)
Message-ID: <1033284781.908504.1377285587778.JavaMail.root@mail>
References: <20130823190247.GA3821@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130823190247.GA3821@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram wrote:

> On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> > This patch moves the at24.h header from include/linux/i2c to
> > include/linux/platform_data and updates existing support
> > accordingly.
> 
> This message explains what the patch does but not why the change is
> wanted. I'd be surprised if we really want *all* platform_data in one
> single directory?

IMHO it makes sense. Why wouldn't we want all platform_data in
include/linux/platform_data/?

> Is this patch part of a bigger series?
No.

> That being said i2c is not the best place for this include, in deed...
I agree.

Thanks,
Vivien
