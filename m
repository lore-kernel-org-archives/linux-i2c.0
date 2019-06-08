From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/8] pinctrl: msm: Add ability for drivers to supply a
 reserved GPIO list
Date: Fri, 7 Jun 2019 21:06:10 -0700
Message-ID: <20190608040610.GJ24059@builder>
References: <20190605114302.22509-1-lee.jones@linaro.org>
 <20190605114302.22509-3-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190605114302.22509-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed 05 Jun 04:42 PDT 2019, Lee Jones wrote:

> When booting MSM based platforms with Device Tree or some ACPI
> implementations, it is possible to provide a list of reserved pins
> via the 'gpio-reserved-ranges' and 'gpios' properties respectively.
> However some ACPI tables are not populated with this information,
> thus it has to come from a knowledgable device driver instead.
> 
> Here we provide the MSM common driver with additional support to
> parse this informtion and correctly populate the widely used
> 'valid_mask'.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 18 ++++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index ee8119879c4c..3ac740b36508 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -607,8 +607,23 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *chip)
>  	int ret;
>  	unsigned int len, i;
>  	unsigned int max_gpios = pctrl->soc->ngpios;
> +	const int *reserved = pctrl->soc->reserved_gpios;
>  	u16 *tmp;
>  
> +	/* Driver provided reserved list overrides DT and ACPI */
> +	if (reserved) {
> +		bitmap_fill(chip->valid_mask, max_gpios);
> +		for (i = 0; reserved[i] >= 0; i++) {
> +			if (i >= max_gpios || reserved[i] >= max_gpios) {

reserved is a list of GPIOs to reserve, I don't see a reason to check
if that list is longer than the number of GPIOs (i.e. the first half of
the condition).

It wouldn't make sense to be, but there's no logical issue with it and I
had to read the conditional a few extra times to be sure what was going
on.


Apart from that you have my

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> +				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
> +				return -EINVAL;
> +			}
> +			clear_bit(reserved[i], chip->valid_mask);
> +		}
> +
> +		return 0;
> +	}
> +
>  	/* The number of GPIOs in the ACPI tables */
>  	len = ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL,
>  						   0);
> @@ -964,6 +979,9 @@ static void msm_gpio_irq_handler(struct irq_desc *desc)
>  
>  static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>  {
> +	if (pctrl->soc->reserved_gpios)
> +		return true;
> +
>  	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>  }
>  
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index c12048e54a6f..23b93ae92269 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -121,6 +121,7 @@ struct msm_pinctrl_soc_data {
>  	bool pull_no_keeper;
>  	const char *const *tiles;
>  	unsigned int ntiles;
> +	const int *reserved_gpios;
>  };
>  
>  extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> -- 
> 2.17.1
> 
