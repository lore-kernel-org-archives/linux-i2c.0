Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3793A8FF5;
	Thu, 22 Jan 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081224; cv=none; b=TOcCAX+OrL7PECv+iNtqSXctNxYebshEsu5CqkcTliaBpEXOVBJgereiC5Mi0AE/XLxUZLgiwLzVHPVLi+9PgqN8V+B9nAZxQYAnLgT52ts+WoE1l3KHqBbaGVZdiAI7o9W8P8dF7I7G6jQDVDeoKvZ0tYKxByqsFfjcvBubgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081224; c=relaxed/simple;
	bh=44qK7B1Q01Nb+UDAIkpcDpUzt228eBdv6uZl5gMbMVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pS+yq1mmghuUOcZk+w6x67JpACbFydxiB//5LOBTIV4lHwjHuisMDOwga2xmkaInRVwyCuieSxUihfjD/ZCC/TE/QD4bAr5+CYYxrIsdf/d8k4LXBqQjj/DI6p++mb98jTEXXJ6K3LgRnAwn0lmfA0kbcrmQ6PmD7+WaHigWCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgLdVqlp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgLdVqlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA07C116C6;
	Thu, 22 Jan 2026 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769081224;
	bh=44qK7B1Q01Nb+UDAIkpcDpUzt228eBdv6uZl5gMbMVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MgLdVqlp1mUhdjvWezqr5SsxWsNSXpvtkO939PCTYcrBGrcTt4qmUg2RF7ur632ED
	 ftfYH+uCJgP29jckZUyQkUpaGi7sMFV88n6KXcxxRQLsKYIggOUNJXPnrKz1zpL3lX
	 sI9CW+anrlK4qXxtTenFhGi3feGmHERXII5DYmlR++RXOvePyS+XPo3aLmci2PVK+J
	 MHOrMcgBuoJ6duI0Ke7i/T4QPtK6fTiGGSaGGpTWqoy1n8U2Rrmj8WwP0l3Jcw2xqZ
	 huQi/BEKI0Nw+C2oquveAtDZHU3YvJ2Y6KJImALhYmFF5f+hnKky6dV0R88m46Cdpj
	 jfq1vfN12pYFA==
Message-ID: <d85048ff-ed13-4fe0-ab5c-b1ba810964a5@kernel.org>
Date: Thu, 22 Jan 2026 12:27:00 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: i2c: add atciic100
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20250207021923.2912373-1-ben717@andestech.com>
 <20250207021923.2912373-2-ben717@andestech.com>
 <20250209-antique-camel-of-assurance-390cb9@krzk-bin>
 <aXIHg59ZZouB9WMl@ANB420.andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aXIHg59ZZouB9WMl@ANB420.andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2026 12:18, Ben Zong-You Xie wrote:
> On Sun, Feb 09, 2025 at 01:29:58PM +0100, Krzysztof Kozlowski wrote:
>> On Fri, Feb 07, 2025 at 10:19:22AM +0800, Ben Zong-You Xie wrote:
>>> Document devicetree bindings for Andes I2C controller.
>>
>> Explain what is the hardware... Here is Andes I2C
>>
>>>
>>> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
>>> ---
>>>  .../bindings/i2c/andestech,i2c-atciic100.yaml | 40 +++++++++++++++++++
>>>  MAINTAINERS                                   |  5 +++
>>>  2 files changed, 45 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
>>> new file mode 100644
>>> index 000000000000..cf96a9186176
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/andestech,i2c-atciic100.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/andestech,atciic100.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Andes I2C Controller
>>
>> Here as well
>>
>>> +
>>> +maintainers:
>>> +  - Ben Zong-You Xie <ben717@andestech.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: andestech,atciic100
>>
>> But here atciic100. This is all confusing. What is the SoC? What is the
>> name of this device?
> 
> Hi Krzysztof,
> 
> Sorry for the confusion. atciic100 is the name for the I2C IP block, and it
> is integrated on QiLai SoC. That's why I added a new compatible
> "andestech,qilai-i2c" in v2.

So atciic100 is not an SoC... but then why there is I2C and SPI variant?
Is this some serial engine? Because if it is, you probably miss here
much more bindings for complete hardware description.

Plus, if this is IP block, how can it be used alone? We forbid that sort
of compatibles long time ago.

Anyway you have entire commit msg to explain that.

> 
> For AE350 platform, I know it has not been upstreamed yet, but it was
> discussed and acknowledged in a separate SPI series [1], which is why I

I see ae350-spi there, not atciic100.

> included it as a fallback. Can I keep this? If not, I will drop it
> and update the compatibles in v3 as follows:

Nothing was explained in the commit msg, so with all this being
confusing that's the review you got. You literally wrote one half baked
sentence being copy of subject, so like nothing relevant and should be
treated as almost empty commit msg.

How do you expect us to understand anything from that if you write
NOTHING in the commit msg (except copying subject)?

Best regards,
Krzysztof
