Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB770379EF2;
	Tue,  7 Apr 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594645; cv=none; b=ouskxI0tTTZTFyVxCWTBrZ3uT1Is+lkGi2iiX10sAhGOzZfUP2J5/wJT1wCrpu3bCn+CGL5IwUtr7PB/jHIuKfvtmM2Ugcf58ta25LgltipdHkRMovAL1dtrZtpHrF/1h06y7mKzu4tTg5F5iU3w/jkDsVKyXWGZrEiQwF2BYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594645; c=relaxed/simple;
	bh=ds5g5d0oS4MQyIT0BsNumaIh8fLF8x9rw6OQMpQU+uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLbSMO9d+HBxTVxviyN2ZFvK9l4Z5lket1LiRDJDdtfRc/Btf7wpJU/Qw74PeI1Mv7WfpNCpoqy1yWpQs5V5ydo7rxfhkMxY4hdv/6OiFNpdugMSkW01Y+P9Yb0ejulFEs1peaimNmdw7fPw9eOnKIHPTee4h3/L01vhcj03uig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHhCe4tP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHhCe4tP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12689C116C6;
	Tue,  7 Apr 2026 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775594645;
	bh=ds5g5d0oS4MQyIT0BsNumaIh8fLF8x9rw6OQMpQU+uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHhCe4tPmGbkZTpZN9Rrs8D9dJOiIv2+bHWFiMZ05TIVDwiWNoTVOdsISivUCHNdY
	 uCuf/fSBK6RrsOStoyi2Okr5nk4MOznSQj10P3JNd/6irEulWYqNBPnKslaDUQIJ3f
	 Hj+V7I+uJcQFzJAgHHV+lrK9Gb8PQDExW7z4fv93cQW++Ewq9qBpP2QPRoWGq0l6Et
	 /r7HB6hAI23z8VWUxp+IfNQ/IyUTqRyP1I0y1UyTHm5Jv28gWGNiAAO2XFgdEKBAc0
	 y5vUDrgnoN632A0GrlK152WVlrb87NPl6IEJCSqpqS1eBli2miQHa6Za+VbO/ZGA8h
	 fBG0bbMHEtcfQ==
Date: Tue, 7 Apr 2026 15:44:02 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
Message-ID: <20260407204402.GA3641251-robh@kernel.org>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
 <20260331-fanatic-certain-bustard-fb13bc@quoll>
 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE64B7988CD85A7189164E1F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Tue, Mar 31, 2026 at 07:30:58AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add global-regs
> > and enable-dma properties
> > 
> > Hi Ryan,
> > 
> > > > Sounds reasonable, but before you do so, how are you planning to
> > > > manage the allocation of DMA channels across multiple i2c peripherals?
> > > >
> > > The AST2600 I2C hardware has only one can use DMA at a time.
> > > To avoid the complexity of managing DMA channel contention, I plan to
> > > use buffer mode by default for all controllers, which still provides
> > > better performance than byte mode without requiring DMA channel
> > allocation.
> > 
> > OK, but your wording there ("by default") implies that DMA is still selectable
> > for one controller peripheral. In which case: you still have the problem of
> > managing DMA channel contention, but now it's at runtime instead.
> > 
> > So my question still stands: how are you planning to enforce that DMA is only
> > enabled for one controller?
> > 
> > Or are you planning to disable I2C DMA entirely on AST2600?
> Yes, This is my intent to do.
> Disable I2C DMA entirely on AST2600.
> If I remove DMA, should can I keep byte and buffer for sysfs? 

28 versions and it's still not clear when you need what mode. Sigh. The 
only thing better about sysfs then it's not my problem, but that really 
doesn't sound much better.

DMA is only going to be useful for transfers above a certain size. If 
you are doing the typical SMBus style register accesses, then DMA is 
completely useless. The setup DMA overhead is going to be greater than 
just directly reading/writing the I2C controller FIFOs. What's the size 
that makes DMA useful? 16, 32, 64 bytes? Something greater than the max 
size in buffer mode probably. Really, provide some data that DMA gives 
better performance and/or less CPU usage. If you set some minimum size 
and request DMA only above that size, is there really that much 
contention? If there's some specific device that really needs DMA, then 
make that device's driver request it and reserve it. 

For byte mode, there's not a clear need nor description of why. Someone 
once long ago asked for it... Who cares, if they really want it, then 
the issue needs to be described. If a certain device requires certain 
timing that byte mode provides, then that should be some property the 
driver for the device communicates to the controller. No need for DT 
nor sysfs in that case.

Rob
