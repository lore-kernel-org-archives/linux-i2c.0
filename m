Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D493FAE14;
	Wed, 25 Mar 2026 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457554; cv=none; b=oNV8J5GgxgpKhhbaATLSNj6krvnZs0UCkiw5AmoXW/TLXawrg0Nmi8WkvtQySvPFyq6ZAyKuJ3ACSETW3VfsZ+Pbxs/jGWcte9BAxqEJprl2P7kLFT4KUbw7/cyVx/hT7Pp+TKIeKzYiQaxCKPTY2s1crzSVsQCvj0AWGS2idwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457554; c=relaxed/simple;
	bh=pWOqtv6jmpKLYd9pPWq7muuvSWKqfEOPOAHMJ6IkXEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvlPvVAMVgSNooAc3XQRPrdIZLymYSX77Is/UiaBj8mGN9aZDWRYhMW6dsIJFvrCMMXizHo49tN10sw7mwS5FgfDKXrOOoMnWedikIkb/oH5ok4ZGWB6pbHLxtbynOF9WdLQGXGxPUuUEJPCcU9fdtaIkBDv88DhlrmGkS+yOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eANHokos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eANHokos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F026DC4CEF7;
	Wed, 25 Mar 2026 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774457554;
	bh=pWOqtv6jmpKLYd9pPWq7muuvSWKqfEOPOAHMJ6IkXEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eANHokosIVd5KD95xp+HQHRfvXeuEHK7Eo6rbRCk32CsXyhlZFVFE2ezxytgD44zU
	 ZjYbNSKo/8j6WtbSSI3hYpj9HcFPD5hrfB/Y9thx8togWdftQf8QN2swMcN+5jdHWl
	 PZiiqM95vlHF3pO+VaVFD2HUUvhksmVKV1AcKQsFftLkZ8RvQQ2FO5ikayoqBf+3OG
	 /LkA3oXJTWAM4YYUJLWe3nCCg7XqPkqfD4nBpNDjw/lV08H7YZHYkgLYtdg3MHBic4
	 OqG/BVzr/uCUsDzNpOUrXND7FnQuVkffbmLkBWeDf/5GhrdHVuwN1gWHBoM4kvKgZE
	 J2shInOqyYJsw==
Date: Wed, 25 Mar 2026 11:52:33 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Message-ID: <20260325165233.GA3782899-robh@kernel.org>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
 <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Wed, Mar 25, 2026 at 08:11:54AM +0000, Ryan Chen wrote:
> Hello Jeremy,
> 	Thanks the review.
> 
> > Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add global-regs
> > and transfer-mode properties
> > 
> > Hi Ryan,
> > 
> > > The AST2600 I2C controller supports three transfer modes (byte,
> > > buffer, DMA). Add "aspeed,transfer-mode" so DT can select the
> > > preferred transfer method per controller instance.
> > 
> > This patch does not add an aspeed,transfer-mode property.
> Will update use aspeed,enable-dma

[...]

> > > +  aspeed,enable-dma:
> > > +    type: boolean
> > > +    description: |
> > > +      I2C bus enable dma mode transfer.
> > > +
> > > +      ASPEED ast2600 platform equipped with 16 I2C controllers that
> > > +share a
> > > +      single DMA engine. DTS files can specify the data transfer mode
> > > +to/from
> > > +      the device, either DMA or programmed I/O.
> > 
> > As we had discussed: this does not define the transfer mode, only whether
> > DMA is available to the peripheral.
> > 
> > Why mention the 16 i2c controllers here?
> > 
> > Please keep this description simple and relevant to the specific purpose of the
> > property.
> 
> Will update with following.
> description: Enable DMA for transfers on this I2C bus.

You still don't understand the distinction. It's not enable, but that 
the h/w instance *has* DMA capability or not. It is still up to the OS 
what to do with that information.

Rob
