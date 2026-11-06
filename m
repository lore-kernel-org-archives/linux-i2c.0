Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000384;
	b=D2jIBNXTSfBb0UvRccFmBi/YI9sBJvSbzIWto9Jhp2vpdgEnIGl19xQ7k+hb/4uFRkkI
	 4PTfavIAx3pcdrv4KCWR39zypjoHC0Aknu0giuKTCHsumLJR9s15bFBPZ5DPd9qmREDW5
	 LJMSDhsnVcQVABkHWwF+rXEPeTYzbNM2YG4IXry380mc/yMW/vgyAn0pBvmPKw74Lsj3V
	 22Iqf1v2lSmyhk5wDKAYGXtGmK6n/1Y2T+KnhWTLR6pBP7ncFZFuQkKxRvOq7jrJ6pZQB
	 tK14ggd6TZSnCmDnZkoIdIhwDAdH5kxgE70EWprO4MPHPDhA8Ixy9HD57ZnN7VYxvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IS0n6SvtrSel8zY6vkWXqf2dHmq9Z3b4+UIE+41Cj1Y=;
	b=Ip52nubZMj9HIP6JIj90Fqo9fEkjMhGaZRq3vCrJa5Pmg22sXDRodDXkp7317bwvrhOH
	 sszCQa4yID0+2D8TnS10BDh+nSFMyoosqx6trBY7/bH0CNHJTDCPDo5ZDngNv6Q7/A24F
	 5Pt7vsrNJEGWUT4vNINiufGGhXt2NxULx24f/T5BqsVApGshexSdZYbWUgRY41wKUfSZ7
	 YrW3/S+fxXWIs6RuvTb1cFrck6T65yPczjvOV6hUeFS9/NDW0+v9X909VhriNw+3aTeb7
	 Q+8jctEdcslMcUTAzojH9yR1bsMvJUISbY2T9kAlNBzPY/WAMkgze81c/YJBR5xJJKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fElw+eI5;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C5606A331
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 21:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 469C5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fElw+eI5
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab35a9d9ceso1322241fa.3
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 13:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794000382; x=1794605182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IS0n6SvtrSel8zY6vkWXqf2dHmq9Z3b4+UIE+41Cj1Y=;
        b=fElw+eI5A1w3IHAlBMJDLXRdBdImdRRuG7tpGlwkAMmBHAk16RV4TH/P0ZmbfhQYpp
         US2j+t2uTpkkH6Tvzs7OH4p4mgNUfQ9kbl2ANOSRPJSY34f++LIT70jAr/dBguYOgU1+
         0pfQQhuSZa/m9R5bhgoimw63HMKZMgihXiH6MUVCIYnXubaiAJZMT4kjUqLQLQYamQV7
         ADuxWSh3ffVdPJN5Mf9g8EhiqF/11g4M0XzKm2TlnCPDha+NBvRjeJ4Q9UjaAIb8cAIN
         bEsbw5aJM7boNpVe9K+HcYqpeB60vwmXjr/2qzSbU+YM6FsexXa4G+xwUar6b+1OoWIe
         6KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794000382; x=1794605182;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IS0n6SvtrSel8zY6vkWXqf2dHmq9Z3b4+UIE+41Cj1Y=;
        b=Rgizal3Jyj+Ot3mLFa0RHBHTzpC5mQFgf6NKiBHQbsGYG3tIoGQeuEe6iWd3jSdcgy
         48qb9zumbi12uUs8Lh/iPmIZI/cnZeAWnQPTwFURAJISZsZhfMD9C94e8fXw3581Y7gX
         nBfO/d2ZodFWR267fryHkPI3yrmUdtEW3PPvkECKZOdO5MiPnQNPGw1V633ehYVfZXWp
         8APcPfl6OgmqRrwA61zje1EHGwjkoLdcXSxEUPzaasBSPoHa4dLCIO/9E8WCFKbHENdz
         WzPNm82qOSxjQXZnhSFzHo6rM5SEzyS5llXeeqR1OFohwT0YzLeiRkaHEkPWTboPPQrm
         c1RA==
