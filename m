Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B886277;
	Tue, 10 Feb 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723021; cv=none; b=R9eUfBYXpT3bOVGDRpiPd74dNbsJXNdDnq8hxaqLC5g7bVL5SJ4Lv1DgxXJvf5lYdBHgzcBhOFqC3uBxuDZrAQoKdPT5FJqru7e7kpzajxN68Q36rBE8O6wIxpJ3zuj7nX/kM/4MWDPZWdRxQnerkV9kIvdXVCCkp+KppO9fchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723021; c=relaxed/simple;
	bh=D5L6xukTB2y0f8ufBjYPCkYxEnWjQeB9NN8j/BqgWJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl08sb/17pURtjDXCz+1VACrk3gEINadRWh0RuqIePirK5CN3wdWQtXQ4MGOlTyzACnyvYO/J/FiQrUuvZoF1sPqoH129OyOSgiJg61dsQEP0JHN2sp2Jj37SL/3pF+b72H+hkRh8yOVRVXTwSghX99BeCj4KWS6ONmNhBBXh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4QEcgAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4QEcgAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFD7C116C6;
	Tue, 10 Feb 2026 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770723020;
	bh=D5L6xukTB2y0f8ufBjYPCkYxEnWjQeB9NN8j/BqgWJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4QEcgAY8MxVoZKhB6Xw/lGLqUCq5XB8HBm4YCmrnbZob7ZUp1iQ5PHYaoVaC5JWo
	 GNTXml8BDOUQfBTme6+IPq/J3gtfdro0wht2iCWDM642cYU9dBHtW0DAufLlrtQAGz
	 ZzGIOnY5duQZMaIyslrbDIeLC4mXKYDBPMITH8HQrhRE9YHZqDW+tr/ThwShzrLWBF
	 uQb1/spPRHuLIxigaTUp4V0lzgAamYDR/QXooZlTaNUfC9+3h8rMA7GBLemP5Cp0iC
	 4UQxiHXiZ0ie6msgpFjelE2X2xym/Ra0IqU3VPxlkvSFA+DTET6vk8ImT3Bl3qWLqY
	 WTsbGLTOdY4DA==
Date: Tue, 10 Feb 2026 12:30:15 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: lkml <linux-kernel@vger.kernel.org>, 
	linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: i2c-host-fixes for v6.19-rc9
Message-ID: <aYsWFSABsDeu4C7V@zenone.zhora.eu>
References: <aYZ-AZcfwfG1poEH@zenone.zhora.eu>
 <aYjE1N-_26RNg6os@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYjE1N-_26RNg6os@ninjato>

Hi Wolfram,

On Sun, Feb 08, 2026 at 06:16:04PM +0100, Wolfram Sang wrote:
> Hi Andi,
> 
> >  drivers/i2c/busses/i2c-imx-lpi2c.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 83 insertions(+), 24 deletions(-)
> 
> Well, this is a bit too intrusive for an after-rc8 pull request. I will
> add it to for-mergewindow. With the tags in here, it will be backported
> nonetheless.

don't worry, I will include it in the pull request I will send on
Friday.

Meantime, you still have this one[*] in the queue for this week's
merge window.

Thank you,
Andi

[*] https://lore.kernel.org/all/aX1yiVJq7s2iJ3FH@zenone.zhora.eu/
