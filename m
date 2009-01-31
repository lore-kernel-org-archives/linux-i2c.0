From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: timeouts reach -1
Date: Sat, 31 Jan 2009 22:10:43 +0100
Message-ID: <20090131221043.23d3ecab@hyperion.delvare>
References: <49842682.2020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49842682.2020903-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Roel,

On Sat, 31 Jan 2009 11:22:58 +0100, Roel Kluin wrote:
> With a postfix decrement these timeouts reach -1 rather than 0,
> but after the loop it is tested whether they have become 0.
> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-amd8111.c |    4 ++--
>  drivers/i2c/busses/i2c-pxa.c     |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
> index edab519..3b9f768 100644
> --- a/drivers/i2c/busses/i2c-amd8111.c
> +++ b/drivers/i2c/busses/i2c-amd8111.c
> @@ -72,7 +72,7 @@ static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
>  {
>  	int timeout = 500;
>  
> -	while (timeout-- && (inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_IBF))
> +	while (--timeout && (inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_IBF))
>  		udelay(1);
>  
>  	if (!timeout) {
> @@ -88,7 +88,7 @@ static unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
>  {
>  	int timeout = 500;
>  
> -	while (timeout-- && (~inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_OBF))
> +	while (--timeout && (~inb(smbus->base + AMD_EC_SC) & AMD_EC_SC_OBF))
>  		udelay(1);
>  
>  	if (!timeout) {
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 6af6814..6379ec1 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -644,7 +644,7 @@ static int i2c_pxa_do_pio_xfer(struct pxa_i2c *i2c,
>  
>  	i2c_pxa_start_message(i2c);
>  
> -	while (timeout-- && i2c->msg_num > 0) {
> +	while (--timeout && i2c->msg_num > 0) {
>  		i2c_pxa_handler(0, i2c);
>  		udelay(10);
>  	}

Good catch. Applied, thanks for reporting.

-- 
Jean Delvare
