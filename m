From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [RFC PATCH 2/2] i2c: at91: provide bus_freq_hz
Date: Wed, 4 Apr 2018 17:34:12 +0200
Message-ID: <20180404153412.GL2574@rfolt0960.corp.atmel.com>
References: <20180326111927.16040-1-tudor.ambarus@microchip.com>
 <20180326111927.16040-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180326111927.16040-2-tudor.ambarus@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: alexandre.belloni@bootlin.com, wsa@the-dreams.de, ludovic.desroches@microchip.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 26, 2018 at 02:19:27PM +0300, Tudor Ambarus wrote:
> The clock-frequency property is not mandatory for the i2c buses. If it's
> not present in device tree, the buses usually assume that is 100kHZ.
> There are i2c clients that need to know the clock frequency in order to
> compute their wake token. Spare the clients of making (wrong) assumptions
> and provide the bus frequency in adapter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/i2c/busses/i2c-at91.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdf..d3cd84e 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1116,6 +1116,7 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	dev->adapter.quirks = &at91_twi_quirks;
>  	dev->adapter.dev.parent = dev->dev;
>  	dev->adapter.nr = pdev->id;
> +	dev->adapter.bus_freq_hz = bus_clk_rate;
>  	dev->adapter.timeout = AT91_I2C_TIMEOUT;
>  	dev->adapter.dev.of_node = pdev->dev.of_node;
>  
> -- 
> 2.9.4
> 
