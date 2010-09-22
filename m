From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: Fix use of default platform data if none
	supplied.
Date: Wed, 22 Sep 2010 01:24:42 +0100
Message-ID: <20100922002442.GJ7494@trinity.fluff.org>
References: <1283616468-6344-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283616468-6344-1-git-send-email-michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, chaithrika-l0cyMroinI0@public.gmane.org, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org, nageswari-l0cyMroinI0@public.gmane.org, dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 04, 2010 at 12:07:48PM -0400, Michael Williamson wrote:
> There is a bug in the i2c-davinci device init routine that attempts
> to use default platform data if none is supplied (e.g., is NULL).
> This patch fixes the bug.
> 
> Signed-off-by: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 2222c87..6d4eeeb 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -235,10 +235,12 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>   */
>  static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  {
> -	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> +	struct davinci_i2c_platform_data *pdata;
>  
> -	if (!pdata)
> -		pdata = &davinci_i2c_platform_data_default;
> +	if (!dev->dev->platform_data)
> +		dev->dev->platform_data = &davinci_i2c_platform_data_default;
> +
> +	pdata = dev->dev->platform_data;

At first glance this looks like a code shift, however is the platform
data used later in the driver by referencing the device.platform_data
field?

Could you rewrite the header to show this, and if possible note any
actual oops report that has been seen with this.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
