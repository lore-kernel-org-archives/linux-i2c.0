Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F752758A
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687543; cv=none; b=E6ieup3b6fzHtz42mvKSHrtXSKrg048xMLwoPEOAwFFl7tPhSzxIH6+ZD4p/eodXcxEjjSqGM4fBkj94/93BPP0HgJhjHQtOhWjhLhctuVaz5H4ad9RjhXU3cPVhNEUsbXtRJcdHQwj4ebIDZTVilpLe17j2nw0Te50WVVaX16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687543; c=relaxed/simple;
	bh=wOjzlOoYB90lyjfFiVBHTNDKDKGt6bPwugUnMawhWc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTWGoUntOKxbPc1w9jIiC7Bwu04Ypemv2DWcslSvFxsMWPm0acE2Adh6tX0yvuNUE5TVOV5ERlTcSumxJITZmPx94588QaZqtAOCVExmJF8O8LUjZoG/k3D9yXNLRm28QoKRbwi2xvUTZN2No++PhZsu+aOfQtODW7GM3JPJXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HwPu+TmK; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HwPu+TmK"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c72bd8a017so2519233eaf.3
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790687540; x=1791292340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSKiUJRQhiLhPi0pr/mU+MmO5Nu+j31ELjJx/f3jfj4=;
        b=HwPu+TmKVQyVgdqw8atSaQoVOE5z+qT/44x+yo701WfkGLui9wMWFcyuZFzl4ZvFMZ
         84wdieWdMGI5TS2cJqaLel5iTUP2otlah8yQIoOjAOEiQj3SN47PhJmOSbduu4NBhEME
         TTsbTukxuV3ff5LNxcjs1+2zk3dYBHUy/RT0G/RCYifr1vOooHvXgm0v+FwdM5DbC6ED
         jByQbNLDsSpr6TZ1HNuAOplHgJ06ZHwaJJVzvgH/m8hsx44uxlKQq3/YXiJb96XWMUWG
         viZn7hPmTqLyuIX+5+jbjdDeedFvsaIyCHY4bCpdNuhPf6VNQPOc94SE3vMJlRT/ZPuF
         Jpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687540; x=1791292340;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FSKiUJRQhiLhPi0pr/mU+MmO5Nu+j31ELjJx/f3jfj4=;
        b=XQRghgv+EaVpW6RXCWBR0Nt02s0qGjnRZ2YvP1reXwfCwJu8CpLV26H/b0+RPJaDgs
         rU0gVtQGS2qyQYOqar9pqnfw0a5ypvgmaM9Nd1j47V0BpSbE+MCd70L8yEMaOY+zDn7n
         +U6Uu1xyQUDv+oT4zvLD36hPgWpTnUhmM9xxUvAt+sZs5Zl8zN2wQi8kyxvoUCcI35kd
         6gIeiMvP+/YfkEghqSRnkhuyOpY0LCDzPyBuws77Ijc6l9fGxtSywzmQKgRYGTtcTPuW
         1tie4Xe1MLfDB5R8NDthQWgzz9NtUpeHXsz9ZAsCCmVTn2aLfVYPat8+eRqPUBLvfsly
         Vv5Q==
X-Forwarded-Encrypted: i=1; AKwUvBypTtfzkeG9zfoerGVZ3Lxl0Qc0B3TIMjh1Tzus/MlRVOIuPUQf/PNZ574eb6JCGoPYVAgtuSm2Up4=@vger.kernel.org
X-Gm-Message-State: AFuF++l5QVkX2czhOSmwNlN1/HIWzTftM5kbbSdClqI1/wL7XCTb3qfo
	uL3/KP5YD5uiV4EoNU8eW8jrS2YEdG/Kf8n/WJRWmWfeH4KZEvXb4PPpYVCBbocVcmY=
