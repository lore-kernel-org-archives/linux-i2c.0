From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 4/4] gpio: add support for the Diolan DLN-2 USB GPIO
 driver
Date: Wed, 5 Nov 2014 16:45:17 +0100
Message-ID: <20141105154517.GT31358@localhost>
References: <1414427472-4100-1-git-send-email-octavian.purdila@intel.com>
 <1414427472-4100-5-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414427472-4100-5-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 27, 2014 at 06:31:12PM +0200, Octavian Purdila wrote:
> From: Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> This patch adds GPIO and IRQ support for the Diolan DLN-2 GPIO module.

[...]

> +static void dln2_gpio_pin_set_out_val(struct dln2_gpio *dln2,
> +				      unsigned int pin, int value)
> +{
> +	struct dln2_gpio_pin_val req = {
> +		.pin = cpu_to_le16(pin),
> +		.value = cpu_to_le16(value),

Drop cpu_to_le16 (value is u8).

> +	};
> +
> +	dln2_transfer_tx(dln2->pdev, DLN2_GPIO_PIN_SET_OUT_VAL, &req,
> +			 sizeof(req));
> +}
> +
> +#define DLN2_GPIO_DIRECTION_IN		0
> +#define DLN2_GPIO_DIRECTION_OUT		1
> +
> +static int dln2_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +	struct dln2_gpio_pin req = {
> +		.pin = cpu_to_le16(offset),
> +	};
> +	struct dln2_gpio_pin_val rsp;
> +	int len = sizeof(rsp);
> +	int ret;
> +
> +	ret = dln2_gpio_pin_cmd(dln2, DLN2_GPIO_PIN_ENABLE, offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* cache the pin direction */
> +	ret = dln2_transfer(dln2->pdev, DLN2_GPIO_PIN_GET_DIRECTION,
> +			    &req, sizeof(req), &rsp, &len);
> +	if (ret < 0)
> +		return ret;
> +	if (len < sizeof(rsp) || req.pin != rsp.pin) {
> +		ret = -EPROTO;
> +		goto out_disable;
> +	}
> +
> +	switch (rsp.value) {
> +	case DLN2_GPIO_DIRECTION_IN:
> +		clear_bit(offset, dln2->output_enabled);
> +		return 0;
> +	case DLN2_GPIO_DIRECTION_OUT:
> +		set_bit(offset, dln2->output_enabled);
> +		return 0;
> +	default:
> +		ret = -EPROTO;
> +		goto out_disable;
> +	}
> +
> +out_disable:
> +	dln2_gpio_pin_cmd(dln2, DLN2_GPIO_PIN_DISABLE, offset);
> +	return ret;
> +}
> +
> +static void dln2_gpio_free(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +
> +	dln2_gpio_pin_cmd(dln2, DLN2_GPIO_PIN_DISABLE, offset);
> +}
> +
> +static int dln2_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +
> +	if (test_bit(offset, dln2->output_enabled))
> +		return GPIOF_DIR_OUT;
> +
> +	return GPIOF_DIR_IN;
> +}
> +
> +static int dln2_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +	int dir;
> +
> +	dir = dln2_gpio_get_direction(chip, offset);
> +	if (dir < 0)
> +		return dir;
> +
> +	if (dir == GPIOF_DIR_IN)
> +		return dln2_gpio_pin_get_in_val(dln2, offset);
> +
> +	return dln2_gpio_pin_get_out_val(dln2, offset);
> +}
> +
> +static void dln2_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +
> +	dln2_gpio_pin_set_out_val(dln2, offset, value);
> +}
> +
> +static int dln2_gpio_set_direction(struct gpio_chip *chip, unsigned offset,
> +				   unsigned dir)
> +{
> +	struct dln2_gpio *dln2 = container_of(chip, struct dln2_gpio, gpio);
> +	struct dln2_gpio_pin_val req = {
> +		.pin = cpu_to_le16(offset),
> +		.value = cpu_to_le16(dir),

Same here.

Johan
