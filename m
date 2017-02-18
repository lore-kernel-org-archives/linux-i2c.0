From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Sat, 18 Feb 2017 19:34:10 +0100
Message-ID: <48907a31-eaa6-27e2-633f-d36de521e868@tronnes.org>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
 <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487280047-29608-2-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Den 16.02.2017 22.20, skrev Stefan Wahren:
> Since commit e2474541032d ("bcm2835: Fix hang for writing messages
> larger than 16 bytes") the interrupt handler is prone to a possible
> NULL pointer dereference. This could happen if an interrupt fires
> before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
> on the RPi 3. Even this is an unexpected behavior the driver must
> handle that with an error instead of a crash.
>
> CC: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
> CC: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> Reported-by: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-bcm2835.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index c3436f6..10e39c8 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -195,7 +195,9 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
>   	}
>   
>   	if (val & BCM2835_I2C_S_DONE) {
> -		if (i2c_dev->curr_msg->flags & I2C_M_RD) {
> +		if (!i2c_dev->curr_msg) {
> +			dev_err(i2c_dev->dev, "Got unexpected interrupt (from firmware?)\n");
> +		} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
>   			bcm2835_drain_rxfifo(i2c_dev);
>   			val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
>   		}

Thanks,

Acked-by: Noralf Trønnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
