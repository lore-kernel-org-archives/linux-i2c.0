From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/5] I2C: DaVinci: clock between 7-12 MHz
Date: Mon, 28 Apr 2008 16:32:17 +0200
Message-ID: <20080428163217.207423cf@hyperion.delvare>
References: <1209142694-30046-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1209142694-30046-1-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 25 Apr 2008 09:58:10 -0700, Troy Kisky wrote:
> Ensure psc value gives a clock between 7-12 MHz
> Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> Signed-off-by: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   15 +++++++++++----
>  1 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 7ecbfc4..0e5a39c 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -142,6 +142,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
>  	u16 psc;
>  	u32 clk;
> +	u32 d;
>  	u32 clkh;
>  	u32 clkl;
>  	u32 input_clock = clk_get_rate(dev->clk);
> @@ -171,23 +172,29 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	 *       if PSC > 1 , d = 5
>  	 */
>  
> -	psc = 26; /* To get 1MHz clock */
> +	/* get minimum of 7 MHz clock, but max of 12 MHz */
> +	psc = (input_clock / 7000000) - 1;
> +	if ((input_clock / (psc + 1)) > 12000000)
> +		psc++;	/* better to run under spec than over */
> +	d = (psc >= 2)? 5 : 7 - psc;
>  
> -	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - 10;
> -	clkh = (50 * clk) / 100;
> +	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - (d<<1);
> +	clkh = clk>>1;
>  	clkl = clk - clkh;
>  
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_PSC_REG, psc);
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
>  
> -	dev_dbg(dev->dev, "CLK  = %d\n", clk);
> +	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
>  	dev_dbg(dev->dev, "PSC  = %d\n",
>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_PSC_REG));
>  	dev_dbg(dev->dev, "CLKL = %d\n",
>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
>  	dev_dbg(dev->dev, "CLKH = %d\n",
>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
> +	dev_dbg(dev->dev, "bus_freq = %dkHz, bus_delay = %d\n",
> +		pdata->bus_freq, pdata->bus_delay);
>  
>  	/* Take the I2C module out of reset: */
>  	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);

Applied, with a few remaining coding-style cleanups, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