X-Forwarded-Encrypted: i=1; AL+hErHOlgJ0madPQINw1ffK8BPm3GjGZXRkvL+h6fb1Q9RfIvRc815ibIIFl7lQo/qGiFyFGmiDq2SoLRI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fD/Ftg7eRHneht9dKVwW7NjrocWExFDkgECHu53rVY+1niOhZ
	6yQ+TAxlEnXGfMXhm7/p7iNriRYAQyWc1e7Isaq8OamoR9UcbrKr1nPgjLmSIJW6HLo=
X-Gm-Gg: AYBFou3i5ewXOXUnrA/Aauj3Qtuj8G8B9rGJ4vEPgfLfXahFleESS70rwqbASrMHhFq
	yTLGRGUcpPbUVDESAXfZszsRZA2UTFtV9SHYF20rJYpSh2sfjNkiC8Z7v/TcjZYoaQzXhpXnMTV
	J2prTqK6Ps+2vpFhYAR1zs4kLi0qb4NS8NiP2mgBqIHce/dq1hGFXhKzSGURpz9E2YvGouf++qk
	duvVf90qKU/3Wmu3DrlncRGKPgPkJqdn5vo+KZe7D1jl36W5ivn2yplrkySLzcdleKTDPYvO+ts
	WlNB0OD0kUXh/eAN5WXKqohrQ8+Itaq33I3/zxDHYhYiPD3TX75sA7gDIWVcw7UmZpXJZN1L2Ej
	z2GX0+sxL99T7nQpofVlwZNqSornkQdJW/qvW3Ea56QKvyQwpljepdRtPBpE5FfvbduIXzVIGYi
	0aqGmHFsKpd5NKAPUjvyq4UfLM3eUjBLcmgEN4CKjjNzLxqlmcyl5xNa7NiI3yzUJlmSYphAmWD
	tkiAcwJHf/AYpyPoGwtL0mmLVuluM6FeiRphHf4IRKjNRbdV1IZgOlvAEuPyZCTUtV5N3GNqDeN
	ND+/krZ+fGh7M6taoiMKm49QRpuvpNdj0BHvrtUdb5m/SB/WuNWJzcpeQx5n8xgk5KF9QzIK4Sz
	8c4EHErsHpbt1d1hT+pP4yJdajXY=
X-Received: by 2002:ac2:5690:0:b0:5bf:ff57:b346 with SMTP id 2adb3069b0e04-5c003c44406mr1296500e87.5.1794000382152;
        Fri, 06 Nov 2026 13:26:22 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c00ba6e7d0sm4667e87.64.2026.11.06.13.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 13:26:21 -0800 (PST)
Message-ID: <ba22b7a6-83a9-43d3-9eab-93503e23a76e@linaro.org>
Date: Fri, 6 Nov 2026 23:26:20 +0200
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
Subject: Re: [PATCH v3 1/7] dt-bindings: i2c: qcom-cci: Document SM8150
 compatible
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-1-0103e8a0bbcd@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-1-0103e8a0bbcd@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/26 20:35, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Add qcom,sm8150-cci as a CCI v2 compatible, with qcom,msm8996-cci as
> the fallback.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 1e8def25ec0e..1e7a8efaa398 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> @@ -39,6 +39,7 @@ properties:
>                 - qcom,shikra-cci
>                 - qcom,sm6150-cci
>                 - qcom,sm6350-cci
> +              - qcom,sm8150-cci
>                 - qcom,sm8250-cci
>                 - qcom,sm8450-cci
>                 - qcom,sm8550-cci
> @@ -218,6 +219,7 @@ allOf:
>             contains:
>               enum:
>                 - qcom,sc7280-cci
> +              - qcom,sm8150-cci
>                 - qcom,sm8250-cci
>                 - qcom,sm8450-cci
>       then:
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
