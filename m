Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462843E2AD7;
	Mon, 15 Jun 2026 11:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521667; cv=none; b=iU/VL6zw2htzT0hBNJ0juWMyUIosxNUinY8886UdEkXNQDXN4GufVzGKDUykUgA3Fg0NPwGylqu7slvziSGXe+jIzuXMMgV5hNGdYsws+JYwSEtz+LB3ChInZGmcxDJ3ZH4dIN7SfHZIVxUWrchtPrWb1Ta9otlpGs30pG8LuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521667; c=relaxed/simple;
	bh=5IsDVMKoPJvLpvptuX1lpJHY6wn9dp8hACNCowdF2AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1NvIeB5eb1e8B/BQ/QqYJH3pze4hTh/t2vLKGr8ZyERa6G9v3d+twHTsxds64k8tdagrvUbSEmLVad1gOquHGFkePaSF1s6/iyTeAoKtG0dbhVAaE/v06WeYnmroNAlGmf1xmef78qMLbccpFssSsK2t67e/pVkRRxT4a2fc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z45vdnCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z45vdnCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168C21F000E9;
	Mon, 15 Jun 2026 11:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521666;
	bh=UO3rpfvYBBfuE5Ibo3k4HDGQ/cgjzFJy9qYSUkcP7I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z45vdnCP/DIFOtMyTiQHaC/jwY7RguxR3orCHgTJj7TjBJmOai+rw+wMalmWzYFLx
	 iWF7txnOF962LrHydjZH6GEaEFbOJEqFmbFdBhJZmj1fk2czHvsX2wMD0+GQ25DPa9
	 hauKuHV7W91vADi22vqSYS/vfXtnnyfEMWqneDypF+xe2bD5F6Xl8ud44l/8QjB/9r
	 RloRpAuitmV/+psivHebPD8SvKrblMbMKSvCA1wOkZv3/zdTcNpU2BmvICCfQ+c6n7
	 eUWR/qDQdLQKKlZY1gKIHmC34WH87uIjrjFV16TQpVxpng/bTkgMUMNiIxIWa9wBET
	 Z0gJYbhPY17aA==
Date: Mon, 15 Jun 2026 13:07:41 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hardik Prakash <hardikprakash.official@gmail.com>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org, 
	nathan@kernel.org, chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Message-ID: <ai_cAd41W3iX1ic-@zenone.zhora.eu>
References: <20260610083701.18663-1-hardikprakash.official@gmail.com>
 <ai8jhK9hUGHpojB5@zenone.zhora.eu>
 <ai_PwNWnMZB01AYU@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ai_PwNWnMZB01AYU@ashevche-desk.local>

Hi Andy,

> > > This reverts commit ef76a3a28c79b628890431aa344af633e892035b.
> > 
> > Is this in your branch?
> 
> $ git tag --contains ef76a3a28c79b6288
> next-20260601
> next-20260602
> next-20260603
> next-20260604
> next-20260605
> next-20260608
> next-20260609
> next-20260610
> next-20260611

Yes, but I'm not finding out how it got there. I only see it in
one of Wolfram's branches, but I don't think it came in that way.

I can merge this revert as well, but only after the original
patch hits mainline.

Andi
