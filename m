Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092319;
	b=bPwlAauzkN8dMYbvEtyKcJWdMZ/fswYRlpH+ENqd+eP1YzZoJRpogZKzTYzjJg9o+H1I
	 K9yMKn2IdaouZga9hC2OoLLTK/3M+jg9r/8+TBo3EDGKPOO1l1bP7BMMmuHxQh8b2a9uX
	 n7BHTWMKVJrvCL3rFSMzDDsYZqSuhLecCvzUwU4ZRM3wcuFDcaZjQLXASNecRwSAqqjxd
	 votUljwG8GJPjC+gnLMXS+2NHG7nu2Apx9alHCxcy/tPNyal57I+6FHQAHjwWMg42NepV
	 XvE91kxQJyiohUHc51tqlp+cBP67kqRyw7SzJ1gYWoHuhfmJF15p0O2DSZSZGlQgEqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092319;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=T79Dr75s1wvEXUoDZaE7cn4PwcHACPes5COGJi8oy7U=;
	b=EJEP3n5hUhNqQNWcNhUE3ag9L32oRAsIqZGSm7RdfMc5lJ/+7KXW/8w4TOpNTw3GxpB1
	 hHM4y4YoH0Tj3diJYU68dgwNwhXKBys61q5CEiKFnN+LSfn/1Mh43n0zNdYJ3j37XcSOL
	 R4Wjl7gl53nd+c9/Z+PG/IYMJFbDFAZWh2i7nclWUTrenqVtAWFGOvxY7tQzOgG/dx/6b
	 OIxsCQk6ZAfbsuU92seKbBtaZaK3I5V5quzpoPxgy7aSP1ouyCtafiSA5CweWfAoV++LX
	 nVvrstZnfFX2ZlKB33heTSVUYmtYYrHI6Vwaf01OSiOefj4JkKetZLYzJauP2noUnUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="UuR7/ceK";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D49606A328
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 09:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D49606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=UuR7/ceK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 63EAD1A12AA;
	Tue, 27 Oct 2026 09:11:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2E838603BD;
	Tue, 27 Oct 2026 09:11:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C36211032904F;
	Tue, 27 Oct 2026 10:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793092309; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=T79Dr75s1wvEXUoDZaE7cn4PwcHACPes5COGJi8oy7U=;
	b=UuR7/ceKR3WvRHfZBPIedxhdV4OfAZXNIaXp3g8W7wt1efy1uoDsg0DMZTk5cRNDiNtala
	Omvkg8mIONIePJs1AXs12/YATeNT0fD5h/EXQZicnjbXevpQ2CpHVhz/8haGqX0ZlIo+JA
	EG6OC5DHxEGXP9hOB3ylx3BkmW4u5czjzb4XHEq4dL9KXjgmT9wjq8veuW4iAgbI/Q6kOE
	Tq92N6JhK2VGV1QVFyN8UjliNVqXShOUtGsP3SZLgsFopKDji/FB71MDawONogQloIyLEt
	h9rUVj8ZpDSYFZlyEq+sOxwNupUnHhkapAE3hbDZlc4ft2t38vmFeyK1r2tU1Q==
Message-ID: <42d26a0b-c517-4fc5-8d19-e0b7c4506cbf@bootlin.com>
Date: Tue, 27 Oct 2026 10:11:37 +0100
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] dt-bindings: pinctrl: berlin: Support Synaptics
 SL261X SoCs
To: Jisheng Zhang <jszhang@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Andi Shyti
 <andi.shyti@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, mfd@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260929061417.20733-1-jszhang@kernel.org>
 <20260929061417.20733-14-jszhang@kernel.org>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260929061417.20733-14-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 29/09/2026 à 08:14, Jisheng Zhang a écrit :
> Document the dt-bindings for pinctrl in Synaptics SL261X SoCs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   .../bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml  | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
> index 6ace3bf5433b..fb60a310a24e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/marvell,berlin2-soc-pinctrl.yaml
> @@ -37,6 +37,8 @@ properties:
>             - marvell,berlin4ct-soc-pinctrl
>             - marvell,berlin4ct-system-pinctrl
>             - syna,as370-soc-pinctrl
> +          - syna,sl261x-soc-pinctrl
> +          - syna,sl261x-system-pinctrl
>   
>     reg:
>       maxItems: 1
> @@ -44,8 +46,10 @@ properties:
>   additionalProperties:
>     description: Pin group configuration subnodes.
>     type: object
> -  $ref: /schemas/pinctrl/pinmux-node.yaml#
> -  additionalProperties: false
> +
> +  allOf:
> +    - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +    - $ref: /schemas/pinctrl/pincfg-node.yaml#

The special value bias-pull-up=2 is handled has a strong pull-up in the 
code, maybe that's something that needs a documentation in the binding
(or the strong pull up value is really 2 Ohms, and in this case, 
everything is ok)

>   
>     properties:
>       groups:
> @@ -60,6 +64,8 @@ additionalProperties:
>       - groups
>       - function
>   
> +  unevaluatedProperties: false
> +
>   allOf:
>     - if:
>         properties:

Regards,
Richard
