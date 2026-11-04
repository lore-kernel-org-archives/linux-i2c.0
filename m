Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832073;
	b=jKrklYIh8rMfaYswIWNo925fRXMdkx1elQ5qklWDhX3SWCEB2AcZAKy1YmzUEWCKd7TN
	 NJWirtXm45JHOwHLTTx0I4+HQAOMsqgyVw2l8LxinG8yxtuQd/CHaE7RD+O9fXvoYZcEm
	 jsFnIoFTf2+TjxhMaqnhOCqb7zaDlRNWtsxQgABSUNBuz//ADwBZWuS3G5qs5oQHrxQG/
	 QDj0ylnXhcss5rvgihfTfAXQUn9x4d3qchJYQOVb4kFraMpIGnWf5EY3hmozAPtDiVSsW
	 UBlAT3fsMJnO2fNQ2GCOp+l16ZS3/m0nrQbQ5gpKrejb6z7EHsV9W6j6gCsLF4DFebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/nW6715EtFswgRm8I9cbPPt4Or68BEFqTuXQQkMmvZ0=;
	b=mKilKaa3gQDeowh/WoL3yS6R7aKhSRqyZehf3IaQnYCIIsFh73LHngaQRqxoyWoZ1OWj
	 U704lUNwAt2cNfaohT9/iy02RM5dMTE78aicMTtM/elEsDgp857u8DxfBw1lP6fOSqDnh
	 KpL6xRd9IoXReRe0q7T4EKPPd90StXM98/ymRky45/rR6lXNv/fBc/gOE2pFIwifOAxAZ
	 ImHzN8Oi68naiAOeGjhaE8HpzuVt/ixBypcyob+nEWHoyCNml45CeKE7SNc0sep/Nl5/j
	 qV5+ykDIw/0YCHcP56JcFpzIaL1Gz6NF2b+a9AOHlzz3bCs/XYwZtgsITNzvBc5q85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VblTHW8t;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE1606A329
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 22:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60DE1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VblTHW8t
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so7814075e9.2
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 14:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793832071; x=1794436871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/nW6715EtFswgRm8I9cbPPt4Or68BEFqTuXQQkMmvZ0=;
        b=VblTHW8tFX/DEh57e325ubcAiELluEymaW2vTWJuEEHyAuM3tm7KpOyqmWbQG/Op3f
         Msw0b1pJGBWgfSh66KmwWzwckkRp6IePhYqHGIkYUFna08m/hgJZd6QQDswNo0PXVObu
         3CpiTQiXj5E4+WZdskOIi7h0GjU40neX6tFnJ8NY1Sd2YVcZ12618lqLKskZg/T6dbYn
         mYxG36peURPv7BA0Mr/ughxR+KzpZXsw9r8R5fYIME9yNHAVdz8a9PRP1fQI38oKuPrd
         TvSa2T9416wZnCTTXJcP9uSG4Dwf2kTo0XZoaNmbIxIBmJpoHEd7hhkaTpqcR0TqdV4M
         46Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793832071; x=1794436871;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nW6715EtFswgRm8I9cbPPt4Or68BEFqTuXQQkMmvZ0=;
        b=0gR31fKozULeseSurjnp4fZO+VIcbabvisI5Kyd2EsiRAJHL20redBYNKGo/ksyPOp
         RHs70nt3lpMixRu2ErBSRaTLUinpQscCpI0wwXyqNBh/DfnncPzvHaL0rxNIqbzVvSnc
         RhzjAv477Q4g8OKlirjjhnZX2NnQ/45WFFCmwyEm5UGMj+K6OL8RUhwnmB1v89jSDOuL
         rbPEIFJoT4dcEADqYju7xZHgkKpazkHro8YI8AonSXZVgCVmCxzOZ59sJxCwQK4ply+S
         piW2WjaIwRvnImvRAZ/pJ7in2PiSWzB+KURAc9y52TP5KSNUQIiHNxon2UJ0pXnsjWIe
         kcWw==
X-Forwarded-Encrypted: i=1; AKwUvByxWOoTht+XmZATlWAHnoCYvFopZcsdc14Eqrh3HnZEfG+XM0qUTzCVQW/e2Rld1LOEEYSkeOkUC2M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qCffk5jg3ZW84IlxeAhwm80ALmsfDyyYQc9vMDD12uMwG4jF+
	830SsHwr9VOIU4XZc21gm5g9RaYU7p+1cWP3kCHabwzXpWv078+zHeMNL3hMNCnwb20=
X-Gm-Gg: AYBFou0WJB4KYuYC49w0kjyrrxv5poLVUCLlB1ZkZTiHNoqnbcuY0XvyEZcz3AjNQoT
	EAaLE8ue35Bxb5/UvX8Vs1/GPYUFEJphvuRq505bguMHbjfi1U394QLa7qHO1+/tNSmWqY1/6k/
	q/8gOs6tXwzySSNSLcdpYJX2n4lK6J9nLy36aUfb5zq26ghlWFdrjMEWvHo1deyazKTPvNu6JXf
	0uNK0uGEbcve/SdXbyM2dsbiRMKZEDU7jLAHow4dbJW11Pr1MNPuNMpA/nFJM6EQAJF8ddswmbq
	7n7stNDdoY7ZWrQmM6AA4uCdTBrpfAteuU5ivHKLMqhktPY0LEkggkFb3sSvHnzKhIoyV6m9L3X
	9F8UWOURWvIvSn9nkdoY4aSih5nkNTBkTN/vek4bGburoT36YwOb0Yt5NmPr1fxJ2erJYCTf7AN
	BMzK8fOBeNScGQuelbVuwL0XUDI2xfiQ2JSzNSzpN2SnHTiJ3MMZEWOoPnpwnl9Nr1QWjpldZX/
	vEDnR/ItvBGUfZNHbvvcj+QQmHDzVupSQCpLGfgOP5bPOxHtgTxnjq0nhkM9nnCDA206Vl6TyUI
	BtqoBulP0VZjzItwe+xzNcWUJBdPNgQGTS9aXW4Ta3jqBdy0KpYMPsFyi+LjftA=
X-Received: by 2002:a05:600c:848c:b0:4a5:dc5d:20f7 with SMTP id 5b1f17b1804b1-4ac175669d8mr428288325e9.14.1793832070829;
        Wed, 04 Nov 2026 14:41:10 -0800 (PST)
Received: from [192.168.0.167] ([109.76.163.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56f5e65c8sm16013915e9.12.2026.11.04.14.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 14:41:10 -0800 (PST)
Message-ID: <ca9d806b-567d-41fd-95a6-daa6aa14d7cd@linaro.org>
Date: Wed, 4 Nov 2026 22:41:08 +0000
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
Subject: Re: [PATCH 1/4] dt-bindings: i2c: qcom-cci: Document SM8150
 compatible
To: mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-1-7a9534a9a22f@andrewgigena.dev>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-1-7a9534a9a22f@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2026 20:54, Andrew Gigena via B4 Relay wrote:
> From: Andrew Gigena <mail@andrewgigena.dev>
> 
> Add qcom,sm8150-cci as a CCI v2 compatible, with qcom,msm8996-cci as
> the fallback.
> 
> Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
> ---
>   Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
> index 1e8def25ec0e..b545fd2378da 100644
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
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
