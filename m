Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3D3BFE3C
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746942; cv=none; b=WJpuI2NLJ2xBp/KkFK/PqA7se4Hn9H1NHGHC+MmcB3zFH7D+ZSXViUTeRLfSfPqz540CO++hu8NlZnRJkDmzefpuDjcnX0Iqobr3vfm8vKaNWFyszVxW2Uv/dIEXBq7SiPYeVjT/18rza9H4EYCN/usc6L4xjy45W8YcWrypi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746942; c=relaxed/simple;
	bh=fXGBxwt49z7XnZX6d8Vyp0KPby/Zgq/bU0dkrOszvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2ihPjNtnhVgI0MdaxQFuUB9ICQFhBQ5vAA72juXVtIJKoE4iWAmEfWJfSzjq8+pq/+64ETH3ygBvvFY+5fDBqY1yEhbSGLOsMR2M6qvr9wAWDDd7DBt+3nY0Q07tgPOD+xquvjn4RptLYmkXrAUn+P18OHpZ33nU3D5AB/WNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiKuX1Db; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiKuX1Db"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82d029fd52eso675593b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775746940; x=1776351740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhXtNcfXFczFC0TvlssSpcRPxwc314v0ehuoW5MZUg4=;
        b=fiKuX1DbGyVtnp7dtcMjI+Pt8AwCt5ayp3fzcVj1n0sMtW3SjpwHQmCK4yMqKykGA1
         8V6Y0SG6u8YZAOcu9Lh7USRxhYl6cZDdT6f1nkAwP9m0E7iJJKrhKKlGIH6ISyRB6vt9
         7tzfy0Qh18KnyeOH0+4Vwu21mhzWQ6ZbsVq9s2qP+UurCKK8ITSdZZzOnxjcC2NvFEz1
         dm41rYavFY9eeVFqqZYv1aWiBYmt/C/XXd0qHOQrdm0y9yY+0l0hbvv9CUZo0VsoJxv+
         7h/xAh5UkPu/zJR3IqTrNhf0PVG5IoXoAZLYq/VTZqfT2T0sFVkYbEs6R58rTu8HAt9u
         RYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746940; x=1776351740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhXtNcfXFczFC0TvlssSpcRPxwc314v0ehuoW5MZUg4=;
        b=ZkSOPA5+MpxINXzML8Smx7cCZF15QIdbuRt3IujjGenKuEVK4kMolTOFEthc7R3dbE
         cJqWFz8ENYOKGa+4eOy7bD/u7tsUUsb8U4eeDmc1hsd9hfltFI15OAYOqK3PtnJsn/CZ
         8+q6VTqWDUYu3B4h6CpyLLz5xc/eZjTNKWCTBXunS/48MDtekCvSwyhxRIeXA2bKH4aQ
         yQ6+/KydD3EGYCnyB7pwHRzm1YYoon1SrgZB3DHFMt7AxoJrfowj+KKSJGIBQRLM057/
         vwPONFZspNxA3wKcMwiKwupOiEsrrswwSrZFQgTxUi/5A2uUH1W9fARQ/a6Kh56jfEBK
         2JHw==
X-Forwarded-Encrypted: i=1; AJvYcCUYdk0ZvuMCnQyH8yokISdRr4Y4/0zG7kXRGEZRK9SNfbMXdgdGeG+qXYOLhm60Vcnw1hKoysQ5hCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPYhTJSvaDOpYEYTclodET6oiZFt01Os5GhCUONKhJX2pSi8T
	aNSTFCoJwQkOyTXI4W2NDejjxqTSUo2O7pQ4RcB84pvEmyOqa0E6JYWV
X-Gm-Gg: AeBDiesuyXuSNdw85/nmxkbrZZVa/L3NpBLJiipYMmkCI350yaZEHGd9hNqB1jr1MD+
	Bftm1mT/BS7tqthGGWJePLfwjoaiRY8f9sMPC4KcFZ52/42mnYrLh6j+hj95l7zSdCxPIROSlPg
	DED/k01qu2IwERg861EQFz4cTm8PlRy3P6fbGoB0rgLOsZU4EMM6/zisEXYDNMmZXRD/Wm6h01X
	Vzo0slCeOefJSTMIQglqMPkmhUDmuPw6ouVI1sOxqfIFuNSx3vG4O+YkW+utc3VmoosM14gNaxQ
	IfYeVFnCv47rC2y4yRupFySOwYZV4SYTleqr087w+Z0MhB/P3PpAMromz43S5jM4fvx31G9icC8
	/LeKbANh78HjSahmLaeUbONSUzXh7iyKaUoW+HsyRY9eiRU3tbnHX5DMy9dveHcAxPinMIWBp5Z
	FDAasNKLs9UjC4pToIqEe7dzNLgmT9iM1PsBXqm6PnUitJ7z3aGRPSeAWil2PbhGyjr/U4o/t4v
	cbot5L6Dig=
X-Received: by 2002:a05:6a00:4397:b0:823:9c6:1985 with SMTP id d2e1a72fcca58-82d0da8a9bbmr26784425b3a.16.1775746940074;
        Thu, 09 Apr 2026 08:02:20 -0700 (PDT)
Received: from ?IPV6:2401:4900:8f4f:f496:a1bd:e74b:4413:84f8? ([2401:4900:8f4f:f496:a1bd:e74b:4413:84f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261b6sm29782954b3a.3.2026.04.09.08.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:02:19 -0700 (PDT)
Message-ID: <7930789e-6930-45b9-997b-0e5c850db194@gmail.com>
Date: Thu, 9 Apr 2026 20:32:12 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: i2c: nxp,pca9564: convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260408-i2c-nxp-v1-1-8276ccbd95fb@gmail.com>
 <20260409-rampant-swinging-wolf-51ab4e@quoll>
Content-Language: en-US
From: Akhila YS <akhilayalmati@gmail.com>
In-Reply-To: <20260409-rampant-swinging-wolf-51ab4e@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 09-04-2026 13:56, Krzysztof Kozlowski wrote:
> On Wed, Apr 08, 2026 at 08:23:31AM +0000, Akhila YS wrote:
>> Convert NXP PCA PCA9564/PCA9665 I2C controller to YAML format.
> DT schema, not YAML format. Look at your subject.


Okay, i will change it.

>
> ...
>
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  clock-frequency:
>> +    default: 100000
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
> And if you tested any DTS with this, you would see this cannot work.
> Look at other bindings - you miss ref to i2c-controller and
> unevaluatedProps. But the problem is that you are doing something which
> would never work, so I have doubts that you know what you are doing. One
> thing is to make a mistake, other thing is to post something can never
> work thus putting quite noticeable requirements on review.


You are right, i missed referencing the common i2c controller schema and
did not handle unevaluated properties correctly,which makes binding invalid.

>
> Please first learn how DTS and DT bindings work, before you post new
> patches.


Thank you for the review, i will work on it.

> Best regards,
> Krzysztof
>
-- 
Best Regards,
Akhila.

