Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57E3033D6;
	Sun, 14 Jun 2026 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781474221; cv=none; b=ZFUjGIlU6LUyBW1zbovBi9AAhqC/ADH9ZkJAqQTHWOWsQfA+k6nBraFCQfh0n3kAvToDSkBl+5x4bH/ZTf6Q20ZwXb4N/ZJW7oj/FJ7ztKLQ/D8NBsUIgbEWfhBKsqCXXT3txHT2g/PpzvCkiGAv3Cnrzh6UWRhZi0o3L8ILD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781474221; c=relaxed/simple;
	bh=gfusoYhhMiuoPQpRGJdqyX4ld/v0QKaqXCmJ/8lB/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV2vHqlnEZQ0P4I540zNLFtKSg+w17HDWtCYTnOKzvDSj3K4k2S9TabpAkmdt+E4AeTV+eGRO9J/2d//qiEX0pXn57fXNR7QGQxg0brxzK63F3hqK6zMRvkHmKNNs8LdKf9Zu36c2qbkmYop7oMzWtzy3G17nQeNW1TZEEJ1uXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZnAVylU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZnAVylU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B51F000E9;
	Sun, 14 Jun 2026 21:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781474220;
	bh=sOWyGm51W/mqIx1mwo8p9nJO4HnEzPZLwUGuJu2ou7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XZnAVylUkcuGpVW8AJ2q8GSfbcXhryv5xbZYjoYQNWTYCxVam61f51zA/YOyeX1Xt
	 CEnzSWsEcgfz99hKszENzA0DovQfhUE7otkKGYLsayD/GlWatBrjr50/ku+Yaemyss
	 BtGSDPtxkmaJ3iYJRJZWH410o2poXlgPnppDh62uyQkByJ9sUc1fZpP7yKC/4L0vIM
	 /ljL4zKDZhaaZafxiCarZg50YMsHGEddnMAbxwiMMLdqYVC6TvSkyacqd9fLqa0unI
	 JIt5q4gyAkvJwuKAFYun4TI+t/sdnG3sr/iT3hPhs4wZtpyVaIZQIB4PKyOSl2pAvL
	 y3kf+5UhlGIsg==
Date: Sun, 14 Jun 2026 23:56:55 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, mario.limonciello@amd.com, brgl@bgdev.pl, 
	basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org, 
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH] Revert "i2c: designware: defer probe if child GpioInt
 controllers are not bound"
Message-ID: <ai8jhK9hUGHpojB5@zenone.zhora.eu>
References: <20260610083701.18663-1-hardikprakash.official@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610083701.18663-1-hardikprakash.official@gmail.com>

Hi Linus,

On Wed, Jun 10, 2026 at 02:07:01PM +0530, Hardik Prakash wrote:
> This reverts commit ef76a3a28c79b628890431aa344af633e892035b.

Is this in your branch?

Thanks,
Andi

> The patch causes boot regressions on multiple machines. A NULL pointer
> dereference occurs when agpio->resource_source.string_ptr is NULL (i.e.
> when string_length is 0), and a probe deferral loop causes CPU starvation
> leading to kernel panic on Intel CI machines.
> 
> The patch needs a proper rewrite addressing these issues before resubmission.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Hardik Prakash <hardikprakash.official@gmail.com>
