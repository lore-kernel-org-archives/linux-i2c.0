From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v2 2/6] i2c: at91: implement i2c bus recovery
Date: Thu, 9 Jan 2020 08:48:19 +0100
Message-ID: <20200109074819.rhlaxg3sgwlng5xm@M43218.corp.atmel.com>
References: <20200103094821.13185-1-codrin.ciubotariu@microchip.com>
 <20200103094821.13185-3-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200103094821.13185-3-codrin.ciubotariu@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "kamel.bouhara@bootlin.com" <kamel.bouhara@bootlin.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 03, 2020 at 09:49:07AM +0000, Codrin Ciubotariu - M19940 wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Implement i2c bus recovery when slaves devices might hold SDA low.
> In this case re-assign SCL/SDA to gpios and issue 9 dummy clock pulses
> until the slave release SDA.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> [codrin.ciubotariu@microchip.com: release gpios on error; move i2c_recover_bus]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2:
>  - called i2c_recover_bus() after an error occurs, if SDA is down;
>  - release gpios if recovery information is incomplete;
> 
>  drivers/i2c/busses/i2c-at91-master.c | 79 ++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-at91.h        |  8 +++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
> index 7a862e00b475..c55e8ff35201 100644
> --- a/drivers/i2c/busses/i2c-at91-master.c
> +++ b/drivers/i2c/busses/i2c-at91-master.c
> @@ -18,11 +18,13 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dma-atmel.h>
>  #include <linux/pm_runtime.h>
> @@ -478,6 +480,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  	unsigned long time_left;
>  	bool has_unre_flag = dev->pdata->has_unre_flag;
>  	bool has_alt_cmd = dev->pdata->has_alt_cmd;
> +	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
>  
>  	/*
>  	 * WARNING: the TXCOMP bit in the Status Register is NOT a clear on
> @@ -637,6 +640,13 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
>  		at91_twi_write(dev, AT91_TWI_CR,
>  			       AT91_TWI_THRCLR | AT91_TWI_LOCKCLR);
>  	}
> +
> +	if (rinfo->get_sda && !(rinfo->get_sda(&dev->adapter))) {
> +		dev_dbg(dev->dev,
> +			"SDA is down; clear bus using gpio\n");
> +		i2c_recover_bus(&dev->adapter);
> +	}
> +
>  	return ret;
>  }
>  
> @@ -806,6 +816,71 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
>  	return ret;
>  }
>  
> +static void at91_prepare_twi_recovery(struct i2c_adapter *adap)
> +{
> +	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
> +
> +	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_gpio);
> +}
> +
> +static void at91_unprepare_twi_recovery(struct i2c_adapter *adap)
> +{
> +	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
> +
> +	pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
> +}
> +
> +static int at91_init_twi_recovery_info(struct platform_device *pdev,
> +				       struct at91_twi_dev *dev)
> +{
> +	struct i2c_bus_recovery_info *rinfo = &dev->rinfo;
> +
> +	dev->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!dev->pinctrl || IS_ERR(dev->pinctrl)) {
> +		dev_info(dev->dev, "can't get pinctrl, bus recovery not supported\n");
> +		return PTR_ERR(dev->pinctrl);
> +	}
> +
> +	dev->pinctrl_pins_default = pinctrl_lookup_state(dev->pinctrl,
> +							 PINCTRL_STATE_DEFAULT);
> +	dev->pinctrl_pins_gpio = pinctrl_lookup_state(dev->pinctrl,
> +						      "gpio");
> +	rinfo->sda_gpiod = devm_gpiod_get(&pdev->dev, "sda", GPIOD_IN);
> +	if (PTR_ERR(rinfo->sda_gpiod) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	rinfo->scl_gpiod = devm_gpiod_get(&pdev->dev, "scl",
> +					  GPIOD_OUT_HIGH_OPEN_DRAIN);
> +	if (PTR_ERR(rinfo->scl_gpiod) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	if (IS_ERR(rinfo->sda_gpiod) ||
> +	    IS_ERR(rinfo->scl_gpiod) ||
> +	    IS_ERR(dev->pinctrl_pins_default) ||
> +	    IS_ERR(dev->pinctrl_pins_gpio)) {
> +		dev_info(&pdev->dev, "recovery information incomplete\n");
> +		if (!IS_ERR(rinfo->sda_gpiod)) {
> +			gpiod_put(rinfo->sda_gpiod);
> +			rinfo->sda_gpiod = NULL;
> +		}
> +		if (!IS_ERR(rinfo->scl_gpiod)) {
> +			gpiod_put(rinfo->scl_gpiod);
> +			rinfo->scl_gpiod = NULL;
> +		}
> +		return -EINVAL;
> +	}
> +
> +	dev_info(&pdev->dev, "using scl%s for recovery\n",
> +		 rinfo->sda_gpiod ? ",sda" : "");

Is it possible to have scl without sda? From the condition before, if
there is an error for sda or scl, an error is returned.

> +
> +	rinfo->prepare_recovery = at91_prepare_twi_recovery;
> +	rinfo->unprepare_recovery = at91_unprepare_twi_recovery;
> +	rinfo->recover_bus = i2c_generic_scl_recovery;
> +	dev->adapter.bus_recovery_info = rinfo;
> +
> +	return 0;
> +}
> +
>  int at91_twi_probe_master(struct platform_device *pdev,
>  			  u32 phy_addr, struct at91_twi_dev *dev)
>  {
> @@ -838,6 +913,10 @@ int at91_twi_probe_master(struct platform_device *pdev,
>  						     "i2c-analog-filter");
>  	at91_calc_twi_clock(dev);
>  
> +	rc = at91_init_twi_recovery_info(pdev, dev);
> +	if (rc == -EPROBE_DEFER)
> +		return rc;
> +
>  	dev->adapter.algo = &at91_twi_algorithm;
>  	dev->adapter.quirks = &at91_twi_quirks;
>  
> diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> index 977a67bc0f88..eb335b71e775 100644
> --- a/drivers/i2c/busses/i2c-at91.h
> +++ b/drivers/i2c/busses/i2c-at91.h
> @@ -151,6 +151,10 @@ struct at91_twi_dev {
>  	u32 fifo_size;
>  	struct at91_twi_dma dma;
>  	bool slave_detected;
> +	struct i2c_bus_recovery_info rinfo;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_pins_default;
> +	struct pinctrl_state *pinctrl_pins_gpio;
>  #ifdef CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL
>  	unsigned smr;
>  	struct i2c_client *slave;
> @@ -171,6 +175,10 @@ void at91_init_twi_bus_master(struct at91_twi_dev *dev);
>  int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
>  			  struct at91_twi_dev *dev);
>  

Wrong names here:

> +void at91_twi_prepare_recovery(struct i2c_adapter *adap);
at91_prepare_twi_recovery

> +void at91_twi_unprepare_recovery(struct i2c_adapter *adap);
at91_unprepare_twi_recovery

> +void at91_twi_init_recovery_info(struct at91_twi_dev *dev);
at91_init_twi_recovery_info

Are these declarations still needed?

Ludovic

> +
>  #ifdef CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL
>  void at91_init_twi_bus_slave(struct at91_twi_dev *dev);
>  int at91_twi_probe_slave(struct platform_device *pdev, u32 phy_addr,
> -- 
> 2.20.1
