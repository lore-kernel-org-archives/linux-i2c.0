Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49B2DEA9B
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883131; cv=none; b=oCB0Z4/O8QF5lHlc8tFSPJFx8Ml8iJWXhJIr8m0MvffnTvyOTw+7enFpVURxpb3pKdNuUVSEeHyt41n9mXA6LteW2ys/LQf5qXBovmkAN28nZsD4Qzv9t2lllYVYWkMTuFiw/nfqan1uA6QNvR1FzkkyjgsCFsXxEXS13ABjG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883131; c=relaxed/simple;
	bh=fYEreH4tV67pPT5Re5xMRgGqjBmpXFF4UFvyb5OI6Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxJnhehl5tSxZYueoC+/q5C/EgsD7x6wauL+FC0Zb/dXzZmnKPUVgCEQhVugoq+ZXx++lK1Gx5H5Mk49Zxet7bIL3GxEiei/DBk95XawPgQWQBeC40DPWYQGiT8rKHko6LJiCfQBJNyZxhZB29BjqSa+1GeViMpzInxbYhnH1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mD/zbGAP; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mD/zbGAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=69yL
	hlBI16XoVN9bn+X224Mok/47DWhaQAjx6HzSTTc=; b=mD/zbGAP2702YJM1OPmA
	ub40M6Ut4DpN0w3RYqDDcsh29QDSXY0wM/vRVTbX0NA54uOKr4Jmry/szvORS14o
	FFBX/ozRpyki7PoKTe7eLJcKX76Y558PbSZKvcGRVuugNtLQZSvCz8eK7CkVCFGW
	43l8hbVWYFEwby8OeP8ETvg6pWyd/5ij4neBkuEu+YV5ZwfXIAdjQcieN4Cafpfy
	e2Ue3Ndw2B84JuiaKEGxUkDvY5NHyqaR1t4nt9Zcs9Zhyq/yIXq0SRhOKOQ8Xlv8
	EoMHbpxFYI++ZYwWfA7ozfIVSfLir6TYYUA9dfQdwceeuVzEyv8Xmij7TJ58tBF5
	nQ==
Received: (qmail 2102619 invoked from network); 4 May 2026 10:25:28 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 10:25:28 +0200
X-UD-Smtp-Session: l3s3148p1@hdhNrPlQZrcujnvR
Date: Mon, 4 May 2026 10:25:27 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-i2c@vger.kernel.org, Alain Volmat <alain.volmat@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Pierre-Yves MORDRET <pierre-yves.mordret@foss.st.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] i2c: stm32f7: Move reinit_completion() to
 stm32f7_i2c_xfer_core()
Message-ID: <afhX9z20oxSZxM6L@ninjato>
References: <20260502153218.56142-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502153218.56142-1-marex@nabladev.com>

On Sat, May 02, 2026 at 05:31:54PM +0200, Marek Vasut wrote:
> Currently, the driver may repeatedly call reinit_completion() during
> transfer which contains multiple messages, while another thread is
> waiting for the completion.
> 
> This happens during transfer with more than 1 message, invoked via
> stm32f7_i2c_xfer_core() -> stm32f7_i2c_xfer_msg(). After invoking the
> stm32f7_i2c_xfer_msg() to start transfer, stm32f7_i2c_xfer_core()
> calls wait_for_completion_timeout() to wait for completion of the
> transfer of all messages. When the first message transfer completes,
> the hard IRQ handler triggers, and detects transfer completion, which
> leads to stm32f7_i2c_isr_event_thread() IRQ thread being started. The
> stm32f7_i2c_isr_event_thread() calls stm32f7_i2c_xfer_msg() in case
> there are more messages.
> 
> Without this change, the second and later stm32f7_i2c_xfer_msg() would
> call reinit_completion() on the completion which is still being waited
> for in stm32f7_i2c_xfer_core(). Fix this by moving the reinit_completion()
> into stm32f7_i2c_xfer_core(), together with wait_for_completion_timeout().
> 
> Since stm32f7_i2c_xfer_core() now waits for completion of the entire
> transfer, increase the default timeout. This fixes sporadic transfer
> timeouts on STM32MP25xx during kernel boot.
> 
> Fixes: aeb068c57214 ("i2c: i2c-stm32f7: add driver")
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Reworded $subject a little and applied to for-current, thanks!

