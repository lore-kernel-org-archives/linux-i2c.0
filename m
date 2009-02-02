From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c,algo: timeout reaches -1
Date: Mon, 2 Feb 2009 22:53:09 +0100
Message-ID: <20090202225309.359e77d6@hyperion.delvare>
References: <4984688B.2090805@gmail.com>
	<20090201114121.6448a3c9@hyperion.delvare>
	<498760F7.6020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498760F7.6020005-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 02 Feb 2009 22:09:11 +0100, Roel Kluin wrote:
> Jean Delvare wrote:
> > Hi Roel,
> > 
> > On Sat, 31 Jan 2009 16:04:43 +0100, Roel Kluin wrote:
> >> The postfix decrement decrements timeout till -1, but the
> >> warning is already triggered on 0
> >>
> >> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
> >> index 3e01992..0e2933f 100644
> >> --- a/drivers/i2c/algos/i2c-algo-pcf.c
> >> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
> >> @@ -115,7 +115,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
> >>  
> >>  	status = get_pcf(adap, 1);
> >>  #ifndef STUB_I2C
> >> -	while (timeout-- && !(status & I2C_PCF_BB)) {
> >> +	while (--timeout && !(status & I2C_PCF_BB)) {
> >>  		udelay(100); /* wait for 100 us */
> >>  		status = get_pcf(adap, 1);
> >>  	}
> >> @@ -123,7 +123,7 @@ static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
> >>  	if (timeout <= 0) {
> >>  		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
> >>  	}
> >> -	
> >> +
> >>  	return (timeout<=0);
> >>  }
> > 
> > Never include unrelated whitespace cleanups in patches which fix bugs.
> 
> I thought it was nice in this case, since it shows where things go wrong.

If you really want to show this, feel free to increase the patch
context. But in general, people can go read the original source file if
they have to (which is what I did.)

> Also I think it is generally considered wrong only if it affects code
> that are in totally different sections - because it confuses, which it
> does not if it's in the same section.

I tend to believe that it becomes confusing as soon as it creates an
additional hunk in the patch. It also increases the risk of patch
rejection when one ports the fix to a different tree.

> >> @@ -134,7 +134,7 @@ static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
> >>  
> >>  	*status = get_pcf(adap, 1);
> >>  #ifndef STUB_I2C
> >> -	while (timeout-- && (*status & I2C_PCF_PIN)) {
> >> +	while (--timeout && (*status & I2C_PCF_PIN)) {
> >>  		adap->waitforpin(adap->data);
> >>  		*status = get_pcf(adap, 1);
> >>  	}
> > 
> > Not as critical as the ones in i2c-amd8111 and i2c-pxa, but still bugs,
> > I agree. I am, however, not totally happy with your fix. Leaving the
> > "<= 0" tests while the timeout will now stop at 0 is confusing. I think
> > you should change these tests to "== 0". Other odd things in these
> > functions:
> 
> I consider the "<= 0" test to be safer considering possible future
> changes.

Do you realize that this is exactly the kind of thinking which in the
first place led to the bug you're fixing?

> > * The timeout decrement should be _after_ the status test, otherwise
> >   you can exit with a timeout while the status was correct.
> 
> I agree, fixed in the patch below
> 
> > * Mixing actual error codes (-EINTR) with arbitrary negative error
> >   values (-1) isn't wise. We are lucky than EINTR isn't equal to 1. I
> >   think it would be better to return -ETIMEDOUT for timeouts rather
> >   than an arbitrary number.
> 
> Also fixed (for both functions).
> 
> Also I noted that in wait_for_pin() on a timeout, dependent on the
> status, still a handle_lab(adap, status) and return -EINTR may occur,
> which I think are wrong.

Depends on the hardware implementation. If I2C_PCF_LAB can be set while
I2C_PCF_PIN is set then indeed this is wrong. But I suspect the
hardware is such that I2C_PCF_LAB can't be set without I2C_PCF_PIN
being clear. You'd have to check the PCF8584 datasheet to make sure.

> 
> > Could you please submit a new patch fixing all the above?
> > 
> > Thanks,
> 
> here it is:
> 
> ---------------------------->8----------------8<------------------------------
> * Fix that the warning was already triggered on 0, which was not yet a timeout.
> * Move timeout decrement after the status test so that we don't exit with a
> timeout while the status was correct.
> * Replace arbitrary values with error codes: return -ETIMEDOUT; upon timeout. 
> * Ensure that upon a timeout we do not handle dependent on the last status.
> * Local whitespace cleanups.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pcf.c |   41 ++++++++++++++++---------------------
>  1 files changed, 18 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
> index 3e01992..05f0f56 100644
> --- a/drivers/i2c/algos/i2c-algo-pcf.c
> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
> @@ -108,45 +108,40 @@ static void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
>  		get_pcf(adap, 1)));
>  }
>  
> -static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
> -
> +static int wait_for_bb(struct i2c_algo_pcf_data *adap)
> +{
> +#ifndef STUB_I2C

As a side note, I think it's about time to get rid of STUB_I2C, as it
is totally undocumented and at first sight it doesn't seem terribly
useful anymore (if it ever was).

>  	int timeout = DEF_TIMEOUT;
> -	int status;
>  
> -	status = get_pcf(adap, 1);
> -#ifndef STUB_I2C
> -	while (timeout-- && !(status & I2C_PCF_BB)) {
> +	while (!(get_pcf(adap, 1) & I2C_PCF_BB) && --timeout)
>  		udelay(100); /* wait for 100 us */
> -		status = get_pcf(adap, 1);
> -	}
> -#endif
> +
>  	if (timeout <= 0) {
>  		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
> +		return -ETIMEDOUT;
>  	}
> -	
> -	return (timeout<=0);
> +#endif
> +	return 0;
>  }
>  
>  
> -static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
> -
> +static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status)
> +{
> +#ifndef STUB_I2C
>  	int timeout = DEF_TIMEOUT;
>  
> -	*status = get_pcf(adap, 1);
> -#ifndef STUB_I2C

As long as STUB_I2C is there, the above is incorrect, as you will
return 0 with *status unset. I would like to suggest that we go with 2
patches, one removing STUB_I2C and fixing any coding style issue you
like, and a second one with the actual logic fixes.

> -	while (timeout-- && (*status & I2C_PCF_PIN)) {
> +	while ((*status = get_pcf(adap, 1)) & I2C_PCF_PIN && --timeout)

This lacks parentheses. Also, you'll get a warning from checkpatch for
this construct (not sure if we care.)

>  		adap->waitforpin(adap->data);
> -		*status = get_pcf(adap, 1);
> -	}
> +
> +	if (timeout <= 0)
> +		return -ETIMEDOUT;
> +
>  	if (*status & I2C_PCF_LAB) {
>  		handle_lab(adap, status);
> -		return(-EINTR);
> +		return -EINTR;
>  	}
>  #endif
> -	if (timeout <= 0)
> -		return(-1);
> -	else
> -		return(0);
> +	return 0;
>  }
>  
>  /* 


-- 
Jean Delvare
