From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/4 V5] add 88pm80x mfd driver
Date: Mon, 9 Jul 2012 12:55:51 +0200
Message-ID: <20120709105551.GK15345@sortiz-mobl>
References: <1341815855-13522-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341815855-13522-1-git-send-email-zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, yu.tang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, wilbur.wang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Zhou,

On Mon, Jul 09, 2012 at 02:37:31PM +0800, Qiao Zhou wrote:
> change log [v5->v4]:
> 1, change the file name, from 88pm800-core.c, 88pm805-core.c, 88pm80x-i2c.c
> to 88pm800.c, 88pm805.c, 88pm80x.c, and modified Makefile accordingly.
> 2, replace the spinlock used to protect wakeup flag, with using set_bit/
> clear_bit, which is suitable adn enough in SMP env.
> 3, add the version number in each patch.
I applied the first 2 patches, I'd like to get an ACK from the respective
maintainers for the rtc and the input ones. They can even take it as both
drivers are protected by the MFD symbol.

Cheers,
Samuel. 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
