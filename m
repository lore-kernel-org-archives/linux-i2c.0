From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH RFC 4/4] i2c: at91: take slave mode capabilities of
 hardware into account
Date: Tue, 31 Oct 2017 16:22:50 +0100
Message-ID: <20171031152250.4oasjhfpya5rmzyv@rfolt0960.corp.atmel.com>
References: <cover.1509112910.git.me@jue.yt>
 <1e3e7e50e25afd3ebe14daf89d1f194c45ca6cbb.1509112910.git.me@jue.yt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9280 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdJaPW5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Oct 2017 11:22:57 -0400
Content-Disposition: inline
In-Reply-To: <1e3e7e50e25afd3ebe14daf89d1f194c45ca6cbb.1509112910.git.me@jue.yt>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 27, 2017 at 05:12:17PM +0200, Juergen Fitschen wrote:
> Some AT91 hardware has no slave mode included or only limited features
> (i.e. no fifos).
> 

I am wondering if it won't be better to squash this patch into the
previous one:
Without it, it seems that we can set slave_detected for the RM9200 even
if it doesn't support the slave mode.

> Signed-off-by: Juergen Fitschen <me@jue.yt>
> ---
>  drivers/i2c/busses/i2c-at91-core.c | 14 ++++++++++++--
>  drivers/i2c/busses/i2c-at91.h      |  5 +++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
> index 3d7287c..9bf1e9d 100644
> --- a/drivers/i2c/busses/i2c-at91-core.c
> +++ b/drivers/i2c/busses/i2c-at91-core.c
> @@ -69,6 +69,7 @@ void at91_init_twi_bus(struct at91_twi_dev *dev)
>  static struct at91_twi_pdata at91rm9200_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 3,
> +	.slave_mode_features = 0,
>  	.has_unre_flag = true,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -77,6 +78,7 @@ static struct at91_twi_pdata at91rm9200_config = {
>  static struct at91_twi_pdata at91sam9261_config = {
>  	.clk_max_div = 5,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -85,6 +87,7 @@ static struct at91_twi_pdata at91sam9261_config = {
>  static struct at91_twi_pdata at91sam9260_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -93,6 +96,7 @@ static struct at91_twi_pdata at91sam9260_config = {
>  static struct at91_twi_pdata at91sam9g20_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -101,6 +105,7 @@ static struct at91_twi_pdata at91sam9g20_config = {
>  static struct at91_twi_pdata at91sam9g10_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -131,6 +136,7 @@ static const struct platform_device_id at91_twi_devtypes[] = {
>  static struct at91_twi_pdata at91sam9x5_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> @@ -139,6 +145,7 @@ static struct at91_twi_pdata at91sam9x5_config = {
>  static struct at91_twi_pdata sama5d4_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE,
>  	.has_unre_flag = false,
>  	.has_alt_cmd = false,
>  	.has_hold_field = true,
> @@ -147,6 +154,7 @@ static struct at91_twi_pdata sama5d4_config = {
>  static struct at91_twi_pdata sama5d2_config = {
>  	.clk_max_div = 7,
>  	.clk_offset = 4,
> +	.slave_mode_features = AT91_TWI_SM_AVAILABLE | AT91_TWI_SM_HAS_FIFO | AT91_TWI_SM_CAN_NACK,
>  	.has_unre_flag = true,
>  	.has_alt_cmd = true,
>  	.has_hold_field = true,
> @@ -219,6 +227,10 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	if (!dev->pdata)
>  		return -ENODEV;
>  
> +	dev->slave_detected = i2c_detect_slave_mode(&pdev->dev);
> +	if (dev->slave_detected && dev->pdata->slave_mode_features == 0)
> +		return -EPFNOSUPPORT;
> +
>  	dev->base = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(dev->base))
>  		return PTR_ERR(dev->base);
> @@ -245,8 +257,6 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	dev->adapter.timeout = AT91_I2C_TIMEOUT;
>  	dev->adapter.dev.of_node = pdev->dev.of_node;
>  
> -	dev->slave_detected = i2c_detect_slave_mode(&pdev->dev);
> -
>  	if (dev->slave_detected)
>  		rc = at91_twi_probe_slave(pdev, phy_addr, dev);
>  	else
> diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> index bb502c1..4a4fa67 100644
> --- a/drivers/i2c/busses/i2c-at91.h
> +++ b/drivers/i2c/busses/i2c-at91.h
> @@ -107,9 +107,14 @@
>  
>  #define	AT91_TWI_VER		0x00fc	/* Version Register */
>  
> +#define	AT91_TWI_SM_AVAILABLE	BIT(0)	/* Slave mode supported */
> +#define	AT91_TWI_SM_CAN_NACK	BIT(1)	/* Can send NACKs in slave mode */
> +#define	AT91_TWI_SM_HAS_FIFO	BIT(2)	/* Has FIFO for slave mode */
> +

I would not add AT91_TWI_SM_CAN_NACK, AT91_TWI_SM_HAS_FIFO since there
is no code relying on them. Maybe you have some plans for the future?

>  struct at91_twi_pdata {
>  	unsigned clk_max_div;
>  	unsigned clk_offset;
> +	unsigned slave_mode_features;
>  	bool has_unre_flag;
>  	bool has_alt_cmd;
>  	bool has_hold_field;
> -- 
> 2.7.4
> 
