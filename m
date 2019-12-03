From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 2/3] i2c: at91: fix clk_offset for sam9x60
Date: Tue, 3 Dec 2019 08:01:21 +0100
Message-ID: <20191203070121.ebba7qc7mvo6jcgy@M43218.corp.atmel.com>
References: <1575276957-5615-2-git-send-email-eugen.hristev@microchip.com>
 <1575277244-6507-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575277244-6507-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@axentia.se" <peda@axentia.se>, Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>, Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 02, 2019 at 10:01:17AM +0100, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> In SAM9X60 datasheet, FLEX_TWI_CWGR register rescription mentions clock

typo here: description

> offset of 3 cycles (compared to 4 in eg. SAMA5D3).
> This is the same offset as in SAMA5D2.
> 
> Fixes: b00277923743 ("i2c: at91: add new platform support for sam9x60")
> Suggested-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
> 
> Sorry, wrong subject line. Modified to SAM9X60 .
> 
> 
>  drivers/i2c/busses/i2c-at91-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
> index e13af48..5137e62 100644
> --- a/drivers/i2c/busses/i2c-at91-core.c
> +++ b/drivers/i2c/busses/i2c-at91-core.c
> @@ -174,7 +174,7 @@ static struct at91_twi_pdata sama5d2_config = {
>  
>  static struct at91_twi_pdata sam9x60_config = {
>  	.clk_max_div = 7,
> -	.clk_offset = 4,
> +	.clk_offset = 3,
>  	.has_unre_flag = true,
>  	.has_alt_cmd = true,
>  	.has_hold_field = true,
> -- 
> 2.7.4
> 
