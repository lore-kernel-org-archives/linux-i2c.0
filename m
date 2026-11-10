Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354734;
	b=MofK6Eg9Esz9av8riWLxJGLkyxwMdtzmCJbePT8HlY9KJ5XNFNcndy9FFs2TOB0H9fMM
	 lDbSYgv+mFMWVB4amx7SygNDP4WwW4zPTyKDtZw9AuZ4trJWQqpS76S7OOUX/7qavdRvK
	 3lLKl9K2HJmJdJvUULse2HqZmYagT5snvtBuGQL75qlGsaROUWheN7bH0tUMCeoZiTO0m
	 tEtfUDzkBIkqeTEQ/i2bS+s3x3klGGnyC+FsOqqPwrBSiCSeCQV5sgbFwH8vx5z7uM8oU
	 Oaicb/XjQM0xGoRrd1Ew3Qvdl9rPPpf8c4kanKUFwIM9Ju4w9QLbSn+s08VXNcrUN1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354734;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZW6/d6tafc93+2es2jKCUdQztkgttkGrcDy02n1rkws=;
	b=UKmoLjFYjZFt6cMmr3o5VNARi0iarZkrF1mwrbVu9mObw0QTNZIR1TsjzLyTXhH3HZ6q
	 Kcn8KCdKFiAmpHhzEVOdRItchhlyHqMfS+3ah2ZTeUyDmNPWSHzCH1DIZs3A+9Q/LkjQp
	 G7SXk5lkc6uInpqyR2jkKCoqaQTnht562au6aD+GwYYpoLFE9mJO/xNDqAKM3F8Ualvp4
	 AJxyBR93JXoybG8A5wSbSAqoPGMXWLyn/w7wSvfP2ArStEZVUw8NdlMXTwK8ul3M66oZl
	 pSO2mFJNlOy0K5CK693aSVdD1dSrd0EurY45pwm3WB88qTpGtK3fqp1C30bm+XeNW5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=andrewgigena.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB485606A339
	for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 23:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB485606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=andrewgigena.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6798af41644so2210508d50.2
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2026 15:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354733; x=1794959533;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZW6/d6tafc93+2es2jKCUdQztkgttkGrcDy02n1rkws=;
        b=yMVd6LimfGweCb9cfrQPzub0Bjfa/wMMuGGIEaJ2KTuvXxYdZ1tcl32qcvDX7pZBvw
         THku2miS+09Wyvh9k00QgayXK9G3i9gKu2qtBTAfoAWy80/HSQKus+bm5AXUZ0PpNEq7
         aIOvsJbdA2b0KjsKpXleqEcEQWPq8lON38DatmIUixdKX75mMEibM9kvYMZN6weC7ohi
         ss6qCRcQGbZVwsAiOVQ48uaeO0F86hYF75z1kNmm+/8cMu05JpK/er3QfwGzYs4xEe9q
         qTQlEtfALjkLbG8LkRY9sG2mdQylyOH7cVBNySIH4IZsKJW0qbEeEwYo0BbT7FJgYpcq
         vy6Q==
X-Forwarded-Encrypted: i=1; AL+hErHpOYACTDNYZfn9ew4HWHFvPPQOfWmmb3PflvkbYxzu3TFI2f7aqsVVGzhzArAVYsGeghKFFcbym18=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tdtAkSrwCg672Vbnw/n36yDLDWSqvgDC+txQXqaBkqDQVjx+d
	mP4pMq49Kbr4cCdKlaTmfxgOAcLsfmdPnQm9/cn6bdqaiewV5LbLg7B5
