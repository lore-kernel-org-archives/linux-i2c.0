From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3] i2c:at91: Add device tree property to set
 clock-frequency
Date: Tue, 11 Mar 2014 18:51:54 +0800
Message-ID: <C7EB5260-2285-4572-9D73-15312BB09F65@jcrosoft.com>
References: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394511938-28653-1-git-send-email-mark.roszko@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Roszko <mark.roszko@gmail.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-i2c@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org> mailing list" <linux-arm-kernel@lists.infradead.org>, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org


On Mar 11, 2014, at 12:25 PM, Marek Roszko <mark.roszko@gmail.com> wrote:

> This adds the ability to set "clock-frequency" in the device tree for the=
 at91
> i2cbus following the naming of other i2c bus implementations. If the prop=
erty
> is not set,the clock frequency will default to the previously used define =

> of 100KHz.
> =

> Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
> ---
> v3:		=

> 		-changed bus_clk_rate to u32
> v2:
>        -fixed return code usage and check to not compare agaisnt less tha=
n zero
> =

> ---
> Documentation/devicetree/bindings/i2c/i2c-at91.txt |    2 ++
> drivers/i2c/busses/i2c-at91.c                      |   10 ++++++++--
> 2 files changed, 10 insertions(+), 2 deletions(-)
> =

> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documen=
tation/devicetree/bindings/i2c/i2c-at91.txt
> index 4fade84..388f0a2 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -12,6 +12,7 @@ Required properties :
> - clocks: phandles to input clocks.
> =

> Optional properties:
> +- clock-frequency: Desired I2C bus frequency in Hz, otherwise defaults t=
o 100000
> - Child nodes conforming to i2c bus binding
> =

> Examples :
> @@ -23,6 +24,7 @@ i2c0: i2c@fff84000 {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
> 	clocks =3D <&twi0_clk>;
> +	clock-frequency =3D <400000>;
> =

The bindings is wrong it=92s not the bus frequency but the max frequency

as you describe the bus not the device frequency. And this is this one that=
 limit the bus

Best Regards,
J.
> 	24c512@50 {
> 		compatible =3D "24c512";
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 843d012..334c851 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -32,7 +32,7 @@
> #include <linux/slab.h>
> #include <linux/platform_data/dma-atmel.h>
> =

> -#define TWI_CLK_HZ		100000			/* max 400 Kbits/s */
> +#define DEFAULT_TWI_CLK_HZ		100000		/* max 400 Kbits/s */
> #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
> #define AT91_I2C_DMA_THRESHOLD	8			/* enable DMA if transfer size is bigg=
er than this threshold */
> =

> @@ -711,6 +711,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
> 	struct resource *mem;
> 	int rc;
> 	u32 phy_addr;
> +	u32 bus_clk_rate;
> =

> 	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> 	if (!dev)
> @@ -756,7 +757,12 @@ static int at91_twi_probe(struct platform_device *pd=
ev)
> 			dev->use_dma =3D true;
> 	}
> =

> -	at91_calc_twi_clock(dev, TWI_CLK_HZ);
> +	rc =3D of_property_read_u32(dev->dev->of_node, "clock-frequency",
> +			&bus_clk_rate);
> +	if (rc)
> +		bus_clk_rate =3D DEFAULT_TWI_CLK_HZ;
> +
> +	at91_calc_twi_clock(dev, bus_clk_rate);
> 	at91_init_twi_bus(dev);
> =

> 	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
> -- =

> 1.7.10.4
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
