Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AA1A9F87;
	Tue,  3 Feb 2026 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143494; cv=none; b=EujCdfVpWDnTUX2pucB/5faXh7DdcFL0EbPII1U9zAMt6wW95elw2mTMOoKSj68TsYuFvgS4JcVv9InydWQcGOTy9JG4gCE3xsqLJ4Xa436zsyuDyU+GnFwyGu8LUtiMfyK6cY4jmTc95TDUIBc9C/RNN9oWTtXuhHicpXSQ58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143494; c=relaxed/simple;
	bh=klo4mWR0C8BMMdkc2TvzV97w4+uPhmy5Q6suirxcYLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idKcQv0B2CnUN7WjqN+SI0L2yzlXdsaqhChMSA1gPWbvG1hWaDchRbW9FVJlLtauIP/Leu1JPxh8zeGycVefGTiFacYOPB2RjYz2WElkmTzKPwfh+fW99wahDEV2Y56r1S71frjGGqtQJT0Hoq8FD7Ez8tpaiSdAZyF8iL/Ddus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dg0zxwih; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dg0zxwih"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=QIMe2Ioc9UGdW9LCRhcDlXsMqIA76N7uk6YtpDu6XO0=; b=Dg
	0zxwihO5hnaB22iXug5cUAwg3shTmwFRLbRfMmwskVoSrDLpX/62Mu0U9pjy5OAhK0igJF/5iO+O5
	rIHb4qtD4pQUQkG+QX5zPdpxsdVgZaFLBuBzZEndCfxunRz9REjuQi+Y9NAT3oi915SzENQLVz0pQ
	JgdgHHUDD/ZU6fw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnLBI-005z49-Pg; Tue, 03 Feb 2026 19:31:20 +0100
Date: Tue, 3 Feb 2026 19:31:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 6/7] i2c: xiic: use numbered adapter registration
Message-ID: <1ac7be34-22b1-4d93-9957-fc7ade9a2649@lunn.ch>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-6-ce4695f5267d@nexthop.ai>
 <aYIYBheQgIN71os8@smile.fi.intel.com>
 <2F830E87-F00A-4A54-A5CC-E59BD2C5C7B2@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F830E87-F00A-4A54-A5CC-E59BD2C5C7B2@nexthop.ai>

On Tue, Feb 03, 2026 at 10:14:49AM -0800, Abdurrahman Hussain wrote:
> 
> 
> > On Feb 3, 2026, at 7:45 AM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > 
> > On Mon, Feb 02, 2026 at 08:37:23PM +0000, Abdurrahman Hussain via B4 Relay wrote:
> > 
> >> Use i2c_add_numbered_adapter() to allow platform devices to specify
> >> fixed bus numbers when needed.
> > 
> > Not sure about this. Doesn't it break the current approach? Please, double
> > check that.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> 
> If pdev->id is PLATFORM_DEVID_NONE(-1) then i2c_add_numbered_adapter()
> falls back to dynamic allocation and calls i2c_add_adapter().
> 
> Many existing i2c drivers use the same approach, see i2c-pxa.c and
> i2c-pnx.c etc.

It is not about if other drivers do this. Its about does this change
the behaviour of this driver, so that I2C busses get different IDs
then before, and so cause regressions?

You need to explain in the commit message why you think this is safe.

    Andrew
