Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C22C3251
	for <linux-i2c@vger.kernel.org>; Fri, 21 Aug 2026 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284343; cv=none; b=n9mDF0p/MJQrslu5fSKigap5IpTXqGXY9lOkGZ7LvrYjDC4uRd9gqm9m7IgbKeV1XEyvgbwreQcmzrGeNPcId9k7cu8CvFgzMoMmCYWnDIkqq26gN83cnW597bxlhque+D41GptH4vCbyFlEitMZdxGu4mbzt8hTLJ3dMyE2rKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284343; c=relaxed/simple;
	bh=H7cx3dxLR5ZkSrjHPDYzzT5hHYj0NJRb9zQhF2jRXMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5aw3M8bSj2w7At5+KM01u7NdPLwuHDcjaUTJKOYMyk/eqVfRI888mx/JLgWmBbFgj2RamfHNJF4HqADMqAhtndQ+sIz6oOPV03yFq0sYDy5gnsb7WFFIqcTpYWpcdBwEAYPFRqMFr14PVRrcJSfZWAGwXPfmoMu2KElgDEGTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXk/6Pil; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXk/6Pil"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb7926836eso420539a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 20 Aug 2026 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787284342; x=1787889142; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdUpRbJOePqwuGtI7k86e6iXxcPA/KBD5j3OTF6Xnr0=;
        b=GXk/6PilwyR7gpb93GlGIvFfWrG3341YE0CdjAJO3VFfYLlgmEKBZP0wj3hUbcKIR1
         xJ6xENHscy7/npwM5AfSmIJbQFnlV/e3t6Ks6xbIXhvcNA9BCOK40UpiVgrd1L/Gc/F8
         FPZ2aVhprxfmA5Rgl/DeCFOhapDa96tY2oH89hd3ItqZUXev7zkBsSVTQMrawgZcYSTM
         qjtTlhF4CcMkS6tNqukn8bIvfOCkEQrLYA5enE+wPYnm+QBhldonewbTCU6ZHKEO+Tlj
         ZRl/+JTkUZk0DqtD6GvB5GGOpDHNBzmY1WCQrMEeB0cRnllwZQtpXwyrrHblRo/k1KCt
         5ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787284342; x=1787889142;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bdUpRbJOePqwuGtI7k86e6iXxcPA/KBD5j3OTF6Xnr0=;
        b=IVx9n9gaoy6b7+Cv94pbmYNsKeopy8R20H92vRppGbr2+t0jU0aGhh39jGbB10N6xz
         9EI+SUrNNCNYh12h3nE4z3z39DOnDs6HQ3mrK+HX/pPangYoMSjzmJQjoO/NSlwjZ3dS
         GxynGHHnser83WdYYu6GyQpuHHtqwcjzNx6VubuHf/wBtfzMGgAlzEb+ggyUtQwrIrdC
         J9H8e3wLEe3QgVfEM+4tAiXWADz7EwK31JwL35ZjtobV7jTx7H0DwdSmo7dxrnpIuICg
         DE/g+6jZTMlZml2OKyfM1ytt6Azb4IknPeDaDL9QY8gEXMsGxYgsgmU4HrZXicJY/aVY
         aEnA==
X-Forwarded-Encrypted: i=1; AHgh+Rr4o8pGgGBZwyE8Atl3zBWo+71AWWZHbBf/p8KW+Hvxnef7Oah9tKIOlWMshT+Q3y719/3oXPusYCw=@vger.kernel.org
X-Gm-Message-State: AFuF++nL0YYsIJHfSMqzzUIb2EQw/tEimElbHyo05VVXNEQjBQrzh++d
	H1nr/HZjXxR6V4xnPon9zAzlPJjEtaRYKGFmsmefSbzBrYmc3Hf51w2K
X-Gm-Gg: AR+sD13RtNAnzL0kurrRJpkG0qweI/sVEHEUGqu4k9co64G9b+loV/KBkQY+1rBriyr
	tzrG472avzU9oCbvCqtsablDwCCCTzflK+3MYsryVGmM+b+OqTHk/f0xyW9shmaS8XDb/wBerHY
	sl6bKlS1qjCarEUYFl3+Sfb5xbAeEn8a37OO20TmjoxSUU+9uPV65YxtjbT6w9O7zjXvTbnbLwb
	8Ct30r5HRrZ38gyBHgQi3/lqL0vprYieGuWZoFeHpwYwLkAamKhVZ1o7zXQQHv17/hHrK9/J+0G
	o6wi/c2hqVYOPbGLBBvlbhu4F47zOFpXoroHu3vfAId1PTtAbHjwRtMMON+6vyAsYYV3nnXg2dQ
	VrjTHr+KndSUKD/ZxS3x38hdxlVfsc2Ur7e6EeKm3e/7zI9B1nV3P71JlYKrooLzDU7NFjHXeLT
	MdywdnC64Xte1HjfuMqI9NvvLeRnQxgFOsoWlNv+w8p2t05mpiFfazLNtlBI0fKKs1mlTuzguVS
	Brh/JDxO4Qxz9ztYTZtnkI8ixkgnCJ/hxjAVw==
X-Received: by 2002:a05:6a00:2191:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-851f96af150mr4980697b3a.0.1787284341813;
        Thu, 20 Aug 2026 20:52:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3668b06sm2269920b3a.47.2026.08.20.20.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 20:52:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4efefd25-9115-44ac-ad03-6dc1ea0fb2a9@roeck-us.net>
Date: Thu, 20 Aug 2026 20:52:19 -0700
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] hwmon: Add Support for PMIC5000 Power Management ICs
To: Stephen Horvath <linux@stevetech.au>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Horvath <s.horvath@outlook.com.au>
References: <20260819-pmic5000-v1-1-e5e0ddcf0863@stevetech.au>
 <6b8bf838-011f-46b9-a2a8-379de9cceddf@roeck-us.net>
 <7fac8b19-af18-4365-94d6-a6bd18076abb@stevetech.au>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <7fac8b19-af18-4365-94d6-a6bd18076abb@stevetech.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/26 20:27, Stephen Horvath wrote:
...

>>> +static const struct of_device_id pmic5000_of_ids[] = {
>>> +	{
>>> +		.compatible = "jedec,pmic5000",
>>
>> jedec,pmic5000 is not documented.
> 
> Is there some centralised database for device tree identifiers, or does
> it just need to be added to trivial-devices.yaml or something?

You'll need a separate patch adding the property to trivial-devices.yaml.

Guenter

