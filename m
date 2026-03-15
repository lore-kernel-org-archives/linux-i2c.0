Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF60225416;
	Sun, 15 Mar 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773569415; cv=none; b=UxsADJGF9UvDPQKjHnhpR8l1n223c0HaNFj67PGCXVAH7UU541jK4uGXvBL4W5F2suGZOrYnVN29xTs63Pf4lDJEyA/baEbmkYxGVpg65MMYCBb6yVzVoJ56Ykv7r5+4A6w9AKnPWmcYKfvvXD8lI8vSsSAOdHvlyOwjlyn2yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773569415; c=relaxed/simple;
	bh=2kw1sbKR/vEkSJj9nsrmMCEPQZJu7Ji5z3i8iH0upVw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dfouavKliLA1uFJxN11FWM9cbIAk7FRWZs7LbzhqsX0ARPSwjCNnLM13floCTOAP9tAKzWW9CXEjLzmqOr2Czp5xe9kabUMbBnPrH2vRTCTg+sRtKvidkM3smZw9nHTSxUBb0kzE3E24WoxI+xNc6Qm/jbVCIS9FIKAeOUxzAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bmBlfxmT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bmBlfxmT"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7F72C2715F;
	Sun, 15 Mar 2026 11:10:05 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6A2cGKR5FvL; Sun, 15 Mar 2026 11:10:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773569404; bh=2kw1sbKR/vEkSJj9nsrmMCEPQZJu7Ji5z3i8iH0upVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bmBlfxmTnsjR8G5JzM4k18e4ewigdTRTu9mYv75x/1FTxRvlyTBrHhXmoEHHnbB7v
	 tjWz+e0CLdB4y/TfLTt16KwHox3lUJZei7p4iRlQbO4jkjO1FD4QQUfIw8XX7R8bnW
	 AP2z7n0jX3CDfRYHFxjPAVbo7vbCbRJYGfdYscPbK7oCNqiB+K8EmNN5cQEc4oXTBu
	 DI3pJbWqnkRmIXF//ZhDY3o6Rwd/WlVo+ASo+NjIE6L6ppPVjaWZvFmA7iUQQekZgi
	 9InXTvuM42kzZ3F6pK8p4kg2VmVGXN203AS/0+O3F3RyOCnXlgSrRAOfTbmsr9TUqt
	 9JDCG5VTNvD7w==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Mar 2026 10:10:04 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
In-Reply-To: <20260315-invaluable-adamant-urchin-7aaf7e@quoll>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-8-adilov@disroot.org>
 <20260315-invaluable-adamant-urchin-7aaf7e@quoll>
Message-ID: <c975cfa4c18adc35c49d81a5c50b74ac@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

On 2026-03-15 08:56, Krzysztof Kozlowski wrote:
> On Sat, Mar 14, 2026 at 01:26:27PM +0500, Rustam Adilov wrote:
>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>> RTL9607C SoC series.
>> 
>> Add a clocks property to the properties since RTL9607C requires it
>> along with the realtek,scl.
>> 
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> ---
>>  .../bindings/i2c/realtek,rtl9301-i2c.yaml         | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>> index f9a449fee2b0..5873cfdc5b3e 100644
>> --- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>> +++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>> @@ -15,6 +15,8 @@ description:
>>    assigned to either I2C controller.
>>    RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
>>    can be assigned to either I2C controller.
>> +  RTL9607C SoCs have equal capabilities but each controller only supports 1
>> +  SCL/SDA line.
>>  
>>  properties:
>>    compatible:
>> @@ -34,6 +36,7 @@ properties:
>>        - enum:
>>            - realtek,rtl9301-i2c
>>            - realtek,rtl9310-i2c
>> +          - realtek,rtl9607-i2c
>>  
>>    reg:
>>      items:
>> @@ -51,6 +54,9 @@ properties:
>>        The SCL line number of this I2C controller.
>>      enum: [ 0, 1 ]
>>  
>> +  clocks:
>> +    maxItems: 1
>> +
>>  patternProperties:
>>    '^i2c@[0-9ab]$':
>>      $ref: /schemas/i2c/i2c-controller.yaml
>> @@ -81,6 +87,15 @@ allOf:
>>      then:
>>        patternProperties:
>>          '^i2c@[89ab]$': false
> 
> Other devices do not have any clock input? Hard to believe, but if that
> was the case then previous "if:then:" should disallow this. But if you
> assume they have clock, which is expected, then document this in the
> commit msg. Now you just silently add clock to each of existing variant
> without any explanation WHY.

As far as i can tell, that does seem to be the case that they don't need the
clocks input. In RTL9300 and RL9310 there is a simple SCL_FREQ bit field that
sets the frequency from preselected option (100khz, 400kHz, 2.5MHz and 50kHz) and
it is gotten straight from the clock-frequency of the i2c child nodes.
But in RTL9607C there is CLK_DIV bit field instead and it is set to the calculated
value of "clk_get_rate(i2c->clk) / i2c->bus_freq - 1" and that is why it requires
clocks.

With this, what should be changed in this i2c bindings file? I was under assumption
that even if only RTL9607 requires the clocks i would still need to add it to the 
properties along with the "if:then:" but if not then i can remove it.
> 
> Best regards,
> Krzysztof

Best,
Rustam
