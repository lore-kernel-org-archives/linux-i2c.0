From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller
Date: Fri, 21 Mar 2008 15:23:12 +0900
Message-ID: <20080321062312.GA17225@linux-sh.org>
References: <20080320141840.13560.24850.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080320141840.13560.24850.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: i2c@lm-sensors.org, khali@linux-fr.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 20, 2008 at 11:18:40PM +0900, Magnus Damm wrote:
> +static void sh_mobile_i2c_setup_channel(struct platform_device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
> +	unsigned long peripheral_clk = CONFIG_SH_PCLK_FREQ;
> +	u_int32_t num;
> +	u_int32_t denom;
> +	u_int32_t tmp;
> +
Use clk_get() and friends here for the module clock. This should
absolutely not be hardcoded, especially as it can be scaled by the clock
framework, and the i2c clock will need to rebalance itself to account for
that. Any driver that references CONFIG_SH_PCLK_FREQ is utterly broken.
