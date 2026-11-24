Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515362;
	b=euvIRrjJBtYEmW8ifZ1MNCI0CfkWgvYbLhv0F+sfmKtthZd95467b1ng+AywjVRZa1KC
	 r50snfemEkNwlUT30ImrSJoDR+L5evC4dhsa4AyBb3YqK7tFqp7HqWZqkyxiKttX3fio0
	 9aYmpyojPIXyGf0JJphMmT/7N1RpRKERg4ZaWNKHqI0BeMSUwxhdGXcRcp6rCLMN7uFd1
	 f+zML4ODdl8Aff2+TMe2mhPDkBqWcXjBZYAGqBXHSAVBgWhmuLFMT4dlyfnqYhsV3/JgO
	 PR3Fh6eLG2AIWxRzz1DysW3KNVbYE5tTnKln5Gr4eqdiO2FAihEuNDkTeZBmiRTOaSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RrKfr9NI9CivHaA8pHjFoPu8oHwiXk5e1C77F3AOha0=;
	b=rANje5H1OFQ7VmUaA54987EdChK0t4iRECG4hwp9+EidFb44BANq7IlawHh05TPpISis
	 Wii1DoRl0m37tSj0g/+aQrwOIEoSqYc1grti6pLDrT7/saBw20YVLOz2p5I3/jDFtdgal
	 /RdEPVMKkQ6dWWnQ75EWWqslqgSLC2tiv3++/AqanP39NcBmozOCpA5YtnPrC0T3EvvW5
	 mN1qrS+D3Z7OkUWGYSeWVwaufaymx9qcqGcveZw9/8GHZfdsZsq63LJtYO/8m5kEg6Q3I
	 GVDOf5sQT7wfpUvpRT5O78vawS/nG/iwsEwt3PeNo51JevTJQgkjd/f07Vy2QpcQSxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BEzQ6evf;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4E606A691
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 10:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA4E606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BEzQ6evf
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab3cb83f54so3054841fa.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 02:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795515360; x=1796120160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RrKfr9NI9CivHaA8pHjFoPu8oHwiXk5e1C77F3AOha0=;
        b=BEzQ6evfQL/UWxcO1jMemegBaiItWgXt7K3ICkbaB+XVjQx3epFSxALyZnr3KEcsHE
         jmT41Y+/N5yi6qiRjAotOmDCy47AW8AmnIepEhRivFuxjhKXTwNLcNvRw6gyK0Blaj0B
         16GA59m5BLke/QdOwHVVHRtC/49B+83NGxnh1loplB9EHrgNYfbZZiCp7kWgbUv8Q2fr
         FNGNFC3FuI17j1Q/ivCovmgN0OgfUCrt5CpEnr4bQmq7sKX8fqYSXlzNYIl5e4T9EF5v
         0TK6L/KUhPXEbbukolilaEUgXwdFwYnfy5KpOpJdNUgAson4KD5hmJi0wS1e4PPwblQ/
         HzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515360; x=1796120160;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrKfr9NI9CivHaA8pHjFoPu8oHwiXk5e1C77F3AOha0=;
        b=0x3W0LxtH5ZvQJI7T1oRey9e9joR3LdmKQ3gu6iEWcnXl7Bjul3AhQuRYusBc5JdOv
         6H72NWTHSz5L2CK+X32MMa5Kh+i2LSQYMZnGt69GyMl/N3vgOZCuQVPCmbwn5qrNel7G
         S1Ol0Av0iRDFOvIRy+m08gUcj6Ud7PciRFN0I3w1MGAaa8/95RjdxcB5RbHdiyIE1TDL
         Knlh5lUmpwUYdaaxLG7lFsaXk7gJrVruu49CkvJxYtV8AJcqHsEOfl/YJY+2zvy5lHVt
         0H7eyaAAu/tKWpkKZRUf5P0WiRCRazwXVfH785IZwlqe3C8at6WX1IHObxu+Yv5U6/Qx
         EgSw==
X-Forwarded-Encrypted: i=1; AL+hErGsrw7ODdVMUr50fcyUGExWEjOgsEz1A/pNoPpxF4/oW2+3LPUibpBwC5wSdupkgZ+4AjGZ1+lPUZ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/87oZ3UkPoqyzuvviElEHff480ad78lX+Fu2v++q807tDuDmVJ
	jVyfwXR+F2DKlV8yUReHd1krqSLRsHXASLK9NX1ad6dK4+JegyIDETiMH0DP48HTeXU=
