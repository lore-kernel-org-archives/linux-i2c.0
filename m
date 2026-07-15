Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0933B47F7
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133351; cv=none; b=kGLYCHw2/b9J+DVBf8PhkyeLmTgjw6k1jquJqSFs05rmNtQI8KAaJZrWoEAnW36Kmj1SzlxM6Uw48IQfICIxi5kDJzdUdHv0s4YipAI4qWrYNr2LXYWIc6rRUrulbcclAniNvR3fIQ1cZ1OtMuLoW3TNViSvmR5XXLC9lL/ljng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133351; c=relaxed/simple;
	bh=7IrB0okd03Aqpih7Ns5d5dds/+Un1am8C/UF9ELzHjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfneM8JbfZr1x9834uvOWVZIjiJNo42xmpFwnnoRhbP9534sSPxfqaQjWOz8iTqMe0yzlJFI0o6t61fmIofvb/EbVV7Iu+Kbi77rrK3JTjkYLuqVn3Li7J6m1yP6x3qUAaqgbVWMbbOPSrXMGlgCzV1/OPL+/z+e0bJ/oVPDV5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCY8RiUX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCY8RiUX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so2739083b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784133346; x=1784738146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=JCY8RiUXpBXqEOBcCz4WafKkyHB8ySjhgeWB8GNXpoxdYAFfl2tk8WWSznNL5s2BNA
         1JdEj5JeRiy7hx6ccsoHwDQRLe4VNpdsjJ0Oqibb/lGu5lxhSCYTvfMZHkzDPGRsgeS7
         Dpfkd8XKHPAGyGd32nvlZ2hOu7P7oJt62VrioZfemi5jqEDQc1OgMwslRo4Es8b8YJ/M
         KyRDmEetrbnIp4UAoQmeR2+zRuPwe8j1gAYhD1PB7XyXJ/SiPIOBJpqo22WcHxe1Wh70
         7Ua9XjwM5KVybYBV3j6irPrF+ud6FUG/PNLXbq5PKdagSe8/hZzAkB8B6ak8w/9RCltM
         Rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784133346; x=1784738146;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKMpslmS1nZLwbcYPHb8iOZLrmPISU+0dOPEfAdriDw=;
        b=pF4jQJRqOhnG2v4XEp9bKWOeBxywRdh0EP6fwPXkKOXRw2pP5P/KH3A216a78CQ8/L
         KT8QZ8+C0fxiH282K7pyoJiP2ysAwmLwpKEoma/XciTCb5feiWrrI7msZTDqfgVi0UxT
         zDvvMmctr+SpGZmpBeVze5tb1Q6gmkR8UG7pRkBtp69GJkcy6JRioKG9SsF2xZBjQVDa
         U9yF5d8wnrjLUlx43W268sE/QLyT38wO7cJvuWk+VQi1H9zo5N/LhuFpdiwJBuVPJb76
         vRnuh84vLZ9txpEP+jehxP2MmP3F6sDnlKT/hHm+uMUNYMKxzhCww6X177f4F4NJLyQF
         bbZA==
X-Forwarded-Encrypted: i=1; AHgh+RrjgEitEIYtEmXDWemoAnO2pF2/x3DKz8D+ngELd7Wfn1qyF8oyRZnpagL5yACa0cPL3uVscalP5dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JWisZZAYNws8hQ1R0/vFJ0gGiyVCmpFyMv1zOfM/g02Qhyok
	oxde1gLn31hoZY+tujZrJInkQZJrVFn3upEVQBURuDofbtrMqIlPtRsg
X-Gm-Gg: AfdE7ckSkYu9hegZsYjVslWKzVSK0m2VnxThuksrbBqX6RG9eRUYcu57nxoch8W7kKW
	5C3otpSEerlGqMGuDAcujcrZYmUZLf/ULSjfza84MFPHajAVHawklzDNyikPgfzuWdad8nDNk5c
	F7j6r5bRRKgxjAX3TueHpoiCjx/aYtlhm0w0ii9y9wvywnaKnPLOlRAHtZbLie8aCYuo/QTdHDt
	gS6s7E4ma1bjJOMRfRO5mT+4d0bwiKIjBci2VNJbWzAV28GkcvYeyqfkX8Uq6XjdOA9kWObJObS
	EL+k642MobuBHhO/clTvGu4kQcU9BYesywvNi9qIWlUev7pxSuWI+ODUX0TUq+YEKbtl0+IGG2Q
	A49XJJTiEdNrE64Dt9dunFnbRg43NmXXAG9u86NdR8wAFbxdsF6s5+IvdVh0jRql307TmVzd4kO
	StxuUwswBMSJ4Qvckp7bHojEU0UQ==
X-Received: by 2002:a05:6a00:2d8b:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84a672425fdmr2861024b3a.16.1784133346501;
        Wed, 15 Jul 2026 09:35:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238b21sm3470359b3a.7.2026.07.15.09.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:35:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 15 Jul 2026 09:35:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 06/10] dt-bindings: watchdog: apple,wdt: Add t6030 and
 t6031 compatibles
Message-ID: <990ec316-5050-4e7b-93f4-b5a2a85ef447@roeck-us.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-6-df65b2485710@jannau.net>

Hi,

On Wed, Jul 15, 2026 at 11:11:53AM +0200, Janne Grunau wrote:
> The watchdog on Apple silicon M3 Pro, Max and Ultra SoCs is compatible
> with the t8103 (M1) one. Add "apple,t6030-wdt" for M3 Pro and
> "apple,t6031-wdt" for M3 Max and Ultra as per-SoC compatibles.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch didn't trigger any conflicts against watchdog-next,
so I applied it directly.

Guenter

> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> index 845b5e8b5abc..bef8255022fa 100644
> --- a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
> @@ -18,6 +18,8 @@ properties:
>        - items:
>            - enum:
>                - apple,t6020-wdt
> +              - apple,t6030-wdt
> +              - apple,t6031-wdt
>                - apple,t8122-wdt
>            - const: apple,t8103-wdt
>        - items:
