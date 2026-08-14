Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E713ECBE4;
	Fri, 14 Aug 2026 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744061; cv=none; b=pNEVkVxf0/WXcyWdiERHRXRjFfyfSo/XsTgdTof2/XFzL9z1ae3TQc/qCZ4MloahSzyv7E8Gigz3PCaK3UF9qUMDSQCjxyADIHvtKMxV8GNCOtcrxJdb8rsqim2z2aMjlU1NnbyR74ohUo1uez0zsAstSA8GV7eRV3yQ/oJ6Rh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744061; c=relaxed/simple;
	bh=d+T4qGmkwrrvLcrN4CAfrsnYybD3LQRwGl+zVUanOQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATmD5wrgbgfIv2ATjdqPSY2bRhinoX9v9Qw5axk1m1dGGVWKySypoGzUq3P3RpzkxTXLglop4MyHouuO5I1Epht/x8JCDcGpSPemxl5PWWyygI4gwy+/F3HoqCAWmIckWW9TaG2N3yrPxCNI+oG0tt+FMEENiYMA7inY+63fStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIA0HyLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIA0HyLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04031F000E9;
	Fri, 14 Aug 2026 21:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786744060;
	bh=2qNebYmttxSqJhOl9ARdT0d6arM2F5VGJb73bWlx1eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fIA0HyLJxd1HNDAEL+c+mHqJkCX/3A7sclQcu4qzx9J4dFpGYmeJhBcZBEajBUoBp
	 s6IrP0Wfb7g64yCgANqYZyamBi7mLAJNx+FzT2vnz0MJ92xcb6S0r0KLXOVvvn+LtA
	 aQjxCqYPYA/tSEB7M7zbxupCpYEnzOCHIlnpwkq3VKx0BLfslo0utW0G3kE/ER2pd9
	 WaY+pMlLwTP4lUT+gsMVgM85UQU9mupcFrf1PVexGB9yvjEi6s0HCQRLfBNXL19Q42
	 7sJTJAiRnbNAOoxSx8mwDynY8yrHeHF1479MoMfXcZQ4I+W2yXVLmvx4Euyr/S7pYp
	 fuamc3vyxaYJg==
Date: Fri, 14 Aug 2026 23:47:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: linux-i2c@vger.kernel.org, peter@korsgaard.com, andrew@lunn.ch, 
	jcmvbkbc@gmail.com, wsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: Disable clock on failed resume
Message-ID: <an-MW3uW-o5tPpiT@zenone.zhora.eu>
References: <20260813153155.3953577-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813153155.3953577-1-ruoyuw560@gmail.com>

Hi Ruoyu,

On Thu, Aug 13, 2026 at 11:31:55PM +0800, Ruoyu Wang wrote:
> ocores_i2c_resume() enables the controller clock before reinitializing
> the hardware. If the clock rate changed while the device was suspended,
> ocores_init() may reject the resulting prescaler. The callback then
> returns an error with the clock still enabled, while the controller
> itself remains disabled.
> 
> Disable and unprepare the clock when ocores_init() fails so the failed
> resume path balances the successful clk_prepare_enable() call.
> 
> This issue was found by a static analysis checker and confirmed by manual
> source review.
> 
> Fixes: e961a094afe0 ("i2c: ocores: add common clock support")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

merged to i2c/i2c-2.

Thanks,
Andi
