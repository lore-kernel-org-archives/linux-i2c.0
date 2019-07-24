From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/1] extcon: extcon-max77843: convert to
 i2c_new_dummy_device
Date: Wed, 24 Jul 2019 19:04:27 +0900
Message-ID: <6bff5707-c460-c7e8-d913-bbc4d8fd5447@samsung.com>
References: <20190722172601.3506-1-wsa+renesas@sang-engineering.com>
        <CGME20190722172604epcas5p4ce41ff3eda1b28ae07eef332808780ac@epcas5p4.samsung.com>
        <20190722172601.3506-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722172601.3506-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 19. 7. 23. 오전 2:26, Wolfram Sang wrote:
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/extcon/extcon-max77843.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
> index a343a6ef3506..e6b50ca83008 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -774,12 +774,12 @@ static int max77843_init_muic_regmap(struct max77693_dev *max77843)
>  {
>  	int ret;
>  
> -	max77843->i2c_muic = i2c_new_dummy(max77843->i2c->adapter,
> +	max77843->i2c_muic = i2c_new_dummy_device(max77843->i2c->adapter,
>  			I2C_ADDR_MUIC);
> -	if (!max77843->i2c_muic) {
> +	if (IS_ERR(max77843->i2c_muic)) {
>  		dev_err(&max77843->i2c->dev,
>  				"Cannot allocate I2C device for MUIC\n");
> -		return -ENOMEM;
> +		return PTR_ERR(max77843->i2c_muic);
>  	}
>  
>  	i2c_set_clientdata(max77843->i2c_muic, max77843);
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
