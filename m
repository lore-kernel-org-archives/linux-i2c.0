Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C82CCB5;
	Fri, 16 Oct 2026 00:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109580; cv=none; b=sbjNTRevLBN4xOGuK5rlKuN6GxfkfAYfIl244+PLCN/nuP8eugAsoD6Jz3ufMn7S+U5JCk6BpcEYFgrA44MncAngx6ZRWZJpkXpa0fhHNhgJx4diw9egLhpE8O4VWr6uc2Xg1PmJNnIEU0L/MdEdKcgsyEsz55nexzbYI2zI65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109580; c=relaxed/simple;
	bh=DpKovIzs85FEFcfu/WBYRiygOUrnJnuPZZaCmsRXbrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjyhQOgU4Qdgr8QHEFEWAcj1lxTNnYMd+0cOP/nA255Eisrsf8+zfuhcEp5rBTy7EN9HglSYssiqhIxOBMwAtcxQIreGfG+PVAd2G/F298yE5v6ddZ+cSSRoQKr96Lox2K8qq9/c512X1WRbZonxuseaSuhAt6Bk3tnmpraKB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5lPQ6Gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5lPQ6Gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4621D1F000C4;
	Fri, 16 Oct 2026 00:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109578;
	bh=d1wSy7RT41DUB91oiRuTHRrSKY56pGjVa906vGGr0fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V5lPQ6GpPORb5SLWF7kwvBBnCQ+3e45/bokuvT5IzYSVKznhtClwSRqtO7CfLsado
	 Y2zO/827/v2iIsLLty7x5jRhRshXAjUir2m1C/EF7XA/qXLZTzn2A1sVgDfXB6b0R3
	 Ks+7eZTx6C1aj3ypFb99KtOhtovCJhkhOgaOcwum2iHJWrYZrswcdEQZUC7bHA5EfJ
	 BRWe2s6UAJ3bvKgpe4mNMvJ5+uIzj+SSWduiGF/0JqmpSzelP/2eTRDTSAk7GTTA+J
	 OdU2x67YtGD/5seSzG64ncZjYRNfUmBcVEm8q/6dME2+7zyShbthjUjcDE+VZbL4nB
	 jmX6S9Yo6Uqgg==
Date: Fri, 16 Oct 2026 02:12:56 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] i2c: stm32f7: close SMBus alert work before removing ARA
Message-ID: <atFp5Tji-ZFX0euI@zenone.zhora.eu>
References: <20261012051608.177145-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012051608.177145-1-mhun512@gmail.com>

Hi,

In order to take it, I need an ack from Pierr-Yves here.

On Mon, Oct 12, 2026 at 01:16:08AM -0400, Myeonghun Pak wrote:
> Clearing ALERTEN does not join a handler that already observed ALERT.
> It can enqueue work after the ARA client has cancelled work and freed
> its backing state.
> 
> Exclude transfers and join both controller IRQs before detaching the
> alert pointer. Check that pointer before queuing ARA work, and handle
> single-line controllers without disabling the same IRQ twice.
> 
> Resume the controller before masking and clearing ALERT. On resume
> failure, skip MMIO while pointer detachment still closes the producer.
> Restore IRQs and release the bus lock before unregistering ARA so its
> worker can finish an I2C transfer.
> 
> This issue was found by static analysis.

it would be nice to have a real issue here. This theoretical fix
leaves me a bit perplexed.

Andi

> Fixes: c8062d11e20c ("i2c: stm32f7: add SMBus-Alert support")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
