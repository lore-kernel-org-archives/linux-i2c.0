Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27561EE7B7;
	Wed,  4 Feb 2026 01:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169413; cv=none; b=pxfihzidAqycDyYGF2RhAgg5oLu9C6xNQZxtrPra3KMwSmQU0WRahxZgbpgoVrf3ZCRPoWPUUhtDCmAQhu5mUj9CiLaWUgXSkUyZG3jdm804OXbuhxaFO0iV/uF211KUBlh5HzyDF1uUgav4MNJ4YaQs3yTJN4VqVTegFjRgAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169413; c=relaxed/simple;
	bh=2wCLPcHLsh3x6sikIneebd4o/tUNq96QM7xnIR7WW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3riNhOf20xFP2/UzaaUGMgi0gLfiHZdTjyb00SxZp02WTe6GAu72/vgrXHCeiJXjfl98sOo19/hanGa7LO69oqhQhrYN9qoFI5sg7vYOaZOuumq6s0FCeubsArzd/nIzuOzL4xots/wFFq4R/3BsQrUnPb+vh6n6hHRer8/+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5niPjnJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5niPjnJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB99C19422;
	Wed,  4 Feb 2026 01:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770169413;
	bh=2wCLPcHLsh3x6sikIneebd4o/tUNq96QM7xnIR7WW9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5niPjnJzQQwZ1Y+DCfRfyDMd/Ef0afIPSrwZ3K3kXfqWedjzdwu41D//sjzmiQgu
	 IvgbMfsMYZKDGxe4x2TKU2m0BX2csWVY00ME70IUgd3jGfGUjD8RAMBP6lGp7AoGhE
	 aNlOpDzM2UsQOU1pMzBIjtXpTNo3k819+PI9DJVucaxCdsa/ReefV1PGRnw6QA6z5N
	 cYgkWrjAFUFPULl9H4jy3XJXWHN20Hat2h9VSWR4UZUvmaprjildJsiiuriazr2SxK
	 GeVSWOZF9neFUkahyzDpIcWBbYzDbHnMCQe64krxv6Tfg79DXUv2vEpEF03wUX6KZq
	 Xbeagli8lH7Ig==
Date: Wed, 4 Feb 2026 02:43:30 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
Message-ID: <aYKj31hi1bF4wmsi@zenone.zhora.eu>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130111039.874548-2-a.shimko.dev@gmail.com>

Hi Artem,

On Fri, Jan 30, 2026 at 02:10:36PM +0300, Artem Shimko wrote:
> The current implementation uses separate calls to acquire and deassert
> reset control, requiring manual error handling for the deassertion
> operation. This can be simplified using the dedicated devm function that
> combines both operations.
> 
> Replace devm_reset_control_get_optional_exclusive() with
> devm_reset_control_get_optional_exclusive_deasserted(), which handles both
> reset acquisition and deassertion in a single call as well as
> reset_control_put() which is called automatically on driver detach. This
> eliminates the need for explicit deassertion and its associated error
> checking while maintaining the same functional behavior through automatic
> resource management.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 30 +++++++--------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 7be99656a67d..88e70970c72c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -227,40 +227,32 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
> +	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
>  	if (IS_ERR(dev->rst))
>  		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
>  
> -	reset_control_deassert(dev->rst);
> -
>  	ret = i2c_dw_fw_parse_and_configure(dev);
>  	if (ret)
> -		goto exit_reset;
> +		return ret;
>  
>  	ret = i2c_dw_probe_lock_support(dev);
> -	if (ret) {
> -		dev_err_probe(device, ret, "failed to probe lock support\n");
> -		goto exit_reset;
> -	}
> +	if (ret)
> +		return dev_err_probe(device, ret, "failed to probe lock support\n");

the dev_err_probe() changes are not mentioned in the commit log.
Can you please split this patch in two, one for the
devm_reset_control and one for the dev_err_probe?

Thanks,
Andi
