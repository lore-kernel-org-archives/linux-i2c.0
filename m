Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872048;
	b=I2BGhJzRGj7aaSTzDdHIMBPnW3FCLUCpaHhERYv35DueAcJlykcfw3yGPVVsIw26Pgbx
	 pjX335tWT7HioKaOVw487810jMx7Mo5eUnr7R+lpis3YdGAFI90WZctja5dALuFxrTmhM
	 tyR1QGWX1zw7QCohFUAnLC+e5XFtHHT3XiJxZHnCVgFXbSJT3SCu87s4JvwwUCjKTS1Ds
	 9PdURk3xV6BmO3ZM5Ksx2krlR0DyXA27UXf/Rv78uR1x9YciGX3JYO1vX++jGw28wUf0R
	 oVh4iP2EIpw0/x350+aDN63xWsEh4cHsWtEnRNXsYUZ7H2PUSg842v4xqJcU3w1HPYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872048;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jyLL8ZmxrAARfweF0V8YGIXZS1Pegf4tg2ZATRaSJHc=;
	b=GYTOfGHmiKqrOUeKbz4v2WN+TzUFBbNpVyK6krINaVkmgP2PkuvRCj+hSHasZox8yZ+0
	 UTXoJTQdmZ8TjtVTrUwb0pcm4oKANmu8LMqT751xyz0+XUQssPgPANfVjyuY/2Makowh+
	 /3zjNGMUgwDFUMtBJqYmY3u1neCVDlG8nVHbrQPit12RZCbndx6i8De/EJCrP6WwGGU3e
	 SwGtNmgHIEEb3djBrEFcwI6AGMrmAI9197COfm8pZrawT2apu3CnI0KlOZYTTpy9Kk+Ji
	 6RGV+eK0uJOOPZCb3nFvk1/SmM6DwTnzp1dhP0yddgzksgYNxM1JJ79Z4fDw/2kL0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFD606A330
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDFD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a208d93758so18465495e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793872041; x=1794476841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jyLL8ZmxrAARfweF0V8YGIXZS1Pegf4tg2ZATRaSJHc=;
        b=RASG78SQJZb7zly3rDtTUgyOxzbegHId3oxXTHrgcPPTO7wKUsm28sWnWodJU6lGHj
         Xl4lgSwi6T8p8iO48+EYJyut2DlkqBgDidTj54wXHNwFYg81frFZE8Q7apcHbehGyfUA
         oEBrf2dIpQtOCwWHURtTzf2Dzmg0FgcsA/tVffLX9VOTMSbrVTczidrPCVBSUmPfF8xr
         VdCf7x+UzAcuXIV8ZgZ7/IHSey42eTXQt/qVDbQZL/NKaCBoqsLCKXtWNZ4qjue5YjS9
         3KNNVGfvWsr5ovwtxywRvbMkqZpXcjcM2JDvQJQyfSpzT0jiqJ0bYD4srOLe6uto7P4W
         fyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872041; x=1794476841;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jyLL8ZmxrAARfweF0V8YGIXZS1Pegf4tg2ZATRaSJHc=;
        b=C3URBMzwnb1VQzBd3791u/OQ/TI+f82scBtnrpd+xva/Cog+swEp/hVDc8Iy6FgJXJ
         tClVTyRmNXd+zNy5fZ95jFKUfxlPiVTDg6jnkWq9BPn2z5rAPEmAEQx/vxDiGGOFR9uz
         8k3i27EYPJAyoyT8wvvyvN3m3h7y95KuEy8Dlj3o6LtLeaDd1v1J1+iHitjvmQdnEJ5d
         NtrK3OKuK7DuP+zGYcsBR0xvrsDMOHJyIpnz96iWhuVrEENr+ulfFrPjkLWG4iAFLGw6
         sPAc0+kU/It8ssiRfrdItAB/dpAezXoow4IEPrQb2QKUqsuKCakRySLqhYgT9ga9HdUU
         Qq8A==
X-Forwarded-Encrypted: i=1; AKwUvBwe1tF7SOcObKBlNRZ5K0RKORbNgFzcUiQtvVFZQMHxn1E2NUymF8iJixpXcPOqdRiMgzmJg788nfU=@vger.kernel.org
X-Gm-Message-State: APuU4Z807U5EzowuViDvPGZho0dKEAxp+TdUI2W5vw21Am/zp9/zNYuj
	LE7y89hYZGAnYL6Exf4OGvji54sEsW1Ki4aNvsEs8HEUo934iz4yJF6QGkx1hv3Kjsc=
