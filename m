Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A2448B8F;
	Tue, 28 Jul 2026 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266723; cv=none; b=TpB5KWMEPbgGf6EK1zZrrBaVMr9WgcPei4HWkjf2BMcP/sQXFgP+3RMbGXIK0AE92DEhgtO+rt/cQ/rWN9kA6ianBaiOMc7nZ4nu7ToaTtUne8LRmxyDbZlgeKj1wwRp/+DIUeMYN8PH/0bqQnspqxzBJ8O0RQkH6YyG5u8ZaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266723; c=relaxed/simple;
	bh=rficOr8Ws8ZOZBZp0SRXi5JpPZ43FLgD/z8K2JYvSAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUQACw2sLx9envDS3596uo9Se5JaxlodGLE/J9xvSxmgzMpbOu8dyWhrKSY6XmGOGo7dMOJdFN/Q/d/U0dvtEpzlpuJ3e68ovdufSzqm+yNtpCVKCqsU6yD2RLTqDctMep+BoDfQAf7O8WlWb9Zmv21v8R0zqiXKuATRogkAPYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKqVUeJf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKqVUeJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4A31F000E9;
	Tue, 28 Jul 2026 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785266721;
	bh=aXXghq0ck7/bZz6/RnGVHHpMOUZUuu1W1BAVs1A2zeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IKqVUeJfdE7K+xUG2xcvJ0YDr8KQtdcJAjS4rRTZ8PblXHITibpoUo2CdC3y55/oN
	 zg9SmeR/1F2rZZc96g2ApvP/PV9pg8IdbOQNhmZNhIbOwB5i+4C+TivJAuAo48ApiZ
	 jW7Z/pyxxz/lzO4IwC78FN/9vNkWrlPrSP5eV08AVJnvSGLiVX/nIEHSlMm/v15Opa
	 wtfBxOpV6dyn3vkbNvfqTlIFGQ8LNICEdp3sT8VPnGK9GOK9ZZWJIs74LJD7QHKQhv
	 a6ocodRwI8MzOlpi79lsxypWRMhvuhdwm682NURs/ZzPuv7HfL6hLYepCtLb8orszc
	 Kvv0RKsjoNsMw==
Date: Tue, 28 Jul 2026 21:25:16 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, linusw@kernel.org, 
	brgl@kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sander Vanheule <sander@svanheule.net>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] i2c: i2c-gpio: Enhance driver for buses with
 shared SCL
Message-ID: <amkB2rm2Ochu1bxJ@zenone.zhora.eu>
References: <20260714162915.3018703-1-markus.stockhausen@gmx.de>
 <20260714162915.3018703-3-markus.stockhausen@gmx.de>
 <alfvXUq_lNXhKQZk@ninjato>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alfvXUq_lNXhKQZk@ninjato>

Hi Wolfram,

On Wed, Jul 15, 2026 at 10:36:45PM +0200, Wolfram Sang wrote:
> On Tue, Jul 14, 2026 at 06:29:15PM +0200, Markus Stockhausen wrote:
> > Some lower end hardware (especially Realtek based switches) are
> > designed with multiple I2C buses that share a single clock line.
> > E.g. the D-Link DGS-1250-28X realizes 4 I2C SFP busses with 5 GPIOs.
> > 
> > Enhance the i2c-gpio driver so it can handle such hardware designs.
> > 
> > - Detect shared SCL GPIOs that are used by multiple I2C buses in the
> >   devicetree by using a "unique identifier". This is basically the
> >   phandle and all additional cells.
> > 
> > - The first probing instance allocates and requests the shared SCL
> >   GPIO with an associated rt_mutex. Subsequent instances detect the
> >   existing entry via the identifier and increment a reference count
> >   to reuse the descriptor.
> > 
> > - All data transfers are serialized via custom lock_ops that handle
> >   both the standard adapter bus lock and the shared SCL mutex. This
> >   ensures mutual exclusion across adapters sharing the clock line.
> > 
> > - This shared SCL detection works only for dts based systems where
> >   the GPIO node has at least one cell (usually the pin). GPIOs in
> >   legacy systems without devicetree will be handled individudally
> >   as before.
> > 
> > This patch was successfully tested on Linksys LGS310C that has two
> > SFP slots with two GPIO based I2C buses that share a single SCL.
> > Test environment: OpenWrt snapshot ported to kernel 6.19.14
> > including CONFIG_GPIO_SHARED=y and CONFIG_GPIO_SHARED_PROXY=y.
> > 
> > Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Tested-by: Sander Vanheule <sander@svanheule.net>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for testing this series!

> Cool stuff! It took a bit of handling gory details, but I could not only
> check that there are no regression with non-SCL-shared busses. I could
> also try two busses with shared SCL and it worked like a charm.
> Congrats!
> 
> Andi, from my side, you can pick up these two patches. I will put them
> also in my 'for-andi' branch to increase their visibility.

are you going to send a pull request at the merge window or can I
pull it? Either way works.

Thanks,
Andi
