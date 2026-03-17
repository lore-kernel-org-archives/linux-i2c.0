Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9931326A;
	Tue, 17 Mar 2026 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773711833; cv=none; b=GQ59zcUVHBK1Fp1G6kgC/DO/BwTtMT5EamxxNVrOMd58xeXlfUj1NU9VRGw0ZorbwezyGF2x0K5H3soAZiDt/H4M0B36TwFfFiaqZzx08BZfJDps2BUJ2kBCwwfs3Kpn92oUZ979diO2kYmeva7XAbQWNix2xhg4vPoF49kdU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773711833; c=relaxed/simple;
	bh=9SmP2+4heY2mqxSh+2kpDHacvKUssfAIu1YMw99U9Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/TQ6Nq+OdZIVYJq007M6M/k8ced+JiOTGAZvgKDg2cHxvKh4NhujpDJmIP8J9jQCbZUjPkUo1eGldj4+Xsh0XtGbVvgxC+Q6tEGEpLtybwbkvZLyAkTIVHILaXoSdeJqPMxKVf/4d+ESzmgm8c1nvahnU7xCurzhizPii7bNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=BgZqPQgl; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="BgZqPQgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773711830;
	bh=9SmP2+4heY2mqxSh+2kpDHacvKUssfAIu1YMw99U9Uc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BgZqPQglYjGenbMZ0Xry4Vi0J1fUs7CVX0RMnYCDdEszoZdhji6xgedEDz+ah9kVW
	 Etk0ivyOAztnVJEysv7ZT9sFMW0Y8pv76leRIKsT3953qGb97mA+Q18A/AdmHw0lXp
	 Ey1/3IIKZCQFyjKj5v3zGbkfeNZ/BbblQa15T/hey98kRyWRFh1Te8r5pgMrUCeteD
	 w0omaMe3yiDJXxGrErJ5gJOaSL+2p5AKbEjB9Kcj8FzQ4FU8Iyws/jKEwklYPA2kHR
	 88XiwfeQr1IXCQJnuu1AYjYpIxlV3U65Dt3TCPkzsKQIUBDnLz7/V0xkb4UU6lWxsI
	 fk0uIShtMwILQ==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AF97D6009B;
	Tue, 17 Mar 2026 09:43:49 +0800 (AWST)
Message-ID: <9dec962eb510d947a458fd2318a3812d58b3553a.camel@codeconstruct.com.au>
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
Date: Tue, 17 Mar 2026 09:43:49 +0800
In-Reply-To: <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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

> Your understanding is correct; the byte and buffer mode is mostly the
> same. And also mode should be decided before xfer, due to the
> controller/target both use the same xfer mode, not decide by transfer
> time. The original my submit is only buffer mode and dma mode, and use
> only one Boolean property, aspeed,i2c-dma-enabled, but someone suggest
> add byte mode select, so I start to add at v17. I can drop the byte
> mode, if this is confused.
>=20
> byte mode request:
> https://lore.kernel.org/all/010e55e9-d58b-444c-ab57-
> ddf8c75f2390@gmail.com/

OK, that sounds like more driver configuration than hardware description
though.

> > Ryan: I think this gives us a much cleaner approach to the binding.
> Thanks the feedback, do you mean, just one boolean property for mode
> selection,
> Am I right?

It's less about "mode selection" (which is a driver implementation
consideration) and more about "hardware capability", which I think the
boolean property better represents.

The driver implementation could do whatever it likes with the
information about whether a DMA channel is allocated (and select a
suitable mode depending on that, and/or other runtime data).

This property only seems to be applicable to 2600 though, as there is no
need for it on 2700, if all controllers are DMA-capable.

Cheers,


Jeremy
