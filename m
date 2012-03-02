From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-eg20t: Rework pch_i2c_wait_for_bus_idle to reduce
 wait time
Date: Fri, 2 Mar 2012 09:51:29 +0900
Message-ID: <CANKRQniA2icHddFG22r7VtLTuoefbK61tpcUQnXgShFHuffUuA@mail.gmail.com>
References: <1329725656-32715-1-git-send-email-alexander.stein@systec-electronic.com>
	<20120224121753.GE2479@pengutronix.de>
	<CANKRQngWB8kUO68UdbDeWey5eGRF0nGCE341j8jyCMogvYUYKA@mail.gmail.com>
	<20120301101502.GB2535@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120301101502.GB2535-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

2012年3月1日19:15 Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>:
> Ah, thanks for the update! Are you fine with the patch in question now?

Alexander's patch looks good.
Did Alexander test i2c-eg20t driver with this patch ?

thanks,
-- 
ROHM Co., Ltd.
tomoya
