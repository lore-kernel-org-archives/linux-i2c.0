Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE113635E;
	Wed, 18 Mar 2026 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806138; cv=none; b=lSiahYKrGsmEGE8X6gqcW8YKrUb+8crn8rA2rJxRDHSfmDaGWwlLiukyXJc3N7IzFmEdd+zXnc+vxiTEv1lshDOJQr/aR1kZ9wELjvR0FJf8fRtOgw89v5ghutTXFGfScUK9/t4EBepnuP1sEXYGbYTA9V5dYUfwArGMDhAq12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806138; c=relaxed/simple;
	bh=XcCPj0djZ7iwvsvLXAAWU0n5yU8OTGIc1kAvZ/CFY3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liCiSg1XD3zsFwlA9pQvpT6pF0QgCBr3mBx6clriKqEIlz6BYfXIuizx5j3ISSW436umMzBchePb3xq7TwTHOIgxqZCy88gEPh/cGqQf/xHaRVQTm6Ps5L4rNnH4Xn/ltaeQn+RBpZ8ZZZlbBhci9/vKPTwtvDHIPP6SKEz8zyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ETg2cZME; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ETg2cZME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773806134;
	bh=XcCPj0djZ7iwvsvLXAAWU0n5yU8OTGIc1kAvZ/CFY3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETg2cZME6M6ho60BQ1zKAgYALPDMsyF2RAOX6zfhHWI+bdZp+BGK5bBpfFd9H0mTW
	 aiphV7IDK/bb4zHyuGpJdyrLQ5fugH6PzttqLVSanSt5GXmc9CCOKKQl/tW8lxhmlC
	 WLSNGYlk4sJwUBNur404RnG0EpKHGNGgkkbssZeAVFSNAVYLGzhBKH8Bb/gGZOEHa5
	 OxmSOrY6fYv7m4/EBxGZKfWbSUIKrRxpYS3VbOYJ1ApxPFyj0mQ3Gtr2Sz65u3YZ38
	 Cjfh33eBCWVyz9BxhygBdGPXm2xOU+1ZgvQnTkDdzyxo8vFACUoZmh4uQxIVMe79aN
	 rxfnt/GXYSduw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C0E860C33;
	Wed, 18 Mar 2026 11:55:32 +0800 (AWST)
Message-ID: <d5ae7e63dd5a39ffa26002a3a5988eb0d74cb189.camel@codeconstruct.com.au>
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
Date: Wed, 18 Mar 2026 11:55:31 +0800
In-Reply-To: <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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

> Do you mean sysfs select support mode selection(byte, buffer, dma)
> Or just force byte mode?=20

I would think that the best approach would be a mechanism to specify the
mode - either byte, buffer, or DMA - if DMA is indicated as available to
the controller.

Cheers,


Jeremy
