Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA617C69;
	Sun, 15 Mar 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773569727; cv=none; b=oGSlJKFaqwMUgNEQDe9N/RNJVpKtIfa/eK9TiMr5NFyB/RN5SZIjhLcfxuiqp8Sqmn/ABXcuvJazprx9RJ9iX1ZFxfLzOBHZb+N+zbh59Gp4cjY9W0qPI5B9SUie6KpeAsnQnjUa3W5TCic4Sxk/Ka9cpe+Q3SKuqW3Gj2ihYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773569727; c=relaxed/simple;
	bh=QFtn113gt7+xT3chfxhIIN1YUetPH+SY+ZSJH9Yk2eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQKuI8HAdpfz07ln6rRSIXVvQn7SIjtKqeo84aq+jyvM3jsXj13L5qd3SOoow4PKAoJtXrs+fFUE5G/NrNPLzt1RMkbjvcj4gWl+E3+ztHzQY6ql+M+BKMJqLNZj9Egz4d7x5qeaul9jsbkm5tA5taeTkjtLfuxlwPHew0qUwss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5/tATgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5/tATgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DAC4CEF7;
	Sun, 15 Mar 2026 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773569726;
	bh=QFtn113gt7+xT3chfxhIIN1YUetPH+SY+ZSJH9Yk2eQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n5/tATgFsDyJryCGupSC+oFM+xOT7fpBlLnkI5m5dyF29ojTFB1ciA/0yqx+azlN0
	 qWO3ne1nqGsoVcGOrlG+Wm/9Alfkm8fbi0q8XRCIibeDb6oED2IGVrbG3U8K3thdHV
	 gwitUCID7Z13iUINpCnn58A8bmI66+cXI1DLTlIDLXRVv4EtuhKJyg4tYwMnqrAQNc
	 8QmG2UWP+kpaWQscey7x3neX5UbdeBS2lG2gfaS1q8WKTIpnFa44TpvFQ3BqCjcUDO
	 T+HcVVhYqzaIwqWiFp8OkIKoEjoEleCSazCiaCoxHckxojiPasS8r++ckOxuS2pYJg
	 mmV6aG/AwE0Dw==
Message-ID: <764c3942-925d-47e9-99fb-cfd84daee0fe@kernel.org>
Date: Sun, 15 Mar 2026 11:15:22 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
To: Rustam Adilov <adilov@disroot.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-8-adilov@disroot.org>
 <20260315-invaluable-adamant-urchin-7aaf7e@quoll>
 <c975cfa4c18adc35c49d81a5c50b74ac@disroot.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c975cfa4c18adc35c49d81a5c50b74ac@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2026 11:10, Rustam Adilov wrote:
> Hello,
> 
> On 2026-03-15 08:56, Krzysztof Kozlowski wrote:
>> On Sat, Mar 14, 2026 at 01:26:27PM +0500, Rustam Adilov wrote:
>>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>>> RTL9607C SoC series.
>>>
>>> Add a clocks property to the properties since RTL9607C requires it
>>> along with the realtek,scl.
>>>
>>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>>> ---
>>>  .../bindings/i2c/realtek,rtl9301-i2c.yaml         | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>> index f9a449fee2b0..5873cfdc5b3e 100644
>>> --- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>> +++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>> @@ -15,6 +15,8 @@ description:
>>>    assigned to either I2C controller.
>>>    RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
>>>    can be assigned to either I2C controller.
>>> +  RTL9607C SoCs have equal capabilities but each controller only supports 1
>>> +  SCL/SDA line.
>>>  
>>>  properties:
>>>    compatible:
>>> @@ -34,6 +36,7 @@ properties:
>>>        - enum:
>>>            - realtek,rtl9301-i2c
>>>            - realtek,rtl9310-i2c
>>> +          - realtek,rtl9607-i2c
>>>  
>>>    reg:
>>>      items:
>>> @@ -51,6 +54,9 @@ properties:
>>>        The SCL line number of this I2C controller.
>>>      enum: [ 0, 1 ]
>>>  
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>>  patternProperties:
>>>    '^i2c@[0-9ab]$':
>>>      $ref: /schemas/i2c/i2c-controller.yaml
>>> @@ -81,6 +87,15 @@ allOf:
>>>      then:
>>>        patternProperties:
>>>          '^i2c@[89ab]$': false
>>
>> Other devices do not have any clock input? Hard to believe, but if that
>> was the case then previous "if:then:" should disallow this. But if you
>> assume they have clock, which is expected, then document this in the
>> commit msg. Now you just silently add clock to each of existing variant
>> without any explanation WHY.
> 
> As far as i can tell, that does seem to be the case that they don't need the
> clocks input. In RTL9300 and RL9310 there is a simple SCL_FREQ bit field that
> sets the frequency from preselected option (100khz, 400kHz, 2.5MHz and 50kHz) and
> it is gotten straight from the clock-frequency of the i2c child nodes.

And from where does this clock gets its frequency? Really SoC IP block
not having clock input would mean it is not part of the SoC, because it
would have completely independent clock domain.

> But in RTL9607C there is CLK_DIV bit field instead and it is set to the calculated
> value of "clk_get_rate(i2c->clk) / i2c->bus_freq - 1" and that is why it requires
> clocks.
> 
> With this, what should be changed in this i2c bindings file? I was under assumption

If devices *do not have* clock, you set it as false (see example schema
and even line above!). Clue here is what I wrote "devices" and "do not
have".

Best regards,
Krzysztof
