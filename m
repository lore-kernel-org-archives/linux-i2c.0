Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563232C0261;
	Tue, 16 Jun 2026 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652138; cv=none; b=VutbrxrcdH/ZP2KJ5FekjC800vMWwEnIL7meLBAfu6ch0ghYaX4IFhb1PgnyzOxGKaa5esZRazIyDMmsfCJX4DMV0IhohsHayzZAaxRXq3lke0Ij1hd6qfHQWt8N0VXXeJVA2j2PjABqbjKs1kX3daBbmWpOl2v1AFm1mdG07tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652138; c=relaxed/simple;
	bh=2jQrBW9e7jyrArgAMgVsm+mgjv31CIQ1YF4g3psNk/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT6VjLHsVLv/6vYKiqHUohGLAXVNuOyv2voXe560yCFPwT7SIGYzGyHcXGXz7dlEp+7YhBkodYmtIi/dFp5CrEYmGxumwa4gr8IAxcEkXvOYD9qELO9Jg/acqJ6buaD/OdhFqdtTmIQXdDj0YT5yGMHv00s/CMQEBWdUs3xQNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsWL+wN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsWL+wN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4911F000E9;
	Tue, 16 Jun 2026 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781652137;
	bh=YdNsyLS0xIRwFOePOCO4/JAdhTSZodRRJEfOsB4tgZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MsWL+wN2diqyyIlRE/08CgMYkbsXvg7JX6Afz0m6trlE90T4HTQWDXKvvPU+cGjvj
	 cnVUEUy5GY2izXRf/iYGqdr81z4j91v184NBEtT+RFTkVW97oCpjYjGKoAQe0FkVuq
	 r/0a/U3Z3sdu7n+4+U9XggAN2DMhU0C4Ci3iGR86tcJrqBwKk9HaJi9o2XSnRDVyYX
	 PVRVlQezDJjMV6Njoy0VW4ipOb6vamgyBuMKG9BOlr142PpTXFx9DpX7fCYiENn8Ho
	 WmWZ71OiifqOnSVYeZFH1zHOCXN3WazmphunbBMTDbctV73y3jbKl+Yw2dngQTYNW1
	 XpOi+LkGCfZng==
Date: Wed, 17 Jun 2026 01:22:12 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
Message-ID: <ajHakkNAqWRCn1x9@zenone.zhora.eu>
References: <20260506044818.19842-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506044818.19842-1-devnexen@gmail.com>

Hi David,

On Wed, May 06, 2026 at 05:48:18AM +0100, David Carlier wrote:
> The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
> calls loongson2_i2c_isr_error() which clears the offending flag, issues
> STOP for the AF case, records msg->result, masks every CR2 interrupt
> enable and completes the waiter. The handler then returns IRQ_NONE,
> declaring to the IRQ core that the device did not interrupt.
> 
> That report is wrong. The device did interrupt and the handler fully
> serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
> spurious-IRQ tracker counts each error as unhandled. A bus that emits
> sporadic NACKs, arbitration losses or bus errors will therefore march
> toward the spurious-IRQ threshold and the line can end up disabled,
> wedging the controller.
> 
> Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
> neither an event nor an error bit is set, remains correct.
> 
> Fixes: 6d1b0785f6d5 ("i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C controller")
> Signed-off-by: David Carlier <devnexen@gmail.com>

merged to i2c/i2c-host.

Thanks,
Andi
