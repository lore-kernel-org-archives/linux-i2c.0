Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66512566F7;
	Wed,  4 Feb 2026 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170138; cv=none; b=jBGTqPozc6PfUiRvpkLjKNMs4MQwV10PGDT9nq4TP+1rBdoAsbV5CDEph811IaAZP0ns4zbS6ZDl+kERhaAALRrp8fxeCerq5NBY7g/lV/NefsZrk5hMcpPJBVpQWmPpVY4Io2fJmXPy2rsLHuLKdNiclbdmZwZNBm5Ph2qM5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170138; c=relaxed/simple;
	bh=YKGDqmLZhf/kCrPdxoYx13Bcpad2AS7aHfIuOUnnoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJDTy21lXUiDxmE5vcl/b8xAug32wq/8qLC/czowBt3js6cqzQsckmddO/CMUNjYjYU93gJ+8WWcHAKGW6lk9mwzZ74ixdSyli+ZY9WgSNoJfBUs44uCKquerIm5CA8Adl2sy0RUX6ZZHqOakpzNKvbg6x/ODs3GoGhzLqEYH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbyatxe8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbyatxe8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13756C16AAE;
	Wed,  4 Feb 2026 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770170138;
	bh=YKGDqmLZhf/kCrPdxoYx13Bcpad2AS7aHfIuOUnnoRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pbyatxe8/YIUqUwYOAABmXzYqbSEdeyoJU+o5S3WDFX3jcH1DtoNInyWL1VHROBlU
	 g557kokTpPQ+mAcH5uxwtMsd2Eo2UdSpxCvbnYzelmad0RpteHpHM/FGV/rUeIM1AM
	 hb7fnRVByWWIJ4kHNST+1oOtiBnPvvmbS9NAhvRuxxG+ChSOwbuP7+iTnH1jPUY4Gt
	 walTwphkUrVOdYCuBH0bNDdGiwHhptNyZ4Ef+ICQ8slYF+qB+O8qJtppetc4wyfl1T
	 8i1QjzBUprrbasEPuYWmyzM0Q+AOYmBJB5Aer/jwtehLj+/dhLIAR0I+vt3DQcfXON
	 4bRXCstTYS3aw==
Date: Wed, 4 Feb 2026 02:55:34 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: aisheng.dong@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, pandy.gao@nxp.com, vz@mleia.com, wsa@kernel.org, 
	B38611@freescale.com, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [Patch V4] i2c: imx-lpi2c: fix SMBus block read NACK after byte
 count
Message-ID: <aYKnAfQTvSrjJLhE@zenone.zhora.eu>
References: <20260123105459.3448822-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123105459.3448822-1-carlos.song@nxp.com>

Hi Carlos,

On Fri, Jan 23, 2026 at 06:54:58PM +0800, Carlos Song wrote:
> The LPI2C controller sends a NACK at the end of a receive command
> unless another receive command is already queued in MTDR. During
> SMBus block reads, this causes the controller to NACK immediately
> after receiving the block length byte, aborting the transfer before
> the data bytes are read.
> 
> Fix this by queueing a second receive command as soon as the block
> length byte is received, keeping MTDR non-empty and ensuring
> continuous ACKs. The initial receive command reads the block length,
> and the subsequent command reads the remaining data bytes according
> to the reported length.
> 
> Fixes: a55fa9d0e42e ("i2c: imx-lpi2c: add low power i2c bus driver")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
