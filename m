Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280222173D;
	Fri, 27 Mar 2026 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620351; cv=none; b=tXEQlK4FQtCsCdT49jzBvEUWqJZGZ1+u7oqa+LyoJaWhvgfDi0M46eU9cGorwnjrv3Y2LCHVS5wyq+al+Zn2BS9K/MBF+BOW+dHPAqjh5y9CElJOxOf49Os4FV8LC2yRXB9y2uBCYexEejyUE7+uBsH0Z89BUSM6SpxvrQZ+Clc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620351; c=relaxed/simple;
	bh=1Ytr54Qui4gyj+gv4PL4vq/K3QaCphWji1udL+1JykU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvX3AJNT3wv9vFrHDkoo/xePZWAl/pSRsFr+mWHFqqhRkMC1JhvByJFa/s32Y4HEg0i7k2wAYRrhf7ztKGwMdrsBGOnqc2gncq64nReehUba653I5gsf5v6gTA2zjZ9v2WxTO2OEdWu5DQKZz1/Dy9Nma+lI1wHmqAZLkWMnNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NfirfCPq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NfirfCPq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6gGcLLtSBfnKsz9SgIctKwnoDITsxj0pHAg5z2KVu6M=; b=NfirfCPqbP4T1VNxijPYAaKw1Y
	YVfZYew3om/nsamtTPK7cyYab0+xBEygtqCj0p374qzMSJsceCnJ1kU4pcyEJ2MXHxs9Hnb+Xp+G+
	6XPJEp0VGp9GEDc2c7yU604iwqtCxKEsfgdcPmeRJ5HhjpmH/cwWX48scQ1tv6IETRqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w67ok-00DfYf-7r; Fri, 27 Mar 2026 15:05:42 +0100
Date: Fri, 27 Mar 2026 15:05:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Martin Aberer <martin.aberer@bachmann.info>, peter@korsgaard.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: Use read_poll_timeout_atomic to avoid false
 poll timeouts
Message-ID: <8acca1c5-af03-4cb4-9d01-6b4d035cf81a@lunn.ch>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
 <20260324140556.2249039-1-martin.aberer@bachmann.info>
 <c9afbdf9-d5ce-4f1c-8192-5d3baebe125c@lunn.ch>
 <acaMqaKYy6mctA2S@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acaMqaKYy6mctA2S@zenone.zhora.eu>

>     In particular, the helper guarantees a condition check after the
>     delay, even if the delay exceeds the timeout, avoiding spurious
>     timeout errors under load or preemption.
> 
> Let me know if it doesn't work.

That is good, thanks.

     Andrew
