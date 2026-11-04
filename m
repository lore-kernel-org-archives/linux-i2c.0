Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833963;
	b=BY/fDZn5xOOce0abF2LuSNx1iSdC4VsDSvUGQmfvMZZLhjsHdoCjQGAqnMDzH1IMgIEp
	 Orkv1ewgJfupgkADacBq9Sx5e7euLjJnEBr/TOicebQun9bJ8hRslUzNr5NWhxYj7ng9U
	 nmPyGHkRrwHmJFsZl7EIJZF6DKZJiHh41h1nR7NZlxUijS1YmiXJzEytTN+5t9oEYJ825
	 u+RX+Wh7jarRLfcH1dvZ3lTz0ogkDTcpHDQSKY6UYyqBf6CQLmqq/dimrU4o0t4PxhIdJ
	 QKc7EYJQrqoNK5yYqxyaw7xrJ5zwLCmfRrL0E/fFAGEhKPpUUeaV7KKhO6FHHKFS81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4lBfIR/LafX25Og3OCJQ1wVKuVTFo8wSNFYi96ni0r8=;
	b=VDplW4pNqaxMyvZ9ftUx/mqdhDT3lnT2aAwjSExcSsV4Qb80mwxaNqXej4svTV6UiGNr
	 AfCKJeg6UvQF3SKsW9AKnNCbkQN14h7qH4XR3/us8RfyIJLSagkbNcAL44vNTz7CLw1kG
	 Axxd75lHsjkc1F/REYJgE46m9Z0BN8Au2ITspjEJSoENROqdoaLjOgjKW2RgRfn9lGA0m
	 uvgIBZuszYxKWgCTWK96SNDIwwf2YUDHFTeMq5/rXtSkakVStM4XAufypp9HmYrFG6fzp
	 cZYdzYLvMJpdOR6Y49gGZSC/1wCroPiyyBF3mFhg+D07KfWXfizxBsxXgRTVNC057nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gs9pV5e5;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08A606A326
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 23:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F08A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gs9pV5e5
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bb786c89c8so116228e87.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Nov 2026 15:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793833961; x=1794438761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4lBfIR/LafX25Og3OCJQ1wVKuVTFo8wSNFYi96ni0r8=;
        b=gs9pV5e5Um20Qgo2XDi0crgyXVOH8hndAHDdS9S8n+43dJaechcABgzMF3gj9EfEey
         KIuAT3G2FtKH/EJj1mtS1PFBWAxdRZmTdwvvqANPzSJZLEqsmxrOY60co79CiqVHLgpx
         I5T962ziyuGsNoMsE2hTh7U2V4DLW3/oe5rwcxjoSHX2o/K8U5u3Pu1/gKksHc1W0OKf
         j0ZwfHiBu3eoKoUKeSfBMPHKlJO2yCbPHSem0oghIS/EpeGTfPWJpe7jR/8Mqq43IY7T
         sNQkzUZWyy7FKByarHD1qsabOlRFUrBvwsAgNUPm7mHBowzx/reelAmpt3hqobysshdX
         V8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833961; x=1794438761;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lBfIR/LafX25Og3OCJQ1wVKuVTFo8wSNFYi96ni0r8=;
        b=y5b7K+amM5VUE7BCZzDMUGBxePFOWfJzK8RXGdr9rubigT1epriiQ2eTtVks5696HU
         z99NfMq21Z6ZdqH4EJfdogfa8DbX6pkOAUFgcFFcYv8ObI6r657eJUlquCIfzXFn5daP
         liALdsVeWmhAYLAj44BO0fqh/sJruKCc/GQuXBtGqTUVoIhG5LUm37KroLgcIMhrSkbF
         wpw47h5P1KK3AybHdWaMpk2HUO4PYKX+FGMpIPniSHp3zITmhMJjSMg5yt6NcPaB9ukn
         YFQESnA6mDk3fqE+4l9XokP4rDy9dh7ccersQZ46W4zW3HVMoSADVxJ3KDox/iTTNea4
         AcEw==
X-Forwarded-Encrypted: i=1; AKwUvBy3saWVWxwBIaqV/GZ+yTC+Yf+NE+jno22eBKz0dAdc1s1g21tPCv5pNIfJ4/dup7g4BjhLU0EhVUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3oVyXoUAlOe1sKG7TVMtvTQy8pcGykIQx4qqUIJcuzpego8MO
	rJiviqo+wxGbxaWrFkFpKuG9n8A1HUZImeSW5YnSdpnDucJXgDZT4rvg7kBVUAv3Bw4=
X-Gm-Gg: AYBFou0XpGuHoKcqbSwaiePp/KBMLjXz6W10siwKc+rB6Pu670AvWzn9DeOiXC+BcQo
	5GDABhbUw3YBlKR/CfqPOGLoUsppajOWh/mZgMu35iABdaSEfh1W54UPDuug4wHUdiluG2nAsd/
	2ncTFarbvFBxcxuUHZ+PzhGWwbjG0YY2JpnxXloF/K8mSGWmQTslxbYlLziVyIv502o8RthcJvr
	j4wkQb5S7AkF1Qpy4a9ww3HTc1kyBceput1B3fLEFvL9ebc9vamWUFs/DZ4UtN0Hw+facsCGWaZ
	qTrwwVuM6gsjkPPs7wPFwmdm0PsrTUdtD/oL3LM3JUlkm28ntU/q6bkuGT04WOYvtqOYi5V4a4C
	ZV/nqH6tOtunaJFYCNo478Y8ZqJ4Lj01ocoY7qdv/08WGKNQcAv6tD8LjpuJ7buXiZ53Xv5CMQJ
	r0uYprttoNuSzbaa/Et+R2E+N02fhsYwyqnDvZUK3H0gbdurfbfEw0q8P++6dDl8KpaXzX711eK
	/e0jMj7knIxYkU3Z5ISgA9MmOL9e3Q4Z7FKiqzThMBPFof/elzPqPloD6/Vbnie/qEX4FOOQFs0
	n/l/RlMMrAn0sIDKmx0H+V8ZV/h3/QMtmDxy0y3qPU5pvnHU8OHb9ZQYTNg1camnC7Pw/4wWfSj
	1cBYdx/I=
X-Received: by 2002:a05:6512:3a89:b0:5bf:f642:bb43 with SMTP id 2adb3069b0e04-5bff642bd0emr1119881e87.3.1793833960601;
        Wed, 04 Nov 2026 15:12:40 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff38cf7bcsm540327e87.71.2026.11.04.15.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 15:12:40 -0800 (PST)
Message-ID: <ec559f1d-0ecd-4de8-9baa-a0a6d5aac5b8@linaro.org>
Date: Thu, 5 Nov 2026 01:12:39 +0200
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
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-1-7a9534a9a22f@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-1-7a9534a9a22f@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 22:54, Andrew Gigena via B4 Relay wrote:
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

Apart of the update to the list of compatibles it's expected to document
the clocks.

-- 
Best wishes,
Vladimir
