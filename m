From: Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCH] i2c: altera: use proper variable to hold errno
Date: Wed, 1 Apr 2020 16:00:10 -0500
Message-ID: <4170acee-b3d1-8c79-f895-706501223b59@linux.intel.com>
References: <20200327222826.10207-1-wsa+renesas@sang-engineering.com>
Reply-To: thor.thayer@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200327222826.10207-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 3/27/20 5:28 PM, Wolfram Sang wrote:
> device_property_read_u32() returns errno or 0, so we should use the
> integer variable 'ret' and not the u32 'val' to hold the retval.
> 
> Fixes: 0560ad576268 ("i2c: altera: Add Altera I2C Controller driver")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Found while trying to refactor code handling "clock-frequency" property.
> 
>   drivers/i2c/busses/i2c-altera.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
> index 1de23b4f3809..92d2c706c2a7 100644
> --- a/drivers/i2c/busses/i2c-altera.c
> +++ b/drivers/i2c/busses/i2c-altera.c
> @@ -384,7 +384,6 @@ static int altr_i2c_probe(struct platform_device *pdev)
>   	struct altr_i2c_dev *idev = NULL;
>   	struct resource *res;
>   	int irq, ret;
> -	u32 val;
>   
>   	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
>   	if (!idev)
> @@ -411,17 +410,17 @@ static int altr_i2c_probe(struct platform_device *pdev)
>   	init_completion(&idev->msg_complete);
>   	spin_lock_init(&idev->lock);
>   
> -	val = device_property_read_u32(idev->dev, "fifo-size",
> +	ret = device_property_read_u32(idev->dev, "fifo-size",
>   				       &idev->fifo_size);
> -	if (val) {
> +	if (ret) {
>   		dev_err(&pdev->dev, "FIFO size set to default of %d\n",
>   			ALTR_I2C_DFLT_FIFO_SZ);
>   		idev->fifo_size = ALTR_I2C_DFLT_FIFO_SZ;
>   	}
>   
> -	val = device_property_read_u32(idev->dev, "clock-frequency",
> +	ret = device_property_read_u32(idev->dev, "clock-frequency",
>   				       &idev->bus_clk_rate);
> -	if (val) {
> +	if (ret) {
>   		dev_err(&pdev->dev, "Default to 100kHz\n");
>   		idev->bus_clk_rate = 100000;	/* default clock rate */
>   	}
> 
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
