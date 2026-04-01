Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5C2673B0;
	Wed,  1 Apr 2026 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079708; cv=none; b=JBa8rRwLhCyvO7Gj82ZWTRFqoAvFfBHtEFHb5eBARuGS15JDKrx9bWTk70Pa9HJPfSiJUgwKsh3T20rSN8WpX5Up+3vY5ghSf/MsA8ZE2bMYp5AbFQymC8UPkJQC6U+6xHeDnoMvEx0h+Nl9Ud+cSYdq3B57Gn/IzMjPZ6CDTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079708; c=relaxed/simple;
	bh=cOpJyFRQaeBvVLZ75XgMKomIyEvn48drmPaRwbXAwM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5AZclBzaQ+/5nocQ4CPGywNtT2Qhk9k1p/iXSXD4SewCy6xk0wnOMtN4z3eARVWFWrh2ZAXPPd93TZd6pS+eZ4xto5BtZTW+PswEns2PIOqnFkppBf/jhKZw00jDxP+o2HN7PYjDyu2iI2pxCCiRgnnKSPhF/Hk9Qg1wCSj4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4skxSUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4skxSUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D24C4CEF7;
	Wed,  1 Apr 2026 21:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775079708;
	bh=cOpJyFRQaeBvVLZ75XgMKomIyEvn48drmPaRwbXAwM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4skxSUoKqBPyEvWj2cpJYp6lEpo2A4CuP0H8lWt4g+ZRaoQGdTQrbNL3cuHAXLxp
	 eMhHJUWMnEqVvgJpfxHiymV3pY6SHQX8CndkiphBh/H8AFqY8TuD5X4Vp4bz8X/tyI
	 yAHGg7hlvrNyJ44Zlrw4avBjMWSK7sc1q6aXCdUEF2KZh0JlmRK3AVXfVsluUJ1tqf
	 Eduqf7v0AXlF/F8J7Na/R977n9pcfex/jH/X1MWcvWKeBC29T7RaFxET7NyFoYzO9l
	 3+B2kzh5JVYJKR0GR8+UDADfuHLF6Y4Ku4De82ORTciReH9OtzpgQQ42K0FvdKo426
	 Ky9IIZ+15LYWQ==
Date: Wed, 1 Apr 2026 23:41:43 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] i2c: rtl9300: support for RTL9607C I2C controller
Message-ID: <ac2QI46UPfHxCiBl@zenone.zhora.eu>
References: <20260326152656.14030-1-adilov@disroot.org>
 <acxMeyVpRh9nts3d@zenone.zhora.eu>
 <049adbc3ec3b15229684bf26c167f1a3@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <049adbc3ec3b15229684bf26c167f1a3@disroot.org>

Hi Rustam,

On Wed, Apr 01, 2026 at 02:09:35PM +0000, Rustam Adilov wrote:
> On 2026-03-31 22:38, Andi Shyti wrote:
> > > Rustam Adilov (8):
> > >   i2c: rtl9300: split data_reg into read and write reg
> > >   i2c: rtl9300: introduce max length property to driver data
> > >   i2c: rtl9300: introduce F_BUSY to the reg_fields struct
> > >   i2c: rtl9300: introduce a property for 8 bit width reg address
> > >   dt-bindings: i2c: realtek,rtl9301-i2c: extend for clocks and
> > > RTL9607C
> > >     support
> > >   i2c: rtl9300: introduce clk struct for upcoming rtl9607 support
> > >   i2c: rtl9300: intoduce new function properties to driver data
> > 
> > Patch 7 does not apply (not even in i2c-host-next, next,
> > mainline). Which branch are you on? Can you please
> > rebase on top of i2c/i2c-host, please?
> > 
> > Thanks,
> > Andi
> > 
> > >   i2c: rtl9300: add RTL9607C i2c controller support
> 
> As per the request of Chris Packham [1] this whole patch sets depends on [2]
> to be applied
> first before my patches.
> I don't know if you have seen it yet cause Jan Kantert didn't include you in
> the emails to
> the send the patch to.
> 
> Although, i just now have noticed patch 7 has a typo in its commit subject
> which i have to fix.
> 
> [1] - https://lore.kernel.org/linux-i2c/c933a245-2b35-41a5-9eee-cb655c8231ae@alliedtelesis.co.nz/
> [2] -
> https://lore.kernel.org/all/20260227111134.2163701-1-jan-kernel@kantert.net/

Thanks, I overlooked that. I will follow the dependencies.

Andi
