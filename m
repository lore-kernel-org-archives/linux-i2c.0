From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2] davinci: I2C: Adding bus frequency as module parameter
Date: Wed, 11 Aug 2010 08:39:02 -0700
Message-ID: <87aaot40rt.fsf@deeprootsystems.com>
References: <1281521313-4556-1-git-send-email-vishwanath.k@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281521313-4556-1-git-send-email-vishwanath.k-l0cyMroinI0@public.gmane.org> (vishwa's
	message of "Wed, 11 Aug 2010 15:38:33 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org> writes:

> With current implementation, when I2C is used as a module,
> for slave devices which operate at different frequencies,
> the bus frequency needs to be modified in the board
> configuration file and kernel needs to be re-built.
>
> This patch addresses this issue by adding bus frequency as
> module parameter.
>
> Signed-off-by: vishwa <vishwanath.k-l0cyMroinI0@public.gmane.org>
> ---
> Since v1:
> a. added MODULE_PARAM_DESC.
> b. Moved module parameter definitions to the beginning of the file.
> c. 'pdata->bus_freq' is being set in i2c_davinci_init() function.
>
>  drivers/i2c/busses/i2c-davinci.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 2222c87..8fbfaa2 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -98,6 +98,10 @@
>  #define DAVINCI_I2C_IMR_NACK	BIT(1)
>  #define DAVINCI_I2C_IMR_AL	BIT(0)
>  
> +static int i2c_davinci_busfreq;
> +module_param(i2c_davinci_busfreq, int, 0);
> +MODULE_PARM_DESC(i2c_davinci_busfreq, "bus frequency");
> +
>  struct davinci_i2c_dev {
>  	struct device           *dev;
>  	void __iomem		*base;
> @@ -243,6 +247,9 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	/* put I2C into reset */
>  	davinci_i2c_reset_ctrl(dev, 0);
>  
> +	if (i2c_davinci_busfreq != 0)
> +		pdata->bus_freq = i2c_davinci_busfreq;

I don't really like using a module parameter to modify the contents of
struct platform_data, especially when this comes from a board file.

Intead this should look something like

	if (!i2c_davinci_busfreq)
		i2c_davinci_bus_freq = pdata->bus_freq;

and the code should use i2c_davinci_busfreq instead of pdata->bus_freq.

Kevin
