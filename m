Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D92853F8
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824898; cv=none; b=jLYchLkmWmTgSTlTVKffMfMUxgYwaHuAKWU0r8eYQsUZa8x4m08n/4HiqItKHrnZO6Js2V6Kvk9x06V6Fsqij1+7G0hKxX64Y/nCNfibeVS4JVsMk1z1xJ+OMGOYVe80gWWaWM4Ali2dqdkBu5aDYChfUAYvCBCKuXttw/dlEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824898; c=relaxed/simple;
	bh=QD2Y4euWc8sJhTfA/CnILxd65/kGLdlI2wrj77LxXas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhWQYxCQESq8aI2SRyLkOnnJMczdj3c3VAjfrAoaTRRYfvNuptGefFktFlmMrOd3QX0RdXfui8taGYGN/Fweua7c/WrZVuLensQQNdVUfUiSBG8u22iKgciFvsMtsRWDCi67NThGwVTDSaPxG8oXL0iy1ZeFXlrrCXyxUzo98DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bbaoKaIh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bbaoKaIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=cY7P
	mbuIO+wL0uJ2uHrRtzrWH+FdbJWbWlM2ezduFew=; b=bbaoKaIhE2stUAQjF+qp
	e5k+KFnssZaLadQbzBvPrVO+x0Z/lZ4yrLiKyuco2pzoP8GxeQpGq/Faamk/QMlc
	H49x4g28PQzCLD8Xmf2SPiFs6rM81aBGELe/gGomrOOEz7kp5IZ2QYXtWxaRmg+K
	W7b+0uR0NcxZGb5rdn/vRLWU9hrOA9pv7+qbQow1wZvpTe+MnOpSeLbBrCpy3JWG
	nxGKx/TP4XfnyjXnHMnSfOTEDu/PXznTkr4fVivQ/tQL+GEeBkvu4W38BoC64IdY
	Kwip2QCsLx3mNBxiWjVuoDO6b9AAJdNAqrYXkuq5JOlyi9zMP49HC9DW5tTRKc0o
	aw==
Received: (qmail 387701 invoked from network); 26 May 2026 21:48:14 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 May 2026 21:48:14 +0200
X-UD-Smtp-Session: l3s3148p1@QSmTxr1S41OSABpf
Date: Tue, 26 May 2026 21:48:13 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <ahX4_WaqodYt3PmD@shikoro>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
 <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>


> +Multiple muxes in series
> +--------------------------
> +
> +When multiple muxes are used in series the same rules applies.
> +
> +Transfers to D3 may interleave between select-transfer-deselect to D1, which
> +results that the bus speed to D2 or D3 will be at 100KHz.
> +
> +Transfers to D2 may interleave between select-transfer-deselect to D1, which
> +results in that the bus speed to D1 may be at 400kHz as the transfer to D2
> +will set the bus speed to before the transfer to D1 starts.
> +
> +This is probably a bad topology ::

In documentation, we probably shouldn't say "probably" ;)

> +
> +                     .----------. 400kHz .----------. 100kHz .--------.
> +    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
> +    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
> +    '--------'  |    |  mux M1  |--.     |  mux M2  |
> +                |    '----------'  |     '----------'
> +                |  .--------.      |  .--------.
> +                '--| dev D3 |      '--| dev D2 |
> +                   '--------'         '--------'

400kHz leaking to a 100kHz device is bad. I guess we cannot do much
about it here because the bus speed is a board specific parameter...

> +Idle state
> +-----------
> +
> +Muxes have an idle state, which is the state the channels are put into when no channel
> +is active. The state is typically one of the following:
> +
> +- All channels are disconnected
> +- The last selected channel is left as-is
> +- A predefined channel is selected
> +
> +Muxes that support an idle state where all channels are disconnected are preferred when using
> +different bus speeds. Otherwise high bus speeds may "leak" through to devices that
> +may not support that higher speed.
> +
> +Consider the following example: ::
> +
> +                          .----------. 100kHz .--------.
> +        .--------. 400kHz |   mux-   |--------| dev D1 |
> +        |  root  |--+-----|  locked  |        '--------'
> +        '--------'  |     |  mux M1  |--. 400kHz .--------.
> +                    |     '----------'  '--------| dev D2 |
> +                    |  .--------.                '--------'
> +                    '--| dev D3 |
> +                       '--------'
> +
> +If the idle state of M1 is:
> +
> +- All channels disconnected: No problem, D1 and D2 are not affected by communication
> +  to D3.
> +- Last selected channel: Problem if D1 was the last selected channel. High speed
> +  communication to D3 will be "leaked" to D1.
> +- Predefined channel: Problem if the predefined channel D1. Set predefined channel
> +  to D2 as D2 may handle 400kHz.

... unlike here. We have MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT defined
already. And I'd think we should only allow bus speed switching for
MUX_IDLE_DISCONNECT to avoid out-of-spec scenarios. Opinions?

> +Supported controllers
> +-----------------------
> +
> +Not all I2C controllers support setting the bus speed dynamically.
> +At the time of writing, the following controllers have support:
> +
> +============================   =============================================
> +i2c-davinci                    Supports dynamic bus speed
> +============================   =============================================

This paragaph is easy to get outdated. We can document that only
controller drivers with the callback function implemented will work.
People then can find out if that applies for their driver...

There are some grammar correction in the Sashiko-review[1]. Most of them
look correct to me. Can you have a look at these, too, please?

[1] https://sashiko.dev/#/patchset/20260324-i2c-mux-v9-0-5292b0608243%40gmail.com
