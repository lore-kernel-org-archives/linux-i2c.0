Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BB450F2;
	Thu, 14 May 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761013; cv=none; b=aBQXVkpFblusjqU3mrYqL0rs1YvoT3nS0rqoh8xH6LxTqsaeqOZqysr0VIEDkVRNlaDfczUmqANFcNQb1PUUZKPeoCLMvsUgOoZucX/vesD+1W+DVQx9RquHkNWK17uRi+icscsPG2p6hw1ceEUmS9IvtMpXAU8Z7OxFrkEF0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761013; c=relaxed/simple;
	bh=PORTGk8P/rtVvT7OmF0VyhTfXBL6HoNBPRhenyOjF1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF25JUmFYs5SY6Sb2TDlDDDWWcj39CVrJNljGqdpy1KZM8LNIO70LoH+UuWmAIJBuFMdBcBbmRaoZQ6IuodQLS8UPGtPvSMST/hansecKGa+RzQVugmhZCTyZqisy8ksXt3XS3Cezuw386Eh7VOOSSfQ0MvcQ49BpYuvnNpNH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RxES1V9A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RxES1V9A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pSxyMhepbltjo+/qfsH50GQ7y+k3llxjzRCuYimqObg=; b=RxES1V9AbPBFkgrLjmu0PiBWe8
	ulik2w1AH7SPArvIbxsubgsW9J0H8ELKcCdisyPfSZy4mlkJcWSSZ8/RQnxCFhsVyEdDq9/6w3IxX
	hyV3nJ1/v4d2Ao4lLDr1nHzyWxdCRN3zsXLjt7sOjagEZxx1wSbdxGz68Vc4T7d6Cz0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNUzg-002tuE-Pw; Thu, 14 May 2026 14:16:48 +0200
Date: Thu, 14 May 2026 14:16:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: brgl@kernel.org, andi.shyti@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] i2c: davinci: fix division by zero on missing
 clock-frequency
Message-ID: <1ce483f8-1d9a-40c3-a45e-6ca536010b20@lunn.ch>
References: <20260514103740.5416-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514103740.5416-1-chaitanya.msabnis@gmail.com>

On Thu, May 14, 2026 at 04:07:40PM +0530, Chaitanya Sabnis wrote:
> When the 'clock-frequency' property is missing from the device tree,
> the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
> macro is defined in kHz (100), whereas the device tree property is
> expected in Hz.
> 
> The probe function blindly divided the fallback value by 1000, causing
> integer truncation that resulted in dev->bus_freq = 0. This triggered
> a deterministic division-by-zero kernel panic when calculating clock
> dividers later in the probe sequence.
> 
> Fix this by isolating the division so it only applies to the Hz value
> read from the device tree, cleanly assigning the kHz default otherwise.

Why not keep the patch simple and just change the value of
DAVINCI_I2C_DEFAULT_BUS_FREQ to Hz?

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>

Please also added a Fixes: tag.

       Andrew
