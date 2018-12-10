From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 2/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Date: Mon, 10 Dec 2018 19:23:09 +0530
Message-ID: <20181210135309.GD25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-3-pn@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-3-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Parthiban Nallathambi <pn@denx.de>
Cc: afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:19PM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
> 
> Add Actions Semiconductor Owl family S900 I2C driver.

S700 ;-)

> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

With the change in subject,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Cheers,
Mani

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id owl_i2c_of_match[] = {
> +	{ .compatible = "actions,s700-i2c" },
>  	{ .compatible = "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> -- 
> 2.17.2
> 
