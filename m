From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Generate correct i2c address sequence for 10-bit
 target.
Date: Mon, 7 Nov 2011 10:30:30 +0100
Message-ID: <20111107103030.78ed7a28@endymion.delvare>
References: <B6A520E9CD57404AAFC0831E4FB39541AE6855A097@IRVEXCHCCR02.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B6A520E9CD57404AAFC0831E4FB39541AE6855A097-4wnuKdaqIVJdD26/7+am4baTQr+y5IJFqs7JOtOhHmkAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sheng-Hui,

On Thu, 3 Nov 2011 12:15:12 -0700, Jeffrey (Sheng-Hui) Chu wrote:
> From 31eb33a1b648f380db284a59d7fa5b4c1a321651 Mon Sep 17 00:00:00 2001
> From: Sheng-Hui J. Chu <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Date: Thu, 3 Nov 2011 14:24:06 -0400
> Subject: [PATCH] Generate correct i2c address sequence for 10-bit target.
> 
> Signed-off-by: Sheng-Hui J. Chu <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index 85584a5..525c734 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -488,7 +488,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
>  
>  	if (flags & I2C_M_TEN) {
>  		/* a ten bit address */
> -		addr = 0xf0 | ((msg->addr >> 7) & 0x03);
> +		addr = 0xf0 | ((msg->addr >> 7) & 0x06);
>  		bit_dbg(2, &i2c_adap->dev, "addr0: %d\n", addr);
>  		/* try extended address code...*/
>  		ret = try_address(i2c_adap, addr, retries);
> @@ -498,7 +498,7 @@ static int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
>  			return -ENXIO;
>  		}
>  		/* the remaining 8 bit address */
> -		ret = i2c_outb(i2c_adap, msg->addr & 0x7f);
> +		ret = i2c_outb(i2c_adap, msg->addr & 0xff);
>  		if ((ret != 1) && !nak_ok) {
>  			/* the chip did not ack / xmission error occurred */
>  			dev_err(&i2c_adap->dev, "died at 2nd address code\n");

Applied, thanks. I wanted to apply it before, but couldn't retrieve it
from bugzilla before it went down. Thanks for resending it.

Note that i2c-core will need some adjustment to properly deal with
7-bit and 10-bit addresses domains (their bus_id currently collide.)
I'll post a proposal for this later today.

-- 
Jean Delvare
