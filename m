Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934824;
	b=b/EkpXuTsIp/X07cU7xvSje6kiZIQ8oBzNB9IJetYARBKuytn6u/4GYL3sQ5HLXor9pR
	 Me8zT8JnfnRkXPexS8zbKelePeXmX1Qo15WuCHGiIoNUcEVzTK9ISnlbBRooXLAIwysOg
	 8ImfkG7ue2vKlw/C4cgLw5rkFkfCyxN54+vG2+MCfNxEi6SbSW/yiKxkrn15Xk0LRF1va
	 Zs1acUi4d6MahyIqWgYnxwTx210aJtrO1nErtn/HkO43fc0URHy7jVcaOYU6v/nYDM2rP
	 Z24qeQTk4Q21hgHipuY11gRmVVs4H3xluB6GBXI7fMHpFEaNenSyMnG8F+38BS7V0Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934824;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=InNgl3TtcjJHMVvDRtFJfM97UJ6hHy2nObXAWQhTsAw=;
	b=sUbur65WY7zkpNl8g7ATgPaqNhj92z/3OmWI5MkBo4IKvz/I4s6q3xRqrOsNlP++fhbN
	 nv+Zq50UOJXLveB4risCX3Y90LvPRnKC37nz5c/3FvWanQxUVHgBtcAY66iShwzzcN27d
	 EZROyps/kVM4Smv8VXohqSTV/E7qoCoRJBB//ilkDFE7jwlrQcTE6X7dGCZnbsI+1t1+q
	 nTIlfMyXjRDLa6gFbtJTIaTewnipjMTVDFMy+bQY3hVu7y9W1Mb/+Ohpap8+TLX0TQuuj
	 j46bDuChyMwTtLvJKPUTDdqYoVyK8wXc8i5Upwa+EV5DD4iYW+z2WHPiu2wKdyc7kPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9A606A326
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 03:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DE9A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso29748766b.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 19:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934823; x=1794539623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InNgl3TtcjJHMVvDRtFJfM97UJ6hHy2nObXAWQhTsAw=;
        b=dHWE+x4dLsu5+KgnqFR4vOSWkP1FWrOKd3wQRoFkK5jVULNduGzDARimq/x1QURAuk
         vlXynM91mJ5gOwyMp7BEKJ5b1gl6CohGlhLz1tVSPkZrX16jcXzurj8RWfJcoB+4P5lW
         CGCk2jeAjDDCEg4GVWHbFBhul56TNPffYsFus0Il53hHBr7IgvHdWSOSQT79YQSzVWzT
         qcKhWE1G3xGw0uPL6716knqclPxNzVfVc0+ol2YbBKkXgDa9kHYWOhLLdkyuYuW2hUqY
         /bMv3anvX/+k8m+4hUGFpnnczuQrMm36iAhJKRxTPma3InHgIXYrx2cdjlaINjZS31VD
         Rnkg==
X-Forwarded-Encrypted: i=1; AKwUvBzCK0a35EQ/+k38UxEUvQJV4me3jnv/PEXJnFptrXOClNG3TYrd3wp8sK7UKUiHVCJgbMLYqVH9rG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GzL2JScFwlinGiVA1YJBMMI324wKJC9Ann2yYCLj6JGX4Vwgf
	oTsuePUiGTz2bqQQTc6bGbqnwkAskamSD9xxgDmQ76JCKwXFj5exqr5s4e1f/8IZNPr8qg==
X-Gm-Gg: AYBFou3CYeIIXahDVtGNrWsCeujFfJ7fYn/+jPXTf4C0eZrqdj6ST4lc2AZINgwI2GX
	M3oYojcqqRtP8WiqNykEvL3cBMVlcDjY9ZqRfdk+z1b1GxziT007H/alO00jyQbujlDNX4/EIPt
	LApF1Dpk/Gemm7Df6LrlNEXLYbC7as4MXKRwER0eN/5+yj8nAi0d4EoVE3Sf6cBmlNo1vj2/9v/
	K0IATcIomyJ/0shMgxTRZ7ErSj06kmgUcS1qaGlxB6+Sx8pt4IPIlPWgp8TJ7xgs2VLzoZ86vYh
	PCeovufUL8c7fz2Q/+7kxAyRpKgjtN6pAcs5y2ksYGj7hbLF2zyzFhd6PBMHgJppaolLgoA01KK
	4o2eygx4ZIWK+SOYPOAnJiVnxajfUHBMHciQxxbWE62HJPQCj4BNe73qzb79JkaOKw59sVaLsgT
	jY2vMD6ohRg/y6U8/f7qcW/1iO/yvwjrQS4nXfTUf8jlJeA1lXgz88/yQXrlSRXRls2I59nAQ9H
	+nj8kdoM8LhNlXDRjXflyaaL8nDv7ruf1ooaLgNGUqjWdTYyvEidLOGEL/XK3SGVwO66jqRvXjD
	gqU+xMLmi1VH07m5153q083Xp08Mm1UmkclR8Hwj2NCrPJV9CEtXyDfCH6L79f2dxrOQ91FdO1v
	oDGIrkutwQgaf
