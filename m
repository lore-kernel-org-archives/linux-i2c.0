Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009D35E931
	for <linux-i2c@vger.kernel.org>; Fri, 17 Apr 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412401; cv=none; b=K1Am8qi7Lhu1/NH4ULlxXHABHYFnc3N6JSSU+uzrdGT1pTjSBj1lgRk18OfVR0TySebPa9sA9W+D5wa6e35qX6xaLWJGkD8x/iCAzJOt/jn7iRD9wQ+Yo0maYe2f8DTA03GSBY0qsEuCJQ447/ddPZzej/0tG2eM0urLA24kdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412401; c=relaxed/simple;
	bh=m3YKyh/WY8cD2z45OzOO3VzffzzojcrAYmKe4Wimn3Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F+65aRRjNQ9KNwVMFN1XmA9VamVAJHh824sO+IgGskEMtYGUG/if888j5xuyZ6ueHpj3CdRjATZI0/KOnIkS9KigjsmpsqgtJi+E2oUXuYrttwfYAfpo09MK73aRrczg0fWhz79SdVj34qIt9LMZ2vF5nzfrFobieZtDdIzauvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXPCmhPa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXPCmhPa"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d77f60944so258615f8f.3
        for <linux-i2c@vger.kernel.org>; Fri, 17 Apr 2026 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776412393; x=1777017193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpo7P+uEagDswLieoNvqnFSXN/IsF5q+qpaAheY25VU=;
        b=MXPCmhPafD2JJc7m3ubPPO/DLgLdgfiD3VHlS+i7D3q0R0RhDwsR26712hGJlkjwjf
         zxOWw7hAek28AWGcTzordRfecul4yJIdgZmYhV6ZiHoTBun0/f+/HJEPhL9mXkORrsWU
         Zhkz83bNhsksCJQF0FJt6OjQBFz/xYv2Gwm5xA3PNTVXm9YRHDISozO5IwAO7bgDZ3d6
         Gp/A/nfk21L8rECCVOqhPh/OtTPFr17fnSapxfwk6iV5xv9fECSnu+Q3SY+wM4+GrFl6
         yi3H2puAmRQ+T/tWnhV6xCZaBnjpp75MCPhZt+b4XW+n52i2wuUxKlHONFJyGIWgdNMq
         DChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776412393; x=1777017193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpo7P+uEagDswLieoNvqnFSXN/IsF5q+qpaAheY25VU=;
        b=s82a+mJEhjOAxfrZewLD7fE6ilKsC/SVjH6JfScZEKOZt3H6OqR0zE04J0Krro5Wjh
         AMuBvobVEmDBh6R9S11Jl2Jfblb01Ke+Oa/+BTdOGE/Cek4A2NZK3S53IUuyMmF7FRY2
         JJNeFII8apgS1oPCn+Z3mvTV0SuGdRW4ahGkp+C+YAnpkwTaQA2rN2KFsfH91XY59GIE
         N2EBsdzQ3NQd7ABy4S/1pvy470KJX1XDYgjTS100rCQqbR/HjXzpmEICZyRzO/eib+wR
         PmFuoKJdzIjSESlSygOCtXsFcPBN7IfrpLj7uevMtXX+XeMM2zvUyO5zr8ztz9gDd0wu
         Kr7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+qiNUvB55I7ihct/xT+J66PlcEKE9sibuZEeptjBXsPY9QOYX3HTAxwbCv0HB0ZayxXtN97y8Adj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtmtjpQ2RXdXLqk3yeSig/WEm0oT2GLc4tds7MlsD9EO304JW
	9TMAJRbMVPZpbkVQsiE7I7ROr6SETMLh3fVWwr7bvDn97vOtp5Ep/jQnZ7rDxPBYJoA=
X-Gm-Gg: AeBDiesrr/XvJsyD9XduncnGJNmEx1Cui/IC7COSFcAd8vW9FgwzCFLku4riiPtYG+/
	gWbpqsZtprb3vWSLnprfdvprxepYTfIPRb/WgkMzuZfiAyKMYd6OYhQ5Yd2a5B7eHJ4IKhwm9dG
	Il14EPLfADmJ6EcfPyporx9xQRD+/PF5LzS0AhQmkq2fk8R231Wr+Eijl7jsgXoI0Mb5p/MICDY
	BWIvEyDM0O5amIRCCimkmWUuMTf908N8v3N18f0Uxw2NzT7qEpUHdma1muqOy5mVrZgB7lrdnHi
	/Jd5STylKUYmNFhP8jNsSFlZsNL4yxjr0qMmQIUfsIBq2v0pRnnX3HN0JjszgaoLBROyo5SJAi3
	qjjEubMaApQnqAYc7TA0yNt4B8elHjSqawL6/nSf7LMcezR+XC5SAPYcmBfJKgqrTAcYVNAoI4W
	4vis35DDwKFkSoqEq7xusdmoSMLMco/4+fochge4ZclMokx/G+QBxTi0OSS7qtrmLZDIXtjytwg
	RPY40hc8wv+2D4=
X-Received: by 2002:a5d:5d88:0:b0:43b:5231:e94a with SMTP id ffacd0b85a97d-43fe3e0d12dmr2364823f8f.30.1776412393117;
        Fri, 17 Apr 2026 00:53:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b416:50ee:20e:8775? ([2a01:e0a:106d:1080:b416:50ee:20e:8775])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm2584776f8f.9.2026.04.17.00.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 00:53:12 -0700 (PDT)
Message-ID: <6758aaa2-ac1a-4751-aece-2b445b84f2bc@linaro.org>
Date: Fri, 17 Apr 2026 09:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
To: Ronald Claveau <linux-kernel-dev@aliel.fr>, Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
 <20260415214815.GA602572-robh@kernel.org>
 <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <6fc8ddeb-d54d-473d-94d2-49dc78a07154@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/26 10:25, Ronald Claveau wrote:
> On 4/15/26 11:48 PM, Rob Herring wrote:
>> On Fri, Apr 03, 2026 at 06:08:34PM +0200, Ronald Claveau wrote:
>>> The Khadas VIM4 MCU register is slightly different
>>> from previous boards' MCU.
>>> This board also features a switchable power source for its fan.
>>>
>>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>> ---
>>>   Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> index 084960fd5a1fd..67769ef5d58b1 100644
>>> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
>>> @@ -18,6 +18,7 @@ properties:
>>>     compatible:
>>>       enum:
>>>         - khadas,mcu # MCU revision is discoverable
>>
>> The revision is no longer discoverable as was claimed?
>>
> 
> The firmware revision is still discoverable, and via the same register,
> but the VIM4 MCU has a different register layout (eg: no DEVICE_NO
> register). The new compatible is needed to describe a different MCU
> variant, not a different revision of the same MCU.
> I will remove the comment as it is confusing with new boards.

Yes basically it was discoverable for earlier MCU version, but is not
for this particular board version.

Keep the comment, but add a comment on the vim4 entry saying this variant
is not discoverable.

Neil

> 
>>> +      - khadas,vim4-mcu
>>>   
>>>     "#cooling-cells": # Only needed for boards having FAN control feature
>>>       const: 2
>>> @@ -25,6 +26,10 @@ properties:
>>>     reg:
>>>       maxItems: 1
>>>   
>>> +  fan-supply:
>>> +    description: Phandle to the regulator that powers the fan.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>>   required:
>>>     - compatible
>>>     - reg
>>>
>>> -- 
>>> 2.49.0
>>>
> 
> 

