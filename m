Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330123128CC
	for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024858; cv=none; b=XItfA5IbYhwlCNGAgHSz6sQK/HPEBnm/eRCenPdWAFw9tdMaEBAeWKewOR/ieON2400hzCBOGxgFALHLTz02T0tmu1KX/R7GWcSPCbe+aPR5BWVfGSYCC3wO5ACsJJiD0xgjH55xOi52IA8QVTRaXBjxc/itPLt2mtKTy5OvsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024858; c=relaxed/simple;
	bh=iRJN0EpeLnWDppG3Hz26XEsK22cIjFzJh5h4CN/uSXQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rXCkBRZ7hY3CKFPa12WuH8LdAxEzdOb2gdYccZkOc5JzputCbXb6D6KkV5KZiikvWlxa7B0YsP4boKjMvt/vkI1uS9D8+1ZsJVjaN167ilkoXvTFXx+gwVhwzmmCDvARMm0hsCgTGjog5MlGWSszWX82+N5G0PP++yGrJrJq1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOmZQqDr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOmZQqDr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so69182335e9.1
        for <linux-i2c@vger.kernel.org>; Fri, 24 Apr 2026 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024856; x=1777629656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq07QUD8xIc4JRSL4PxKVMWxBFYSl0vshdBEVj4c9kM=;
        b=FOmZQqDrIZ/pmmpWN0rDw19/2X6h72ApvNLREix3SHA0s5rC5XUptqsdsOWhi/MXf0
         cvzMtAA2MTlTa3sY29S7R/h3mHcFtHlzCza53KSxuA1hpYBVfUo107flxpm96H80zq9S
         6obsgFkIOdFezvgZ4dYYOXr0eK5ygEHooY9P7xXcy8oRTE/aJYgZAHhxTxldnPLGRySa
         yWXYDoj2ocMCpFYtobp75TRSYTd1Ro3ocJXS+DaSkoWjprNhye1tENh1iqKw9YLnV4Qd
         WRM8MWD8ISAtNFTobE9Y/Lf4Jr5MTM/2e+rze7SrNqK6QJBy2HmyJGWPu9DnDruhQPIo
         scAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024856; x=1777629656;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq07QUD8xIc4JRSL4PxKVMWxBFYSl0vshdBEVj4c9kM=;
        b=ewdC4ylVsWehagt5uzbe62+N4GQ8MrqKV/cWUkTzFU1IeCnULT+2r1a/4QAiFBBL7t
         nQ8hm6JUvO2WrtkJlcvYDSr9ztXghV52AhmzRNgaWEFKwPGm+21t/qY0ma9FEViNok6z
         1qGsNEEGaYfW8zxNnSMbxjYXzAzxKpn2Mjin7iH1Dkj2hOg9l00mWAp7kOV56Lg9vGXC
         49LAMcvsm5sd4ll3Cz7Qm1W24jq6NrJF2zYtKXZ4uehU4khOgPsej6yWPvM1UnTzmXLo
         Xbkmc44PSG6eYT4GkEjQaeZ4DziT4TAkfK4jybVuAbQNEMunKmw8t6KXqIAmJl2iErcV
         cpTg==
X-Forwarded-Encrypted: i=1; AFNElJ/7iv45lLA/nFjeWqjCrYqt1jniH68HdQBjEKeCwHYQq/qxlVO0isLeKTi3H8Ssj25Tx7YV69s/Jtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEFgHV8KmO3w3FeiXu8Eaiut3nChHIit/BCdwDdD169pEcfx0K
	UX1JRRCPb+D/7UY4CDsbet/B6W2O1k2hneVgkKLUSMhM9cv5YTSty4lc8pDcqRRSYSnJ3ZKAey6
	xvtIjYA8=
X-Gm-Gg: AeBDieug4fzCQ4iyvjWrZzyevivAktw29OozTAt+rPU8+qyOIKX/xfLV4ldZp/K6dN4
	qT5Wl2CwrZ9oNtGN6YwmHV6JCAGZrMDkat8MHGpMVAEdT2JOPmOWH72NTyHj5JRnqd36B4lAelh
	7IrG4fnLBynEVe+d3RAIWXkMmINVzhWb3A/Zsc/SeY4uq3TXbs1uwSeuJeT4/9E/Uvbz8F2vYem
	Jm+6SyH9C7KNGDEQL7XHXvhwgFo9mTUCCeElgP+jZxySGpY9hGtUr0iakkSYlQ2yGYjIb6jcdAs
	Ib2qlAx3kT4pbuHfJh3nYYIU2rLk0w7u3qRT9eP/2bN3S+7Fm/zxLubGKESJmnxD3iEzryDD2DE
	OztSyVpmuq0MDV4DyeQm2vLCXTBZ5MACA0xqsNC/ERa0N3qWpFS6jV8tJTJ/QmpRko3B85RQyQS
	Sg+DFJGmub7OsuWHvGLeKtcuCS40vD6LA4ScJUJcF5lXAiVBegzdfZL4E3+jcDrkEMgcRLSTyGM
	GjYAUPg8FbDta7INQ==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488fb78ee4emr429943265e9.25.1777024854110;
        Fri, 24 Apr 2026 03:00:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0b60sm169961765e9.17.2026.04.24.03.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 03:00:53 -0700 (PDT)
Message-ID: <e65c3933-996a-4ab8-8431-3f6ae18e44bc@linaro.org>
Date: Fri, 24 Apr 2026 12:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/8] arm64: dts: amlogic: t7: Add i2c pinctrl node
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
 <20260421-add-mcu-fan-khadas-vim4-v4-6-447114a28f2d@aliel.fr>
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
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-6-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add the T7 pinctrl used by the Khadas VIM4 for MCU communication.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 7fe72c94ed623..e96fe10b251a0 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -376,6 +376,16 @@ mux {
>   					};
>   				};
>   
> +				i2c0_ao_d_pins: i2c0-ao-d {
> +					mux {
> +						groups = "i2c0_ao_sck_d",
> +							 "i2c0_ao_sda_d";
> +						function = "i2c0_ao";
> +						bias-disable;
> +						drive-strength-microamp = <3000>;
> +					};
> +				};
> +
>   				pwm_a_pins: pwm-a {
>   					mux {
>   						groups = "pwm_a";
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
