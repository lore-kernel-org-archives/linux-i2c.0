Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E0C84039;
	Fri, 22 May 2026 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419203; cv=none; b=aczfjxzUInDMq5iyrlVdeUfniX+2a2Y13v5Wbjsem5RbflQ6yS23AtHzy6aU6QTTe6xe2P87+DioP6dQIBmFGxDerwmm+4CaDInk4QVuQ0Q5e5N0ep9DM808B1iLI+SVuqkNBlayki8a7/NIamsNc6Akh1eWlnBDEqSqXK5qhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419203; c=relaxed/simple;
	bh=wnfswKmU3JEePFNowrjaJWVRDHtwZQj4gEogS9sqdUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2ff2bo0hcBI8NA61Z0RgMTZe/AVBlVwqPdsWq5GZzJtHmkINBfVGWZJitJ8HyPdJuKHefS1fJ+R77vf8Rz8TuLH2foxX6UsPqLkD5idv0oBPwoy+Pn+IpdVLBJ0ZF60jIosUTmjPZn2+wsny7WsoPuIL0W6MfKFj5B+s7/Tcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rulh6ytf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rulh6ytf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B5E1F000E9;
	Fri, 22 May 2026 03:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779419202;
	bh=+DRe1ydAdJVvVGbtaGGH0MRRsOntoVdMq1KfjTaDLKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rulh6ytfs2dT3/0yzrGO7rZKDQzWfi/Mpw2eQlftkn+klfOp59O+cKB+Ca0g33h/U
	 41gadPpji1nCXys6kSMMJl23fpMoYzlyJmDy7g3/C5z4QQasCx4jrraPKbKD6BGS9/
	 KegtUr0Qiyen6LlPdCmwH3+9zvbiArpjIRZDgQ28cfK4ZZwRb17nIzkcDKqT2lN8l2
	 LVy6HPiIbBJ2pTZ4dQQmVIEjRqE4iEY/C3CcZj07dbjlMG1MBGOkLB6eB453mjy9+u
	 +10jocLJBexg9ytA6JZd1LUb3bEIPddjUvRv48eCmYYN88fjTOfN4NrbF8ehWFGOp/
	 YGy0+POQADhHA==
Date: Thu, 21 May 2026 22:06:36 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org, konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com, 
	bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH v7 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
Message-ID: <ag_HGVQjIQuMoKO6@baldur>
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
 <20260423145705.545552-4-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423145705.545552-4-mukesh.savaliya@oss.qualcomm.com>

On Thu, Apr 23, 2026 at 08:25:50PM +0530, Mukesh Kumar Savaliya wrote:
> On platforms where a GENI Serial Engine is shared with another system
> processor, selecting the "sleep" pinctrl state can disrupt ongoing
> transfers initiated by the other processor.
> 

Isn't it strange that the DeviceTree will define a sleep state for the
OS to select, but when this other property is set the OS should never
select this state?

> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
> when the Serial Engine is marked as shared, while still allowing the
> rest of the resource shutdown sequence to proceed.
> 
> This is required for multi-owner configurations (described via DeviceTree
> with qcom,qup-multi-owner on the protocol controller node).
> 

The requirement as such is reasonable, but you don't define in the
binding that when this property is set, the sleep state must not be
selected by the OS...

Regards,
Bjorn

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 15 +++++++++++----
>  include/linux/soc/qcom/geni-se.h |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index cd1779b6a91a..1a60832ace16 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -597,10 +597,17 @@ int geni_se_resources_off(struct geni_se *se)
>  
>  	if (has_acpi_companion(se->dev))
>  		return 0;
> -
> -	ret = pinctrl_pm_select_sleep_state(se->dev);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * Select the "sleep" pinctrl state only when the serial engine is
> +	 * exclusively owned by this system processor. For shared controller
> +	 * configurations, another system processor may still be using the pins,
> +	 * and switching them to "sleep" can disrupt ongoing transfers.
> +	 */
> +	if (!se->multi_owner) {
> +		ret = pinctrl_pm_select_sleep_state(se->dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	geni_se_clks_off(se);
>  	return 0;
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
> index 0a984e2579fe..46217cac73c3 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -63,6 +63,7 @@ struct geni_icc_path {
>   * @num_clk_levels:	Number of valid clock levels in clk_perf_tbl
>   * @clk_perf_tbl:	Table of clock frequency input to serial engine clock
>   * @icc_paths:		Array of ICC paths for SE
> + * @multi_owner:	True if SE is shared between multiple owners.
>   */
>  struct geni_se {
>  	void __iomem *base;
> @@ -72,6 +73,7 @@ struct geni_se {
>  	unsigned int num_clk_levels;
>  	unsigned long *clk_perf_tbl;
>  	struct geni_icc_path icc_paths[3];
> +	bool multi_owner;
>  };
>  
>  /* Common SE registers */
> -- 
> 2.43.0
> 
