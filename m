Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E9515746F;
	Fri, 28 Aug 2026 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879121; cv=none; b=lxJtJ3EDHIDSknSdEU8GblmHsdWOnIkpCmdLJmoVV3GZ3NifiSLVeNmLb8Yo8BAla3nM/ZhYdMUVM7r4h1ZRdvOB3Vu5pLM7p6huVXj3H4ugBwlK8fFWOANpTwzFoaoURATmbid1P2XtRefH1CCFsO9maK1S1RA0UwQI4gZJiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879121; c=relaxed/simple;
	bh=izG4RbeNTWnSPAd5dHWREw8Q42wnVbXhP43VHaXPPF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArVdxYvbbmVxS3sBqNVminNpfcBPVf4ento4yiN3RQ01tTUbEGBlwgj9SBXPLdWPxsxBJxchqD3KqibPAEUS/QtHUm7RNTuX/8cC6+ntrs2JdZhMwwJ/SxGlKr1M8/sn9RZZuaeCI2B7MIiE+09g7dYCzO8Ug2UgWjpHOWPjpCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMgM+lk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMgM+lk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F2C1F000E9;
	Fri, 28 Aug 2026 01:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787879120;
	bh=6U5ExAOwpuC9HkpTj1w+MoxH5Zx9pOSlze71yGpb08M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aMgM+lk7XLVXONkznjgO7m5hNyJIKapRLi1xZUitLCCHqPSXV7dQl5j3JIq5kde3u
	 GrcuKOg9TLqnGiFhSzalDeu47dIfEgqM0eqQyLVur0QTcaNvdUQfhNZB219+SZJcVa
	 3C/EXIpJFgGXhKLrCtnd0uzqXTREumhh27MvTPViIPjrIXXdhIBcRWSm3v5Yt3w1L4
	 FXRDV++HiHEloECuDOBJUIZEgTkWyzxpVL4kLdlrWcKROTJ6RYzvsYk0I6/sa0Qebt
	 gnzKQ9LxufAsjl5dG34QS0R+HGi9DV0MYwK6m/Zkqvy3CljLC6apm0vD2xw/RBidbj
	 Z3seq24nBwrUQ==
Date: Fri, 28 Aug 2026 03:05:17 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: carlos.song@oss.nxp.com
Cc: aisheng.dong@nxp.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: imx-lpi2c: avoid accessing target registers on
 master-only controllers
Message-ID: <apDetAiapLq-VVRb@zenone.zhora.eu>
References: <20260803032705.2250373-1-carlos.song@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803032705.2250373-1-carlos.song@oss.nxp.com>

Hi Carlos,

On Mon, Aug 03, 2026 at 11:27:05AM +0800, carlos.song@oss.nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> Not all LPI2C controller instances implement the Target block.
> Since commit 90311787f483 ("i2c: imx-lpi2c: reset controller in
> probe stage"), the driver unconditionally resets both the Master
> and Target blocks during probe.
> 
> On controllers that do not support target mode, accessing the
> Target registers triggers an asynchronous SError and prevents the
> driver from probing successfully. For example on i.MX8QM:
> 
>   SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
>   Hardware name: Freescale i.MX8QM MEK (DT)
>   pc : lpi2c_imx_probe+0x280/0x594
>   lr : lpi2c_imx_probe+0x224/0x594
>   Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> The VERID register is implemented in the Master block and can be
> safely accessed on all controller variants. Its FEATURE field
> indicates whether target mode is supported.
> 
> Read VERID during probe and use it to determine whether the
> Target block is present. Only access Target registers when target
> mode is supported and reject target registration requests with
> -EOPNOTSUPP otherwise.
> 
> Fixes: 90311787f483 ("i2c: imx-lpi2c: reset controller in probe stage")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>

pushed to i2c/i2c-fixes.

Thanks,
Andi
