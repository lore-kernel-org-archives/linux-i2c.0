Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794744224;
	b=WXRurFCr29oivcjQ4i3C0nUBa0nNFdbKAWfyYA1tWc038VhvemxaphqZsgu4DZ4mlNAI
	 pGqqcIIgSrTeXL5pintcAKnVQhkPl591vVHZkoqmUgdQiU7NpMNhvywMT/Psv1H9AtyAa
	 EYBiyaBgEO9jpNNLXlSeJT2dTXEMCrUTl1vQHT0kzBDKTS4Q3fYuqzX3EUks2AP5KjuI5
	 eLbFroitZo030OwFo7X3kDErzoXdbJxF/XOsZqyOsHBllVld7eTcFOaekKHvFVMMEJCId
	 rPYdEL5H/BBjpfRMJepogVbcpNWHVVb4OG0PLShtwb8+lxgNTeBuyOtFM/Q1q8Yhz+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794744224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G2xfTStPsDXrBa4bi2OyO6+uMbuqPCiOosCTtZjhiB0=;
	b=pL/IAz3Vnl7WA3wDWOtk+lJZMYxqr70a9xlVfr0Qd9ghZUiIlhXFxBEXg4mFogs+xxed
	 tbzV4akwFRQYOldsfjq3mx8hbOglEXQFNxh5gGWnYOky4W7JRFOokA4Jrhkaj9CEl5dLs
	 eugBqH3QYA42H1hrBbZit6j7FGTseFZtLPx9WzdqCoBTxARY6lf9fgywldS933ap2uyYJ
	 FRRnTNBjl5e40+gT6NL8ArPR34IM97Xrym3y1AFXOYimvkxCbNt52ln8PmNpGC2UdjZwm
	 k+mL7c3bPkgWutD54jEDNe3fNohwp6C0p8pMmwG+7RhG5wk4d7pnDL8105F8mSYd+Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PUV0k4wi;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DD606A327
	for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 12:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F9DD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PUV0k4wi
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so3952255e9.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 04:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794744223; x=1795349023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2xfTStPsDXrBa4bi2OyO6+uMbuqPCiOosCTtZjhiB0=;
        b=PUV0k4wiuHhnC2t7Hsp/WAP5J+moB0hPEz1xgcSUOumUT/V74YrWQ+u4/kcDQAZZAI
         FU1UcT4LA71zQaO4RNN3fDK58kEm0gyjmnHcM9RXVv/QQUcKWnFnRVFUJIN5LvgOmRbU
         CdkX2MpZzMt3w1jVBaRwXSai8LXU3yenBkKD3eLHOTo7bbQWZTnRfd7OxqDr2Tm7aqgM
         tqbEjAIs/onLiVZMqsDdlB+BeBjSC46vX/IUEnjCJMfCs4q473Yu0+LQXUWKpIUAmuWq
         g5GqBSIfulUimYpqvkhkiTnwvyFlIbN6ai/HPSelBPAghTiFoksA7JqN58Ta6+eI4q4I
         045Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794744223; x=1795349023;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2xfTStPsDXrBa4bi2OyO6+uMbuqPCiOosCTtZjhiB0=;
        b=05Gb6mpWnlkUJq5VBZtwpF0LQjZqsyIVtvv6Rv6dRaEB54e755AxHcFaEPMoFZHRRx
         HjhnASpuG8p0AyL0w+MmIV7+z5QL/uakhOe1/HlOdKKq59NtJ6OEwmDN9DMswI9NIZBf
         dxtStiUo4WHc60aWZqcrH7YME19gXgGnoPtleDVHEASKWkt3SjJ09vLR9lNyeeAx+ejb
         sQArFNzWvlJBn1QaCYxMIJEb9wSz+WqfIH66740eHiXFJHu6uoKyvFNagbMEoBSGQwHj
         anUMoykve37ZTck/sVU4t3+kV9A0GyZZQcNf3cVZVjsKNjo4NJ0VYCtu6AxAMFuGsZsQ
         KmDw==
