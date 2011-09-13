From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 1/2] i2c: s3c2410: Keep a copy of platform data and
 use it
Date: Tue, 13 Sep 2011 00:01:17 -0700
Message-ID: <4E6EFFBD.6050609@codeaurora.org>
References: <1315887365-30532-1-git-send-email-thomas.abraham@linaro.org> <1315887365-30532-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315887365-30532-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 9/12/2011 9:16 PM, Thomas Abraham wrote:
> @@ -809,6 +810,15 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	i2c->pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!i2c->pdata) {
> +		ret = -ENOMEM;
> +		goto err_noclk;
> +	}
> +
> +	if (pdata)
> +		memcpy(i2c->pdata, pdata, sizeof(*pdata));
> +

Is there a devm_kmemdup()? If not, maybe it would be a good idea to add it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
