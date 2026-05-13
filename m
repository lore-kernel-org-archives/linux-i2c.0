Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7A389DF0;
	Wed, 13 May 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691924; cv=none; b=uGSZ17w1Wqs5by7oEFvLjnVWYpyZZqYnOV42K3v5EtD9qBM72qUsrqD8c4qwM4i6t/VdzuVMXs/qh60F5FxG92nGD6Ju7S+3JOQKk/ZyUsoGvNhVpGG1GNe0GhbrX/KiKOsFHlrGv8hDa/1ohmeQG2mG1/nwnayrUaHceRASHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691924; c=relaxed/simple;
	bh=B+Lh2COB90j5rStyv1o/M72otL7lieSerd5T2ErAozg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNC8civX2TbViOaXuBSLRTaxPKa4HovZOC474NRr1bX+a89lhubz90sA6XAVNILS2Xm5nuD2vVm6OmscEFxcWrl4xHn99HyNqZ/YZM43nzVJOKlkoACoplA/zvySEhhv4GX+rBPQShIYzsraqRwtLKoYIQFrElREgy32dJnESKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j86+vXxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j86+vXxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB7BC19425;
	Wed, 13 May 2026 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778691924;
	bh=B+Lh2COB90j5rStyv1o/M72otL7lieSerd5T2ErAozg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j86+vXxlfjczGFOX+pw2QWVO1pf7gG8Ju7jVRxZImVlHVOOmieIPBv8VtlTlUwy5n
	 gDZpvo7NyLdRH4IErvy6qc+UU5lujjiqdj/vGO0eFEkM63ttPt3OG94BV806Y8/VOu
	 jVNFhKC5UCoNC44JizcJAPLx0nLutrMdbwaRBbIx6zUf8H6J1fcYajOd9DCA5fXXof
	 76ZRDXkzXOJhed34Y6tGycA8tcZCQ4q+76SYASz5PP0MbYM/U5uW76Ta5e3ZU4XKNb
	 A3j11fRn+cVfE12gfrklOiJNfb2lRbNV15GCWecFNWTNcHKXUijb9k58ZkoTRGQ64w
	 F//GpFcw4fqvw==
Date: Wed, 13 May 2026 12:05:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	jk@codeconstruct.com.au, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rayn Chen <rayn_chen@aspeedtech.com>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH RESEND v29 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs properties
Message-ID: <177869192135.1318285.16876434297246564335.robh@kernel.org>
References: <20260513-upstream_i2c-v29-0-fe9926964d55@aspeedtech.com>
 <20260513-upstream_i2c-v29-2-fe9926964d55@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-upstream_i2c-v29-2-fe9926964d55@aspeedtech.com>


On Wed, 13 May 2026 13:32:01 +0800, Ryan Chen wrote:
> Add the aspeed,global-regs phandle to reference the AST2600 global
> registers syscon node, containing the SoC-common I2C register set.
> 
> These properties apply only to the AST2600 binding. Legacy DTs remain
> unchanged.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v29:
> - remove aspeed,enable-dma properties.
> 
> Changes in v28:
> - update commit message correspond with aspeed,enable-dma.
> - remove aspeed,transfer-mode and add aspeed,enable-dma property and
>   description.
> - Fix aspeed,enable-dma description to reflect hardware capability rather
>   than software behavior
> 
> Changes in v27:
> - change aspeed,transfer-mode to aspeed,enable-dma.
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,ast2600-i2c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

