Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28B325727
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089501; cv=none; b=Zhf4pIwoOTFf/FCM7eO2R5jTKhHRUwPy40sK+x7vYS+TkET4rpH77dM+AHAJZR/en9/y+NfGpVCUgVZ2FaD9/jS/ML4x0qI/iWz1rRmhHyDYfOJxonpD4G2u/eWnuusU0lFyzGNkPUWnYG3/IslSevMPzKR6kRm+cOQlFqsw0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089501; c=relaxed/simple;
	bh=zvCB63LFnEjdtIx6luOoekU8E/I0ECmc0pzAnnziwXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tw4JblmTkCLIqeEAEE3O2E/OL4Nc1JatIGR5YvesdRmiEQx0wSNwJK85Zi2cB5PDPrLotmmJxKdeAt4ENV2W8bVVFsU3bM3OG3KC9D+awey8SdOd2boWhIUaIt/Qi7kPF4Qi+3ljKnmczzZgdCQBI4m7Bg60+yqOwvZmeT/i7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dw47YnyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKK1otCL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dw47YnyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKK1otCL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MCwUnC3902145
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 13:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ehwO5LCRInJQM6vPkfsO0mRLXSEQICDcdEnsiHaqUHA=; b=dw47YnyJtrDeJCM5
	wJYJ54TRymRwHwwKJneOJjUCyGQF9JLqOGdsQpImL93qHBZyvkqlUPDhPelYJ38s
	tbxGXr5uRXFVurgQRv2doRWiIMpZIqGI/xpILS9N7kBMyoFnHcANuS/ZuN/GMJBA
	1b1kyc/CycwTZ8q2rKyat7HXK2ebm7xYkIutV7/7UtTZs2OPGz61XZj48PbITt1W
	wEc2uFvBSVorZW9d/RROIUZ/3cVyB4VncWVCqsxm0MiqfThK4nVzdn3c8LDhmXez
	s7AXqXTcGET4VdKqSe9Z2l91enRGMQ7EDr3HpTzEponiD9dyNg7xfYx1NW7XDVWm
	V71cUg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu4khk0ky-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 13:44:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2fdf3a190so16237685a.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 05:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769089498; x=1769694298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehwO5LCRInJQM6vPkfsO0mRLXSEQICDcdEnsiHaqUHA=;
        b=GKK1otCLaaLaz4OCFytQ7tM+vIisq4x7MexhXzkdrsENx3Z2+XDxqM0K0v+ClJ+gRR
         2XKgOIV+B9QnE0RBglD08z/gjdO6d3dJNxeh++cuOmSYvpyPvj2Wgfb+AExSzD8pYYOn
         nR/QZLYfrduUO9OMSN6B7db6ZQR5jxkOvizYVj04yWOE6uCLBA6U7UYRXQTv8s+uvpgf
         fH7AiFJEqGaP4k81arVO4pcOrxqQ0umUTqZlle/Lg8fmZIX0tzAL1S0oCgIyfI1kTpR8
         dd/YrcX3VBE+GKpuQrOz868SLIo5rcOAaxhZPB0n0cs4Y0P+CwR2JdsqFwK0wfq4DhzZ
         woQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089498; x=1769694298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehwO5LCRInJQM6vPkfsO0mRLXSEQICDcdEnsiHaqUHA=;
        b=P0umv6lrTF8tdsTnfAgakRyX9Ru0GOnY7aAlLz6rRIi+rK3mWx5U2nWIrv4hpcADqt
         Dbz/1vZbzUepi6j7GaIrk4RcrvHxx6BkkRLd0H5Qm7fe/sNv7g2wIyfwxnMxd8qE9Q13
         C8p/16994qZdIgiOkw47syOIhazTE4vipDUcAd2Xz6T0CVvVaRIJyEU+2Wx+ADXie7eS
         Pd9b/WXTPaFPsjORyMHOsV/+K10lgj/S22HmxnAdjqYqm4tuTOBKMtTtO3A7jSw4HJoG
         /DIUdl+m5mB+JlH2sEZPteMdiynQFfgjJoz7B9SCCvN1ynWm/fB6YVz2OySd6OeiOWng
         zkuA==
X-Gm-Message-State: AOJu0YxJ7AdJ4MEQKGiNuFC507v3BEtYSfrfEB+L4dEZC5dTk4RJkSnj
	3uyDU6pkN2xw7ETRx7A2aSyMWfTahvRF7cBybcr243BolX973w5G6GikQE5lJz74YoqK0rcvqDh
	gbdtvEhtSPUfdsepdOwSkC2X1wvGtFgRUHDnCZJAfI0eNcz/SriELaNudk8BUO7s=
