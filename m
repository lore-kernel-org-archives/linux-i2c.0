Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F264289E06;
	Fri, 27 Mar 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620229; cv=none; b=ktFezQOpXw1vs72I8NnILYINkciUtFFoKW0/9KKSNa0XmlnaeQpEf4qkccyCCx5ESfPkiR1q9GbUT5IspH50URVk7cLErnCVSYFLEgYrPWhsu9xiZ92TPKP4RsoVyUOp41ijQ37andC87RpAdI4y3yguEfx7UcQ2Vxj6UP6wDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620229; c=relaxed/simple;
	bh=XxTRwyCGAx0jvq4FieN6junPj14vSkBn4sCe5OTN4Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fr1/MQJBWuv/qCiYokWEBsPa9WQZn9GhKah3kMUMu7+i5BHiyt4gtCrG/NFvXwHicwLmTngN4sDgvnfCNfoZqyAoFtHekPhaE5FuplaEskhVhCsTotWqseUbFo7S61iQABkma5p8usp7qxetsPTUHSr8RUtSBqxnr/swjkOTte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRq1A9K9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRq1A9K9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F56C2BCB2;
	Fri, 27 Mar 2026 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774620228;
	bh=XxTRwyCGAx0jvq4FieN6junPj14vSkBn4sCe5OTN4Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRq1A9K9qe/yOh/MR+dHyrx6H+FaAi5EX/X0EjZZqEja30Yd0K5G/aTTd+Cu6EkGL
	 KDTgxd1GStIoLPiqkCw1KaFJ8AEmBnuRqhChViYlApDK9Z3qP7sglA3Wy/aIizlxvE
	 WthE09EVJ6ePfS3JFP1Kmhg+pRrO9PEXdROgr7JCfHLdjwW8I9LLf2aXWvhp5EBcMD
	 W+dU/tvlK2L5GJ+tGUTQG/8w1haw6cREbCNEt4DCN4Da0osLdMlWpJ8rm4Qa963sNr
	 DXROiHonq5S65sxb3uG6woqAyMyklJAaV3YmmOoAyB2W3efHTANsiN+pdNDZ0FNOaU
	 N+IYgObWwL8Vw==
Date: Fri, 27 Mar 2026 15:03:44 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Martin Aberer <martin.aberer@bachmann.info>, peter@korsgaard.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ocores: Use read_poll_timeout_atomic to avoid false
 poll timeouts
Message-ID: <acaMqaKYy6mctA2S@zenone.zhora.eu>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
 <20260324140556.2249039-1-martin.aberer@bachmann.info>
 <c9afbdf9-d5ce-4f1c-8192-5d3baebe125c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9afbdf9-d5ce-4f1c-8192-5d3baebe125c@lunn.ch>

Hi,

On Fri, Mar 27, 2026 at 01:27:16AM +0100, Andrew Lunn wrote:
> On Tue, Mar 24, 2026 at 03:05:56PM +0100, Martin Aberer wrote:
> > Replace the manual polling loop in ocores_wait() with the kernel helper
> > read_poll_timeout_atomic(). This simplifies the code and ensures robust
> > timeout handling. By using this helper, we avoid spurious timeout errors
> > that could occur under high CPU load or preemption, as the macro handles
> > timing and condition checks atomically.
> 
> It is not that it does it atomically, but that it always does a check
> after the delay, even if the delay has taken us past the timeout.

I took the liberty of changing the commit log to this:

    i2c: ocores: Use read_poll_timeout_atomic to avoid false poll timeouts

    Replace the manual polling loop in ocores_wait() with the kernel helper
    read_poll_timeout_atomic(). This simplifies the code and ensures robust
    timeout handling.

    In particular, the helper guarantees a condition check after the
    delay, even if the delay exceeds the timeout, avoiding spurious
    timeout errors under load or preemption.

Let me know if it doesn't work.

I merged the patch to i2c/i2c-host.

Thanks,
Andi
