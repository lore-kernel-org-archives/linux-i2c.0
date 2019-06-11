From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 7/8] usb: dwc3: qcom: Start USB in 'host mode' on the
 SDM845
Date: Tue, 11 Jun 2019 15:33:49 -0700
Message-ID: <20190611223349.GS4814@minitux>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-7-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610084213.1052-7-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon 10 Jun 01:42 PDT 2019, Lee Jones wrote:

> When booting with Device Tree, the current default boot configuration
> table option, the request to boot via 'host mode' comes from the
> 'dr_mode' property.

As I said in my previous review, the default mode for SDM845 is OTG. For
the MTP specifically we specify the default mode to be peripheral (was
host).


The remaining thing that worries me with this patch is that I do expect
that at least one of the USB-C ports is OTG. But I am not able to
conclude anything regarding this and host-only is a good default for
this type of device, so I suggest that we merge this.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> A property of the same name can be used inside
> ACPI tables too.  However it is missing from the SDM845's ACPI tables
> so we have to supply this information using Platform Device Properties
> instead.
> 
> This does not change the behaviour of any currently supported devices.
> The property is only set on ACPI enabled platforms, thus for H/W
> booting DT, unless a 'dr_mode' property is present, the default is
> still OTG (On-The-Go) as per [0].  Any new ACPI devices added will
> also be able to over-ride this implementation by providing a 'dr_mode'
> property in their ACPI tables.  In cases where 'dr_mode' is omitted
> from the tables AND 'host mode' should not be the default (very
> unlikely), then we will have to add some way of choosing between them
> at run time - most likely by ACPI HID.
> 
> [0] Documentation/devicetree/bindings/usb/generic.txt
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 1e1f12b7991d..55ba04254e38 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -444,6 +444,11 @@ static int dwc3_qcom_clk_init(struct dwc3_qcom *qcom, int count)
>  	return 0;
>  }
>  
> +static const struct property_entry dwc3_qcom_acpi_properties[] = {
> +	PROPERTY_ENTRY_STRING("dr_mode", "host"),
> +	{}
> +};
> +
>  static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>  {
>  	struct dwc3_qcom 	*qcom = platform_get_drvdata(pdev);
> @@ -488,6 +493,13 @@ static int dwc3_qcom_acpi_register_core(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> +	ret = platform_device_add_properties(qcom->dwc3,
> +					     dwc3_qcom_acpi_properties);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to add properties\n");
> +		goto out;
> +	}
> +
>  	ret = platform_device_add(qcom->dwc3);
>  	if (ret)
>  		dev_err(&pdev->dev, "failed to add device\n");
> -- 
> 2.17.1
> 
