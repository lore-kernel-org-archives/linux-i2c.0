Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13CA43FD22;
	Tue, 14 Jul 2026 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039897; cv=none; b=nEB9IHUecs3oUwfbWdL2D1pGG67m+oDVuylG5BZ9+s7NJwOqYBJ3GhEtYRRN15xRE5/bNHm0IEwQFk0WosIZogSLUhx6plpvviVNzEKtd05wlE7aR8Zus82VZghWDLQb2yhNC4WWN9D2FuHWVi+CKJ+plIrcLNc/sAhyrvz3Whg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039897; c=relaxed/simple;
	bh=/zUSAs28V6wIZcdz4ifJeDCBf5NGqnY1Pl46RpCEmd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoPQ2WZbahXnxUAJjNY210vfKLcWk1bDr6qz3IhFyoulOf31ogrjzeZyu+Ie09VHikQiDu1+9q1xwPtSgrkCORkOVO52zAjLft2tXDmm+XKYDmyp5VyoRQAuEn1dZASwf3g68vi1lVPYddvamp6hd2hGXNP66YQm2+WSVN0c7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE7181F7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE7181F7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47511F000E9;
	Tue, 14 Jul 2026 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039896;
	bh=PZVUqNL66AHFwyp7v2oX06RHRH2S0TTQXO9U+44ikeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PE7181F7GTFzTMLg+UQRe1v7AM4xYxpLZwGkalT089vdAjHazMVpKUOASyQn+B0pQ
	 Fmu3mpdKmwbd1dv1uro0lBKopumpDXZv5/HN4foF6tIo87Hgp7mI2Q1zWr8qUdxljO
	 BMpXcIpJWBKdKmFXOoHAcxFi5epdE7P/u8fYG99SFA8Fzx0Rh9AhgrGMt/ailwZClr
	 QJOlvdcodBpph1s56Z4cyS3OXtxKdQ0eATVqLWYvMQy7s5cuaNizBw78MrVAsvRHWm
	 1FGf2EbnS9aT6ss34B04XJ8A9ayyCvq+htgeqriRCKEPzwtjuwEbFvVRs8L27zALyi
	 YH4mFxIytUPqQ==
Date: Tue, 14 Jul 2026 16:38:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] CREDITS: Add Wolfram Sang
Message-ID: <alZJpppsVRCRkzt_@zenone.zhora.eu>
References: <20260625163221.183414-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625163221.183414-1-andi.shyti@kernel.org>

On Thu, Jun 25, 2026 at 06:32:21PM +0200, Andi Shyti wrote:
> Wolfram Sang has decided that a decade-plus of I2C was enough and
> is moving on to new things.
> 
> Thank you, Wolfram, for your years of dedication and for keeping
> the bus in line. Your legacy is now officially cemented in the
> CREDITS file.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Cc: Wolfram Sang <wsa@kernel.org>

merged to i2c/i2c-fixes.

Andi
