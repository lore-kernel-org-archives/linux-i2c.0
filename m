Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060222;
	b=wGzEOZ9svufGghgTr92pMrKKzrPetCr5YsOlmocrx3J2baP1smexR0USHSKxoJ65nRZz
	 T5z+S/u1iwxhFEyzU5BmNw872nsZHQ5oqZOHdFzlmfmiXNRhUwDZ3YmFodFZMl81fD9BH
	 K7cEzWnaUWpKq1ENbTAy1cuwmeHFM1aGGC332r4450UKGfmgL0Ovu9ioOWPgxFDBnZuuJ
	 I9IMBALGzelyYHyNYSe7Pm7e2ZKTFGnoLf6vlOWkA2QRDYaaSckDXtp/fIG7OBcCR3GX+
	 uPVkirHTq9UunYmQ5v3QNgy0eJ1pSTo7kjxOkhijQSAHkM8V9IcFpQoSa/S2N1Pu14w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=n4RQKom85jkQdizG8jERqXd4viPHC+189UpuJ/BwOhc=;
	b=CEVKuEK4QDrPqCTANcclwfa6VTSGQBh758kmW1FJMJmgWWUOX+KDIdpbv2I5JkHVwgtl
	 S+BQ2X9ro7YZMNhuofcDzjDc/Jw+P+3WegkShsBKSd7HOBMXAzQDkO5lxNq8OFWwRYbz6
	 40LT31iC3BBXzPDCZfCIA+nQWfeIUh3+HKVgrv42LT2O8sCnSQLRrA+l89nJkg0uB6svC
	 ReL2rdSlW+JSmit6QU8+XWLIRCeXWn0w0VSpN8jHmzeZB2/k8BJ2wdy8UEJNh1CLqvYG+
	 uAW0xi5/9UpWZker1tJmwtRhFELhZKQOflOtxCfX35mhSykkg4gxdxW5x9Hp4122yQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aP3Lr9ih;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB2606A32D
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 14:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DB2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aP3Lr9ih
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso611725f8f.1
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2026 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794060220; x=1794665020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4RQKom85jkQdizG8jERqXd4viPHC+189UpuJ/BwOhc=;
        b=aP3Lr9ihnVE3AAdM9kPgIOvbXrlJiwClq0X74LQv3Wyb/Z9cppqMs2SyBmMxald4yu
         C7kE8oF6MlLS8Rjc84Pwv5t5NU5WSCXq0krYgU0fcGlOjUC+5jVUjdNcpsbspEjjl9wW
         KaVnSY8HVH3kwuZmvaalyNY9bp6d4g01KFtA6dYmG0sJMS0yVIMMoHhHZvdMld0yGyAm
         3XeXSmAfDvym7JVJkOKRByr8hhBdEnA1vTCsa2TEf/dXLc817ZRkiyMQfWgLXfK1+BG0
         qYVUL/yCfx8SnnmCchwCAoJsqVz9UC9Hsf9I7YOUzO5RHkQuJOZlXW7ydqVg7bdAoSjG
         5gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794060220; x=1794665020;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4RQKom85jkQdizG8jERqXd4viPHC+189UpuJ/BwOhc=;
        b=OZa+3RXkGf2zn0Cy4Vv2YZdOttfXwNJAUNX//0U6Lypd5/mR7pKvN2Pbb5wELnUFjQ
         CVN2ftwKUu8E2Ppvr8slmg+RkS6BD1WlBgOk1qviek37Qy+cExh+1O+hGbGseztIuSPd
         F8duulLla5WgpB6PNr8rHvXfJHB0MdVeYPZW08wLkNZcI/9w0va+7qD5a4REWGnR+5Jk
         FcbqluCZPv+3LziuwYNkc1I7UFn+pJODdZh6UlKPN11CYL8urhPD+usLqbzYdH4R/ypn
         T7uh7nmPIpwEMpIRflnL3WHzesJHx80jXZVDpXRazCGOLlawiRQ8J6aMXHSxW/hFdPHn
         ndDA==
