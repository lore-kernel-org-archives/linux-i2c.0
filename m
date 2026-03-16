Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AE625;
	Mon, 16 Mar 2026 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626117; cv=none; b=I2AFlNmG1ZEvXZekSJ2Ibl4jGfw72wfFAf7tO48TelVvSaw6O3KHM504t+Qzp25JJjhkOl5198mQMvNQwn+8SNyLC/qBm8O3Bwkn4Yps3zxy8zY3eGgbGxlzEER2tbmXQTRNdUKTj+UdnND6teAo79HjoFUFDkwmllHrI+dAT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626117; c=relaxed/simple;
	bh=QITUD6ytsc7k4ZZ9XnT0Up9p5WK1RUufuN3HYrKw+2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yps0jqT/EwgavePJ0Ew9zZVoK5jdEjCqWBjFQHuCs9NY6gJTVi4PRMS5E8vglaYt2hT/M3MF2jov/uzGxe8v9nlx2jlICeX2F08x8is1Gzf07StL3fmiMZ5D7uPFECLVSuD2+cNPyrxKxrWPuBopyKtzPwC6RjWyi4xkGUzD4W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=c4ExRsyn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="c4ExRsyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773625789;
	bh=nkGznBF1XyO8DVSgDpTBwSZfSOT93qCEm7hJnIBqTf8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c4ExRsynMm40V9We4mPTyAQ1gMSRmWj67Whu9oyw2qfM5dhrnt1Za/xhR24MZzEjE
	 wE6BS33UEf+oWRBXfIrfXIgaLjxZCscKQEyaW2ILSaH7sVj/3S5aKwXOZOX/JdAGtK
	 oL1ErnHTMy6VKZbjzRCFZ4/PEBSFNTHSJ5/U87wbIKJ43/0QVIQhMCotzD0Pnj1rh5
	 OFkJHP1MuIe3Mn6su+WhadLr+OpA0579MY9xO+u9yHWRsEqrsQpNOI9twi3DvWA4mH
	 uCLYz46YLZXeYU6Y/sVdaFd9g9ec13XAyajn+VC3M3M70j03sOHZQlydpTRGRW/KT3
	 ot8IedAXEoYaQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 74B1960929;
	Mon, 16 Mar 2026 09:49:46 +0800 (AWST)
Message-ID: <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Mon, 16 Mar 2026 09:49:45 +0800
In-Reply-To: <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ryan & Rob,

> > > +=C2=A0 aspeed,transfer-mode:
> > > +=C2=A0=C2=A0=C2=A0 description: |
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASPEED ast2600 platform equipped with=
 16 I2C controllers each i2c controller
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 have 1 byte transfer buffer(byte mode=
), 32 bytes buffer(buffer mode), and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 share a DMA engine.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Select I2C transfer mode for this con=
troller. Supported values are:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "byte": Use 1 byte for =
i2c transmit (1-byte buffer).
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - "buffer": Use buffer (3=
2-byte buffer) for i2c transmit. (default)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Better performance then by=
te mode.
> >=20
> > Good, I like worse performance so I can use byte mode.
> Thanks your review.
> Will remove performance statement.

I don't think that really addresses Rob's point there.

The selection of mode is somewhat a driver implementation decision (and
so would not belong in a DT binding) - *except* that there are
considerations around the use of hardware DMA channels, as covered in
earlier review.

[My understanding is that the mode needs to be defined here to select
which i2c devices have a DMA channel allocated to them. I also
think that byte mode may be useful in some scenarios, but that
consideration certainly does not belong in the DT binding spec]

So, how about we refine this to *just* the hardware-specific component:
whether a DMA channel is allocated. A driver implementation can then
select the appropriate mode (dma, byte or buffer), depending on
implementation-specific details.

In that case, we would just have a boolean property, like:

    aspeed,i2c-dma-enabled;

- to signify that this controller may use a DMA channel. The choice of
actual mode is left up to the driver implementation.

Rob, would that suit better?

This way, we don't have ambiguity on "buffer" default vs. absent
property, and we're no longer specifying actual driver behaviour in the
DT.

Cheers,


Jeremy
