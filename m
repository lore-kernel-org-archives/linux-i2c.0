Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57D313E34
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000706; cv=none; b=k6mrT3Bx4hG5DhnmVa6imELFaE3muQcCjQyRI0/pOuaJvI7uYIMQaLrfLloezzB81GnHRM/F0fUb4GmOdC6RdNJ28FfJQSb6AeBM076tKv7bq0KrQdHmj15ZrYIg+DZ0mQGBuKUtaq8LvrWS193VLg2w/w4Jd97OyQ6LmCrqmM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000706; c=relaxed/simple;
	bh=DNcXxZFyeIZMdNUHvu8f8IpC2uSJW59X1TEJ6zIG9ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0QoNKtG8swIF5DSpjFiqKB5kv991L3JaLW1eyrhD1uURmoS+bfnrg3R7sDDkv8nxQFVTsJa88alBSzl9ii1k3ysCZzGXWFCW88chZMBD2ROlZvMeDHc+Vpl5LYb2uhnPJMjN/eSNi84Ee+jU57U7QAdEasQbyvh7SjjEX0nr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2wc5DiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2wc5DiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1181F00893;
	Tue,  9 Jun 2026 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000705;
	bh=u49xSmqKRf8us4UxWAljAaWXNPmtP0ysso2fJxloa/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c2wc5DiKt0X7zKo9SJzGeteWWRaoshDmZDwjt3HlTWXLj4aH5Ik1pPGSPnJfLVCpY
	 4/OjNL5HF8lQ4qbDbtoI/PGc2eF2gs/GwXLCMkInNvjjI3Gm0NxdyyDKxTUl2IzrbA
	 EoHWdsa/O1hW80GS1/c+w7Kz7wjWi6GL1oD1nRIZhCHs1SkKD8W71girmu7Eu5TH2S
	 QkOSzCgmleHnKcVSUHlSlLjzgKZ20aa+kLA+rsTbIrRZ1LRj6JQCiKCapDL/q04idl
	 ep7pX1SKmGGFUvjSyT429QBOON6M2jtiZpT227BK1/kAp1vXKvqqHmRlKCtwKxjPcc
	 pOxD8zZ0VmazQ==
Date: Tue, 9 Jun 2026 12:25:01 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PULL REQUEST] i2c/fix-registration for v7.2
Message-ID: <aifphmi1oFYZz7dQ@zenone.zhora.eu>
References: <aiclzp0IA2Rk7NyU@shikoro>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiclzp0IA2Rk7NyU@shikoro>

Hi Wolfram,

> here are the latest patches from Johan. I reviewed them, tested them as
> far as I could, and already let them sit in next for a while. If there
> are problems with these patches, I'll take care. Please pull, so Johan
> can continue work on the life cycle issues.
> 
> Thank you and all the best,

Thank you, I really appreciate this pull request!

> Johan Hovold (10):
>       i2c: core: fix irq domain leak on adapter registration failure
>       i2c: core: fix hang on adapter registration failure
>       i2c: core: fix NULL-deref on adapter registration failure
>       i2c: core: fix adapter probe deferral loop
>       i2c: core: fix adapter debugfs creation
>       i2c: core: disable runtime PM on adapter registration failure
>       i2c: core: fix adapter registration race
>       i2c: core: fix adapter deregistration race

I cherry-picked until here in i2c-host-fixes.

>       i2c: core: clean up bus id allocation
>       i2c: core: clean up adapter registration error label

I cherry-picked these last two in i2c-host-next.

Thanks,
Andi
