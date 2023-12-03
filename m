Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619728F8
	for <linux-i2c@vger.kernel.org>; Sun,  3 Dec 2023 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAGTqSdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5874C433C8;
	Sun,  3 Dec 2023 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701607123;
	bh=KJLmOLDiWbHbRIU1hyOCjhwNtBTithDUQc0qUnhefM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AAGTqSddmoKlbybMyrq26jGubAQDYywlmGPYshsq2jY6ZlzOq2NHigE/c4mfgGf9y
	 A/YVWcKNZEpdSWO7ps/+TTsGfcFUK3N3SucyIK9V8bSLziVK00xYx36nJffamlpbtr
	 UJLV00STptEret0Tcs08K6aZDGY//1NYng2MmGGg3YSqnXz5StOvM3yboUvPh7MjPm
	 LENuj7QGU7JgqRZjlDDeD8PYBnQyDHCh2VwMuDXUZq6LyxRGuGEIjmEgydvPCSQd0P
	 cq6etxKZddcASX716yPrAxAdD+3OexNd+zgJrKE9QLVvXaFUcz0cUDTWxcX+rXRUf6
	 s7Wrs3tzAn30g==
Date: Sun, 3 Dec 2023 13:38:39 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Haoran Liu <liuhaoran14@163.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [i2c] robotfuzz-osif: Add error handling for
 i2c_add_adapter in osif_probe
Message-ID: <20231203123839.nu2jcqk3dp2jvgru@zenone.zhora.eu>
References: <20231203053142.37453-1-liuhaoran14@163.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203053142.37453-1-liuhaoran14@163.com>

Hi Haoran,

I made some comments on your 3rd patch. Could you please combine
these three patches into a single series?

Also, please remove the [i2c] tag from the subject.

Thanks,
Andi

On Sat, Dec 02, 2023 at 09:31:42PM -0800, Haoran Liu wrote:
> This patch introduces error handling for the i2c_add_adapter. This missing
> error handling was identified through static analysis, revealing that the
> function did not properly address potential failures of i2c_add_adapter.
> Previously, such a failure could result in incomplete initialization of
> the I2C adapter, leading to erratic behavior.
> 
> Although the error addressed by this patch may not occur in the current
> environment, I still suggest implementing these error handling routines
> if the function is not highly time-sensitive. As the environment evolves
> or the code gets reused in different contexts, there's a possibility that
> these errors might occur. In case you find this addition unnecessary, I
> completely understand and respect your perspective. My intention was to
> enhance the robustness of the code, but I acknowledge that practical
> considerations and current functionality might not warrant this change
> at this point.
> 
> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/i2c/busses/i2c-robotfuzz-osif.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> index 66dfa211e736..0f4d84449050 100644
> --- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
> +++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> @@ -161,7 +161,12 @@ static int osif_probe(struct usb_interface *interface,
>  		return ret;
>  	}
>  
> -	i2c_add_adapter(&(priv->adapter));
> +	ret = i2c_add_adapter(&(priv->adapter));
> +	if (ret) {
> +		dev_err(&interface->dev, "i2c_add_adapter failed: %d\n", ret);
> +		usb_put_dev(priv->usb_dev);
> +		return ret;
> +	}
>  
>  	version = le16_to_cpu(priv->usb_dev->descriptor.bcdDevice);
>  	dev_info(&interface->dev,
> -- 
> 2.17.1
> 
