From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: i2c-mxs woes
Date: Fri, 19 Apr 2013 13:49:05 +0200
Message-ID: <201304191349.05971.marex@denx.de>
References: <51712C8B.7070302@free-electrons.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51712C8B.7070302-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Alexandre Belloni,

> Hi,
> 
> I'm having some issues with the i2c-mxs driver in 3.9. Marek already
> pointed me to the patches from Lucas and that greatly improved the
> situation.
> 
> For the context, my board has three nau7802 adcs, connected to a gpio
> i2c-muxer, connected to i2c1.
> 
> Here is what I observe:
> 
> On 3.9:
> 
> # time cat /sys/bus/iio/devices/iio:device1/in_voltage0_raw
> 2620
> real	0m 7.08s
> user	0m 0.00s
> sys	0m 0.02s
> # time cat /sys/bus/iio/devices/iio:device1/in_voltage1_raw
> 2623
> real	0m 6.07s
> user	0m 0.01s
> sys	0m 0.01s
> #

Looks like there's a fixes 7-second delay. Like a timeout maybe?

Best regards,
Marek Vasut
