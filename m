Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40517BA2;
	Thu, 26 Mar 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564474; cv=none; b=bPNW60Bobat265BRiqfPsB9FGMG6ZQDopOlJ9+zKbcq868FbqH0yZj37MC/2FzWH6bAlyjhm97Ng4gQg1BFmY1nx8fgPUpsAMM6VWFq2chpqW34UNSFWy142B4Pz1EVCe9es4S832y+QVNiaqVc/cPbnyENhb3uKQ6m9TFn+JiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564474; c=relaxed/simple;
	bh=wkl8G216CH2WNw0hnJabeZmnO1/MHaRrp+glbaeQkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9fEpRUa1uuFbHr/OvRcUBf5h5c5/yY5/iaRqRr7fpSXNMXfTBF1yv01GdgibPizPHTo/0GQM7OM0ymicu/xX2Q4CvTqv/UZ0LLEDF14MXLV030zqSvW6pH5BNlWVgYrBXkJpIksCi4iBjYLIDyT7l6Gfb70V5Zd/onkK4L2hRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzcnGteM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzcnGteM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB95C116C6;
	Thu, 26 Mar 2026 22:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564474;
	bh=wkl8G216CH2WNw0hnJabeZmnO1/MHaRrp+glbaeQkyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzcnGteMl6z4KmrqazVx1R96mjP/TBAraVvpaEX/IAI4Mau9Yfe8utofK792jOnyV
	 2Rbg/b/xS0a4cDj779Sx5Hbh3qMNxDrO1d2Q7W7TRXpJVzZRuG0OOJvQUr4kjKd47W
	 uWp1Sbj7pQcT/DE4jrIe5uCmBtvOY3Tl1YbtAnW8ENd9u/CLFO0bgik7tYxsv0ao4h
	 0Nzd56k2sp4KqRfq5l79jBSvPvLX71W2k9ugejQEPP3s0HuhqTqzuvUXbUePgWYNtT
	 ABO325uLhGPIjQ7jxlMqMfARuo7QVjyJq+DFuqbtN8hZsr67f1lJBZJQ/Kx9pmjTTY
	 Q83bWbokaRI4Q==
Date: Thu, 26 Mar 2026 23:34:31 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Martin Aberer <martin.aberer@bachmann.info>
Cc: peter@korsgaard.com, andrew@lunn.ch, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] i2c: ocores: Use read_poll_timeout_atomic to avoid false
 poll timeouts
Message-ID: <acW0BlZAp5Pdn329@zenone.zhora.eu>
References: <20260323135249.550925-1-martin.aberer@bachmann.info>
 <20260324140556.2249039-1-martin.aberer@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324140556.2249039-1-martin.aberer@bachmann.info>

Hi,

On Tue, Mar 24, 2026 at 03:05:56PM +0100, Martin Aberer wrote:
> Replace the manual polling loop in ocores_wait() with the kernel helper
> read_poll_timeout_atomic(). This simplifies the code and ensures robust
> timeout handling. By using this helper, we avoid spurious timeout errors
> that could occur under high CPU load or preemption, as the macro handles
> timing and condition checks atomically.
> 
> Signed-off-by: Martin Aberer <martin.aberer@bachmann.info>

Please, next time don't send this as --in-reply-to, but please
send it as a v2 with a proper changelog.

Other than this, Christian, Andrew, anyone who wants to give this
a look?

Thanks,
Andi
