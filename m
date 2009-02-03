From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: timeouts reach -1
Date: Tue, 3 Feb 2009 20:08:19 +0100
Message-ID: <20090203200819.1d63e96d@hyperion.delvare>
References: <49842682.2020903@gmail.com>
	<20090131221043.23d3ecab@hyperion.delvare>
	<20090201131854.64f54b28@hyperion.delvare>
	<49876AB7.5030100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49876AB7.5030100-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 02 Feb 2009 22:50:47 +0100, Roel Kluin wrote:
> Jean Delvare wrote:
> > On Sat, 31 Jan 2009 22:10:43 +0100, Jean Delvare wrote:
> >> Hi Roel,
> >>
> >> On Sat, 31 Jan 2009 11:22:58 +0100, Roel Kluin wrote:
> >>> With a postfix decrement these timeouts reach -1 rather than 0,
> >>> but after the loop it is tested whether they have become 0.
> >>>
> >>> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>> (...)
> >>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> >>> index 6af6814..6379ec1 100644
> >>> --- a/drivers/i2c/busses/i2c-pxa.c
> >>> +++ b/drivers/i2c/busses/i2c-pxa.c
> >>> @@ -644,7 +644,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
> >>>  
> >>>  	i2c_pxa_start_message(i2c);
> >>>  
> >>> -	while (timeout-- && i2c->msg_num > 0) {
> >>> +	while (--timeout && i2c->msg_num > 0) {
> >>>  		i2c_pxa_handler(0, i2c);
> >>>  		udelay(10);
> >>>  	}
> >> Good catch. Applied, thanks for reporting.
> > 
> > On second thought, shouldn't the msg_num test be done first and the
> > timeout test second? With the current order, you could exit with a
> > timeout error while all the messages were successfully transferred.
> 
> Thanks again for the review, How about:
> 
> ----------------------------->8-----------------8<------------------------------
> With a postfix decrement these timeouts reach -1 rather than 0, but after the
> loop it is tested whether they have become 0. also test before the decrement
> 
> As pointed out by Jean Delvare, the msg_num should be tested before the timeout.
> With the current order, you could exit with a timeout error while all the
> messages were successfully transferred.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
> index edab519..a73346b 100644
> --- a/drivers/i2c/busses/i2c-amd8111.c
> +++ b/drivers/i2c/busses/i2c-amd8111.c
> @@ -72,10 +72,10 @@ static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
>  {
>  	int timeout = 500;
>  
> -	while (timeout-- && (inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_IBF))
> +	while ((inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_IBF) && --timeout)
>  		udelay(1);
>  
> -	if (!timeout) {
> +	if (timeout <= 0) {

See my previous mail: you're trying to fix up the confusion regarding
the value of timeout at the end of the loop. Changing the decrement
from postfix to prefix is sufficient to solve the issue. Changing the
test from == 0 to <= 0 is also sufficient. Doing both is redundant
_and_ fails to clear the confusion. The resulting code makes it look
like timeout _may_ become negative, which is not true.

So, I intend to keep only the first half of each fix, and apply that.

>  		dev_warn(&smbus->dev->dev,
>  			 "Timeout while waiting for IBF to clear\n");
>  		return -ETIMEDOUT;
> @@ -88,10 +88,10 @@ static unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
>  {
>  	int timeout = 500;
>  
> -	while (timeout-- && (~inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_OBF))
> +	while ((~inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_OBF) && --timeout)
>  		udelay(1);
>  
> -	if (!timeout) {
> +	if (timeout <= 0) {
>  		dev_warn(&smbus->dev->dev,
>  			 "Timeout while waiting for OBF to set\n");
>  		return -ETIMEDOUT;
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 6af6814..04751fa 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -644,7 +644,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>  
>  	i2c_pxa_start_message(i2c);
>  
> -	while (timeout-- && i2c->msg_num > 0) {
> +	while (i2c->msg_num > 0 && --timeout) {
>  		i2c_pxa_handler(0, i2c);
>  		udelay(10);
>  	}
> @@ -657,7 +657,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>  	ret = i2c->msg_idx;
>  
>  out:
> -	if (timeout == 0)
> +	if (timeout <= 0)
>  		i2c_pxa_scream_blue_murder(i2c, "timeout");
>  
>  	return ret;


-- 
Jean Delvare