X-Gm-Gg: AZuq6aI8KUSJUi35UcHs6HX2BOmXDZaNC1GljAgXp3Kt5jnJXLqzJninJCHYx8NfqWa
	FQkHo7zPFv5sePHY82drJyjciHGlZ+AXzaZS+SKO+iZa570gZsZpik5FXJ5Bgm3vuRhbTzehgOs
	6PxidBvpmdI9vnKH3ZWLNwS5lObW1Jp3Ilz3kkQJT6U0QWMcDbLuFCsBJmp9bdkVtzykX4FPEaX
	6Xrn4LrR+OKQY+yfalIOIlRzK3mEyc/D3OV5HtytU3smznvIX03+cNMVvSKO5Pv1NjYKQjsmUbs
	wjDeomFiVKQbAXLKH2NnJXluUmpYzicQkP/L8FFRBKzK8RSWtJIxrl4vXnvdBgejEUkBnC6ig11
	xspX7RvS2u8AeRPjkUFTcGWb0yr8wWEmkypSxEdQDexPIc2ZrBUICEJU9kjizUKfEDdU=
X-Received: by 2002:a05:620a:4710:b0:8b9:fa81:527b with SMTP id af79cd13be357-8c6a672694bmr2200110185a.5.1769089497768;
        Thu, 22 Jan 2026 05:44:57 -0800 (PST)
X-Received: by 2002:a05:620a:4710:b0:8b9:fa81:527b with SMTP id af79cd13be357-8c6a672694bmr2200106085a.5.1769089497144;
        Thu, 22 Jan 2026 05:44:57 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65831de21e0sm1129568a12.28.2026.01.22.05.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 05:44:56 -0800 (PST)
Message-ID: <825c3e7c-469a-4d69-b298-18f2edf72ea4@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 14:44:52 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com>
 <20260122-sm6150_evk-v5-5-039b170450a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v5-5-039b170450a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEwMyBTYWx0ZWRfX2VKenQPWvBjD
 myPsQ7NJJAKvH2VluD7tkRWm8m0z2L2kuaLhd3qITv87HW2iWuWx5W2q+PRXX+spGh8EJGBylvb
 35YGC2fdskPfuM2edBhgMRVif1Z16VMYRmwsYarpojxVJNkjJ4KabdOMFMq+kwv8rKr8KALdWaQ
 1epCbEKV/ifHSmjSnSHsgE+PYxDL74sFe5Xbs/dvLJJbLors8oE5MWrtb2Sl4DmXl1tneqT5d4y
 xhe116jO5dG8Mo1Al8K7yaDKShPmmlio1Ug1doiEI7ug8N8OoR4lSPihtwsDfXVCeovlFHatolt
 tcQu5qReLLC6ebz2DwKcYl6kO+w7OqVIb5z0Y5mM9hQjeTiVh8dXsYJKV596Su90jc4sM+CeQtf
 7cCpQA4nhkNvLjrPd4haiRL1r0EudT6tvlo6UrA25zKcrvicBP1hAQ+VmYcEv36haoZYTsLtYHf
 542laSQm8zqKtwodjZg==
X-Proofpoint-ORIG-GUID: Cx_cmhsk_PY9nqWFFCgm0OjddOA6ZMII
X-Authority-Analysis: v=2.4 cv=UOjQ3Sfy c=1 sm=1 tr=0 ts=697229da cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=fwfv46HyQb7ozjPenEcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Cx_cmhsk_PY9nqWFFCgm0OjddOA6ZMII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220103

On 1/22/26 11:48 AM, Wenmeng Liu wrote:
> Enable IMX577 via CCI on Taloss EVK Core Kit.
> 
> The Talos EVK board does not include a camera sensor
> by default, this DTSO has enabled the Arducam 12.3MP
> IMX577 Mini Camera Module on the CSI-1 interface.
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
> ---

[...]

> +&cci_i2c1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	camera@1a {
> +		compatible = "sony,imx577";
> +		reg = <0x1a>;
> +
> +		reset-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;

Let's define the pin settings for the reset pin too, otherwise lgtm

Konrad

> +		pinctrl-0 = <&cam2_default>;
> +		pinctrl-names = "default";
> +
> +		clocks = <&camcc CAM_CC_MCLK2_CLK>;
> +		assigned-clocks = <&camcc CAM_CC_MCLK2_CLK>;
> +		assigned-clock-rates = <24000000>;
> +
> +		avdd-supply = <&vreg_s4a>;
> +
> +		port {
> +			imx577_ep1: endpoint {
> +				link-frequencies = /bits/ 64 <600000000>;
> +				data-lanes = <1 2 3 4>;
> +				remote-endpoint = <&csiphy1_ep>;
> +			};
> +		};
> +	};
> +};
> 