X-Forwarded-Encrypted: i=1; AKwUvBzba54+uHv97YM1+9rs+y7s6kqQ/E5WGPq1yGPrpGqaETCDh5x5ucDR6XRjujYe+50pKVS+1uYEPLc=@vger.kernel.org
X-Gm-Message-State: APuU4Z970VOz3PUqJLLi2Eg023vn1z1JamxcvHD/t6IFXL5RXoUBHMyS
	T761vpK+W9ZQW/rkjd8P+vroaGUkK+IwdEwDaERFZM21qJRCdx+sWiJYIHVqe0TaIb+Jkhwd02n
	0OwzOwx8=
X-Gm-Gg: AYBFou28SUQuItq86pt2hPmkxInKddRHqt/4mwPjkURq1k1HFCEIxv0Vtokmyl55PKw
	GqjmZ2NATiYWATxRcQjRSnYXpEzg5GTW6NkjP89pCywdU1xRL69HFJUvd3G6tiIdkQpAu8vazAR
	DxECIdAJq/pMhf1zpcJHvKu0pYaRzBs3WNeN67PrSNYDZBSqYGwK0QvvHiCfyIiN/Kmar1tZUrs
	93p30AuCw5IBeHf3k2ud5G2yWUKSc3L9QFrSDlkYboRld6oEAUtRjIggmV6UZPWOvLZZrDPknx8
	tQ55L2JxpeAVQSFAYl/SgBs8EIYKZ8nbsERaacLxF4nBvFuQdIrFic3SnVKYAx90StZ973VlHqz
	XGPT2te6+srGzEpjyWrKRmp0ctF7w1Q2/iXAX9Bib3/I/yvRUk+7JHCEp1LeYd3pEwACBw8t1ZP
	ZtlXO1jlIE3IIyUb/D8uuALyCuYbQHT2rbFcWEJMmBgwy8S1LM7eRHZmGX+awx8BM2RYWAHqcpY
	YyPxzY2vBytH6MVQ+KAgVeLcd43a2Z+phjZ4YSoxThN9/zKRwwgCKIpKLQ+ArW+r7O95Ua27dhq
	cMZg65XUNbvPp3Sp77UUTM4yK7/MZTgF9gWX+rm1lqZd3lFJFFSOSQvGLw2gew==
X-Received: by 2002:a05:600c:4e0e:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4b6e054920fmr98235845e9.35.1794060220092;
        Sat, 07 Nov 2026 06:03:40 -0800 (PST)
Received: from [192.168.0.167] ([109.77.86.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7a0e1f298sm49309125e9.4.2026.11.07.06.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 06:03:38 -0800 (PST)
Message-ID: <83c6281f-1887-4481-8c63-957b4bc856b9@linaro.org>
Date: Sat, 7 Nov 2026 14:03:36 +0000
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
Subject: Re: [PATCH v3 6/7] phy: qcom-mipi-csi2: Add SM8150 CSI2 DPHY support
To: Bryan O'Donoghue <bod@kernel.org>, mail@andrewgigena.dev,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
 <C4VI5PNThYmwD0VGOO9DvvHRRydBUz2k5DOLjkianYgYaz4G3-El6cDpnQh2siR4mMwjeiL4_Yp2xEAYeJDJ2Q==@protonmail.internalid>
 <20261106-sm8150-v7.4-rc1-camss-v3-6-0103e8a0bbcd@andrewgigena.dev>
 <88407f72-0c6e-4e46-b97b-7031c237dac7@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <88407f72-0c6e-4e46-b97b-7031c237dac7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2026 22:29, Bryan O'Donoghue wrote:
>>
>> +    /*
>> +     * platform_probe() auto-attaches a single power domain during 
>> probe.
>> +     * Detach it first so devm_pm_domain_attach_list() can attach all
>> +     * domains by name (otherwise it returns -EEXIST for single-domain
>> +     * SoCs such as SM8150).
>> +     */
>> +    if (csi2phy->dev->pm_domain)
>> +        dev_pm_domain_detach(csi2phy->dev, false);
>> +
> 
> No, there's something in the CPHY series for this already. You'll either 
> have to absorb that patch or apply those changes to your tree and base 
> your stuff off of that, and orchestrate landing this series on top of 
> that series.

What you could do to unblock your series and not have a dependency on 
another series is cherry-pick the necessary patch.

https://patchwork.linuxtv.org/project/linux-media/patch/20261102213936.1251316-1-anusha.nandi@oss.qualcomm.com/

If you do that you can drop the above change and resend your series with 
indicated changes.

---
bod
