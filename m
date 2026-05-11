Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58D39C645
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503417; cv=none; b=H3GvaqPZp7FgrMcDCh8m8k2nBobuHfX5pj6JEWfMTVv1gPgDOs2o7PSLPpflTZlbF8owl65NXxoKk5LSUUKjE3BxYJgqtab6VB/StjKs0wzkMin7SPRn0H17jJrSRg5sdK/+kFbdw60ilAiuXHm/Z9+GouK9L1C/MZ+ljscF4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503417; c=relaxed/simple;
	bh=8jKbrIxS79LQlDqKsfLebs92J/1T0XANiXEs6ZL4sEQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDvhaZzgHNFkn75NFAxyRZml6IarOBj2x2UILsVrVS+lneq6bJ3b8Cj/CPp2UD6YPL3Rk27IPGPZ024QzmanEx2va3yisq3JnicW3A5rDawWW2FzebRL8R01L7XJz6L/V+332mFmUoeSUVNENmV0VMpVZXioyQc7f2YcLVRA9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBAh0Az+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBAh0Az+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC39C2BCB0
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778503417;
	bh=8jKbrIxS79LQlDqKsfLebs92J/1T0XANiXEs6ZL4sEQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=fBAh0Az+HWJZ563YZrguZlSi/cvHLiwcivJ60iqDLeNoih71PfSRxFMlYXOUh2Xyn
	 +0JYLho61ok6M4XuQd+GAijRml23oj0MRAlV5rBoAMJinQiB3TyOzkeq7vUuYLK718
	 kz61+5cYliq/o8/+oul0q9wUx1/KA1Aq8Dwarh6Yqh+zoZU/uY41iNC+w7a2hAQLsA
	 7a5hLTD624gJ/7NJs2LKQnQOOuSqx+r87XU777q45ZZZQWuh9CyyQXj/h0OzeGnxX9
	 C2vdNU1zGQv8bUaXS59A6pOJ0OEk07gsIaFlA+S+HWhl3oCLinvAsr9eZ19PXbKNyp
	 IihUb859JGVNw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a860667fabso3843787e87.0
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 05:43:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8hSTz49Of3uW+ZMRGMjeyNi1HhHv8cwFdsMDodIxXfKSN5rdjpOTR7sPPpyHANMRIuHJDGZRyjGFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSIH1yfJmKkCQACR5XnRlUsJyG1i/fk6huvojf/KAjT0jKFgh3
	LZOHCrjXIN+qJvZq6agqBBpXotbHFnmPxiVvyXedF6Qw1842j6SnAgU07dlkpLFPMKI2+Z6bC13
	gnwpo57louyVmCqvb14nRVB/aienr1WQR9t/drAUWZg==
X-Received: by 2002:a05:6512:8013:20b0:5a8:9909:50a3 with SMTP id
 2adb3069b0e04-5a8a94c1fc3mr3083121e87.32.1778503416021; Mon, 11 May 2026
 05:43:36 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 05:43:34 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 05:43:34 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <00ef01dcdff4$42318c70$c694a550$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507181711.2696783-1-markus.stockhausen@gmx.de>
 <20260507181711.2696783-2-markus.stockhausen@gmx.de> <20260508131830.GA1135235-robh@kernel.org>
 <007a01dcdef9$05ba7140$112f53c0$@gmx.de> <af9xGlIWG_OmREzX@shikoro> <00ef01dcdff4$42318c70$c694a550$@gmx.de>
Date: Mon, 11 May 2026 05:43:34 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfN=jNiPRp_fS9T-39s7c366ak4MC6DWGFreonCZM92FA@mail.gmail.com>
X-Gm-Features: AVHnY4I08Z498qLDXux_zayzjHSKAhqd_PvGE-539uIUMGVNm4fKBeSHuHxXmVU
Message-ID: <CAMRc=MfN=jNiPRp_fS9T-39s7c366ak4MC6DWGFreonCZM92FA@mail.gmail.com>
Subject: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
To: markus.stockhausen@gmx.de
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 May 2026 22:41:48 +0200, <markus.stockhausen@gmx.de> said:
>> Von: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Gesendet: Samstag, 9. Mai 2026 19:39
>> An: markus.stockhausen@gmx.de; Bartosz Golaszewski <brgl@kernel.org>
>> Cc: 'Rob Herring' <robh@kernel.org>; andi.shyti@kernel.org;
> linux-i2c@vger.kernel.org
>> Betreff: Re: AW: [PATCH 1/2] dt-bindings: i2c: Add i2c-shared-gpio
>>...
>>
>> Now, the GPIO subsystem since recently allows for shared GPIOs[1]. This
>> sounds like the proper approach to me. Sadly, I can't help much because
>> I have not used this API so far. So, it seems you rather need a GPIO
>> expert... CCing Bart.
>>

There's no new API TBH. The GPIO shared proxy just mediates the usage of shared
GPIOs without the drivers knowing.

>> @Bart: is it possible to share a GPIO so that multiple i2c-gpio
>> instances can use the same GPIO as SCL? Use case is explained in the
>> cover letter[2].
>

The way it works is with a kind of a voting system. As long as there's at
least one user that votes for the GPIO to be "high", it stays high. Is this
behavior fine for the recovery use-case?

> Thanks fort he hint. That looks partly promising. I gave this a quick try
> on Kernel 6.18 in OpenWrt. Set the target to HAVE_SHARED_GPIOS.
> Finally added several backports (deadlock stalled the boot). Now it at
> least starts.
>
> This dts:
>
> 	i2c0: i2c-sfp0 {
>                 compatible = "i2c-gpio";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 scl-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH |
> GPIO_OPEN_DRAIN)>;
>                 sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> 	};
>
> 	i2c1: i2c-sfp1 {
>                 compatible = "i2c-gpio";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 scl-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH |
> GPIO_OPEN_DRAIN)>;
>                 sda-gpios = <&gpio1 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> 	};
>
> Gives these messages:
>
> [    2.048352] i2c-gpio i2c-sfp0: Slow GPIO pins might wreak havoc into
> I2C/SMBus bus timing
> [    2.058333] i2c-gpio i2c-sfp0: using lines 542 (SDA) and 573 (SCL)
> [    2.066139] i2c-gpio i2c-sfp1: Slow GPIO pins might wreak havoc into
> I2C/SMBus bus timing
> [    2.076333] i2c-gpio i2c-sfp1: using lines 543 (SDA) and 574 (SCL)
> [    2.084817] sfp sfp-p9: Host maximum power 1.0W
> [    2.091419] sfp sfp-p10: Host maximum power 1.0W
> [    2.200954] In rtldsa_vlan_setup
> [    2.397223] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.407907] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.418605] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.429275] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.439937] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.450584] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.461223] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.471875] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
> [    2.482539] gpio-574 (scl): gpio_set_open_drain_value_commit: Error in
> set_value for open drain err -1
>
> I assume I must dig deeper here.
>
> Markus
>
>

Can you enable CONFIG_DEBUG_GPIO and see what it says in the kernel log?

Bart
