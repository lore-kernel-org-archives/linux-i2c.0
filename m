From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 3/9] i2c: i2c-mxs: replace platform_driver_probe to support deferred probing
Date: Tue, 8 Oct 2013 22:58:57 +0200
Message-ID: <201310082258.57659.marex@denx.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de> <1381264542-29396-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381264542-29396-4-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a
> .probe function specified in the driver struct. Fix this driver to have
> that, so the devices it supports won't get lost in a deferred probe.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Certainly makes sense,

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thanks!

Best regards,
Marek Vasut
