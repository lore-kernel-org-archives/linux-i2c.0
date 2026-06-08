Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28138655C;
	Mon,  8 Jun 2026 18:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944432; cv=none; b=RxP7IrNoXv8P3oPfwg4BQnjttB1yvQ+2UXZLM5WPO5MEqDqP6ip+JL8MNCtoqEluFf1cTLoTTJMkqWGeZR1u9peHuoR1yGzo8ILcHmiMMGyhCHNQXAH9JwlfilZy7R2DC0dPQENJpGpHefJPTd+vHNs6dwE0AsiiQVtNhzFPrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944432; c=relaxed/simple;
	bh=jIXOa3IANriRmE+Hrzn/zHPjxWLZE6MoAuaoVvnKymY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B604GOjayNj/+nNfd0eEBMWlc3bzNtlAavb7CTANfMRe0Q0P5rruc4f6YbxRa15V/PkqCF4HXhuld0Fb2/1VZbB+PR6XN1Le9xKVV5q8uRvbQJIr4SXp67Un5ANapqtw5PPgNBrY2y5VnOaWTXDfaQNAVlOwF9KuoATCNOscYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpPBPesJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpPBPesJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E442B1F00893;
	Mon,  8 Jun 2026 18:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944431;
	bh=EtweTn+TBzruOlaaXfFvtIoBOUF/n2c1CEY/TA07AuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EpPBPesJA1d0nGq/5LgoelWHamqVlKkLkGBmf1vtA+uguhLm7uKn6i53Wlww8pc+P
	 5pHIw/1Vgh4z5eF+TS2H3jOYVdUIami9SfpvxHVNIaWMy+t38OPDvz8fI9RP84ZZkI
	 ZtDLBO0X2N0GA9xVJyyovimM7A5SaXpgfyQyzkqn4/8ZWtgAVC5X7toUBD26UVid0a
	 PIGtVViiTjIN6j5pN0D7oSyG0DbAwVa/H7lXlkOd+95mMHCdPdfykG2eQxUrawSWg5
	 i2HxRfm092dkSHwOzh3zKN3k+kUKGQBchYrTLDNNB2K4DxP07yuHS5TPk79LA6jBHu
	 hCSt6zyvsyIVg==
Date: Mon, 8 Jun 2026 20:47:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] i2c: qcom-cci: Fix NULL pointer dereference in
 cci_remove()
Message-ID: <aicOEBDOmFVbtcgr@zenone.zhora.eu>
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org>

Hi Vladimir,

On Sat, May 16, 2026 at 02:41:17AM +0300, Vladimir Zapolskiy wrote:
> On all modern platforms Qualcomm CCI controller provides two I2C masters,
> and on particular boards only one I2C master may be initialized, and in
> such cases the device unbinding or driver removal causes a NULL pointer
> dereference, because cci_halt() is called for all I2C masters regardless
> of its initialized state, the bug is present in the driver since its
> inclusion to the Linux kernel.
> 
> Along with this fix a number of driver code simplifications are added into
> the series.
> 
> Changes from v1 to v2:
> * remove junk accidentally added to one of the commit messages.
> 
> Link to v1:
> * https://lore.kernel.org/linux-i2c/20260515152003.1604187-1-vladimir.zapolskiy@linaro.org
> 
> Vladimir Zapolskiy (4):
>   i2c: qcom-cci: Fix NULL pointer dereference in cci_remove()

merged to i2c/i2c-host-fixes.

>   i2c: qcom-cci: Do not check return value of cci_init()
>   i2c: qcom-cci: Move cci_init() under cci_reset() function
>   i2c: qcom-cci: Remove overcautious disable_irq() calls

merged to i2c/i2c-host-next.

Thanks,
Andi
