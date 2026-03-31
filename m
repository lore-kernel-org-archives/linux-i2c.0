Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415840DFCA;
	Tue, 31 Mar 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941452; cv=none; b=BkbZXaMs6p9iMP91uDBFYco+EVyodnzgBtIjQyzuueEk+LKpGnE3hmfEVbAWmmSgRpe7SEONzL+VzrlR+2soBPK6NzFQELt+JUy46uf6tTijqFE/EcfJd0VVHx+gwE2deS6Ngyx5ccyRnC3LzihzJeFIEoa15bb8Pf3/J0nxGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941452; c=relaxed/simple;
	bh=qkbimkF7HoXE/Jf1vzsZkAfNbNEc1Y65ZFXjx0QhOzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hY6ltcuZWrtCTCzkppkUt2aoWr523/Ctbhs6xtXxx+NCz1LJCV/RP0xX/fkzKemO8/zMxL1J0aUpGBoA0PESdqJ2ervy0xQEmtg1GwshqVlymRE/Iym9RTs25LcQVvGTnXh8tDAG2op3V8qmd+LlwLHKaXxmPDbQIK9BlfuiFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NISHE6MX; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NISHE6MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774941448;
	bh=qkbimkF7HoXE/Jf1vzsZkAfNbNEc1Y65ZFXjx0QhOzM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NISHE6MXoK8tfRV9S8pt+leeucFZ70wxemyKXKi9pRF+a6WzkAGIquNAVMhKf2cnG
	 YN5MOUGglqn76zKkmoH/lrTvgp8y8TAQJXrZIOd3X/VQwwzBZWwBnHnDKY54P56KGx
	 XcB6sQ8EvgaaZQZkMHg5IsZzaH4wlCvxsA87d9poVrwV3A8tkMtbM4j6rgTVkkVLdi
	 TNjJawi4Hvre/DNptnvZk6d650ymJ9y+B5x7pjivv+j2W/GEJ6aEu2cemVW7T2VGaX
	 WTpk7L2R3bDnuaKMlcpG8Ff9O4/81GyOFLTUht1LMBFiTKMMjYE7AOQxcDFQzKDG2D
	 8CH2GwMt2fcoA==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3163E6002E;
	Tue, 31 Mar 2026 15:17:28 +0800 (AWST)
Message-ID: <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Tue, 31 Mar 2026 15:17:28 +0800
In-Reply-To: <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ryan,

> > Sounds reasonable, but before you do so, how are you planning to manage=
 the
> > allocation of DMA channels across multiple i2c peripherals?
> >=20
> The AST2600 I2C hardware has only one can use DMA at a time.
> To avoid the complexity of managing DMA channel contention,
> I plan to use buffer mode by default for all controllers, which still pro=
vides
> better performance than byte mode without requiring DMA channel allocatio=
n.

OK, but your wording there ("by default") implies that DMA is still
selectable for one controller peripheral. In which case: you still have
the problem of managing DMA channel contention, but now it's at runtime
instead.

So my question still stands: how are you planning to enforce that DMA is
only enabled for one controller?

Or are you planning to disable I2C DMA entirely on AST2600?

Cheers,


Jeremy
