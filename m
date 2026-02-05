Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169B38F935;
	Thu,  5 Feb 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770287227; cv=none; b=hFRp4vnVFNyux3OjSKyC3AZQUxBd+7mMsYCNuoweKQyAizrVy4A/W3yIbwzrHPxHCSpUZqJBRJ3XPf3eo69S/s6A9URY1kudRCyGyqrtxALR/TkVzBUrAjIb5vKeBcvoZzeX5VlNaoA/pmJ2SsVZnAjhE/iMee1tfvPPrzA6u6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770287227; c=relaxed/simple;
	bh=cI5Dyg8OksOUik2xzrls+Xl3HS0xtKI3/Wzgo+O3S+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJjc+lnJsyZ+RS+0ZBTFxLUglWKjSinvCSAuohZdQTJRIl+YsOURpKkJVK4waImgq2NR3eXZMAsJ+xJVB0gINlpM0dzoutbsPpfeHySKnki54XPnZ01VfmcT6khqcDF7LcYutt7zWwhXMKG6UI6UkxJ/oRHfJinmCQWASpbaml4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK2MFY4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK2MFY4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5EBC4CEF7;
	Thu,  5 Feb 2026 10:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770287227;
	bh=cI5Dyg8OksOUik2xzrls+Xl3HS0xtKI3/Wzgo+O3S+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XK2MFY4P7nUjIa8tZavPGPBMtMwMdsip6oC1FdA+kPl/AfwiupBmHy+ij2ECXIhQF
	 mxs2UImJspEjKJiiDRQsE6qQjljgfXGC8LcYaMaA4ygdg7wCc03xCGPjNUjFuoC7dZ
	 P+vVljxJKb9XiJFvWSfra2m+zqQLB1nh9yVVOXr+qrVIKcli5s8/anZUR+gJY/f7Q2
	 Yf4u1ngOkLX5oWni6NX5e8+4/OgpjwXiEs5Fo2nDczk7MW4C/ykmjeICOrdV2Up4c0
	 Uo5ttBO/hKXeGOpZGWrI+8596PdKPlQyZ/rmnFoTU4DeAqDIO8cp9S/gNOLBTdMBlZ
	 /ct3rd+nn/BwQ==
Date: Thu, 5 Feb 2026 11:27:02 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
Message-ID: <aYRwJKdaleP6R6Qe@zenone.zhora.eu>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com>
 <aYKj31hi1bF4wmsi@zenone.zhora.eu>
 <CAOPX744QCxpXZuVDfSHkw44SGe+Pr=gXt=MetcK22C7aVrv5hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX744QCxpXZuVDfSHkw44SGe+Pr=gXt=MetcK22C7aVrv5hQ@mail.gmail.com>

On Thu, Feb 05, 2026 at 10:56:13AM +0300, Artem Shimko wrote:
> Hi Andi,
> 
> Thank you for your review!
> 
> On Wed, Feb 4, 2026 at 4:43 AM Andi Shyti <andi.shyti@kernel.org> wrote:
> > the dev_err_probe() changes are not mentioned in the commit log.
> > Can you please split this patch in two, one for the
> > devm_reset_control and one for the dev_err_probe?
> 
> May I suggest to keep the commit as it is? From my point of view this
> dev_err_probe() relates to changes of the reset. Otherwise, I'll have
> to return the reset_control_assert() to the first commit, that's
> unnecessary when we use the
> devm_reset_control_get_optional_exclusive_deasserted().

I'm sorry, it looked to me in a second look like there was one
dev_err_probe() replacement independent from the patch. The patch
is fine and I'm going to apply it in i2c/i2c-host-2 (it will be
sent as a pull request next week).

Thanks,
Andi
