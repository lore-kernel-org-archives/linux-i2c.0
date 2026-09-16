Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126D357CE1;
	Wed, 16 Sep 2026 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539006; cv=none; b=hsRqpzjACwBmJ+KnJ5CIXxiS/IbDtJbz2EdCR2xIlJCYD+wrlN2TDOR5CozCKU0HpkzN/mrTws/t3bnArN6k0PVDxFi9XpfgAs0mDLcX600bcWc2X42wctY3ocJdHcPAa8KywB1nuvj/fLucZkP3qezz7d0kX25KrdD3pwz7Eso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539006; c=relaxed/simple;
	bh=cgmZUj37znDWHLe1/1qVDF0HFfyqRXUjGanSdGoxQmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXh5gr1C1bNLT+WWWv113euZn8o5reeIYRxxR2J6UD7RvdeX21nTzJ879DXUBEk/x693tN4beF5gfZCoMaKKcnJd3EiiTZkCo5bv/Rgv1sRsA462buAmD9gx+miOu+sUMOUUgXVeq7CA65Y7GNUYcGRoLPFPyV/B7Yq23u7vE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcuhtJlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcuhtJlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E848D1F000FF;
	Wed, 16 Sep 2026 06:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789539003;
	bh=2suWbUO1++tl2GtDPvL7vT4XRH9qSp7387WoQtb3opc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EcuhtJlU2oyKYUerEcaeP1JAQdy9+pthcr9c5F8mt6pRBx9QlMgANwk353gJApHYq
	 uIJRK7CGLeyWJdfzTfYY6h14+tBTMksR8zDwPCwMn8YD0hhSzF445QuZWLywvu/l9Z
	 8Y4x46nTAuJ52tDhYFoXtkGg5HUmL/s/0EBkOC8D4gDcaMu4Z5eUN5ZyKNpaEF+nT3
	 AsthU1Zvjr6aiWwkYdNuV0Cld8MOfSuWLy86fxcxEFdgEwStwh1mRNxhRzLRaBLzZq
	 Kq0XAPP7oRCrhHehhaU4GzzwJQQ0VrqfL1FaIfpcwnEYO3TKKhSTQVXvM3q0SYTwau
	 IyLzT85TYv+AQ==
Date: Wed, 16 Sep 2026 08:09:59 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: atr: fix dangling adapter pointer on add failure
Message-ID: <aqoykvwKbsFS81aO@zenone.zhora.eu>
References: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
 <20260907071102.1080840-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907071102.1080840-1-gonglinkai@kylinos.cn>

Hi Linkai,

On Mon, Sep 07, 2026 at 03:11:02PM +0800, Linkai Gong wrote:
> i2c_atr_add_adapter() stores atr->adapter[chan_id] before
> i2c_add_adapter() so that the I2C bus notifier can match child clients
> during registration. On failure the channel is freed but the slot was
> left pointing at freed memory, which can lead to use-after-free in
> i2c_atr_del_adapter() / cleanup and also block reuse with -EEXIST.
> 
> Clear the slot on the i2c_add_adapter() error path before freeing chan.
> 
> Fixes: a076a860acae ("media: i2c: add I2C Address Translator (ATR) support")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

pushed to i2c/i2c-fixes.

Please, next time don't send v2 as --in-reply-to.

Thank you,
Andi
