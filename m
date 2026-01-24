Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E782367D3
	for <linux-i2c@vger.kernel.org>; Sat, 24 Jan 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769250278; cv=none; b=qNJraS4Ao0ye/DkP1cMfVHgdH83ZFxG17YTRhJrBlKpWlkYqgmAUDxGHU+1XhzooVBj9e9WMbP4VVUTxO+JxfrA/l0342HElPRiEIkQWoF/dSMAJLGpgyIWuU13SdxADMsBfaDF7z7DtK8S5SCDe4MyDev6vfVGVqzFBBg5N0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769250278; c=relaxed/simple;
	bh=SsIOscoc4kxZ0+X5vINR23gFekLWS36exm5VqIWN7ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D31jsPs2Gssq86gVjObheQtlM5GOXDCescfjiM9OCSb49/cVrrUImx6C0xqDCwQB9D9YI/ppundsUBqa0FRHfokj0DOfYg779zPwKX7jfR4pA6mzlJPe//xq9+ceBAUj57WqQWCJLkLdbKTEurlmyTjxMFfjG92UHyb1AsSnYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Lx3ieygl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Lx3ieygl"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso15898575e9.3
        for <linux-i2c@vger.kernel.org>; Sat, 24 Jan 2026 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769250275; x=1769855075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6KeuWtNDinjaFnZinUuAvPa1zdf4IDBNYyQ0smSyMs=;
        b=Lx3ieygl3ijotffRo1OJkk/3ZfMlNYxbrpJN4NEKR1Clb0Jqb7ZR5GMHZkmtxJEIFn
         tbNcfpcg0lioh7LlFc+4yDp9+3DpJVcplgZseMjABHStumeRqAn6pceuAGymEK9bCtCj
         z/0B2YGBZMs+52RPtuW+WMiQ0D/cEQgRY8laprvSTrC3R/7hmr63cAhyr5YUQo5W9bOe
         P8lHsTFbIqobYE/FIFWDWFD3uzqEHuLggqSi05rCtN8spwD2FJtxykHAiwx147mgdqcJ
         W2g689wH8t5FAnKVSDV3Uso5GBbBz62GGnckPlnhPnP7EjWJ3u06VxaOdjYFWLOVQ1Na
         LvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769250275; x=1769855075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6KeuWtNDinjaFnZinUuAvPa1zdf4IDBNYyQ0smSyMs=;
        b=OD3qSnJxo+EEDbt87shHjBxIdhNV8zazhiB+99d5keGxf/bHKsz8QEzSvmaaEv0Klq
         c5TmlhCt75o+K1NtkTOxg6gT30tjttrDL4qFsTsl03wKWP1lN5ad3ERmSXF3aeNgSOk8
         CjOilS+QVoS7qGkbrwYYbvp0NKJiFjoQMYSZeocxoCjKvVLhdjCDp/cfFKg0RiZs7ouZ
         Zj99Ygqke60dBKMb5b7LCdLFboqJ0LPOyf3V5QIv2kc2a/2Hbjbg96T85PDl+4TZi7Z5
         dvnuiyh20zeTILtuEYoONwMv/XfjOOwBAdoojF2aioBH8sX0jhE6isaRR03l6wSPWA8h
         0wxg==
X-Forwarded-Encrypted: i=1; AJvYcCXpkPxS1ywazhk1UL1AzabSDfuBm2qaRl7vpx2qi3E8qFn/B49kTkg5pQJMcCbq3wqn8/2KuiEAxoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UKxufsBqwDFog6w4Cxwkji47P6oAUBxwFgC68nr5q3w4rvVf
	8Qe6Mzk1dY8VW+GZvk926hJT7p7Gs3+5/PFywrAsyGyuKbKgBplrCdCrVGLKkA71mMc=
X-Gm-Gg: AZuq6aJW1SFm1TAtxtZkmDXyL82eKz0F18v16/RDzkIf0Ss//jXyX/nf0NmID5CJab+
	S+tOO4mYTYskIjCmZCi/o0ktZX9o7EnWRRE9oB3qtDLgbdj+lsMIAUKyf2JpLtB42G60bilc+57
	tUAWH/HQR3Cy6UNBGSjME7W2LybhtB3G9lGH1OWhSOWQaLcV7pMg6i32lHGuuxuoD5KlP1y8kMi
	+ztKUOwebiRVgKEXrGCjhiaVN2enYvMxgGlekKEezAwgM35qKqfrkj6j5YM+7qwXKCTMlPVbtiC
	+/oKSBfXqHv25N4Y+dsJ5WlIf33oUPh7zxR8MF0C438ZkIZ2Ttwiuvr3AVqufIM4is7S11/C3YG
	m4rRGh2mZO3TD7HUxFTDzV3m91/HEqGlrGf2NiRITb9DmfK4Ha5lD00OepjCODSgfDCR8jm3Nuy
	fo+V5SCNI7V0zyWcla84Yo0vs9E2NYZljD4ThSumXFyfANOpJSgJ2+rPdoDHgl3dYu7XjqdcxV1
	XCKvwf2XmJtit/593PA0UkSwEMz4BQPLVGIgEKkaA==
X-Received: by 2002:a05:600c:5308:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-4804c9b834amr88128575e9.32.1769250275201;
        Sat, 24 Jan 2026 02:24:35 -0800 (PST)
Received: from [192.168.3.32] (cpe-109-60-82-187.zg3.cable.xnet.hr. [109.60.82.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02cd8sm12647198f8f.8.2026.01.24.02.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 02:24:34 -0800 (PST)
Message-ID: <55f7c157-c624-4b1f-ac07-f70aa3668b34@sartura.hr>
Date: Sat, 24 Jan 2026 11:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] i2c: pxa: fix I2C communication on Armada 3700
To: Gabor Juhos <j4g8y7@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Hanna Hawa <hhhawa@amazon.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>
References: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
Content-Language: en-US
From: Robert Marko <robert.marko@sartura.hr>
In-Reply-To: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/25 19:13, Gabor Juhos wrote:
> There is a long standing bug which causes I2C communication not to
> work on the Armada 3700 based boards. The first patch in the series
> fixes that regression. The second patch improves recovery to make it
> more robust which helps to avoid communication problems with certain
> SFP modules.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Hi, I see the series have not been merged so far.
Without it, I2C is completely broken on Armada 3720 if I2C recovery is 
used, and
without I2C recovery, certain SFP modules will also cause the bus to hang.

Regards,
Robert

> Changes in v3:
>    - rebase on tip of i2c/for-current
>    - remove Imre's tag from the cover letter, and replace his SoB tag to
>      Reviewed-by in the individual patches
>    - rework the second patch so it does not need changes in the I2C core code,
>      and drop the first one as it is not needed now
>    - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-communication-v2-0-ca42ea818dc9@gmail.com
>
> Changes in v2:
>    - collect offered tags
>    - rebase and retest on tip of i2c/for-current
>    - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-communication-v1-0-e9097d09a015@gmail.com
>
> ---
> Gabor Juhos (2):
>        i2c: pxa: defer reset on Armada 3700 when recovery is used
>        i2c: pxa: handle 'Early Bus Busy' condition on Armada 3700
>
>   drivers/i2c/busses/i2c-pxa.c | 35 ++++++++++++++++++++++++++++-------
>   1 file changed, 28 insertions(+), 7 deletions(-)
> ---
> base-commit: 3dd22078026c7cad4d4a3f32c5dc5452c7180de8
> change-id: 20250510-i2c-pxa-fix-i2c-communication-3e6de1e3d0c6
>
> Best regards,
