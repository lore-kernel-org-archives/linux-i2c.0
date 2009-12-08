From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: davinci: Add helper functions
Date: Tue, 08 Dec 2009 14:24:31 +0300
Message-ID: <4B1E376F.1030808@ru.mvista.com>
References: <1260267218-19406-1-git-send-email-chaithrika@ti.com>	<1260267218-19406-2-git-send-email-chaithrika@ti.com> <1260267218-19406-3-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260267218-19406-3-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

Chaithrika U S wrote:

> Add i2c reset control and clock divider calculation functions
> which will be useful for power management features.
>
> Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
>   

[...]

> @@ -138,15 +147,6 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	u32 clkh;
>  	u32 clkl;
>  	u32 input_clock = clk_get_rate(dev->clk);
> -	u16 w;
> -
> -	if (!pdata)
> -		pdata = &davinci_i2c_platform_data_default;
> -
> -	/* put I2C into reset */
> -	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
> -	w &= ~DAVINCI_I2C_MDR_IRS;
> -	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, w);
>  
>  	/* NOTE: I2C Clock divider programming info
>  	 * As per I2C specs the following formulas provide prescaler
> @@ -178,12 +178,32 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
>  
> +	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
> +}
> +
> +/*
> + * This function configures I2C and brings I2C out of reset.
> + * This function is called during I2C init function. This function
> + * also gets called if I2C encounters any errors.
> + */
> +static int i2c_davinci_init(struct davinci_i2c_dev *dev)
> +{
> +	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
> +
> +	if (!pdata)
> +		pdata = &davinci_i2c_platform_data_default;
>   

   The very idea of "default" platform data seems doubtful. Could we 
remove it?

WBR, Sergei
