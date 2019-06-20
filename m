From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 3/5] i2c: at91: add support for digital filtering
Date: Thu, 20 Jun 2019 10:27:36 +0200
Message-ID: <20190620082736.GS23549@piout.net>
References: <1561014676-22446-1-git-send-email-eugen.hristev@microchip.com>
 <1561014676-22446-3-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561014676-22446-3-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen.Hristev@microchip.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 20/06/2019 07:16:13+0000, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Add new platform data support for digital filtering for i2c.
> The sama5d4, sama5d2 and sam9x60 support this feature.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/i2c/busses/i2c-at91-core.c   | 9 +++++++++
>  drivers/i2c/busses/i2c-at91-master.c | 6 ++++++
>  drivers/i2c/busses/i2c-at91.h        | 4 ++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
> index a663a7a..62610af 100644
> --- a/drivers/i2c/busses/i2c-at91-core.c
> +++ b/drivers/i2c/busses/i2c-at91-core.c
> @@ -68,6 +68,7 @@ static struct at91_twi_pdata at91rm9200_config = {
>  	.has_unre_flag = true,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,

As false is the default value, may we should avoid setting it
explicitly to keep the file size manageable.

>  };
>  
>  static struct at91_twi_pdata at91sam9261_config = {
> @@ -76,6 +77,7 @@ static struct at91_twi_pdata at91sam9261_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9260_config = {
> @@ -84,6 +86,7 @@ static struct at91_twi_pdata at91sam9260_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g20_config = {
> @@ -92,6 +95,7 @@ static struct at91_twi_pdata at91sam9g20_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,
>  };
>  
>  static struct at91_twi_pdata at91sam9g10_config = {
> @@ -100,6 +104,7 @@ static struct at91_twi_pdata at91sam9g10_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,
>  };
>  
>  static const struct platform_device_id at91_twi_devtypes[] = {
> @@ -130,6 +135,7 @@ static struct at91_twi_pdata at91sam9x5_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,
>  };
>  
>  static struct at91_twi_pdata sama5d4_config = {
> @@ -138,6 +144,7 @@ static struct at91_twi_pdata sama5d4_config = {
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = true,
> +	.has_dig_filtr = true,
>  };
>  
>  static struct at91_twi_pdata sama5d2_config = {
> @@ -146,6 +153,7 @@ static struct at91_twi_pdata sama5d2_config = {
>  	.has_unre_flag = true,
>  	.has_alt_cmd = true,
>  	.has_hold_field = true,
> +	.has_dig_filtr = true,
>  };
>  
>  static struct at91_twi_pdata sam9x60_config = {
> @@ -154,6 +162,7 @@ static struct at91_twi_pdata sam9x60_config = {
>  	.has_unre_flag = true,
>  	.has_alt_cmd = true,
>  	.has_hold_field = true,
> +	.has_dig_filtr = true,
>  };
>  
>  static const struct of_device_id atmel_twi_dt_ids[] = {
> diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
> index e87232f..366e90f 100644
> --- a/drivers/i2c/busses/i2c-at91-master.c
> +++ b/drivers/i2c/busses/i2c-at91-master.c
> @@ -31,12 +31,18 @@
>  
>  void at91_init_twi_bus_master(struct at91_twi_dev *dev)
>  {
> +	struct at91_twi_pdata *pdata = dev->pdata;
> +
>  	/* FIFO should be enabled immediately after the software reset */
>  	if (dev->fifo_size)
>  		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
>  	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_MSEN);
>  	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SVDIS);
>  	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
> +
> +	/* enable digital filter */
> +	if (pdata->has_dig_filtr)
> +		at91_twi_write(dev, AT91_TWI_FILTR, AT91_TWI_FILTR_FILT);

You are enabling all those filtering features by default which mean that
if we ever need to handle them using DT, the property will be a
disabling one instead of a more logical enabling one.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