X-Gm-Gg: AZFdTZdHer25BQmhgxtEWvma9JMuNKYd1biL8EFa75dO4Qr5CMhMBjRrK2kBc+3jSH9
	U+NlH9+9AOIiqbObnQVHSOG1MjGEGoPXJnXDJ7SBR7IP2v18ykbuVCdmR9PZEor+pZ4DHeAF0If
	8o8rq0QZ06Xsjvunf1PZI3nLyWguH7OgwjEKN8+6z4b1UGXvstaojSYS4IAcR6TEa0Az3MU3Vka
	RT+50ARG3XEF2VNTp/BIAF+2D9ih1R7K3e684or3/JaxlKGcaUzLgdJEfALXo3aoXl9Cdy4WyR8
	Ul7af6VhHmv3h0tCalB8sSLlmjlxiBfgxpFQwEbjV0XD2hYnFT95myN5lF+CKYchoFanYx+8qkg
	XgNdATf8iHmxTz95xSVBjlmYEiLLjI7SFD3UdfjpDSbqc7zE6ezJVVu8cwprW6QPRyh1bisWslu
	jLO0MN8215Yikqknci5QnbmJ5pa+MwPt7yPVivr9OETpUWik3Mq9ADeSjh4Bjivp4zgdtGjSTHB
	92CcgzAaZGMKBAHZMpMGXBtWkHJGAL72hIkhXat+67Hy/InUYdu4hbZiC+Ha+OKffwX7MhimImc
	vU6QvBjHonsliVYRlhbuIQCVSadOdvhJvRlNMUTH+/D48xaGyQ8BDM+l1DkuOr7LJOhbXzdC50F
	73bBmkCo=
X-Received: by 2002:a05:651c:c011:10b0:3ac:dfad:319d with SMTP id 38308e7fff4ca-3ae7f9d6f4bmr30282431fa.1.1795515359820;
        Tue, 24 Nov 2026 02:15:59 -0800 (PST)
Received: from [192.168.1.101] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e211sm38976231fa.2.2026.11.24.02.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:15:59 -0800 (PST)
Message-ID: <a519c2ff-7d0c-4aac-9a17-b9e76913d659@linaro.org>
Date: Tue, 24 Nov 2026 12:15:58 +0200
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
To: Andrew Gigena <mail@andrewgigena.dev>,
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
 <f127954b-2255-482b-aa3c-cedd2311f77e@andrewgigena.dev>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <f127954b-2255-482b-aa3c-cedd2311f77e@andrewgigena.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

On 11/11/26 01:52, Andrew Gigena wrote:
> Hi Vladimir,
> 
> Thanks for the review, replies below.
> 
>> Please double check if SM8150 CSIPHY v1.1 is capable of C-PHY:
> 
> The hardware can do combo mode, but the driver only implements D-PHY and

"The hardware can do ..." is necessary and sufficient, when you add
a device tree binding description, anything else is irrelevant.

> returns -EOPNOTSUPP for C-PHY, so the binding stays D-PHY. Would you
> like it documented as "not yet supported" anyway?

You may add a short note to a commit message, but definitely not to the
hardware documentation. Hardware is not dependant on driver status.

> 
>> D-PHY combo mode is also supported on the SM8150 CSIPHY apparently,
>> it shall be reflected in a way that two endpoints could be present.
> 
> Split mode is described in the binding, but the driver rejects it, so it

Don't look at an incomplete driver at all, when you provide hardware
description.

> cannot be used today. Is it fine to keep it out until the driver
> supports it?

This change provides hardware description only, and anything related to
one or another driver is irrelevant. However since downstream driver
provides support of some hardware features, it tells about the hardware,
and therefore this information should be represented in the dt bindings
documentation.

>> In downstream camcc-sm8150.c, PLL0 is on MX, and PLL0 supplies CSIPHY
>> clocks. I believe MX shall be added to the list of 'power-domains'.
> 
> You are right that PLL0 uses the MX corner in camcc, but that corner is
> internal to the clock controller, not a power domain of the CSIPHY. The

Formally yes, but probably CAMCC driver should not enable the MX power
domain, if I'm not mistaken, there were arguments against it and to
delegate such logic to a clock consumer, which is CSIPHY here.

> PHY only consumes the top GDSC; SM8150 uses legacy GDSCs, while on X1E
> MX is a real power domain attached by the PHY driver.

Here someone from Qualcomm may help to get better understanding.

If MX is truly not needed, you may add an exception for SM8150 CSIPHY
dt binding description.

>> Still it would be preferred to get 'vdda-0p9-supply' and
>> 'vdda-1p2-supply' properties.
> 
> Renamed in the binding on v4, the driver and the DTS, matching the X1E naming.
> 

Good.

>> In general the change looks good, thank you, but likely it can be
>> embedded into the scheme for X1E.
> 
> Clocks, register offset, power domains, lane table and timer all differ,
> so folding it in would need if/then blocks for almost every property.
> Would you still prefer that, or is a separate schema acceptable?
> 

I believe it is good enough to embed SM8150 CSIPHY dt bindings into X1E
CSIPHY dt bindings.

These two pieces of hardware are non-compatible, but they do belong to one
class of devices and can be described by the same dt binding documentation.

-- 
Best wishes,
Vladimir
