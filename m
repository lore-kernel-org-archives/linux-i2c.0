Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660335;
	b=ypD76nMa1C/BnSQtSpP9yJUAX/9sd0Y9Z0WC/+FL5NG1VK3zAv9qCbChGU6HCrRlO8x1
	 SenJxZAdB+KDfNRh/KyHfRSWwCo77JOCczP33biDuNdzGrdEFeVITyJj1MlBh7nAwIUEp
	 Z+4NVZmBXxARQnhe+GnvX87+y5nhuqZcOk8NSLtq7IFbcrqtCPjbXEAPo66UOUTw7c/do
	 C+0MogxmKhGVLzTbYRZJrG2XY5U1xBeThVimQLDwweLgbZNkWFUjd6iLTu82+bUxks3xo
	 ZgRe4h5sOougO7rB2S5FaFQuQSojKOavORJJvYJWAf1PkTDfTBfAP69RJKePOiG34tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MQ1iBvVrMMpIWy460OOriq542kT+Ih2W70vOTyo6HdE=;
	b=b/spusD+aCWqfF73ICSFdtIIQFc5YxlqeOky9D5SoF6CE9GV8gkgL8SAKAjx8aA0KsIK
	 UnWtXxztFEWZno0xYWMnkmsMAIudHhCGloBXjTwMuIbO8e6cGdIiB4Nx/bFwVWy6n3HAL
	 0LgRQzEAOfEpLdyZVClcC1V6mWy17U5Kz+BcvKKzBuylR4mw5gAgqojeiNbqja3OVX+j5
	 w8X4jZ6zgYrZiyG9Bf9tYFCxwdfXqVaA4Rqd1VtuNkw0CQP0q7HLo5U54npRphHbAqJIB
	 eh3IQyeGPMyMT4T+50rQGUpoRF/t0ZDbf16wIEXj/Xxtm4TVeuReauLcpe/lEIDv3pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WfoWGa1S;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fmpriTNG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4310606A32C
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4310606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WfoWGa1S;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fmpriTNG
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ0oAOv1525171
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MQ1iBvVrMMpIWy460OOriq542kT+Ih2W70vOTyo6HdE=; b=WfoWGa1Sw1GOI+hC
	/OSurM9Nx3Asa/NFMQzIld1qGMqXtwTO1Ie+/LNl+oZKTZhW4crNOLM36shmCzP4
	U2yiq+itKTY5YG6Dt7FlWA4hZ6exYClmrloeqCgyDqOj58iiIHhP5rCIyPXrWo1X
	3o9T0PfABWUNnSp9pfEfM1l++97bsrCRBXw5jNvqjXGCXZPVAIf9sQdLN/oLMe4j
	VoZx0QR3YTcwBOfk54I6FjQ0LiiK+M759XFcARvzGa/mF7xcoHhI8wB/h8Ul+Lkr
	E+MZ4/9jfFi6SJ8gwJWCB3pzTkNpOvwd7iVXDazcPskXpULhD41CAp0uxaVsBvWN
	BXDbAA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak008k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:32:13 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-921052e3e92so113007476d6.1
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795660332; x=1796265132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MQ1iBvVrMMpIWy460OOriq542kT+Ih2W70vOTyo6HdE=;
        b=fmpriTNGu7wJbjqw+78BabtcKRmoMeNKNh8AiMDD/1DlB3xHs1ZvM3ImKtWly+3aW5
         BJ6i/IEpiI6nCVcuG37Ay7/naMqeFF9H+Lq733I+qlHfHTTYkTAeDrILlvvClZiEsSTP
         EFQNVyfCGjSeK7YxAxQLQBzhzj/5WeLC6KcnitnM9Qd0gIqIk+ucTCLiLR9vM4MMBdgK
         mg1z4c9Dsq9r+IEbdCBTnPUCg1/RXGK0FtZOHkKqcL2hHDB2PqztXHt6gAm9f4JbJymd
         ajcIpTgGekXgKjdri97lecbb7O37qjyXXoE5UNY2cmha635jtpfzMT3Z5/TsxXWpMJyl
         2jiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660332; x=1796265132;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MQ1iBvVrMMpIWy460OOriq542kT+Ih2W70vOTyo6HdE=;
        b=IbEm5dXmIdhXxNb2MKs07c5sURQBVxu6nX+03QUYZK5MNvRmaBxOV/BeKCuHTb27Wk
         aGnLWjQlHxYv69CH1FDYsrDzLDTP7cX5ZAZutfQWnxcCZ/Q7RGcHxH71Zr6X18vvwhvt
         wVKaLYVe/hPXGC6MPQECfOVhdH3l5rbVBfHLnSw6h4DGNbrEeQwUqmwqj+Gw885IE65/
         //TAEe835C2uUIbK3Fv86h+0wXeP69aX3tkaikK/JBohEl/8uwnfuCdWfIUUHbpSGFA9
         mvL827O8vpynArUgxPmVubvl2txuFEXzQeDcwSJUYGo//p+mlRoIQBh9cnVkc63geFW0
         PSaA==
