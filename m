From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c: timeouts off by 1
Date: Thu, 23 Apr 2009 17:02:18 +0200
Message-ID: <20090423170218.66dda625@hyperion.delvare>
References: <49A524E4.5050108@gmail.com>
	<20090423143654.7fc2327e@hyperion.delvare>
	<49F07ADB.1030300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49F07ADB.1030300-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Apr 2009 16:27:39 +0200, Roel Kluin wrote:
> Ok, here's for drivers/i2c/busses/i2c-pxa.c. Note that I found another,
> the last hunk.
> --------------------------->8-------------8<------------------------------
> With `while (timeout--)' timeout reaches -1 after the loop, so the tests
> below are off by one.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Ben, Wolfram, I'll let you handle this one as it's an arm driver.

> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index c1405c8..acc7143 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -265,10 +265,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
>  		show_state(i2c);
>  	}
>  
> -	if (timeout <= 0)
> +	if (timeout < 0)
>  		show_state(i2c);
>  
> -	return timeout <= 0 ? I2C_RETRY : 0;
> +	return timeout < 0 ? I2C_RETRY : 0;
>  }
>  
>  static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
> @@ -612,7 +612,7 @@ static int i2c_pxa_pio_set_master(struct pxa_i2c *i2c)
>  		show_state(i2c);
>  	}
>  
> -	if (timeout <= 0) {
> +	if (timeout < 0) {
>  		show_state(i2c);
>  		dev_err(&i2c->adap.dev,
>  			"i2c_pxa: timeout waiting for bus free\n");
> 

-- 
Jean Delvare
