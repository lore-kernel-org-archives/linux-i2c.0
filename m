Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E09390CA3;
	Wed, 17 Jun 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685495; cv=none; b=A7J2oaEicaIDtodsqF9NiOP/mD6xiLe1awcKIdUA28r94huMLimkjVlSUFas/o+Ww92L6f36oW1p2uDH7uUMXXzVWO4ZS+Lv2SfySi5aHAYmpO7EPwHAF84OLQPbxsKx5ibgeHjw1bSE4wITbqYp8pcoi0ZCFRpMie7fFjVs41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685495; c=relaxed/simple;
	bh=OZHTztN1V4+dp3CylQOXqF4sHVZIJA6BZl9bAaRaQRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oITPvfh5hG0zylc6yE67hjbjfDQ4PmuYYFs0LxnKB6YIKQcNVoXKRcqYNydVabBIYqmKP5ak2Aa+7GuYaPgCS6ZU6Gi/QNF62fFD8U+jNP6dDakCq3exGWP4JpyIEE/OZY05yJfgt5WcjK+BDG5tbkryuhNfOvCddcvpNw0+Zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO0im/Fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO0im/Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E9C1F000E9;
	Wed, 17 Jun 2026 08:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781685493;
	bh=ynyGNMVkaF2YOmFkxKrH0dMGdqEXr7Zt1ipWLf8tuH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eO0im/FmLLmA8xq7h67znTWf2Egfp7TA5g3tCk7tVhtkz3GB39hE/A5DiYbt5cKtr
	 Mviz3QsD/6PSuE3I7nMw6h1/Mg0Oku/c+XQxoMWV5VvZ+df7QmrYLygvWireabfKJ2
	 6P47Jcfgj7RxGFkyKQhoCkqREqb1PtoW6uYrUG1DMrl+zNba7rlRuDLOtYF6XxDhn9
	 PmOK/85jmb1C1oZV4HNvnh4FTG6zIUngXsNo7M4gzsTm1LxdBkKj8D08WXGue6IaVt
	 hW63ozzeQUZOBlvFDoG3qHCA32vzcZoWcFkm3sS0xbcwnNnVgv+1HdVyg205KsNppM
	 8KPCgaRFwqgmQ==
Date: Wed, 17 Jun 2026 10:38:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Guillermo =?utf-8?Q?Rodr=C3=ADguez?= <guille.rodriguez@gmail.com>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, M'boumba Cedric Madianga <cedric.madianga@gmail.com>, 
	Wolfram Sang <wsa@kernel.org>, Pierre-Yves MORDRET <pierre-yves.mordret@st.com>, 
	linux-i2c@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: stm32f7: truncate clock period instead of rounding
 it
Message-ID: <ajJcxgVejqzlwo9A@zenone.zhora.eu>
References: <20260611104857.242153-1-guille.rodriguez@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611104857.242153-1-guille.rodriguez@gmail.com>

Hi Guillermo,

On Thu, Jun 11, 2026 at 12:48:56PM +0200, Guillermo Rodríguez wrote:
> stm32f7_i2c_compute_timing() derives the I2C clock source period
> (i2cclk) with DIV_ROUND_CLOSEST, which may round it up. When the
> period is overestimated, all timings computed from it (SCLDEL,
> SDADEL, SCLL, SCLH) come out shorter on the wire than calculated,
> and the resulting bus rate can exceed the requested speed, violating
> the I2C specification minimums for tLOW and tHIGH.
> 
> For example, with a 104.45 MHz clock source (e.g. PCLK1, the
> reset-default I2C clock source on STM32MP1), i2cclk is rounded from
> 9.574 ns up to 10 ns. Requesting a 400 kHz fast mode bus with
> 72/27 ns rise/fall times and no analog/digital filters then produces
> an actual bus rate of 415.6 kHz with tLOW = 1254 ns, violating both
> the 400 kHz maximum rate and the 1300 ns tLOW minimum of the
> specification.
> 
> Truncate the period instead, so that it can only be underestimated.
> The error then falls on the safe side: the programmed timings come
> out slightly longer than computed and the bus runs marginally below
> the target rate (375.3 kHz in the example above) while meeting the
> specification.
> 
> i2cbus is left rounded-to-closest: it is only used as the target of
> the clk_error comparison and is never multiplied into the programmed
> timings, so nearest rounding remains accurate there.
> 
> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guillermo Rodríguez <guille.rodriguez@gmail.com>

Merged to i2c/i2c-host.

Thanks to Alain and Pierre-Yves for their review!

Andi