X-Forwarded-Encrypted: i=1; AL+hErFe/pFAfL1Y63puw5+n3Y9+flUkIQrssxIDQTLKMYkCP/NnTwMsxFpXCt7Jzupd7ZA0Z9A/Aw70xJM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2PRWEMfD46fB8OgacLQ/Mp5eHDNduNLNWAFoTeQpK4afo4Lep
	kPdF3RbRVvpoB85z3kRMHo0OGbVC+l50mnd69UCy4NMNL44dPDxU4t7LJ/TEaz2vUso=
X-Gm-Gg: AYBFou1o+FLhOodYUk39AIbulva6dXaRooVMC6Re2LupSgBlmCYQMhYd60XyOL6PHIg
	m9lrnAy8R62g933SOn13JS8OeuLJwgflkmqWpiv+sAQjpuLZ5JD5Lkv5yZup5ibBdB3ksVKqbfo
	+xF3IlckLF7MbWO+iTNqSQP5ApJqCZP/H6EDExzJIf938GM1+hvLPDaESqvuAm+6G7rz9fwhmoL
	GUjBL+jerBfGaB/BiLgb48Sf3c6dXZRO0J+qbFbJotfd4rti3CZCLILUTLt/OxqC+yij4Shm9YH
	LAt7bhvuWUNNmDEcXU3nB16/hgpH22DVwRnKDXrdSD/wMDnAkFUCJslauZSMIvzj3oe48ENwadm
	zs4pp5+dvpqx35tVSxH/69iQcy20mLDz38ZvSYXzNqEtHoUglq8gOkwRx6liivowpq71Tolionn
	h1rTeTFgQkbmZxsrQFkLgrj1p8K9I2xErfVrCqBw8/rMbcunmvH2yPhmOfwYK7Oazb64RhyvaIq
	b3UzFgkHsq542HBZAtHb1+n/nNxF1Vr69UbRSAHVCFOD0YLW+DKZJ55YMjyq2e8GpsgdB6zBBIj
	2R6rq5NJVFDkZn2hMDpZR4Wq81rFPYqPbSZDKFhFDUM=
X-Received: by 2002:a05:600c:34d6:b0:4a8:f2ad:a9e5 with SMTP id 5b1f17b1804b1-4bb559f609cmr148644995e9.3.1794744222495;
        Sun, 15 Nov 2026 04:03:42 -0800 (PST)
Received: from [192.168.0.167] ([78.152.238.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60021375sm15371401f8f.29.2026.11.15.04.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:03:42 -0800 (PST)
Message-ID: <31101889-9d4f-4863-afb7-0f884b50088f@linaro.org>
Date: Sun, 15 Nov 2026 12:03:40 +0000
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
Subject: Re: [PATCH v7 02/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 Eliza CSI2 PHY
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
 <20261114-add-support-for-camss-on-sm8750-v7-2-8ff2a11835f6@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-2-8ff2a11835f6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2026 11:29, Wenmeng Liu wrote:
> Add "qcom,eliza-csi2-phy" falling back to "qcom,x1e80100-csi2-phy", as
> Eliza integrates the same CSI2 PHY IP.
> 
> Eliza has no MMCX and MXC rails: CX feeds the existing "mmcx" input and
> MX the "mx" input, so only the power-domain descriptions need updating.
> 
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> index 8ff3df1d0d2787b2af0499c1e4106b86f56ff82c..884984f6f6b9e595df9bb3b0027c0bcf285b8058 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> @@ -22,7 +22,9 @@ properties:
>             - qcom,sm8750-csi2-phy
>             - qcom,x1e80100-csi2-phy
>         - items:
> -          - const: qcom,glymur-csi2-phy
> +          - enum:
> +              - qcom,eliza-csi2-phy
> +              - qcom,glymur-csi2-phy
>             - const: qcom,x1e80100-csi2-phy
>   
>     reg:
> @@ -48,8 +50,8 @@ properties:
>     power-domains:
>       items:
>         - description: Titan Top GDSC - Titan ISP Block, Global Distributed Switch Controller.
> -      - description: MMCX voltage rail
> -      - description: MXC or MXA voltage rail
> +      - description: MMCX or CX voltage rail
> +      - description: MXC, MXA or MX voltage rail
>   
>     power-domain-names:
>       items:
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
