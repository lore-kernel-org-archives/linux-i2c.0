Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEC21D3E4;
	Sun, 15 Mar 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591518; cv=none; b=YolAaHbiUUamXWR8bhYYCiSZ9+Lf/K/xIDr3aDolNMevs900PVMQjDNxod0Vj8FM4hA5LJDyKQg9fcooUlgJlEQoIbO+DiPbs61jLnpzt8C0Rd5VdXfC6X0qtwJId7ruZUBXZLMDnRiXkOeDOmj0Oh1e6DY3XN5cEGZygpzzdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591518; c=relaxed/simple;
	bh=fJHDFwpRzXb3BcX2/01HC3jefIUU851Gc1qs3JXK17A=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=M1UVNfjwgMI+93KTZ8KNI7MO0M4d82UxAz3WXCvjqWUldF7XW+qbfLWRjP70xYtW0jgNokeUN75WVb0FmSzuZVeAqC4qttWDja8HvBeVx2wxz4kA77ZkufuzeOF4u0w8gdXRr605xPfuNxa3C+2Bs5Q3PgRtvM1MqaFRkbCr98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PBiIa69g; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PBiIa69g"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CE68526F54;
	Sun, 15 Mar 2026 17:18:32 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elDOnhXWlw1B; Sun, 15 Mar 2026 17:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773591512; bh=fJHDFwpRzXb3BcX2/01HC3jefIUU851Gc1qs3JXK17A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PBiIa69giF0vVmT12pGS2kOs9DlcwecsGg280gd9bYOQ8WL26wsaJ3YehnyJqBHzN
	 Gx1BMZtbWOaKfdf8lrHNZHUoM7TAVkMcw3epKNe39Wg0dq5Dh4c9hN8uW+yc+8vpBG
	 ZbGfi3ucwQTqcIHN3qiq2v1agOS2apOQZe7Uebf5RIpxB+bqXY7aIeHNBE7tPOBqeG
	 1OOHqcMRSKii+TCe8YiBRRo3frZMQO0N7z8TzYLJ6YDnUjpGDcojR/R8SCnyKo++Km
	 sLk7YeoxmeNNfe3NJWVTya0zGvUTNGxA5EdNCMsHugBAAZY24ixIBQfydcpbhIo7G/
	 YDtKgnc1FboWg==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 15 Mar 2026 16:18:31 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH 7/8] dt-bindings: i2c: realtek,rtl9301-i2c: extend for
 RTL9607C support
In-Reply-To: <764c3942-925d-47e9-99fb-cfd84daee0fe@kernel.org>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-8-adilov@disroot.org>
 <20260315-invaluable-adamant-urchin-7aaf7e@quoll>
 <c975cfa4c18adc35c49d81a5c50b74ac@disroot.org>
 <764c3942-925d-47e9-99fb-cfd84daee0fe@kernel.org>
Message-ID: <1e2119e91baf59936c0d42f047a1c733@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-03-15 10:15, Krzysztof Kozlowski wrote:
> On 15/03/2026 11:10, Rustam Adilov wrote:
>> Hello,
>> 
>> On 2026-03-15 08:56, Krzysztof Kozlowski wrote:
>>> On Sat, Mar 14, 2026 at 01:26:27PM +0500, Rustam Adilov wrote:
>>>> Add the "realtek,rtl9607-i2c" compatible for i2c controller on the
>>>> RTL9607C SoC series.
>>>>
>>>> Add a clocks property to the properties since RTL9607C requires it
>>>> along with the realtek,scl.
>>>>
>>>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>>>> ---
>>>>  .../bindings/i2c/realtek,rtl9301-i2c.yaml         | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>>> index f9a449fee2b0..5873cfdc5b3e 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>>> +++ b/Documentation/devicetree/bindings/i2c/realtek,rtl9301-i2c.yaml
>>>> @@ -15,6 +15,8 @@ description:
>>>>    assigned to either I2C controller.
>>>>    RTL9310 SoCs have equal capabilities but support 12 common SDA lines which
>>>>    can be assigned to either I2C controller.
>>>> +  RTL9607C SoCs have equal capabilities but each controller only supports 1
>>>> +  SCL/SDA line.
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> @@ -34,6 +36,7 @@ properties:
>>>>        - enum:
>>>>            - realtek,rtl9301-i2c
>>>>            - realtek,rtl9310-i2c
>>>> +          - realtek,rtl9607-i2c
>>>>  
>>>>    reg:
>>>>      items:
>>>> @@ -51,6 +54,9 @@ properties:
>>>>        The SCL line number of this I2C controller.
>>>>      enum: [ 0, 1 ]
>>>>  
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>>  patternProperties:
>>>>    '^i2c@[0-9ab]$':
>>>>      $ref: /schemas/i2c/i2c-controller.yaml
>>>> @@ -81,6 +87,15 @@ allOf:
>>>>      then:
>>>>        patternProperties:
>>>>          '^i2c@[89ab]$': false
>>>
>>> Other devices do not have any clock input? Hard to believe, but if that
>>> was the case then previous "if:then:" should disallow this. But if you
>>> assume they have clock, which is expected, then document this in the
>>> commit msg. Now you just silently add clock to each of existing variant
>>> without any explanation WHY.
>> 
>> As far as i can tell, that does seem to be the case that they don't need the
>> clocks input. In RTL9300 and RL9310 there is a simple SCL_FREQ bit field that
>> sets the frequency from preselected option (100khz, 400kHz, 2.5MHz and 50kHz) and
>> it is gotten straight from the clock-frequency of the i2c child nodes.
> 
> And from where does this clock gets its frequency? Really SoC IP block
> not having clock input would mean it is not part of the SoC, because it
> would have completely independent clock domain.

I will have to leave this question to someone who knows it as i certainly don't know.
Maybe the driver maintainer has some knowledge on this.

>> But in RTL9607C there is CLK_DIV bit field instead and it is set to the calculated
>> value of "clk_get_rate(i2c->clk) / i2c->bus_freq - 1" and that is why it requires
>> clocks.
>> 
>> With this, what should be changed in this i2c bindings file? I was under assumption
> 
> If devices *do not have* clock, you set it as false (see example schema
> and even line above!). Clue here is what I wrote "devices" and "do not
> have".

I have read the example-schema file and from what i understand it i can put the
"else: properties: clocks: false" ?

So then, the whole would look like

  - if:
      properties:
        compatible:
          contains:
            const: realtek,rtl9607-i2c
    then:
      required:
        - realtek,scl
        - clocks
    else:
      properties:
        clocks: false

Let me know if my understanding of scheme is accurate cause i am very new to this.
Or should the "clocks: false" be under each other "if:" for rtl9300 and rtl9310
const compatibles?

> Best regards,
> Krzysztof

Best,
Rustam
