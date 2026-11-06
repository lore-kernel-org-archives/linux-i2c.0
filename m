Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964021;
	b=HBvAby3GS3TrLTmk+HFlxvoUDs89kP2oxZqsUb93Hkz716k/7SM3wZsaLfEAUV6n0YUV
	 mcrN9e5OBrG8Q6eLce/cbz9BxwlZwwSkzm8k0ENI7f5tYxiDGXh7uXrExs+fV9k+5xn/C
	 1r+hLXk6FD3erWOqulok84r/sZPFxXrgIWSbIXHtyPc35M+jwoTwW7HjACO4qVeYKtngT
	 HVul1dfG8b/USOiYz2Zz7UjPTy/J8WTmKrBbNyMFmAxb+XDsunF5h2kfvSYIHAARKrPlB
	 Vo4R+Fo6lGNbmnkMGEHnv8Rg24885jZt+tpoSylD23W9GdPp2l+ZCLF9Ox0ujLmfhLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QF85CmmgfQB0K98VDXkXqbQirpwlNX5Roqb9EMySWGw=;
	b=3TDweCvzH0BRXkSZfh3PEYSbA2pNdvPL2t3f+x3npwMUL7Yr5ZKZPUKmoPf0MNi9+7/g
	 qPWCIb4TmKhdD3TVJwJ99IqzoeAzGIcjOlZWwHXU5Hp9+eZ2i3JiY6hrhHPRT1ZSTbLpV
	 ma663Rst6KWFHkGg8nPxT975AdXYx2FMTs+XcX9HNSa6DSMWeNkRiPUiko8hgB0qEuaS/
	 HrVa9C1F885gTvsMaA1kzgMMjlpsgSqxr80vY+yDHubRxorPOQ76ohJMXdqjNRb43g+nw
	 RxsXBTnfjM2QGup4NPUJBcLjFjdVI5C/0mejwNQO2SylcDJtEV4wFMkoBfhPcNb7swA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DUFumtMK;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07E606A32D
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 11:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E07E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DUFumtMK
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab35a9d9ceso670051fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 03:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793964019; x=1794568819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QF85CmmgfQB0K98VDXkXqbQirpwlNX5Roqb9EMySWGw=;
        b=DUFumtMK1phvIfSGAyjvBixjvVUbWj1LhChEW4qMThx2dH1KWLjydGDlGxwzpHi34F
         ydA4JtviInKqlL9MBEr4abhaPmqh35/Uak9OQijt/vKOoxpyIl7pLa4orHyfSO4vuI8h
         SglDNnGd8ZUztb4n0NY4SsyAZ9xEeS9rvIb8Uji0t3mFVucpO92chNyBayYeqhSZXz7f
         pju8gY1T4R95xWyHa0+c6Mq3d7+y2EYrsAokrF5RWngcDjic2+Aau7B9OAqIXzMIdHn4
         4rVW8y1o56QVlQPc1f89iBiWKmHxDUxq16YvDKR0r+xTHHx+sXdDVn4V3wvaoTs7a4WC
         gHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793964019; x=1794568819;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QF85CmmgfQB0K98VDXkXqbQirpwlNX5Roqb9EMySWGw=;
        b=sAlHBUEx5vib0f1p66IVeBaAV7o9zeJzf2qdJMReTVc6kwlB7w7rZ2/uniOrIqEU2e
         oJCooL8dlQPtydn/woN+Vg+sqXRqBfbOegtydT070mY73btafUgHkPknj475mN0YTT5O
         7+fSml2ay5fv1k6E+J0Mvce3mepBevpfgUjhtMRexf/k3la6KKyFJ4HmRZtqEQTuhihP
         LhnOj6juMRZVa42QaqShy/EdEd9jRmHAEfGo9IqPP98WsEYysyLtbG0Rc98JbM5iRNQB
         qgiquROL+aJwLDYPIgdisjvBdZYUkb4FEjvw/0hZQsIjyFaU72eVRV6+FR/R0Daj23Hc
         T1UQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoBKCDzWJNurYcrWPu6qIwzSYnp6V40/p0cu8/bMTgwEDdxQsrr067//CmMHrBCw6CeS55gBxRL5g=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Sk+SpF8e0ZeGllYuNgpkn2s7LNmpp3xthAelXmWp37FxUxySA
	y0P1RVPxGMqTiPaZaN6CCqxiHIFgdrcpA++DRs8AMQe67ojDeHr+pQzRWezZwYsloAg=
