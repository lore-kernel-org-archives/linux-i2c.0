Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E723BCF3;
	Wed,  4 Feb 2026 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167494; cv=none; b=nYb34QnXPJbqzbwV7MCFiMsA+3OgTNYI4TEaTexVhKDn0FsLnk/IIu9pB9XkmPNTHYWA1GGQO4BY9nzbP/FWWsLWEBFWRuQxLGoDt64s1QxugVq+snKf4ialg8oFoS4APz/Uuv/PlflBeYZ/jCQC0lu1+0wkjmTHB8a0n699OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167494; c=relaxed/simple;
	bh=s3lTpYIuHg8HtlxmezJcghRfziSTcL3CioyEyTkqFRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amuvnp1EMwV6bAHvOso14140CJsURVbmoM77fNd2jUjm0/xByN3tInO5AHmunmUYZInoLrTx1xMXfUs7kEa1ct4A/YfidRZdchc1LJxfm1sSMUgkduF6n7qioBOnEQuV8eaPkNAAqKgj3X7g7gG/ovee3zv1UPtwFnT0HD2JlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2lFmhBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2lFmhBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651EEC116D0;
	Wed,  4 Feb 2026 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770167494;
	bh=s3lTpYIuHg8HtlxmezJcghRfziSTcL3CioyEyTkqFRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2lFmhByFND7qXjvgfs/szKRGNPi2tJ2Cj5gt9TEI3tzeqwHwK9LXozN3MAs7BN4L
	 NlKGBP02EVcvLINUFRrQ66c/y40Ng/o30IrWEV6AFtoVuM8PPgUzrG1EAGhxrm61Rc
	 8zysuDmNBAF7e0tlQ76+0MyLZRZncVKkuvHcStVrOoVPgy3No7cG/DbOouM/GOK8Ku
	 pH+A/ZQWhEAxuNCqEKiVvkA1GqxundSbQXTj0JVXxxwdxMKYiFSVqz/hChD74qqJM1
	 5T4RTV/3CMH1YlF+TdbkBd56nxkgsFRvKVSdCuCKBOMX522kSFiaSEm9AYAzx6PSgD
	 NSJEA+uBxg7nA==
Date: Wed, 4 Feb 2026 02:11:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v9 4/7] i2c: xiic: cosmetic cleanup
Message-ID: <aYKcc0IGO9jroObH@zenone.zhora.eu>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-4-ce4695f5267d@nexthop.ai>
 <aYIXagCXYb4DrDLp@smile.fi.intel.com>
 <DE565BCD-28D6-4844-BCEE-A1F60DC84662@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE565BCD-28D6-4844-BCEE-A1F60DC84662@nexthop.ai>

> >> Re-use dev pointer instead of referencing &pdev->dev everywhere.
> > 
> > ...
> > 
> >> - dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
> >> + dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
> >> (unsigned long)res->start, irq, i2c->i2c_clk);
> > 
> > No need to do this here as we change the format string afterwards anyway.
> > 
> > But I leave it up to Andi, I won't prevent this to go in, if he agrees.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> 
> No worries, I can do this in the following patch, since there is going to be
> a v 10 anyways.

This would be merged next week anyway, so, please, send a v10 as
there are many little changes (if we were out of time I would
have manually changed things before merging, but that's not the
case, yet).

Andi
