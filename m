Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2A4183AD;
	Fri,  5 Jun 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780656023; cv=none; b=Ugs5S4fEajTskzShGxq+4EfHthKwN2RF/msqAVbJ3YbUfzp9KN1MxCe7avfCz8LVPRxOWRdSQ6LdElNeOcbfZGm4xUOrvlNoVU9A9XUEqFoNOQzuDEpHqyKciMUo2E8X4WuRJkEs6laC0DS4f320Kp5l6TsTjqPsp3Z3nVOeMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780656023; c=relaxed/simple;
	bh=bfKCFDguTYk6SE4TlvKE7ppSFHoriE0eYSWZmTpNBHs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r+DTc08OyaPUVwjA82j0xxQQnl9se8cVmdXV/zfylsiZe4SjNQkCgiPXHTo2SjAjze2b030xVLG9sQI/waEzSoRyD8pX5GaOYXGpjb4jGRq+aZjvQ72RaYAC/Y6fGixM2ZUFIpsvr22GT0GtzGR8i7Y5UEUInc5W0wvbyY9Izfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG+u57t7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NG+u57t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FA51F00893;
	Fri,  5 Jun 2026 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780656021;
	bh=aSxblTHp4Wr76A7dKxI6DpC/5PeOcQyVnWngmkyC4AE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NG+u57t7DDqJgJDw/3LuulBdcDWw4BUaiX5vi8VlRsLET+HBw9GAQipkgPk4+Qqna
	 rzIyZeITsfvH5YoWBj8a8843IUUragaK4FB6Rzcuo0FGq1J/PiG5k1XoZZHkOkZjbA
	 81tubBYQiCKndoT0VnDwcUTGyPnMyJa6TQQRQeduYbXEQ2ndXO/8nfqsTetmbSLbPg
	 TQgT7ZBqmjZKYCS6pCuXGNjyVINSz2PHFzNzv2+hFLjODg8nFmcBmQqFI/QX2pzdLi
	 c2Vt7LKaEHvhORht/0hkDC6DLZHk/RtA7HTgpBMRShvNtNXlEOX4Hr1qJWcC771ANZ
	 tkIbr5NbJT9fg==
Message-ID: <61c140d0-e7c3-4f81-b282-d158a2d37113@kernel.org>
Date: Fri, 5 Jun 2026 12:40:15 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: i2c: add Novatek NT726xx SoC i2c
 controller
From: Krzysztof Kozlowski <krzk@kernel.org>
To: SP_ISW1_AT@novatek.com.tw, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ben_huang@novatek.com.tw, toby_chui@novatek.com.tw,
 shihpei_hsu@novatek.com.tw
References: <20260605035558.383330-1-SP_ISW1_AT@novatek.com.tw>
 <20260605035614.383387-1-SP_ISW1_AT@novatek.com.tw>
 <ffb9c16e-5a5a-45c4-8d4b-369b0a4fe314@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <ffb9c16e-5a5a-45c4-8d4b-369b0a4fe314@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2026 12:37, Krzysztof Kozlowski wrote:
>> +title: Novatek NT726xx SoC I2C master controller
>> +
>> +allOf:
>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: novatek,nt726xx-i2c

One more thing - you must have specific compatibles. This is EXPLICITLY
requested in writing bindings. Please carefully read entire file.

>> +
>> +  reg:
>> +    maxItems: 4
> 
> You need to list the items instead.
> 
>> +
>> +  interrupts:
>> +    maxItems: 3
> 
> You need to list the items instead.
> 
>> +
>> +  clock-frequency:
>> +    description: Operation clock frequency of i2c in Hz.
> 
> Drop
> 
>> +    default: 100000
>> +    enum: [ 100000, 400000 ]
>> +
>> +  novatek,hwmods:
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    description: Name of each i2c pin, must be named with "i2cX". (X is
>> +                 an integer starting from 0)
>> +    minItems: 1
> 
> There is no such syntax. Please do not invent own style.
> 
> Anyway, I don't understand the property - drop.
> 
>> +
>> +  novatek,stbc:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: Set if this i2c master controlled by stbc.
> 
> No clue what does that mean. What is stbc? Acronym of something? Why
> would that be a property of a board?
> 
>> +    minItems: 1
> 
> Please open existing code. Do you see anywhere uint32 with minItems?
> Like anywhere? I really wonder what process lead to such code...


Heh, and now I see you never tested it even before sending it.

Best regards,
Krzysztof