X-Gm-Gg: AYBFou39d91YXDZe7iUPgdo1NxwkIy46ZKNOPoDjyLETGaZn/tvfSOisHAa49o82Kzb
	/BloHyl2CwqPfL4SFQ2n2N/dJz2IYGF4yLGuzaIARja1Y0+KF1Coi6vLfM31CFPUa7KEQnh4ZTo
	lQ4uLlieef/XoZgaMiWJ7jPH0oXpJ/r2b1ZLKoCARZIKe+dmfRQJchH/qLITt4YY8KzecFlCYST
	NWyM+FEiLMWn5zg9eYL5lXLlstXzCxTYKEWaJxPvFny8MYDBts6MXcWey2LcLnxhp8c+lyQbcXA
	TTGWZPBXdaTS/+H5bUSl4BeQo8XzmMcY7dAUqj8j0VGnQMKqpyBRcfDNU6F7mjmCnDSs1mm1gr5
	BwIjDzK2Xzm6MKJ/NAagoDBDaOJ5XhaC36f1iu1asBjqpegQG8bkmkFxYbvreHS9vdqS+16Zi78
	DH2eTR26MNZJOtfn5UOJovtmw7USp8KHhmv9/9G3RxF/5B31UjPvOeZAOgKxTTfIyfE8/fY9qan
	8znXtZp4wz/poGs1FA99edf/CFnbAm8BXmLcqnAxutFv9P4Cikhsq2XQp+qF6KoLcgvHZe6zuwI
	UoEyI8P7pEeYTvYqhlVGGV18M2Hi+ABNs1+iqQ0eGyuRw05x/eEWQVl1NpM+aKzN2AVdGofG
X-Received: by 2002:a05:690e:16a1:b0:67c:17fb:ecaf with SMTP id 956f58d0204a3-67c67ee4a9dmr690322d50.26.1794354732657;
        Tue, 10 Nov 2026 15:52:12 -0800 (PST)
Received: from ?IPV6:2800:a4:806:ef00:2f77:7097:372d:6d14? ([2800:a4:806:ef00:2f77:7097:372d:6d14])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589f065dsm3149000d50.16.2026.11.10.15.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 15:52:12 -0800 (PST)
Message-ID: <f127954b-2255-482b-aa3c-cedd2311f77e@andrewgigena.dev>
Date: Tue, 10 Nov 2026 23:52:03 +0000
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
Subject: Re: [PATCH v3 3/7] dt-bindings: phy: qcom,sm8150-csi2-phy: Add SM8150
 CSI2 PHY
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
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
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <20261106-sm8150-v7.4-rc1-camss-v3-3-0103e8a0bbcd@andrewgigena.dev>
 <a9ab1add-5f04-4687-83bf-ca29a068ee33@linaro.org>
Content-Language: en-US
From: Andrew Gigena <mail@andrewgigena.dev>
In-Reply-To: <a9ab1add-5f04-4687-83bf-ca29a068ee33@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vladimir,

Thanks for the review, replies below.

> Please double check if SM8150 CSIPHY v1.1 is capable of C-PHY:

The hardware can do combo mode, but the driver only implements D-PHY and
returns -EOPNOTSUPP for C-PHY, so the binding stays D-PHY. Would you
like it documented as "not yet supported" anyway?

> D-PHY combo mode is also supported on the SM8150 CSIPHY apparently,
> it shall be reflected in a way that two endpoints could be present.

Split mode is described in the binding, but the driver rejects it, so it
cannot be used today. Is it fine to keep it out until the driver
supports it?

> In downstream camcc-sm8150.c, PLL0 is on MX, and PLL0 supplies CSIPHY
> clocks. I believe MX shall be added to the list of 'power-domains'.

You are right that PLL0 uses the MX corner in camcc, but that corner is
internal to the clock controller, not a power domain of the CSIPHY. The
PHY only consumes the top GDSC; SM8150 uses legacy GDSCs, while on X1E
MX is a real power domain attached by the PHY driver.

> Still it would be preferred to get 'vdda-0p9-supply' and
> 'vdda-1p2-supply' properties.

Renamed in the binding on v4, the driver and the DTS, matching the X1E naming.

> In general the change looks good, thank you, but likely it can be
> embedded into the scheme for X1E.

Clocks, register offset, power domains, lane table and timer all differ,
so folding it in would need if/then blocks for almost every property.
Would you still prefer that, or is a separate schema acceptable?

Best regards,
Andrew
