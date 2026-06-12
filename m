Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BE35E1BA
	for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251290; cv=none; b=Y6FpCaY5zAOEGBkR9U+RwZK1KkUAY2O79igBvfNfkEj7OwaHOVAOdYE5DGtBrTf5OMPQF/KbN65IcTJoR+GZF3D7QE9Nj9sg6+kMndNXGwUThIsh5nXzZBJ2HzpCbDRp+RjRaRmeCLbkrmAwfu9SiOWRFD1opfgWGvQIeUIVdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251290; c=relaxed/simple;
	bh=SQEbNHWiJIM6sDDgeR5ssNziH59tYfVqTFW3jiKDt3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMz/Pk/TJDz5sNwDzK4CEQ88X4c409RVNkF7zzqwHBzZe6Pb1x6wIXkfSEbzj0KlJ4HrYIEmtQVxaeh8QbcblPxGSWtNw84HBWf6iydAWulgWJXll2DisQHsG1xNsXLihotCIF3YjX2Uy9Zne/l4wfY62jhYq21BguLYigPWuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9HtuOYg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9HtuOYg"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-396709ba436so940831fa.2
        for <linux-i2c@vger.kernel.org>; Fri, 12 Jun 2026 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781251287; x=1781856087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGSXIXNGhXGoEinX4j2POzhiX7uHLTUs+2fOXh7YSMY=;
        b=q9HtuOYgQM43t4zBZXlB21FVE25oyLcRD1F4uQwL3u0to14xdP6RFZoN/bKLCZznhr
         lnHFlfG83UPLK3E1KlWYK4jUvyyxT0+NqYE9tKjREXcVB2zsFa0BXSdlv0oSRjACUk6g
         qxHQigTrx8B3fMMyNlZC6uIeV1wONBNeR3q9loMdWYgjFQeGtWrw25eniWJfDvAKHh3i
         IRPRUcG9NWzm/as51YN4xcLjW9PA/c9SzHyLmQG/NrJU6cLUHGelyGIeimf8rqo2mNL+
         eN4Pe9vz22XVt0dcNkAK1flXyb6NwqzCbTQWUotjEVj3CTTj5vfKqjA9rmJ+QrPt1LKV
         Cc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251287; x=1781856087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGSXIXNGhXGoEinX4j2POzhiX7uHLTUs+2fOXh7YSMY=;
        b=G55gvxY3ssHjH0QPTXfNIzPnBdE9gZMkk/hz5Ph4ZDcnbTpG98ORAS5ZT29bRxdsx0
         exwYVosfR4Rxt/6f4H/LbADj0MHOXAmnDuXhslo4Kl7rRhhopKcBb9imWhjMNn3j1mrj
         2ToPv7C/jCxqGvHikwl7vZFh2Pt8MxYSo3300i64FxG/m7sMboHxz62Men1jZniYcuTp
         +kHEGoz2TrDrMFOka5s9fY0DvU4xnTgT6Jx9EGBYHGaibw2HYbmC5bf2yLyQzdqcw1lh
         ih8XgmiZ84ECOfFGJ8OyZXnO8FGs5JBFumBfvbbaK1EQDQ8LjgihJw6pLxCmAD75vwVe
         XxyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EjNo4wGz5Mvt6OU19IIlGWMme7Hml3GS1pjHSnEwucT5H/LaoYRmU9/39GjOXR5xVWfL/LeqyXQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEpAZoZzx8T97wGW5HqPoVaEhtwmVLP5ZKHlukFeWhByaVsCJ
	hYQAjHr7r2lMcvcvbCgcf7lIfRgwqhOVrwMf4BazGvP8v/c5Xi0p2oEwBONO/+s90U8=
