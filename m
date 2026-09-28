Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38E3815DF;
	Mon, 28 Sep 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638104; cv=none; b=WnRCQ4ciUWMXTxic0FFI5t0tbvzcaWHE5l3ozCBW78WRdD3ZbqY2+L2IGDfgsqypt5MrwRerWLHuxNTpUOB4UQ4UnzrKzyYwFPDzeX2HDwShn9Dw7+D3lVPmWvq+LyHhHFj7wAtREJEJ1nrgN48LUVa3CpnGbgAXK4cvKcH9970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638104; c=relaxed/simple;
	bh=YutVHJG0sZy7YrGij8d8zLfjEvsbc5uRWluQnIWAHEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWOtWekp3NpIKZddgxhuvqIn2v9S7fooQ0UZ2GVuIS1FRrK2bT6i2ajFSv2Qybo853AgxTSUY3g+fF8hBVQySYBOAt0p/po6GTWQbNz+yqy4IAeBWjgFeZ+XKHKdWPfWiUwNMmnab+TJVK8Fj7uzQTVo5eG+KR0b+ZHKlYJdS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVpgVMkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVpgVMkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770821F000FF;
	Mon, 28 Sep 2026 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638103;
	bh=YCK46affos81d8aICOHNKYT/US3ZEkCXaLZboaoPCAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVpgVMkQqjporxpG0TbdmbxYZEdDwbkX8AodyOeL2/pn0nCLsLgLEUURkeCQv3c94
	 N6Lp+MTCphYa8S2oNLJts1/RUcW57tIzgD/i4FGE0PbALfE0AvSushgXBydWZEh0iW
	 f+2Dgy04YrxY5Bl85Xh8mUWFwW0doeDFxXFQoq2Rp8PDNL0ehrdXMY5HSL1coL1IMj
	 LOv1RvybgDz89UX4VqBCTTxqU0mcnC91/C4FQuJL6mY+5bDWyPm7xNnH22lmf1xpON
	 VWyPqHzXOEjy6nPg4luz4i/+uhoR0OhjitZ36w1OyAc6k5QSboYCcd2z071zg0dyQr
	 pNoLTa3uSEPZg==
Date: Tue, 29 Sep 2026 01:28:20 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org, konradybcio@kernel.org, 
	stephan.gerhold@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
Message-ID: <arrymkYqBOzLrgnV@zenone.zhora.eu>
References: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
 <20260927-cci-clk-fix-v5-5-4cd498559ae5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-cci-clk-fix-v5-5-4cd498559ae5@oss.qualcomm.com>

Hi Loic,

...

> @@ -318,7 +319,7 @@ static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
>  	unsigned long rate = clk_get_rate(cci->cci_clk);
>  	int ri = cci_clk_rate_idx(rate);
>  
> -	if (ri >= 0 && mode <= cci->data->max_mode && cci_hw_params[ri][mode].thigh)
> +	if (ri >= 0 && mode <= cci->data->max_mode)

why are you removing the .thigh check here?

>  		return &cci_hw_params[ri][mode];
>  
>  	return NULL;

...

> +static int cci_set_core_rate(struct cci *cci)
> +{
> +	struct device *dev = cci->dev;
> +	unsigned long rate;
> +	int ret;
> +
> +	ret = cci_get_required_rate(cci, &rate);
> +	if (ret) {
> +		dev_err(dev, "no CCI clock rate satisfies all masters\n");
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_set_rate(dev, rate);
> +	if (ret) {
> +		dev_warn(dev, "CCI clock could not be set to %lu Hz\n", rate);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Sanity: The hw_params timings are only valid at the exact
> +	 * expected rate, verify what landed on the hardware.
> +	 */
> +	if (clk_get_rate(cci->cci_clk) != rate)
> +		dev_warn(dev, "CCI clock is not at expected %lu Hz\n", rate);
> +
> +	return 0;
> +}
> +
>  static int __maybe_unused cci_suspend_runtime(struct device *dev)
>  {
>  	struct cci *cci = dev_get_drvdata(dev);
> @@ -678,6 +739,19 @@ static int cci_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
>  				     "failed to get CCI clock\n");
>  
> +	ret = devm_pm_opp_set_clkname(dev, "cci");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set CCI OPP clk\n");
> +
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to add OPP table\n");
> +
> +	ret = cci_set_core_rate(cci);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set CCI clock rate\n");

The error logging is a bit messed up here: you either print here
or in cci_set_core_rate(). Besides why is a warning there and an
error here? I would just print error in cci_set_core_rate() and
return here.

Andi

> +
