From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: timeouts off by 1
Date: Thu, 23 Apr 2009 14:36:54 +0200
Message-ID: <20090423143654.7fc2327e@hyperion.delvare>
References: <49A524E4.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49A524E4.5050108-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Roel,

Sorry for the late reply, I overlooked your patch.

On Wed, 25 Feb 2009 12:00:52 +0100, Roel Kluin wrote:
> with while (timeout++ < MAX_TIMEOUT); timeout reaches MAX_TIMEOUT + 1 after the
> loop, so the tests below are off by one.

This is correct. It just shows how all PC SMBus master drivers have
been copied from each other ;)

> 
> Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ali1535.c |    2 +-
>  drivers/i2c/busses/i2c-ali15x3.c |    2 +-
>  drivers/i2c/busses/i2c-amd756.c  |    4 ++--
>  drivers/i2c/busses/i2c-i801.c    |    8 ++++----
>  drivers/i2c/busses/i2c-isch.c    |    2 +-
>  drivers/i2c/busses/i2c-nforce2.c |    2 +-
>  drivers/i2c/busses/i2c-pxa.c     |    4 ++--
>  drivers/i2c/busses/i2c-sis5595.c |    2 +-
>  drivers/i2c/busses/i2c-sis630.c  |    2 +-
>  drivers/i2c/busses/i2c-sis96x.c  |    2 +-
>  10 files changed, 15 insertions(+), 15 deletions(-)
> 

> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -264,10 +264,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
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

This one is different and doesn't match the description. I'm excluding
it from this patch, for this reason and also because there may be other
i2c-pxa patches pending on the arm side. Can you please submit a
separate patch for i2c-pxa? Thanks.

-- 
Jean Delvare
