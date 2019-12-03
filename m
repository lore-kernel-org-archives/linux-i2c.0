From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 3/3] i2c: at91: remote default value initialization
Date: Tue, 3 Dec 2019 08:13:32 +0100
Message-ID: <20191203071332.zwpmeb65g7e7ckmj@M43218.corp.atmel.com>
References: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
 <1575276957-5615-3-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575276957-5615-3-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@axentia.se" <peda@axentia.se>, Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>, Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 02, 2019 at 09:56:41AM +0100, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Platform data structs are initialized by default with zero values.
> Thus it becomes redundant to initialize them manually to zero (false).
> Remove extra false initialization for field members in structs.
> 
> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Honestly, I prefer an explicit description than saving lines of code, in
a glance you have all the details, don't need to go back to the
structure definition.

As it's a personal belief, I won't argue about it.
Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/i2c/busses/i2c-at91-core.c | 39 --------------------------------------
>  1 file changed, 39 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
> index 5137e62..3da1a8a 100644
> --- a/drivers/i2c/busses/i2c-at91-core.c
> +++ b/drivers/i2c/busses/i2c-at91-core.c
> @@ -66,55 +66,26 @@ static struct at91_twi_pdata at91rm9200_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 3,
>  	.has_unre_flag = true,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9261_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9260_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g20_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g10_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static const struct platform_device_id at91_twi_devtypes[] = {
> @@ -142,23 +113,13 @@ static const struct platform_device_id at91_twi_devtypes[] = {
>  static struct at91_twi_pdata at91sam9x5_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
> -	.has_hold_field = false,
> -	.has_dig_filtr = false,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata sama5d4_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> -	.has_unre_flag = false,
> -	.has_alt_cmd = false,
>  	.has_hold_field = true,
>  	.has_dig_filtr = true,
> -	.has_adv_dig_filtr = false,
> -	.has_ana_filtr = false,
>  };
>  
>  static struct at91_twi_pdata sama5d2_config = {
> -- 
> 2.7.4
> 
