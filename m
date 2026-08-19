Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24992F549F;
	Wed, 19 Aug 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122838; cv=none; b=VicU+64+Pdj8Qmb75Us3dA2oLahCh6gPlFItVR44+67tqL9uZ26wFOOymBlla7GniLLtZQCmBhliIB2aXLOfcOMURxpCThs4sM7X8dwJUP5pCBVInza4ApEqzk/u41xeryaXDfz83Qn0DpVJKw8Qp15olPjUPvMSRgtHQlqG/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122838; c=relaxed/simple;
	bh=C7ORvLyE9ag5yUxVT3rbSDjfven3krFJOVunP4CpbmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eulF3z1mfakr/0qknF1+dPbiQRgGsH28kL/wpzaRMI61sxYRJyBd2W3Jjf3rsjpgOjT/rz93TIRC7ozIIpaotgx0BSclJGyYJWrIqOVytTt2Ta8HaygTeXaAEfJLOTSsaWu2LikNN4Cw4nbtpSJvBnfD6RnA24U72baha8f1D8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTIf9opb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTIf9opb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BC51F000E9;
	Wed, 19 Aug 2026 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122836;
	bh=M34KX+Pc2IGBqMteXVnYN6PgKHrJIKH4HQnI+YeHSrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RTIf9opbjRG03FOf+ucBAR0RkwIyP3j7P0JvikgYXIdsXTCaCqMMrO1IilszSGGt+
	 tuH+i33UooEK2i7MHcniW6HcUN3ykCWpfbkJUBcEBnci5iWNgrkZUFaVL9AhpV32x/
	 XE+nicKCp982tc+8Qrengh/6ilzuocDqZE8GWuRRhKEVh4HMS5zBZJTvYHlEsi0h7g
	 Nz/Liu2kA7KLo0DW9KKGGYqM//aotsY8HWdc8mvAbZfmuRKsFM1DFwsMDNPgg+gTYf
	 bJ7/hpnDNCQehvrVNbDZ5PN6RaU+Km+D4SWMnRRiurrup45vmhZ+PnD9j0aNSvDsBW
	 RAwh9EAKy96UA==
Date: Wed, 19 Aug 2026 09:00:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: mxs: fix DMA channel leak on probe error
Message-ID: <aoVUdXdbzZNOgSkD@zenone.zhora.eu>
References: <20260815151720.3757460-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815151720.3757460-1-ruoyuw560@gmail.com>

Hi Ruoyu,

On Sat, Aug 15, 2026 at 11:17:20PM +0800, Ruoyu Wang wrote:
> mxs_i2c_probe() requests an exclusive DMA channel before resetting the
> controller and registering the I2C adapter. If either later operation
> fails, probe returns without releasing the channel because the remove
> callback is not invoked after a failed probe.
> 
> Use devm_dma_request_chan() so the device core releases the channel on
> probe failure and driver detach. Remove the manual release from the
> remove callback because the channel is now device-managed.
> 
> This issue was found by a static analysis checker and confirmed by
> manual source review.
> 
> Fixes: 62885f59a261 ("MXS: Implement DMA support into mxs-i2c")
> Assisted-by: unnamed:claude-opus-4.8 typestate
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

merged to i2c/i2c-2.

Thanks,
Andi
