Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793206447;
	b=WmBvl4DSrACQwOsAvuJ62Zq8TX7VshuovF7vvqY7CcycVMcANruYMs6LD4Elf9ThZsU9
	 sQSqMNv/H6v10sdKxNMGaJXzHIEfcKF/jmUYb83pdemPga0BaQG5n3B1GCV4uoKQ5/KLf
	 qaXHK/aXAQa4uTDlS3ycPRrZCvZWylDeF3zwINVqN8Gs9g+v75OxLtA0aFAk+pfNIo9T5
	 HoFO4jpchn+TwddFul7tbvVqnu85Cz9X6pPXq83cKstzTSwspy88KpijC6xYUSQ0gJPM1
	 qDqbCJrcx1Ftaxm+kbEdlhoja0NpNmmN3h0MVfJ1E19oHuewNhmT+Jb4c7EYL0n3L1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793206447;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l5hOwqaY5GiKDW+F1lrpSl20i48ELRbdCilptnYNhQs=;
	b=R1eDR85xIJIox9khhifDDxMkennRtkUBiN8R2ctbk0xnimb92UwnB3ZOj7/hZi6oJmqN
	 UCF3ePv1sMKFTv7VWTu+uMrA4YJoX9Hf6NAhLIdsGiTbKAKir5ujjuhWPMXhFFQmtdDjp
	 1z3c4p+C/KOVJgNEjjUdw0Jl+FENJIp7QRPGIVskdd0jdq2KCC8W9GNNP9higK8fWWRF1
	 W0y7CtM7LwIUvapyAn2VEFPwSVZWx519wA3W3sdZLUqWTxt+56iYHb7PfRtT9JaR//PvB
	 8O7CAaev6abDnkvLdEPhmRESDQQ6kSLpU+tth12ZYtqsQZPN8cTvTCk3OLbpdglFc0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWBansk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33295606A31A;
	Wed, 28 Oct 2026 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWBansk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0630F1F01828;
	Wed, 28 Oct 2026 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793206446;
	bh=l5hOwqaY5GiKDW+F1lrpSl20i48ELRbdCilptnYNhQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bWBansk0wxZ8zt3diIYZY4IcH+ZLx8dzsxjpURnj2gwz0jwWQZ+BCc/ml7twPvr+M
	 D2endLUV9h1qzTIy40pFIUFFdaigWqH0nETqzLN0rEcRXAC6dNT1yhou7qV9gsd1K7
	 1T5iZXls9966g0xmwNlH6h+qCK9g+6Gt0HolJ6uyW8VAoe39S8m+ajkFcu9hYEuiVz
	 TadzbQrvSu3NnVOpQQoLSLbm+MopHuRZ38h3iv2cOfNc1jpeEfgVsUVoNxH9pestEN
	 rPF3FblPLfdoL8UZ0HGPE1i4BRv+eDUEy/JJ19f5baL70nhHjZYBcEV7V1Ngb99hDm
	 1BooXB0WhFelQ==
Date: Wed, 28 Oct 2026 17:54:03 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Cc: gregory.clement@bootlin.com, p.zabel@pengutronix.de, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mv64xxx: Check clk_prepare_enable() return value in
 runtime resume
Message-ID: <auIolwWWjYU_qx7u@zenone.zhora.eu>
References: <20261026113645.2858-1-tangbin@cmss.chinamobile.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026113645.2858-1-tangbin@cmss.chinamobile.com>

Hi Tang,

On Mon, Oct 26, 2026 at 07:36:45PM +0800, Tang Bin wrote:
> mv64xxx_i2c_runtime_resume() calls clk_prepare_enable() for both
> drv_data->clk and drv_data->reg_clk without checking the return value.
> If either clock fails to enable, the function returns 0 (success) and
> the driver proceeds to call reset_control_reset() and
> mv64xxx_i2c_hw_init() which access hardware registers without clocks
> enabled, potentially causing a bus hang.
> 
> Additionally, if the second clk_prepare_enable() fails, the first clock
> is left enabled without being disabled on the error path.
> 
> Fix this by checking both return values and properly cleaning up the
> first clock if the second fails.
> 
> Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

pushed to i2c/i2c.

Thanks,
Andi