X-Gm-Gg: AYBFou2id38H31FKRutT02y4O4sIIjPNeVX/wxM0Enu3SaiUWzkB2ZSNVf3TBhxa6A3
	3shVoTMGvX9uA3vVbQQBpQgxmmdjdv9LDCNTAx73xNUiFOki0dWTnCoWpljd0PQ6HLVqgqfxGO/
	yfQTSpdZ2uPB3ag/AXXhGUmMspZ8LVUvR9amYY8ns/GT/ySJvDYKftEA+cHNmhWcI7fpChQcFMi
	yJSFCcag2Wkr/bA2nelVUmbhDMiHbZit01KChpgQ1hXt6Pjjee84sBjsIBF3RfJmRSzIdBhgVwk
	4sdj2naP5BIVQEtq6Ky5sNv4mcSJcqebCO/IkB6zGbjjtQXnPcnnN0HxZ4sx5rhT4D68pF1Nb2Z
	JqZMEkTny37HfKNlDCqdJyQzbnEHm66hvM2cif0mSRR2O6XzKasoK9x+A9vHMS3jVkyjz07dW8k
	O3ZW4itMOXACGvoGMBo5Q8rb729VI9R2vWiiUGOzDJcasUxWSWXd7OE/QE0cAOGKvKea/iqghG2
	UhQ7GY5lky95UPy8+EZzu1TFTidtBuFmGrVUupV5o5kjDOBJ6GN0sgptA740UIH/hyhoqr7jskW
	ddEOzmNJKvAwfXxxHQJFLzw/FyE5od9lZBDnrn2T
X-Received: by 2002:a05:600c:4f86:b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4ac18b7df2cmr429163325e9.23.1793872041405;
        Thu, 05 Nov 2026 01:47:21 -0800 (PST)
Received: from [192.168.0.167] ([51.37.126.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d71dsm8886594f8f.36.2026.11.05.01.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:47:20 -0800 (PST)
Message-ID: <5ba03b8e-1d51-4e66-a802-37e63814f5d5@linaro.org>
Date: Thu, 5 Nov 2026 09:47:19 +0000
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
Subject: Re: [PATCH 2/4] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 mail@andrewgigena.dev, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
 <20261104-sm8150-v7-4-rc1-camss-v1-2-7a9534a9a22f@andrewgigena.dev>
 <904675e8-701d-4fd6-b418-6c0dcc9288b9@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <904675e8-701d-4fd6-b418-6c0dcc9288b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/11/2026 23:16, Vladimir Zapolskiy wrote:
>> +maintainers:
>> +  - Andrew Gigena <mail@andrewgigena.dev>
>> +
>> +description: |
>> +  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm8150-camss
>> +
>> +  clocks:
>> +    minItems: 42
>> +    maxItems: 42
>> +
>> +  clock-names:
>> +    items:
>> +      - const: camnoc_axi
>> +      - const: camnoc_axi_src
>> +      - const: cpas_ahb
>> +      - const: cphy_rx_src
>> +      - const: csiphy0
>> +      - const: csiphy0_timer
>> +      - const: csiphy0_timer_src
>> +      - const: csiphy1
>> +      - const: csiphy1_timer
>> +      - const: csiphy1_timer_src
>> +      - const: csiphy2
>> +      - const: csiphy2_timer
>> +      - const: csiphy2_timer_src
>> +      - const: csiphy3
>> +      - const: csiphy3_timer
>> +      - const: csiphy3_timer_src
> 
> Please switch to the new model of describing and exploiting
> the stand-alone CSI2 PHY devices.
> 
> Any CAMSS drivers based on the legacy description of CSIPHYs
> should not be accepted into the upstream.

I mean we are just adding a new define for a SoC here - not a new init 
sequence.

We could move all of sc8280xp, sm8150 and sm8250 to a new driver 
topology but, I don't think that's a reasonable ask for a small change 
like this from a new contributor.

Certainly would welcome the transition given above as a defined and neat 
series but, I don't think there's a need for that to include this SoC in 
100% existing infrastructure.

---
bod
