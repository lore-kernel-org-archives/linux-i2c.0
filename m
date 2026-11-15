Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744306;
	b=p8fSoYedeWwFgbfOXjJCnVWi5pVwKNAQrKZl3eq8YQVNAAI8QmY6TdNfPQ3a+zoOiETD
	 X6RgS/CPpg6MskPK2aqLRz2A1QFwEpWGYuOmESuh1SPbJZfB3fftfxb68NWPq6jy7IugM
	 pU+KxQ/UFHJfZh4+DcO4RNxSb8KGdjbyrzdIjIkjK/HhEE8sLgdLejHv16o0bfup6CKsF
	 5/wN61Hpj9f2GsZ12ivLJAXkBL2s+z8mfug1RXPOZ5VFSrtpB9QXXVGtXzYxb0hX4bart
	 LThQAIXAdQWP5Z8gAYyDksn1C+xneuawtjOY2qSHr69iF0l0LIoz5FYcxv4kR8+hpnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZX7ZEhQfl7zn0ja70UCAxY+bTQCiZDULfmlHtdn9utU=;
	b=pY6b6QW0szOWs6oDkmleUdG8/SNPLAmIfPrtFBuvDc7fM0yNZnE0bITrOEHKf5aJNcRg
	 /7TpUOF814+8NZ0TCVnGVeBgHiogAk6LNKx2xFfCqf3g7GuaMxiUyAL6CS2UwptC3QtN8
	 9E0To7pb5zEyBINpxY75IA+XNUyh/Wn1U9BSJkwOJClp+QGLkjk1uNFn5s0bzitGuSYzD
	 eWySxxxXFdGcmLDP4L9SchB6YQzy38AUfafcB5TCfDVCMLX2czuvvksJLo7UYf7/LR1lI
	 96t4Y6pVsZD3mRgniDSzLVBUZLypxXLv9LPjXEbSho69mtk0ngcyiDY3hZ4nvO2piLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BWNNjBki;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E2606A32C
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38E2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BWNNjBki
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso27583345e9.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794744304; x=1795349104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZX7ZEhQfl7zn0ja70UCAxY+bTQCiZDULfmlHtdn9utU=;
        b=BWNNjBkib8an+oyBZyJADhDa56gBBq04KQvE0jWVFpSJfKxpF4gKrAJaqtGgQ9A7Sk
         ojS6OtMdXCNiENKdce+QVKFflf9mEeRXGuwOfIUJ6ge95F2lMlClOFtMNlc4TMSPM0J8
         OV2FXRdUFoZjdPN3arL5fxZOttuMPOroAyZZOBC7Ur5ZUcnxq1huRbmcstdqw1kgjnAr
         p0ABZijR6NLOhZ2WnekX3RIVDKxp+9ngiyZWFPwfZXDz4vy9t+jSaKtI1nNue4l72DDh
         cQtlj1JRMaanxpySB0K8/6m66GzX8SQjTDawrPFHoWZ3u1MpjINNtwJRoQM1ToXyNUfW
         1a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744304; x=1795349104;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZX7ZEhQfl7zn0ja70UCAxY+bTQCiZDULfmlHtdn9utU=;
        b=yun2EqkNX+71O88Yf70W3oBmebUHHmbjlFAyC40Bbdn3wRstdStP25iOviEEzVkt6k
         2cGIdviwPTR9gwkXim9GW2zhuDOtqCyJVU1UoxYTJEla9jp3tVzmiK5xDfo4LeiwXW20
         8I4cMX9C6MdTWda99fJJJ7cVHjFGi9bVzkyD+EQvjVhPnZwupAIpBltpOPoYnP0JX+aE
         sWj0xRH0ShISe9d1owcV28tS0WuisfEvtG41UyU4LZL/1Zl3C+jV44hYu2On3vbAABm/
         a9RU8BMH8Zt7rhJB4Edcaxa5FF1JxKs6ijx8aMfBLi5qnIhXhqAprf1kSHtYPxxaJ9gx
         QvUg==
X-Forwarded-Encrypted: i=1; AL+hErGNcmTlVMxtHCzLKkmVtlwZzAyr/7g7kxxltgaPmhvQJNlPH1nW/DeBq2ixFfjmkZI30l/B9sd40Pg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sTajIor5Sa/+Mm9Nvy4rVZmad2F3zv6joPtWBxOc/SMB0PFgm
	e0AbDm2KGMheUxUYIkX9Oes+qAEnDgFmS+P20PcWeVuHD/0A5sa2FKy7K2yCNC4CRFg=
X-Gm-Gg: AYBFou3zj1eWh4znzgge65BQ0TZZkghSeFd9hbrMLQrYbw41TFZ/WdVuJpdwBsjXBo+
	P1yueKRvXRwlwJ9QgW+IA1h35c2RIk5bx7xpgSptLlz4sxkFYxn4Xjwf0JJOYdeF06JEu/l3Kic
	Ub+33xlQI5aOFGj+vpDKnictkuiIVDnhw/bmuyN2krYghU1oQRmxITsDAzO9UIxMbaMwN4b+6ET
	ZdOV+wdLQYLt5cBwMLBbrac0fqES/lI9Z/oEJDxENYWdI5CKf4t8creNitCeNSUOlXjAcQ5qQbC
	OwZa4XpaMjDQxTTW9eoGHgaOQXbNeHDdTyBZctCwM3gyexf7YUgYdPJIZK8/fW3hV1mjd1st12V
	sDuFEfEJIwhUILvc12i1BgH0EbCGVfr0urG2ikybhdM07FQWhm3Q6b5sMGrYmKKFcDARgOplH8v
	3nUk9E+KZmBK9ZXHm+ek1vWKa4vW9wcyQODF1uyzVcDB6OfkTBrl0SyIK1gMWQFvH/uU3gxrppC
	hG7Puf8aXLG8p9Qv4WJSDTA5oPfkk2oGc4oH8AU96ELnBZgFbO09H4Q+eTDTpv1QlfIXjr810aH
	jhCqHru6rQLT8ntBoedUcYc7V0fKqJwkyTe5JPA+ZqQ=
X-Received: by 2002:a05:600c:698d:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb5de1f262mr108419295e9.26.1794744304054;
        Sun, 15 Nov 2026 04:05:04 -0800 (PST)
Received: from [192.168.0.167] ([78.152.238.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e33ae5bsm267265565e9.3.2026.11.15.04.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:05:03 -0800 (PST)
Message-ID: <a4a3df2a-eb90-427f-8881-f857100779db@linaro.org>
Date: Sun, 15 Nov 2026 12:05:02 +0000
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
Subject: Re: [PATCH v7 01/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 SM8750 CSI2 PHY
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2026 11:29, Wenmeng Liu wrote:
> The SM8750 camera subsystem has six CSI2 D-PHY blocks. Describe them
> with a standalone "qcom,sm8750-csi2-phy" compatible, so the CAMSS
> binding can instantiate the CSIPHY nodes as separate phy devices.

C-PHY, D-PHY and combo mode ?

It would be nice to get an accurate description.

> Signed-off-by: Hangxiang Ma<hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu<wenmeng.liu@oss.qualcomm.com>

---
bod