X-Forwarded-Encrypted: i=1; AL+hErH68BkfMfeV+BDM6Pk4/0mAew8inKe3kHMcIJAYs/I5haMxu9p8+Jp+t2yGeysgbrj9Y9rBr5LP0Tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z93Gt31l2ZZ1AExjO/9aldLiRvN0gs3x3h2G9Kkt962k10DAO7m
	M3F52FrsK5ZS/tJy13bmKcniDivtAfq1ci5e1+Te3Sf2YoJ76iWiGxF5nVYPcgOXMSA8t0G9B5O
	Di4ycxFTCzdTbq5F4YSdB2wKUk+gbolxLZcnMLLz7fTMxS10Ou46SikJlhbndkRc=
X-Gm-Gg: AZFdTZd8UtiFCZnXNt7uPg1pkoLUBHEepArapHgfuTh8beyPpX4wuBuXmH2S5L9jR65
	sOWPOBJkaaJEhXTcA3N+O0OltoDxLmQ5PwcfNRO+xkB+Ghk1d8CfHmKhgxZy2SWOOyTevj0oIgO
	UckialrXpMd35+7mh1MdXq98+sc2RpFiF+GGfqNHfNkq+VTEYuynZkwSHir7pMpfxsW8UliGogY
	fy19KG/oArqDyGYAXPhUop7SI8X+TrBDpUZw4jugJZvfaZoQ+uYfD6B/Dr3D/TeYUfxX5iviDDr
	ouCZObOd6Hwm9JqldU5bwgy+tJ5cygRU+dBJTDkGyyPT1hqyxY4nhvDK8JDgiXMg8MmmOpwXQiy
	3HK7gO0EVPmYLWm+I1yqMH14PYrIAESG1UKkWjIjU8U1DDc/G061dsMfd+hnjghUaWhwbx9EZHe
	bY1/oULFvBS7EiSW6A22VkWzB2lZOcLVy5Q24=
X-Received: by 2002:a05:6214:3f89:b0:921:3c14:a08e with SMTP id 6a1803df08f44-9213c14c1cbmr332066356d6.15.1795660331842;
        Wed, 25 Nov 2026 18:32:11 -0800 (PST)
X-Received: by 2002:a05:6214:3f89:b0:921:3c14:a08e with SMTP id 6a1803df08f44-9213c14c1cbmr332065816d6.15.1795660331250;
        Wed, 25 Nov 2026 18:32:11 -0800 (PST)
Received: from [10.38.247.193] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213479655asm178017406d6.4.2026.11.25.18.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 18:32:10 -0800 (PST)
Message-ID: <86390ae2-8c33-443b-9730-ebaf4db1b968@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:32:02 +0800
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/23] arm64: dts: qcom: eliza-evk-imx577-camera: Add
 DT overlay
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-23-8ff2a11835f6@oss.qualcomm.com>
 <38bdcad3-2c2f-4e55-9a3e-17047b9f486f@linaro.org>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <38bdcad3-2c2f-4e55-9a3e-17047b9f486f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b079a2d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cvRs29UJe7UXO2q9YXUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1YNYTH-NBQc9gSz3bKOZnkqjtsUdu3mh
X-Proofpoint-GUID: 1YNYTH-NBQc9gSz3bKOZnkqjtsUdu3mh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfXw8RueemPXVYE
 TlfMj1uWFi1ZZEVhaDSkgOOcfc4X0pS1F7h7KmFg10jO17WX88QQTho3Bt7P9BoOxD4EcOcz+4h
 wU6vu56nc0kZ5Kzq5/zOFZVuEH9kIaVcARErNUdxsofvjH5zMD8MDgnlNlrr8eTDihtzjhxGHNl
 f/oVyxFVHsM+c3bdb1rlq/qgKMADeHGd7Y4Qw9LTUTq9q7YKcMjyYsKtxiOxBZXt5GpaWBfONWT
 I30jGwTQlhs1a36Wx08SojTVEPeYiYgRQi+Cb2xYIc21BJ73moQx/zQrYlFfTrb4hFmOHYdjl+Z
 tvsU2ThDt40TS1yJW21nZ+l7yaeXlUjM/KTUh4/h3mRw/twwS60nk8ryGjwVgsOcjzV7SZnok4Z
 glJ2E0fmjpqWzTLI5aF/TN4eV5eTEq6azsSRt8OGhuA5ivEllIV/4/405tnPFKXct6XnavSLXu6
 uRPZ4k1kc5frfaUUOMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX5YWDeZYvfcoI
 pjBhgwEGf2AjgioZ2h9EqcNX5baYpryblBF4BNFgq/68fTKZDZ3/1LxC14Mkw/2mldypQAqREYF
 ruJ4YkYrt6mqu4VTIFJR8DqjtuHZVrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260008



