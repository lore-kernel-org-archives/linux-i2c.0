Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3336F908;
	Fri, 31 Jul 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531352; cv=none; b=ryirQRy2eAN3CR4e7tMCHS0I56ciVjdTCRRS67SAwEwqe3LONMil5Ao7ODy584W5VUVTKBUJpSzbB81zCovR/KCWxXC4rZDYVKRvqeq/GDv+O+8MXIUQuflWkUB+9vwCJN6y6UIeCBYlV+ME/a8lKxNNL9r86Ij/SelsiFrOJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531352; c=relaxed/simple;
	bh=JPiIeiTz3nwyM+F4cNVC7VavGCYC+ZVrDsF0F4h/FPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kk1aI5oR59abNOk44uBmPd+8CTUO+Diea7ry5gJfEyW8ZT0j2O42WKuPKEMkjhQf7XfXTqvzv3j1bCS8KE1SBaqD/HLv0+KfHszlh/ouH34AP2++BfsvOZpGw6FLEfBhVfWZd51pG8iBLu9ziNEZZa0Gd4Vp0nyhp4P4dSUgMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwfr+7oJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwfr+7oJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7A21F00AC4;
	Fri, 31 Jul 2026 20:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785531350;
	bh=iz9/NRV7VBJrddv1BPYUj3jQ5zLNCgkwAi+GrSdwp+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wwfr+7oJT2+oVVJSxeGOfwTWu3dxrpRRcYQ0Vy3I/RFfdCmHx6ZAGO55y0F3bXlgk
	 wzZQkOhzKxEQjjgq6hIH4C9vyJyJeNYvYnF0Bo5flwU0T8IZW1fw8cTADe13y/mat2
	 ngOxAwgSSkR+q0la0s9/07+2gKEzekjJbx2yM+GB45+SdwYxQm+yZtXzsgxEYQCE2X
	 TB1LFTFNlbrpmLiME95XWhm7ObOq8TMnx4XUJHsukDERuhq1x6j2WdiQ3CFMFaHrJe
	 WErnXteq/d6ksaEfhqTbL6TW4S9bYEEsgK741wddi9uDgRtRaPMynB5ciFZ0vKJ6hd
	 CF+SApUtWN3MA==
Date: Fri, 31 Jul 2026 22:55:46 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org, konradybcio@kernel.org, 
	stephan.gerhold@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: Re: [PATCH v3 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
Message-ID: <am0Li7jT2BQAI54k@zenone.zhora.eu>
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
 <20260729-cci-clk-fix-v3-5-f3c731d1596e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-cci-clk-fix-v3-5-f3c731d1596e@oss.qualcomm.com>

Hi Loic,

...

> @@ -588,6 +646,10 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
>  	struct cci *cci = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = cci_set_core_rate(cci, cci_get_required_rate(cci));
> +	if (ret)
> +		return ret;
> +
>  	ret = cci_enable_clocks(cci);
>  	if (ret)
>  		return ret;
> @@ -694,6 +756,19 @@ static int cci_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
>  				     "failed to get CCI clock\n");
>  
> +	ret = devm_pm_opp_set_clkname(dev, "cci");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");

what if CONFIG_PM_OPP is not configured in?

Thanks,
Andi

> +
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to add OPP table\n");
