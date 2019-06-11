From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 2/8] i2c: i2c-qcom-geni: Signify successful driver
 probe
Date: Tue, 11 Jun 2019 12:40:48 -0700
Message-ID: <20190611194048.GR4814@minitux>
References: <20190610084213.1052-1-lee.jones@linaro.org>
 <20190610084213.1052-2-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190610084213.1052-2-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alokc@codeaurora.org, andy.gross@linaro.org, david.brown@linaro.org, wsa+renesas@sang-engineering.com, linus.walleij@linaro.org, balbi@kernel.org, gregkh@linuxfoundation.org, ard.biesheuvel@linaro.org, jlhugo@gmail.com, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon 10 Jun 01:42 PDT 2019, Lee Jones wrote:

> The Qualcomm Geni I2C driver currently probes silently which can be
> confusing when debugging potential issues.  Add a low level (INFO)
> print when each I2C controller is successfully initially set-up.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 9e3b8a98688d..a89bfce5388e 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -596,6 +596,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