X-Gm-Gg: AYBFou0UyodzPfT1Sg1ONDLwre5objcxl6eLnaleTIuBR/HgWEFIFWE5ZG4rDrpQHiB
	9agnDGNfsI3RjM72Y1cfzrKybwfk97XySF5o9urovlX1zA0GsZz4GIyXo5MqUsKbohPj7Ojj1EH
	XvyeQamQD1Z43UgOE9Ad9wH+1wKUyKOCSZEZ9yLoEvFKB4goCzvfPQCBUXDnSfCL2KcenREsR9t
	wvzHsz5gGLAUpcRgnbYK+relgd25f/Y0t2xNBh3fI6jlccbudWWsbwwjDIIbqeWWKeyTkf3Q4rp
	BjGPsLkLeeOkJs/6xtv4COxKYB9+KHl0fH5k/e4NG9QCsL2HoDIzJlSdLff6sPeUMJmhnhVOsta
	GsOKlfWlM4qMQKE6bCWVlwOsVK0sPaI3+5w6ay/EVqteziz+WdE1zYpbP1xwtlcNTMp41lf9n77
	80c9cX3IJ+atsPpTGNvlmXP8C+7/yAGctlX2fDcf8vKgH5l5yZ599NDUw5HG1smfjtI1vwuh7pQ
	BOIA7lIZCMA6MdXT98fQ8S0cIiatCeeHD3X2NVKkBdR2ItT8jzu30QPu7Xt2wcj3U7RMRIrZfh3
	78wCRaVK2gcEMahbzBmQzbFCn/1qjtoDA56rBuBq1ecBRkMgpe1B8VC0K48mI63mdwNsos6dyMk
	Zs95fHg==
X-Received: by 2002:a05:651c:a201:20b0:3ab:1864:5004 with SMTP id 38308e7fff4ca-3acf36dacb5mr4022961fa.0.1793964018157;
        Fri, 06 Nov 2026 03:20:18 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acf5facfe9sm2950231fa.21.2026.11.06.03.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:20:17 -0800 (PST)
Message-ID: <540014fb-d271-4e20-9a3c-3f2fb66723ce@linaro.org>
Date: Fri, 6 Nov 2026 13:20:16 +0200
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
Subject: Re: [PATCH v2 2/5] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v2-2-39ee37787b00@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v2-2-39ee37787b00@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

On 11/6/26 05:24, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Document the Qualcomm SM8150 Camera Subsystem. The IP integrates four
> CSIPHY, four CSID (two full and two lite), two VFE and two VFE-Lite
> instances, with 27 clocks, 12 interrupts, eight IOMMU streams, four
> interconnect paths and three power domains.
> 
> SM8150 has a different register layout, clock tree and power domain
> topology from SM8250, so describe it in a dedicated schema instead of
> using qcom,sm8250-camss as a fallback.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
>   .../bindings/media/qcom,sm8150-camss.yaml          | 412 +++++++++++++++++++++
>   1 file changed, 412 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> new file mode 100644
> index 000000000000..26f8939001df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
> @@ -0,0 +1,412 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/qcom,sm8150-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8150 Camera Subsystem (CAMSS)
> +
> +maintainers:
> +  - Andrew Gigena <mail@andrewgigena.dev>
> +
> +description: |
> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8150-camss
> +
> +  clocks:
> +    minItems: 27
> +    maxItems: 27
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_axi
> +      - const: cpas_ahb
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy3
> +      - const: csiphy3_timer

I ask you to switch to the new CSI2 PHY driver, please exclude these I/O
spaces from the CAMSS container device.

It makes no sense to deal with all-phy-combined supplies and the multitude
of other solved problems.

The cost of changing the device to exploit the new CSIPHY driver is
close to zero.

-- 
Best wishes,
Vladimir