X-Gm-Gg: AYBFou1y1jopmFhUcHISm/fOUFB7iRzacaZWTUQvg0Dyctvw3ciogqcy6plYUouj9OM
	6bh1RUN1mGYSeS1c8EI5RYej4Yzkic82xb9h26sWmhhGG/ydV8SMSBaZa4l+89sXCtsOPpLm5ny
	O2F31hBjR7Tj4XNNPHwaLz9oX+Jc2aQgSPRJM6V+qffGLd91/MpdXNqwjnV0YBQ99eNay1VFcrP
	sXartce4FWdZb2xuz1ZqhjBFNkDllz+Kp3Gvd1Kz8azrXxC6OcB87pJeC/UsoXG7V3xt8i0l9yj
	vyzQ7Se567vs0M3E9Rh/ZHPBaYOSzkU05XyWNhwowBJRaU2UxdfOA/GUbM0IG9y+2mREy9buuMj
	k1y9Fk35S5iqgDBM8VvXmQfuPBY03brnqUwnQk3gPPAIyTNa5jMEpe/LNXpVGWdG4okM/qz/0Zw
	X5W+AqfOYF4eogS5m9ZKvMVoLHzYpusAWzTZXPrS//rLlXOu54X63bajtNH/RNgWN6fnqtjTE=
X-Received: by 2002:a05:6820:1524:b0:6c1:598a:d80a with SMTP id 006d021491bc7-6d440eea6aamr17324629eaf.62.1790687539902;
        Tue, 29 Sep 2026 06:12:19 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.13.74])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8822199cbsm8598079eaf.5.2026.09.29.06.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 06:12:19 -0700 (PDT)
Message-ID: <e27dd631-73a8-444a-8747-84d51ca3a57c@sifive.com>
Date: Tue, 29 Sep 2026 08:12:17 -0500
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] riscv: dts: eswin: add watchdog support
To: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>,
 Darshan Prajapati <darshan.prajapati@einfochips.com>,
 Pritesh Patel <pritesh.patel@einfochips.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andi Shyti <andi.shyti@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Min Lin <linmin@eswincomputing.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
 <20260814070007.1662455-8-pinkesh.vaghela@einfochips.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260814070007.1662455-8-pinkesh.vaghela@einfochips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Pinkesh,

On 2026-08-14 2:00 AM, Pinkesh Vaghela wrote:
> From: Pritesh Patel <pritesh.patel@einfochips.com>
> 
> Add watchdog node for ESWIN EIC7700 SoC and enable them for HiFive
> Premier P550 board
> 
> Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
> Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
> ---
>  .../dts/eswin/eic7700-hifive-premier-p550.dts | 16 ++++++++
>  arch/riscv/boot/dts/eswin/eic7700.dtsi        | 40 +++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> index 5dddcf13fd25..103c3dab184f 100644
> --- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> +++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
> @@ -207,3 +207,19 @@ &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
>  };
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&wdt1 {
> +	status = "okay";
> +};
> +
> +&wdt2 {
> +	status = "okay";
> +};
> +
> +&wdt3 {
> +	status = "okay";
> +};

The watchdog timers have no dependency outside the SoC, so they can be enabled
by default (omit the status property). There is no need to separately enable
them for each board.

Regards,
Samuel

> diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
> index c13432d14504..f873e9eeb929 100644
> --- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
> +++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
> @@ -265,6 +265,46 @@ syscon: syscon@50440000 {
>  			};
>  		};
>  
> +		wdt0: watchdog@50800000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x50800000 0x0 0x4000>;
> +			interrupts = <87>;
> +			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT0_PCLK>;
> +			clock-names = "tclk";
> +			resets = <&reset EIC7700_RESET_WDT0>;
> +			status = "disabled";
> +		};
> +
> +		wdt1: watchdog@50804000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x50804000 0x0 0x4000>;
> +			interrupts = <88>;
> +			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT1_PCLK>;
> +			clock-names = "tclk";
> +			resets = <&reset EIC7700_RESET_WDT1>;
> +			status = "disabled";
> +		};
> +
> +		wdt2: watchdog@50808000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x50808000 0x0 0x4000>;
> +			interrupts = <89>;
> +			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT2_PCLK>;
> +			clock-names = "tclk";
> +			resets = <&reset EIC7700_RESET_WDT2>;
> +			status = "disabled";
> +		};
> +
> +		wdt3: watchdog@5080c000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x5080c000 0x0 0x4000>;
> +			interrupts = <90>;
> +			clocks = <&clk EIC7700_CLK_GATE_LSP_WDT3_PCLK>;
> +			clock-names = "tclk";
> +			resets = <&reset EIC7700_RESET_WDT3>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@50900000 {
>  			compatible = "snps,dw-apb-uart";
>  			reg = <0x0 0x50900000 0x0 0x10000>;

