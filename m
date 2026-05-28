Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DC314A98
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006303; cv=none; b=m+iIpShKSdSptsl9HDecFpvUjHse+RAnZHlKEUTzG7DDBmZkphoa50NnIYGMCYcanSqTtLMTJWAh/DNptSm/iWUD/kdK4V6CswyK7sfckVCG2wak6ulqdbEPqLZa8n1arlznhaGlTX92PwxZ4iP8NsiEX8Lxgf/jVlsKBoVofhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006303; c=relaxed/simple;
	bh=u5eNwZEUdIp2O2rEBWVcOpjv2eRrjl7DArdiQ51VDC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNWQqNCBdKIa9wmf7dF8SvF79uDa07geZ3ethG+9QkO4OWiTxcBz5UyHhGvye/GylguN88y/1+svjHamiVcWWLCAzwx3bjrUATgbzM6Z7IwcbTli/J/BidluYxCdr339bDFY7uy0EIAJPvadtM9CK9skXvuxFT7ABjhBwlhYYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ3uE9xC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ3uE9xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2422F1F000E9;
	Thu, 28 May 2026 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006302;
	bh=sjupMxap3x6It7H7TbkNClw/1b9b0NxTd0jQdYuhCXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IJ3uE9xCOr2sdBpf1r8Awf8bu7CtHNMqOL8RsNhbBYhtPDhePE19MJkbf3QcwEurD
	 svceyYd519tBqWhDCrTCdlXkMD2P9PEQ0rq1fs3c3StAPRlrhYW/Qgo5zaNyoZoUaX
	 KHi5AJLS9X9qmARtPPZ4H/w18GkgiVnq6KBgUUuQF/Adz1meDGCe7t/69/bqWKDFZv
	 o0gIZHyK92TTq/yjCMN5tqGBwUtsQChOKTeUQLAEjNmqXVy8n4dNnNP4p6ceDWb4MS
	 UgJ5rEUrSAhGaL0NcOftEd7tSBd/c6pDB68/z9yybou/smnnt/mjyLxlEaZE+p2JLC
	 GnZmfGwqcY41A==
Date: Fri, 29 May 2026 00:11:39 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Enrico Zanda <e.zanda1@gmail.com>
Cc: linux-i2c@vger.kernel.org
Subject: Re: [PATCH 00/10] i2c: Replace dev_err() with dev_err_probe()
Message-ID: <ahi9de1sSqdf32wD@zenone.zhora.eu>
References: <20250520194400.341079-1-e.zanda1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520194400.341079-1-e.zanda1@gmail.com>

Hi Enrico,

> Enrico Zanda (10):
>   i2c: tiny-usb: Replace dev_err() with dev_err_probe() in probe
>     function
>   i2c: tegra: Replace dev_err() with dev_err_probe() in probe function
>   i2c: sun6i-p2wi: Replace dev_err() with dev_err_probe() in probe
>     function
>   i2c: stm32f7: Replace dev_err() with dev_err_probe() in probe function
>   i2c: stm32f4: Replace dev_err() with dev_err_probe() in probe function
>   i2c: stm32: Replace dev_err() with dev_err_probe() in probe function
>   i2c: st: Replace dev_err() with dev_err_probe() in probe function
>   i2c: sprd: Replace dev_err() with dev_err_probe() in probe function
>   i2c: sis96x: Replace dev_err() with dev_err_probe() in probe function
>   i2c: sis630: Replace dev_err() with dev_err_probe() in probe function

all merged to i2c/i2c-host.

Thanks,
Andi
