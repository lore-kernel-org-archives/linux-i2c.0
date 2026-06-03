Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD633ADA3;
	Wed,  3 Jun 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497255; cv=none; b=iAzxzG9HG0Ii+98KnxwXve+slUOHknxIG6w3F4iHy6hwb9G+mBU+dcGPZmR2OD5ApfunvAqBAB7cuUc9VwCRWc5v1YLKEE4rxk7UrPi+DTESotFY4icPZOdyglJNbB+SDYw7LbKCjoKLvgGY7gCWKSo6VMbTNygaFUZUa5vic0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497255; c=relaxed/simple;
	bh=tJFVf8vXzzjaB0v3APHNlAnYXLDp0ucb0cCQgWn023Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjOFrzgvR6jVk63I7TO/8Uu//qsuwA/4h1N+DDiOJtaW92KS6KtWjdHX39M7YLFkKsdjtlZzB+Bu1Cd+hEBA0C9mvIaGVT/5Zogyi2jS4BTQ37Yel+0iPKFX1zn8jpWVJyzSwKSQVpppOazWQRVB2w/Z7p5YcG9hbxlba7WN1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKYcUPk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKYcUPk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D41F00893;
	Wed,  3 Jun 2026 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497254;
	bh=Gq920oPUzop81+fde7fc5jCiNoQAZVW8+IXP28aDVLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aKYcUPk8yqwRAhVZYNJFqgbig7Ez4t+ELeCSeX0vsAsxEovN5taegZRC1X59bI72I
	 /e7lo9JXrIi8ECQzERCEku/FjkQ4rMdU/WS9ZdF9w3aXyykZ6d+QqwnkMx4cYmq9Qi
	 hFm/Cdx3kV4KztUDdWjNGJGECbCQkgRLN2atyHJQ82Z6hp8eoNjuDBhlJEaOTCZyoZ
	 ydb0ycewysVzCl6+A+g++xD2ca2lT5jPNjk5CGTwDopueA852MY4fvGdq6wpEr9+wZ
	 mWifr/byI+qsL1yR4JDXL1NXIINtnm+11LHKP/8Zzu8xeEA7+F0lDX1HtmJWPQRd9f
	 7Ve8fI97P5VZg==
Message-ID: <be917331-820d-4bd6-b877-77471af5b3b8@kernel.org>
Date: Wed, 3 Jun 2026 16:34:07 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjIgMi8zXSBpMmM6IGRl?=
 =?UTF-8?Q?signware=3A_Export_symbols_and_add_=5F=5Fweak_for_Starfive_I2C_dr?=
 =?UTF-8?Q?iver?=
To: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
 <c1ae50ab-1228-45a3-b910-4564774f4198@kernel.org>
 <ZQ0PR01MB1269B87604C6DE7FC2E6ACCC82092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
 <d138759d-ec07-4d94-bbce-d34d5bd4fe61@kernel.org>
 <ZQ0PR01MB1269926D984F86CB9B87E3F182092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <ZQ0PR01MB1269926D984F86CB9B87E3F182092@ZQ0PR01MB1269.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2026 10:28, Lianfeng Ouyang wrote:
> 
> 
>> -----邮件原件-----
>> 发件人: Krzysztof Kozlowski <krzk@kernel.org>
>> 发送时间: 2026年5月28日 15:46
>> 收件人: Lianfeng Ouyang <lianfeng.ouyang@starfivetech.com>; Andi Shyti
>> <andi.shyti@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
>> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Mika
>> Westerberg <mika.westerberg@linux.intel.com>; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>
>> 抄送: linux-i2c@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> 主题: Re: 回复: [PATCH v2 2/3] i2c: designware: Export symbols and add
>> __weak for Starfive I2C driver
>>
>> On 28/05/2026 04:36, Lianfeng Ouyang wrote:
>>>>>  	{ .compatible = "mobileye,eyeq6lplus-i2c" },
>>>>>  	{ .compatible = "mscc,ocelot-i2c" },
>>>>>  	{ .compatible = "snps,designware-i2c" },
>>>>> +	{ .compatible = "starfive,jhb100-i2c-master" },
>>>>> +	{ .compatible = "starfive,jhb100-i2c-slave" },
>>>>
>>>> So both devices are the same... Or you miss proper entry in ID table.
>>>> Don't sprinkle compatibles around the code - ID table match data is for
>>>> variant customization.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Ok, Master and slave have different base addresses and interrupt numbers, but
>>> the register layout is the same, so in the next version, I will only use the same
>>> compatible ”starfive, jhb100-i2c“, and then add starfive, i2c-slave to the dts
>> node
>>> of the slave to distinguish them
>>
>> You do not need to distinguish same devices usually, but I still do not
>> understand why do you need all these different compatibles and your
>> commit msgs or binding text do not help, so I don't know what to advise.
>>
>>
>> Best regards,
>> Krzysztof
> 
> The IP corresponding to the i2c driver submitted this time is quite unique, 
> so it should be distinguished. The master-slave of i2c designware are at the
> same base address and switch according to the scene, so only one is initialized
> in probe(). But i2c starfive has master-slave at different base addresses,
> and it can work simultaneously. Therefore, both roles need to be initialized in 
> their respective probes. If we don't distinguish, we don't know if this probe is 
> initializing the master or the slave
> 

I don't think you read the comments. Again, you claim devices are
incompatible but have exactly the same programming interface.

Best regards,
Krzysztof
