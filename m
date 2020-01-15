From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH 5/6] i2c: i2c-stm32f7: allow controller to be
 wakeup-source
Date: Wed, 15 Jan 2020 10:13:49 +0100
Message-ID: <803ec9f1-c940-0c95-612d-f1222fc0dcc2@st.com>
References: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
 <1578317314-17197-6-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578317314-17197-6-git-send-email-alain.volmat@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alain Volmat <alain.volmat@st.com>, wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Hi all

Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks and regards

On 1/6/20 2:28 PM, Alain Volmat wrote:
> Allow the i2c-stm32f7 controller to become a wakeup-source
> of the system. In such case, when a slave is registered to the
> I2C controller, receiving a I2C message targeting that registered
> slave address wakes up the suspended system.
> 
> In order to be able to wake-up, the I2C controller DT node
> must have the property wakeup-source defined and a slave
> must be registered.
> 
> Signed-off-by: Alain Volmat <alain.volmat@st.com>
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 98 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 83 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
> index 5c3e8ac6ad92..844a22d64aa8 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -29,6 +29,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_wakeirq.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -49,6 +50,7 @@
>  
>  /* STM32F7 I2C control 1 */
>  #define STM32F7_I2C_CR1_PECEN			BIT(23)
> +#define STM32F7_I2C_CR1_WUPEN			BIT(18)
>  #define STM32F7_I2C_CR1_SBC			BIT(16)
>  #define STM32F7_I2C_CR1_RXDMAEN			BIT(15)
>  #define STM32F7_I2C_CR1_TXDMAEN			BIT(14)
> @@ -301,6 +303,7 @@ struct stm32f7_i2c_msg {
>   * @dma: dma data
>   * @use_dma: boolean to know if dma is used in the current transfer
>   * @regmap: holds SYSCFG phandle for Fast Mode Plus bits
> + * @wakeup_src: boolean to know if the device is a wakeup source
>   */
>  struct stm32f7_i2c_dev {
>  	struct i2c_adapter adap;
> @@ -323,6 +326,7 @@ struct stm32f7_i2c_dev {
>  	struct stm32_i2c_dma *dma;
>  	bool use_dma;
>  	struct regmap *regmap;
> +	bool wakeup_src;
>  };
>  
>  /*
> @@ -1691,6 +1695,9 @@ static int stm32f7_i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  	return ret;
>  }
>  
> +static void stm32f7_i2c_enable_wakeup(struct stm32f7_i2c_dev *i2c_dev,
> +				      bool enable);
> +
>  static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
>  {
>  	struct stm32f7_i2c_dev *i2c_dev = i2c_get_adapdata(slave->adapter);
> @@ -1717,6 +1724,9 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (!stm32f7_i2c_is_slave_registered(i2c_dev))
> +		stm32f7_i2c_enable_wakeup(i2c_dev, true);
> +
>  	if (id == 0) {
>  		/* Configure Own Address 1 */
>  		oar1 = readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR1);
> @@ -1758,6 +1768,9 @@ static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
>  
>  	ret = 0;
>  pm_free:
> +	if (!stm32f7_i2c_is_slave_registered(i2c_dev))
> +		stm32f7_i2c_enable_wakeup(i2c_dev, false);
> +
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
> @@ -1791,8 +1804,10 @@ static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
>  
>  	i2c_dev->slave[id] = NULL;
>  
> -	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
> +	if (!stm32f7_i2c_is_slave_registered(i2c_dev)) {
>  		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
> +		stm32f7_i2c_enable_wakeup(i2c_dev, false);
> +	}
>  
>  	pm_runtime_mark_last_busy(i2c_dev->dev);
>  	pm_runtime_put_autosuspend(i2c_dev->dev);
> @@ -1879,6 +1894,9 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  		return irq_error ? : -ENOENT;
>  	}
>  
> +	i2c_dev->wakeup_src = of_property_read_bool(pdev->dev.of_node,
> +						    "wakeup-source");
> +
>  	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(i2c_dev->clk)) {
>  		dev_err(&pdev->dev, "Error: Missing controller clock\n");
> @@ -1985,6 +2003,16 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  		goto clk_free;
>  	}
>  
> +	if (i2c_dev->wakeup_src) {
> +		device_set_wakeup_capable(i2c_dev->dev, true);
> +
> +		ret = dev_pm_set_wake_irq(i2c_dev->dev, irq_event);
> +		if (ret) {
> +			dev_err(i2c_dev->dev, "Failed to set wake up irq\n");
> +			goto clr_wakeup_capable;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, i2c_dev);
>  
>  	pm_runtime_set_autosuspend_delay(i2c_dev->dev,
> @@ -2014,6 +2042,13 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
>  	pm_runtime_set_suspended(i2c_dev->dev);
>  	pm_runtime_dont_use_autosuspend(i2c_dev->dev);
>  
> +	if (i2c_dev->wakeup_src)
> +		dev_pm_clear_wake_irq(i2c_dev->dev);
> +
> +clr_wakeup_capable:
> +	if (i2c_dev->wakeup_src)
> +		device_set_wakeup_capable(i2c_dev->dev, false);
> +
>  	if (i2c_dev->dma) {
>  		stm32_i2c_dma_free(i2c_dev->dma);
>  		i2c_dev->dma = NULL;
> @@ -2032,6 +2067,15 @@ static int stm32f7_i2c_remove(struct platform_device *pdev)
>  	i2c_del_adapter(&i2c_dev->adap);
>  	pm_runtime_get_sync(i2c_dev->dev);
>  
> +	if (i2c_dev->wakeup_src) {
> +		dev_pm_clear_wake_irq(i2c_dev->dev);
> +		/*
> +		 * enforce that wakeup is disabled and that the device
> +		 * is marked as non wakeup capable
> +		 */
> +		device_init_wakeup(i2c_dev->dev, false);
> +	}
> +
>  	pm_runtime_put_noidle(i2c_dev->dev);
>  	pm_runtime_disable(i2c_dev->dev);
>  	pm_runtime_set_suspended(i2c_dev->dev);
> @@ -2127,20 +2171,41 @@ stm32f7_i2c_regs_restore(struct stm32f7_i2c_dev *i2c_dev)
>  	return ret;
>  }
>  
> +static void stm32f7_i2c_enable_wakeup(struct stm32f7_i2c_dev *i2c_dev,
> +				      bool enable)
> +{
> +	void __iomem *base = i2c_dev->base;
> +	u32 mask = STM32F7_I2C_CR1_WUPEN;
> +
> +	if (!i2c_dev->wakeup_src)
> +		return;
> +
> +	if (enable) {
> +		device_set_wakeup_enable(i2c_dev->dev, true);
> +		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
> +	} else {
> +		device_set_wakeup_enable(i2c_dev->dev, false);
> +		stm32f7_i2c_clr_bits(base + STM32F7_I2C_CR1, mask);
> +	}
> +}
> +
>  static int __maybe_unused stm32f7_i2c_suspend(struct device *dev)
>  {
>  	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  	int ret;
>  
>  	i2c_mark_adapter_suspended(&i2c_dev->adap);
> -	ret = stm32f7_i2c_regs_backup(i2c_dev);
> -	if (ret < 0) {
> -		i2c_mark_adapter_resumed(&i2c_dev->adap);
> -		return ret;
> -	}
>  
> -	pinctrl_pm_select_sleep_state(dev);
> -	pm_runtime_force_suspend(dev);
> +	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
> +		ret = stm32f7_i2c_regs_backup(i2c_dev);
> +		if (ret < 0) {
> +			i2c_mark_adapter_resumed(&i2c_dev->adap);
> +			return ret;
> +		}
> +
> +		pinctrl_pm_select_sleep_state(dev);
> +		pm_runtime_force_suspend(dev);
> +	}
>  
>  	return 0;
>  }
> @@ -2150,14 +2215,17 @@ static int __maybe_unused stm32f7_i2c_resume(struct device *dev)
>  	struct stm32f7_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = pm_runtime_force_resume(dev);
> -	if (ret < 0)
> -		return ret;
> -	pinctrl_pm_select_default_state(dev);
> +	if (!device_may_wakeup(dev) && !dev->power.wakeup_path) {
> +		ret = pm_runtime_force_resume(dev);
> +		if (ret < 0)
> +			return ret;
> +		pinctrl_pm_select_default_state(dev);
> +
> +		ret = stm32f7_i2c_regs_restore(i2c_dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
> -	ret = stm32f7_i2c_regs_restore(i2c_dev);
> -	if (ret < 0)
> -		return ret;
>  	i2c_mark_adapter_resumed(&i2c_dev->adap);
>  
>  	return 0;
> 
