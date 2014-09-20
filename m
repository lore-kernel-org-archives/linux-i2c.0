From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 4/4] gpio: add support for the Diolan DLN-2 USB GPIO driver
Date: Sat, 20 Sep 2014 04:48:47 +0200
Message-ID: <201409200448.48180.arnd@arndb.de>
References: <1411158165-25794-1-git-send-email-octavian.purdila@intel.com> <1411158165-25794-5-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1411158165-25794-5-git-send-email-octavian.purdila@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: gregkh@linuxfoundation.org, linus.walleij@linaro.org, gnurou@gmail.com, wsa@the-dreams.de, sameo@linux.intel.com, lee.jones@linaro.org, johan@kernel.org, daniel.baluta@intel.com, laurentiu.palcu@intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Friday 19 September 2014, Octavian Purdila wrote:
> +struct dln2_gpio_pin {
> +	__le16 pin;
> +} __packed;

This does not need to be marked packed, since it is never embedded in another
structure.

> +struct dln2_gpio_pin_val {
> +	__le16 pin;
> +	u8 value;
> +} __packed;

It's enough here to mark just the 'pin' member as packed.

> +static int dln2_gpio_get_pin_count(struct platform_device *pdev)
> +{
> +	int ret;
> +	__le16 count;
> +	int len = sizeof(count);
> +
> +	ret = dln2_transfer(pdev, DLN2_GPIO_GET_PIN_COUNT, NULL, 0, &count,
> +			    &len);

You must not do a USB transaction on stack memory.

> +static int dln2_gpio_pin_cmd(struct dln2_gpio *dln2, int cmd, unsigned pin)
> +{
> +	struct dln2_gpio_pin req = {
> +		.pin = cpu_to_le16(pin),
> +	};
> +
> +	return dln2_transfer(dln2->pdev, cmd, &req, sizeof(req), NULL, NULL);
> +}

Same here

> +static int dln2_gpio_pin_val(struct dln2_gpio *dln2, int cmd, unsigned int pin)
> +{
> +	int ret;
> +	struct dln2_gpio_pin req = {
> +		.pin = cpu_to_le16(pin),
> +	};
> +	struct dln2_gpio_pin_val rsp;

And here.

> +static int dln2_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
> +				  unsigned debounce)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +	struct {
> +		__le32 duration;
> +	} __packed req = {
> +		.duration = cpu_to_le32(debounce),
> +	};
> +
> +	return dln2_transfer(dln2->pdev, DLN2_GPIO_SET_DEBOUNCE,
> +			     &req, sizeof(req), NULL, NULL);
> +}

Here you also have a strange __packed attribute that makes no sense
for a local variable, in addition to the stack problem.

I think the only correct way to handle these is to add a dynamic
allocation of an entire page for the DMA, which can probably be
part of the dln2_transfer function so you don't have to do it
in each caller.

	Arnd
