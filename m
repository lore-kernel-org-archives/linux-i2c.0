Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025935DA63
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024865; cv=none; b=d5zPTEwBC7/lubisWSsRnkFQo+jOd/iAda3AWz3VBC6gf4WbNYQkz4DsPjnvcPqhzVgmRVvdsnd7i2Bl15LG31naF6pPtf417jZ9VBsgMXtao6dnwYHj11s6s2687dLPd7m6qZohy3uegmA6SmYeMpy0Jhu8Rrr1HyCKPTdrk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024865; c=relaxed/simple;
	bh=5PxmAqhbxT1r3T+11BjTa1R2Ja8Yu6KN6WMKGu0DmNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z9hBZeC0sJoWobt/WkeXkE723y+TM6uc9o84YTORHHtZQAfwSw/Ze5KHw36PzfpaJknSg+Bu/MFkEv8cmNQBPMZaxbX8graGy8HZ4VD8N07Q4wwGZ+aOcyW9eFd/7uK6OOy+HC8p47kvJl00wZJZtrZa5Q+y8lxShHqRus+wrEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mop+oF+J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mop+oF+J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso63292575e9.3
        for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024861; x=1777629661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPAdPOUXw3pVX3oaN35XRvBMX9UHe+5wDadCAJqegTM=;
        b=Mop+oF+JS2rWWapJcjuprjzcOYmb8+nArHuxT+v8O0ie7BYrw0HyDcQvIygsgZ8413
         +9ZIE9HvJXCQ1em0ts9cZDKArROi8ekEwBYy/OoRz7+KsSgrXHXTJI9+Y3xCEg8oVq0P
         FRMxNYXNvCRfYafoUOpCK0eVLG+M0bHgpW8v9VYLslpyDi0C9v1WxKn3twhJg+O2wXwp
         LcoHrJv3U/igLisXPMdg6ibKpNfPGldurb7yYbF0UWR7a+jYacO+jorrvT9YURQkDLkD
         gHeLz9g3YEsZ8gZNOjRq/q8OTxjLWG7n3NyO5+vUjVdDrTlOuYQ1vNUn5BYxZ6jahCEs
         igAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024861; x=1777629661;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPAdPOUXw3pVX3oaN35XRvBMX9UHe+5wDadCAJqegTM=;
        b=dmk40NKlG1H8dnSEyaND73d2ftewrykR0h7j6LpUuiteZZLt00KyvFkFzAORquXtcg
         OO0UituwVf1WqW9ULZjMubBOX2tDyh51sPj41ZNmolVP8kZKn7d04bAbm1TtGIClHYx9
         0ZsfuxduVaRYilYXOmEOkOFKm5MOK9SOSaUYjGtzj3gM4N6y6Lh3YD/hkuIIeatmACHr
         QjUcOKHV36FfhimbePz2eVc3S3fiF04Gg86HrsiGxa51snIa33sBS5RX5qSqvjOuv2CL
         1yzWBJ84rBHKdsa/X37papuf7mzj1z2npqXbLjCACix4HdUaA4RIclC+7jZJd6zLKHu8
         +BJg==
X-Forwarded-Encrypted: i=1; AFNElJ98066EJBy1qER8jG27LkstD0ut6THmDaCwlDCV+wB/DN5FTt8O0oMIxsIaN1VhPAQPajRVfcDv0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMJYFEUTH+HC0JMKNzZltmLMjQ8fgXaxxkI5jruPWPJU0962A
	K/SXTgDJ2dugscgr3ZlzM23CZC4Pz93vj3q2NaynXeYGj1MZ3T5n/gPEQa0xcsYHCmU=
X-Gm-Gg: AeBDies6BfPBnsTox8xxyEYddXIAf/QgVLvPk2UHFA3BIuXzVeZcevqkoE1NXAMRNow
	N/OWssGQD2y3FbuyqoCj1Ffm/hB3OhlQgNf0yhpkyPT6lWVptLkV4qEVmfAHa6v5MNGB9c+bga6
	danGtIaXFAOZ0ECc3SQNwxKwvq67V36FYEEk2pJKoRIPx0SwSd87pnfg7U+k7ZxCgMqrXNGbnmA
	0yhI+eawvqaPfXG9sLKnTDDh/n98xNkaw49N8CF8IROer9QIPhFhrZ0r2KsREBCJWVePzmYkNE0
	Pyr1dKtYtocBXhtLl7lAr4TF8pe8jjeIfKEr8BPO/SOxJ5006YP1n0SHznRptkZgHFKiJQsfl0L
	1693cUEbC9OpkIxQpZjgkz00izHoeg/bTwdiSBG0AIYmtGqrGvL6qX0fgzfABFhcMzxGq8TOeP+
	94sRhFWSNghfbfBmWeluUq5Lt186L2Z03GaLgA6bBj7PPyPygi3wThar4TGHzn3jhFjlnlGQvzU
	QgHdpWv7htsslBxdNsuSJWhVmn5
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488fb77e27cmr387870105e9.22.1777024861411;
        Fri, 24 Apr 2026 03:01:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7aa593sm182225895e9.24.2026.04.24.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 03:01:01 -0700 (PDT)
Message-ID: <12e4c15f-0782-465d-9f90-d9d4f8018306@linaro.org>
Date: Fri, 24 Apr 2026 12:00:59 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 7/8] arm64: dts: amlogic: t7: Add i2c controller node
To: linux-kernel-dev@aliel.fr, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
 <20260421-add-mcu-fan-khadas-vim4-v4-7-447114a28f2d@aliel.fr>
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
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-7-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add the T7 i2c controller node used by the Khadas VIM4
> for MCU communication.
> 
> Use amlogic,meson-axg-i2c as fallback compatible.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index e96fe10b251a0..560c9dce35266 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -711,6 +711,16 @@ pwm_ao_cd: pwm@60000 {
>   				status = "disabled";
>   			};
>   
> +			i2c_m_ao_a: i2c@76000 {
> +				compatible = "amlogic,t7-i2c", "amlogic,meson-axg-i2c";
> +				reg = <0x0 0x76000 0x0 0x48>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc_periphs CLKID_SYS_I2C_AO_A>;
> +				status = "disabled";
> +			};
> +
>   			sd_emmc_a: mmc@88000 {
>   				compatible = "amlogic,t7-mmc", "amlogic,meson-axg-mmc";
>   				reg = <0x0 0x88000 0x0 0x800>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
