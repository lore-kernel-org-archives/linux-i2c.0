From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c,algo: timeout reaches -1
Date: Sun, 1 Feb 2009 11:41:21 +0100
Message-ID: <20090201114121.6448a3c9@hyperion.delvare>
References: <4984688B.2090805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4984688B.2090805-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Roel,

On Sat, 31 Jan 2009 16:04:43 +0100, Roel Kluin wrote:
> The postfix decrement decrements timeout till -1, but the
> warning is already triggered on 0
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
> index 3e01992..0e2933f 100644
> --- a/drivers/i2c/algos/i2c-algo-pcf.c
> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
> @@ -115,7 +115,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>  
>  	status = get_pcf(adap, 1);
>  #ifndef STUB_I2C
> -	while (timeout-- && !(status & I2C_PCF_BB)) {
> +	while (--timeout && !(status & I2C_PCF_BB)) {
>  		udelay(100); /* wait for 100 us */
>  		status = get_pcf(adap, 1);
>  	}
> @@ -123,7 +123,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>  	if (timeout <= 0) {
>  		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
>  	}
> -	
> +
>  	return (timeout<=0);
>  }

Never include unrelated whitespace cleanups in patches which fix bugs.

>  
> @@ -134,7 +134,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
>  
>  	*status = get_pcf(adap, 1);
>  #ifndef STUB_I2C
> -	while (timeout-- && (*status & I2C_PCF_PIN)) {
> +	while (--timeout && (*status & I2C_PCF_PIN)) {
>  		adap->waitforpin(adap->data);
>  		*status = get_pcf(adap, 1);
>  	}

Not as critical as the ones in i2c-amd8111 and i2c-pxa, but still bugs,
I agree. I am, however, not totally happy with your fix. Leaving the
"<= 0" tests while the timeout will now stop at 0 is confusing. I think
you should change these tests to "== 0". Other odd things in these
functions:

* The timeout decrement should be _after_ the status test, otherwise
  you can exit with a timeout while the status was correct.

* Mixing actual error codes (-EINTR) with arbitrary negative error
  values (-1) isn't wise. We are lucky than EINTR isn't equal to 1. I
  think it would be better to return -ETIMEDOUT for timeouts rather
  than an arbitrary number.

Could you please submit a new patch fixing all the above?

Thanks,
-- 
Jean Delvare