On 11/25/2026 9:25 PM, Vladimir Zapolskiy wrote:
> On 11/14/26 13:29, Wenmeng Liu wrote:
>> Add an overlay for optional IMX577 integration on the Eliza CQS EVK,
>> shared by the eMMC and UFS variants. The sensor is on CCI0 I2C bus 0,
>> uses MCLK0 with its reset on GPIO8 and connects to CSIPHY0 over CSI-2.
>> The overlay enables CAMSS, CSIPHY0 and CCI0.
>>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile                  |  4 +
>>   .../boot/dts/qcom/eliza-evk-imx577-camera.dtso     | 85 ++++++++++++ 
>> ++++++++++
>>   2 files changed, 89 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/ 
>> qcom/Makefile
>> index 
>> 64d2cfdb89c89f1c6eb0085e2bf5877ff980dbc4..a9374c54dd514f53b7aa97f5581c99cb6e75697d 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -16,6 +16,10 @@ dtb-$(CONFIG_ARCH_QCOM)    += apq8096sg-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += apq8096-ifc6640.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += eliza-cqs-evk-emmc.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += eliza-cqs-evk-ufs.dtb
>> +eliza-cqs-evk-emmc-imx577-camera-dtbs := eliza-cqs-evk-emmc.dtb 
>> eliza-evk-imx577-camera.dtbo
>> +eliza-cqs-evk-ufs-imx577-camera-dtbs := eliza-cqs-evk-ufs.dtb eliza- 
>> evk-imx577-camera.dtbo
>> +dtb-$(CONFIG_ARCH_QCOM)    += eliza-cqs-evk-emmc-imx577-camera.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)    += eliza-cqs-evk-ufs-imx577-camera.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += eliza-mtp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += glymur-asus-zenbook-a14-ux3407na.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)    += glymur-asus-zenbook-a16-ux3607oa.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso b/ 
>> arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..08f2e3c62dbdaf23a2f6ca69a5c392054cb1c225
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk-imx577-camera.dtso
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/clock/qcom,eliza-cambistmclkcc.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/media/video-interfaces.h>
>> +
>> +&camss {
>> +    status = "okay";
>> +};
>> +
>> +&camss_csiphy0_in_port {
>> +    camss_csiphy0_inep: endpoint {
>> +        data-lanes = <1 2 3 4>;
>> +        remote-endpoint = <&csiphy0_out_ep>;
>> +    };
>> +};
>> +
>> +&cci0 {
>> +    status = "okay";
>> +};
>> +
>> +&cci0_i2c0 {
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    camera@1a {
>> +        compatible = "sony,imx577";
>> +        reg = <0x1a>;
>> +
>> +        reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
>> +        pinctrl-0 = <&cam_mclk0_default &cam0_reset_default>;
>> +        pinctrl-names = "default";
>> +
>> +        clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
>> +        assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK0_CLK>;
>> +        assigned-clock-rates = <24000000>;
>> +
>> +        dovdd-supply = <&vreg_l7b>;
>> +
>> +        port {
>> +            imx577_out_ep: endpoint {
>> +                data-lanes = <1 2 3 4>;
>> +                link-frequencies = /bits/ 64 <600000000>;
>> +                remote-endpoint = <&csiphy0_in_ep>;
>> +            };
>> +        };
>> +    };
>> +};
>> +
>> +&csiphy0 {
>> +    vdda-0p9-supply = <&vreg_l2b>;
>> +    vdda-1p2-supply = <&vreg_l4b>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +&csiphy0_in_port {
>> +    csiphy0_in_ep: endpoint {
>> +        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
>> +        clock-lanes = <0>;
> 
> Here 'clock-lanes' should be dropped, it shall be implied, and I belive
> it is.
> 

You're right, I'll drop it in next version.

Thanks,
Wenmeng

>> +        data-lanes = <1 2 3 4>;
>> +        remote-endpoint = <&imx577_out_ep>;
>> +    };
>> +};
>> +
>> +&csiphy0_out_port {
>> +    csiphy0_out_ep: endpoint {
>> +        remote-endpoint = <&camss_csiphy0_inep>;
>> +    };
>> +};
>> +
>> +&tlmm {
>> +    cam0_reset_default: cam0-reset-default-state {
>> +        pins = "gpio8";
>> +        function = "gpio";
>> +        drive-strength = <2>;
>> +        bias-disable;
>> +    };
>> +};
>>
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 

