From: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-s3c2410: Remove unconditional 1ms delay on each
 transfer
Date: Wed, 28 Apr 2010 13:39:18 +0900
Message-ID: <4BD7BBF6.9090103@samsung.com>
References: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1270214109-28226-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4/2/2010 10:15 PM, Mark Brown wrote:
> The S3C I2C controller indicates completion of I2C transfers before
> the bus has a stop condition on it. In order to ensure that we do not
> attempt to start a new transfer before the bus is idle the driver
> currently inserts a 1ms delay. This is vastly larger than is generally
> required and has a visible effect on performance under load, such as
> when bringing up audio CODECs or reading back status information with
> non-bulk I2C reads.
> 
> Replace the sleep with a spin on the IIC status register for up to 1ms.
> This will busy wait but testing on my SMDK6410 system indicates that
> the overwhelming majority of transactions complete on the first spin,
> with maximum latencies of less than 10 spins so the absolute overhead
> of busy waiting should be at worst comprable to msleep(), and the
> overall system performance is dramatically improved.
> 
> The main risk is poor interaction with multimaster systems where
> we may miss the bus going idle before the next transaction. Defend
> against this by falling back to the original 1ms delay after 20 spins.
> 
> The overall effect in my testing is an approximately 20% improvement
> in kernel startup time.
> 

I tested this patch on the s5pc110. This occurs msleep(1) still by time 
out at the my touchscreen i2c device on the s5pc110. It takes 80usec to 
clear S3C2410_IICSTAT_START bit in the worst case of my touchscreen and
need about 400 spins. The 1msec delay is overhead to me still now.
