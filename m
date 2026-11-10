Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325402;
	b=nu+rnHOY2FRhZkIKTk63HBmeZtYI6FhGDJ3DjKOlmHKncldc/geZr6fJi9G5tyMy6e/l
	 xT+d9XdnMv38TZsjiyTFCRlLDfzcHPm+U9b8sdFA0LroAZn2Gi7tIueGBrSq5cJBfX33L
	 EJV6Tcev+1d20GPCktH9Jll9pAN8TA5MFGOSfQDAVQo7Es1YXi5robr6mD184ld8wPcPr
	 yJ8hSkPP0bRuFb96FOepC3IGBsB4k5hwCp5HP7CBcX3kVe6FhIq2Qn2KTpa7hLokISuw2
	 B3Ju/c3vYZQuuIZgvboXquC1V4aKXXI8ezZEztiUKE3j2oVH7Z6mD6K8QCrDG1S1WSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325402;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TQtG4o/ML/2sB0MvTtvE7H8moOh6q/FDtaR4iqmNY1g=;
	b=M86qT0QInyiSJH/FVKV2/AfZpi7C0GVGLjYOuUyG9sVcP27b7JtJ7lWiTPCHaPMbxlbq
	 RKvpylzhzy5RDHZTQOmScK0F1MadfvzjnKPn/d1q2fk7iWESLdbPCtfR5/wEWG04jux9p
	 PDiL2QU7ulHBGOpOZc+0608c0XpW1ayjQ6lPkZ/UzRxbbf+3GwxHawfRztGsVJEb+EysU
	 rVj98lnyzxxNrX5athL+b+bVSGaRbLgrD5v9mGyrVIbrA3GYIudf71CiwnAwVckWNePDq
	 DGXgOzjbJTZoTSRP9/qNiz082l1roNeHc1iK/xlYIRB6MwCb2AMob3utofTeHxUexNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0860A260E
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 15:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F0860A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1249526a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 07:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325401; x=1794930201;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQtG4o/ML/2sB0MvTtvE7H8moOh6q/FDtaR4iqmNY1g=;
        b=G+ApOjbPEHf+kXdrbCGGqE+xo6urKmH4DbkEDYZwQAbO0OAU+YU+2xyj6ctOGFJRJ3
         6283w2ygEkxMmmHTnnLPOXZ59H/65IQqyYDgIcvaXpWzuWNUKz4pysZ2TEJxcCW9ZjAI
         slxLrnimuZmmUiDlhaoJomSYFOr84sW5D4Ymb9QgtcMzXHXS8mXmwiOeqNqAHc/uHzy1
         aZJesoxpIywqYwToOTHyody8aUIkRxeLcGvf8WTMOrks1PU6op9L1cfGJEwz0NkErniy
         RP69qvS6ZCOAU5gFYlmI6t6+i/DiWDqTdgYZj1IOzvdMvM8MTZX8SfKwCNe1+YdnCLJZ
         PQ2A==
X-Forwarded-Encrypted: i=1; AL+hErGmOKjk6X6QcPP6DSEaMXGx5wSHcyvMuw1xfiPuz/SN3KheBNj2EMvieihQ6+oGy5DxYh0GihFuEto=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bbIt0OZuLjjYUtGCy8pvswFVOynNnZH2NRYUZOFMgvlIEy7PL
	gi0TbAVJYK8z5rfN0YcnGJCXR8tdM8INU7VvXFAGcAYeaYcgYLVCmIUd9/eIz+zr
X-Gm-Gg: AYBFou1d/DXQqDyM2zeQeljute/bayIqHRR2YyvQ1EuBRUq+FeZGAvh/KEZNpEPDcOv
	uHzNfRWcacZ0WEhwEQCLnjV1Op7PLwKoWrq3PKlTkvVe+WJRoIfvc/8FClpH6Qzk+lckQo6mg21
	CoQNLS/Nt3N0dxS+Otq1n1MsWjqbRZVlo9p8oB5v0rdDzklMrj6hLeJUYLZW+N+6X/G9eC7zsS7
	+o8BQiicwd2EIMosW6VchOj7dOKzIAS3GYMT3PP4WCry9VVIR441d8IjrXNUo2qta3A8WG8GqMe
	7tVZFbBMvJqhDWe5GH5jtC5hZvpFzh9Eg1M9qedYw0XYeS0WpMQegDsiw39ZTMYXp1kwN+i9uvj
	p8frE3h+791lnzEyd9BfocWIrBUSM1fpcwTTrI9pS/weQ1Ra2qZF2c0x3bfM1aFGTxB8goDaxXX
	l4MTCfEYaG+dW3CyPnwiFCRXRkRLWGiu0MfpuSU+mJjYg1XAAFT/nXBxwV2UudmXLe5qhkaMohO
	F6in3lf79wjBc4sDAwOUHcd78a8OctKKsO7zYYVJlSiA1EcpsVBXaKDi1ZzzgnKBy4UkgwEouo5
	1MBgCvurqon4j9RKMyIZEd92E+vbxeZNDyF3cFMavxfihvGGmcDFWz+Nrpj6OpAduT/nnI9q
X-Received: by 2002:a17:90b:288a:b0:3b0:a9de:9886 with SMTP id 98e67ed59e1d1-3b166cc035emr3111438a91.12.1794325401459;
        Tue, 10 Nov 2026 07:43:21 -0800 (PST)
Received: from ?IPV6:2800:a4:890:2c00:14b6:ffbd:f8b2:d9f2? ([2800:a4:890:2c00:14b6:ffbd:f8b2:d9f2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d5e830dsm891469a12.4.2026.11.10.07.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:43:20 -0800 (PST)
Message-ID: <987c1008-d0ab-4508-82a2-1a26104a47c8@andrewgigena.dev>
Date: Tue, 10 Nov 2026 15:43:13 +0000
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
Subject: Re: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
 <20261109-slick-transparent-ostrich-28ddad@quoll>
Content-Language: en-US
From: Andrew Gigena <mail@andrewgigena.dev>
In-Reply-To: <20261109-slick-transparent-ostrich-28ddad@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

First of all, apologies for the late reply and for not following your review
advice earlier - that was my mistake, and I should have responded to your v2
comments individually instead of letting them carry over.

I have now gone through your v2 and v3 comments again and addressed most of
them locally in a v4:
- reg/reg-names moved to the top, redundant minItems dropped, property order
  aligned with writing-schema.rst, example cleaned up, ports use
  patternProperties, bus-type dropped from the CAMSS binding, etc.

Regarding your v3 question about the order of reg/reg-names/interrupt-names
(vfe0, csid0, vfe1, csid1, ...): I took it from qcom,sc8280xp-camss.yaml,
which uses the same paired VFE/CSID layout and is the closest reference for
SM8150. The entries are also in ascending register-address order in the SoC DTS.

If you would prefer a different grouping (e.g. all CSIDs then all VFEs, as in
sm8250), I can reorder the binding, DTS and driver resource table. Please let me
know which ordering you prefer. I would like to hear your feedback first so I
can adjust anything needed before sending v4.

Best regards,
Andrew