X-Received: by 2002:a17:907:3e8e:b0:c44:16ad:c31d with SMTP id a640c23a62f3a-c4d3526bc65mr105269166b.4.1793934822578;
        Thu, 05 Nov 2026 19:13:42 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c1ee1sm38724166b.64.2026.11.05.19.13.42
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 19:13:42 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so260182a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 19:13:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByF0S0rfMWdXpeu1vloJaEsvtxdabC5K3N0nXmQiSTJkRTQNmxH+5fwwyI2DUE7QfuUwQHJeA1BRq4=@vger.kernel.org
X-Received: by 2002:ac2:5692:0:b0:5bf:cabe:23dd with SMTP id
 2adb3069b0e04-5c003a87d1amr290258e87.27.1793934401749; Thu, 05 Nov 2026
 19:06:41 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-2-7a9534a9a22f@andrewgigena.dev>
 <904675e8-701d-4fd6-b418-6c0dcc9288b9@linaro.org> <5ba03b8e-1d51-4e66-a802-37e63814f5d5@linaro.org>
In-Reply-To: <5ba03b8e-1d51-4e66-a802-37e63814f5d5@linaro.org>
From: Andrew Gigena <mail@andrewgigena.dev>
Date: Fri, 6 Nov 2026 00:06:14 -0300
X-Gmail-Original-Message-ID: <CANn8UmccjAh7PiLpbGHrhDR4yn=w6uiDYU01aoZvBs-tGkgNsQ@mail.gmail.com>
X-Gm-Features: AclHuK-k_LlKDqZXI1tBCGgD-G1XeUrAUABAuETiZnNnNKc4iM6mV-xfAtboOL8
Message-ID: <CANn8UmccjAh7PiLpbGHrhDR4yn=w6uiDYU01aoZvBs-tGkgNsQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: media: qcom,sm8150-camss: Add SM8150 CAMSS
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, mail@andrewgigena.dev, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Bryan O'Donoghue" <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir, Bryan,

Thank you both for the review and for taking the time to explain the
direction.

Vladimir: I understand your point about the stand-alone CSI2 PHY model,
and I agree that is where CAMSS should go. I hope this series does not
give the impression of entrenching the legacy description; that is not
my intention. My concern is that I don't think I can do the PHY-API
conversion properly within this series: as far as I can see,
qcom-mipi-csi2 currently only carries the x1e80100/glymur
configuration and no upstream DTS uses the PHY-API path yet to take as
a reference point.
Converting SM8150 would also affect the other CAMSS SoCs that
still use the legacy description, so it looks like a separate and
larger piece of work.

If I'm missing something, or if there is an existing branch or series I
should base that work on, I would be grateful for a pointer. I would
also be glad to help with the conversion as a follow-up if that is the
preferred path.

Bryan: as the CAMSS maintainer, could you let me know what you would
like me to do for this series? I am happy to keep the legacy CSIPHY
description for now and follow up with the PHY-API conversion, or to
fold it into this series if you think that is the right thing. I will
follow your guidance.

This is my first submission, so I appreciate the patience.

In the meantime, I will send v2 with the review fixes so the series
does not stall.

Thanks,
Andrew

El jue, 5 nov 2026 a la(s) 6:47=E2=80=AFa.m., Bryan O'Donoghue
(bryan.odonoghue@linaro.org) escribi=C3=B3:
>
> On 04/11/2026 23:16, Vladimir Zapolskiy wrote:
> >> +maintainers:
> >> +  - Andrew Gigena <mail@andrewgigena.dev>
> >> +
> >> +description: |
> >> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms=
.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: qcom,sm8150-camss
> >> +
> >> +  clocks:
> >> +    minItems: 42
> >> +    maxItems: 42
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: camnoc_axi
> >> +      - const: camnoc_axi_src
> >> +      - const: cpas_ahb
> >> +      - const: cphy_rx_src
> >> +      - const: csiphy0
> >> +      - const: csiphy0_timer
> >> +      - const: csiphy0_timer_src
> >> +      - const: csiphy1
> >> +      - const: csiphy1_timer
> >> +      - const: csiphy1_timer_src
> >> +      - const: csiphy2
> >> +      - const: csiphy2_timer
> >> +      - const: csiphy2_timer_src
> >> +      - const: csiphy3
> >> +      - const: csiphy3_timer
> >> +      - const: csiphy3_timer_src
> >
> > Please switch to the new model of describing and exploiting
> > the stand-alone CSI2 PHY devices.
> >
> > Any CAMSS drivers based on the legacy description of CSIPHYs
> > should not be accepted into the upstream.
>
> I mean we are just adding a new define for a SoC here - not a new init
> sequence.
>
> We could move all of sc8280xp, sm8150 and sm8250 to a new driver
> topology but, I don't think that's a reasonable ask for a small change
> like this from a new contributor.
>
> Certainly would welcome the transition given above as a defined and neat
> series but, I don't think there's a need for that to include this SoC in
> 100% existing infrastructure.
>
> ---
> bod
>