X-Gm-Gg: Acq92OFPbqs9f7tQfDbm7q10pACagsTWfNLEfyTp23IS5xBxi9dk010IMkKYtRYAy3F
	ZuFpy4G+C+pg6O/UOOnMjEQrW/jrlqguc9nUSLXI3wUOg3GHnS1qNRaArMYmzYlUOXJ0WtJ1J7O
	rZooF+DZZh5vxccsM3tDcXyGiTAOmuclY77y4LS91gTzdhEIG3Uw83jz99wyY5nS6vY0v8JnjCa
	wCG9XAux0EJHUFXtnra3XaM/tPDQQ7kzaL51ZYTpreIjmxiDm36LQjG7FZPNx/IoODvVEqEvTX7
	xZ+vPStdkmzZuX7B2+n2geJY3kE87wkUp6xGwOQmXHfgZ68T8kIPmRw4i2KnHBpLwke4TyH1lPC
	flyqdjMGK3zbVERh2vo9WAGI5COsggTqNPyp6AdbX9xA9C/H2PNGs3P18b6ProxllGUCJmT7+9y
	l5IBb9HSre+Nz2xlhFUeL/Ve+c3OlxnylPiDNm66xJLSR2iDs7IaFbdmyiVxL2Y2y9maI9zPuM8
	cYNiw==
X-Received: by 2002:ac2:4c55:0:b0:5aa:61ed:482c with SMTP id 2adb3069b0e04-5ad2db73743mr194365e87.6.1781251286462;
        Fri, 12 Jun 2026 01:01:26 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b7a3fsm319389e87.82.2026.06.12.01.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 01:01:25 -0700 (PDT)
Message-ID: <d4d75a39-3575-4bc7-9fa3-a6521619daca@linaro.org>
Date: Fri, 12 Jun 2026 11:01:24 +0300
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: shikra: Add CCI definitions
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
 <20260608-shikra-camss-review-v2-4-ca1936bf1219@oss.qualcomm.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260608-shikra-camss-review-v2-4-ca1936bf1219@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 17:06, Nihal Kumar Gupta wrote:
> Qualcomm Shikra SoC has one Camera Control Interface (CCI)
> containing two I2C hosts.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index b93ce4a92a998ea5d9d4268d2fd46030fafc4084..fed71131491ebf6e261bfcd14b5d4a2624837878 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -348,6 +348,38 @@ tlmm: pinctrl@500000 {
>   			gpio-ranges = <&tlmm 0 0 165>;
>   			wakeup-parent = <&mpm>;
>   
> +			cci_i2c0_default: cci-i2c0-default-state {
> +				/* SDA, SCL */
> +				pins = "gpio36", "gpio37";
> +				function = "cci_i2c0";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			cci_i2c0_sleep: cci-i2c0-sleep-state {
> +				/* SDA, SCL */
> +				pins = "gpio36", "gpio37";
> +				function = "cci_i2c0";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			cci_i2c1_default: cci-i2c1-default-state {
> +				/* SDA, SCL */
> +				pins = "gpio41", "gpio42";
> +				function = "cci_i2c1";
> +				drive-strength = <2>;
> +				bias-pull-up;
> +			};
> +
> +			cci_i2c1_sleep: cci-i2c1-sleep-state {
> +				/* SDA, SCL */
> +				pins = "gpio41", "gpio42";
> +				function = "cci_i2c1";
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
>   			qup_uart0_default: qup-uart0-default-state {
>   				pins = "gpio0", "gpio1";
>   				function = "qup0_se0";
> @@ -701,6 +733,44 @@ port@1 {
>   					reg = <1>;
>   				};
>   			};
> +
> +		};
> +
> +		cci: cci@5c1b000 {
> +			compatible = "qcom,shikra-cci", "qcom,msm8996-cci";
> +			reg = <0x0 0x05c1b000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 206 IRQ_TYPE_EDGE_RISING 0>;
> +
> +			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +				 <&gcc GCC_CAMSS_CCI_0_CLK>;
> +			clock-names = "ahb",
> +				      "cci";
> +
> +			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
> +
> +			pinctrl-0 = <&cci_i2c0_default &cci_i2c1_default>;
> +			pinctrl-1 = <&cci_i2c0_sleep &cci_i2c1_sleep>;
> +			pinctrl-names = "default", "sleep";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +
> +			cci_i2c0: i2c-bus@0 {
> +				reg = <0>;
> +				clock-frequency = <400000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			cci_i2c1: i2c-bus@1 {
> +				reg = <1>;
> +				clock-frequency = <400000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
>   		};
>   
>   		qupv3_0: geniqup@4ac0000 {
> 

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir
