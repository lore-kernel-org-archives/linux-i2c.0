Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423271;
	b=2t1rk7G+BDZopjk98ELbBqv72bgw6MXmjysJBt10GHty3j2T7g8Of0ZmVznZt7YTV1fG
	 l0wuv9yKjaTiR1gjPqxk+vzWAy5p+B7j3pXrqsotXmm/3BvlgXwpS/XtHWemCmrw/S5p2
	 BxgyDqs032n9dJOLjQgHrG3m/VNmiy9N1ZMgMm+IcXChzBavN9xjloWxkebsR52L0XQyL
	 ZpcDKvbSZxmDTn2FYShaae94oOcBEuUOi1UizlJUXikLSD3p3USEfO1PVBiYA25iel0mJ
	 AIb1i4jklabnCI/RYXcnm//S0fNwPDW09eFaaMFOZfNuE7SNSsK+WMqZtQVNEFm0aRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423271;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qW83tcu1nLaIvW9H5AFKzLtLc7tyDERd4OY7y1H/lAw=;
	b=NwOwENlkbkx2BbrYDMNiP4wt5ioMFqfE4hqXWhb6A4L+fzTAVzU8kwnvhhGFA9KUls3K
	 fF/fbfXCskM4UwfFTcvP3VaifuJpW9DTDWzpqTPjnUXyJRUAVpPAnvWlJNFG364Zqj0Nd
	 L9Ri3116AXAlaSOh+LD+8g0RqugyPFW0d825pQgLjE3GgUK1f3ZsDDY6UV+R41TAV7xwD
	 ELu47dQRoQeB47gnHzyRJ9jZowdEYTEJGmeCxSWBLw5eQOC0V/ELDCCKekMUlFFNRwPnH
	 W4SvMfz/MEscm7xXy5zscyKbbvJz0ONlXVDbR6ymeDL74cewUa/ghacu6bJ+9W8RNNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ajeor/5M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7E606A31F;
	Mon, 23 Nov 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajeor/5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2823D1F000EB;
	Mon, 23 Nov 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795423271;
	bh=qW83tcu1nLaIvW9H5AFKzLtLc7tyDERd4OY7y1H/lAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ajeor/5MmfIU6zEsUYcWnXAVwc5fK1+cstxm2Je/i/wUEpmUb8tnYqqVATLxWDaNh
	 YzKKJco0hur5jU6bJhdPl1imMk4YqPTI0Jvn5vZD/Fj3DvrsF3tsXLuEPcG1I2Yfyk
	 922JMAMS9Uhv0+Y2CA9+r8Fe09o057SZSwfyL5c5DECCkh3Ok+Y6QX5s79adsZJ37e
	 TRdtiWfqoZfLOd/cf8580aWKfglYKjm3FnQh+0k6gfUuLBvRKcDtEbI6QbiDXydK9T
	 y+DdJBp/QtAAMEamcP+NQMIDgBLH4UsUEDazLQrQbiiLxLIil4NcCeelLr6dwknM1g
	 LnsbhbPFKfo9w==
Message-ID: <316fe254-813f-4871-b0ac-428bf5bee6f7@kernel.org>
Date: Mon, 23 Nov 2026 09:41:03 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] i2c: remove redundant
 pm_runtime_dont_use_autosuspend() calls
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Chris Brandt <chris.brandt@renesas.com>,
 Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261109-i2c-remove-dont-use-autosuspend-v1-0-49a08b8daf36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09-Nov-26 21:50, Joshua Crofts wrote:
> Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
> driver core is now responsible for undoing any
> pm_runtime_use_autosuspend() calls on driver exit.
> 
> Remove the redundant function calls.
> 
> NOTE: Some drivers in drivers/i2c/ still keep their calls because they either
> rely on pm_runtime_dont_use_autosuspend() before pm_runtime_disable() to flush
> pending autosuspend delays and trigger synchronous runtime suspension,
> or operate on a parent device rather than the platform device itself.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
> Joshua Crofts (6):
>       i2c: cadence: remove redundant pm_runtime_dont_use_autosuspend() call
>       i2c: img-scb: remove redundant pm_runtime_dont_use_autosuspend() call
>       i2c: imx: remove redundant pm_runtime_dont_use_autosuspend() calls
>       i2c: riic: remove redundant pm_runtime_dont_use_autosuspend() calls
>       i2c: stm32f7: remove redundant pm_runtime_dont_use_autosuspend() calls
>       i2c: xiic: remove redundant pm_runtime_dont_use_autosuspend() calls
> 
>  drivers/i2c/busses/i2c-cadence.c | 1 -
>  drivers/i2c/busses/i2c-img-scb.c | 1 -
>  drivers/i2c/busses/i2c-imx.c     | 2 --
>  drivers/i2c/busses/i2c-riic.c    | 2 --
>  drivers/i2c/busses/i2c-stm32f7.c | 2 --
>  drivers/i2c/busses/i2c-xiic.c    | 2 --
>  6 files changed, 10 deletions(-)
> ---

Hi, gentle ping on this series.

-- 
Kind regards,
Joshua Crofts
