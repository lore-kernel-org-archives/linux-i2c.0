From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V6 0/4] add 88pm80x mfd driver
Date: Tue, 10 Jul 2012 11:14:11 +0200
Message-ID: <20120710091411.GV15345@sortiz-mobl>
References: <1341896853-29755-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341896853-29755-1-git-send-email-zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Qiao Zhou <zhouqiao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Cc: arnd-r2nGTMty4D4@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chao.xie-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, yu.tang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, wilbur.wang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Zhou,

On Tue, Jul 10, 2012 at 01:07:29PM +0800, Qiao Zhou wrote:
> change log [v6->v5]:
> export_symbol_gpl for pm80x_regmap_config to fix build issue for module.
I did already apply a patch from Axel Lin that fixes that build failure. See
commit 78a73e59db21b465fe60e795a0b7eadb0451370b from my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
