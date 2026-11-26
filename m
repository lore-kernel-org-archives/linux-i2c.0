Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660131;
	b=fsd4KZghjphY8546/D9C1/4zkPiATlfwJLzz1IgYdJFR7aukkM5yV86rYqOeeeNimsV6
	 h08M9RGRAt+YQ3/Jq0exSq7UGtBYU1sNqzltAiELlJM3kLzEzd4UCqfp1+oTJzFu+kwk0
	 5km1I0YFICeHxaomksRs61cMLMIHwdDZGlBhrC3slZQTT7Up3LXBg7KAKEeFgorzXw1lM
	 sl3b+kXzclMx6ByFIEXbPECQ/+Ar6uCytvrbf6exoX3eHbCZQ0JtijLE9GC5sCEkEbKWK
	 U3BE1JV2DuJiHYMz4Ux3engx29sXRAqK6QJuV4weftYP1kQPqTbYVM65UrwHKIBCEMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660131;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zQlWzuu7QJmhsVW0s8/560AxfqBLNdrcweWywjJiqHE=;
	b=XzR+eLJYncUz1uyuwl+LV7t+peXQ1FhGY71tE1dQ5Twq7c3tqXkM9j6UZNiaOIjR1Zus
	 WnswhMKeWll9I4uxiNx8g7yW4HeF6Fd3XXxwnwS/1MHdIuWgQjjHuPdVAC9XCf9tV3LnR
	 WprRJ4Wb75OtfUJe2zk4TfFS0PBkaOnYoBCYZSf51QHGhSK0JiVwM5Fh5DlzdvHHoXzqn
	 Ho2XwjBjbCrmzVTGeij88UHBRGhZ9/qPd+cC5ZLUp6Y7BcZEFEZlZW3IU+WJJtVaLO82z
	 /5mIopQ/pxiMpVMR1oaQMTJDYbQVV3ZyxGY6at+SMFvA0Zn7VJ7biRyH+z7oPtocsaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b5ZUNpCw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WTwInxDe;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D2606A327
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 363D2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b5ZUNpCw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WTwInxDe
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ0oOQr1525431
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQlWzuu7QJmhsVW0s8/560AxfqBLNdrcweWywjJiqHE=; b=b5ZUNpCwLRcvGhSI
	I+F+bLu1ujFA6F+MY/9pql9vwLcI/LkMozfcJMEIfavqEEvJr9qsXYOYyLiLie2/
	UF9pcboThdc9aF4g3+pJdm4fTLu9KZJ0pyzOJ573LiyQIDUvh5BhU2GpnOWU8Mdk
	6I72mSQvYqbR8uLyosOvwLrAN9glMlKBKZbgdZhqLk1/Du7Au+887FjXs+coiLnA
	yTBNMlGjV5Nat9RCWoLfl97k+B0nlhfUDkgDMDrcBmay3jhuoMg52mkeC7bQ3JRz
	Y0Xg1Amq+n9s4kDJ19tQJuaNNoDnqAL1wS/PhsNQ1esSpnujQkBNuepI2AsOJhUX
	qRjr0A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak0086v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Nov 2026 02:28:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-920fb8b9859so39360906d6.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 18:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795660129; x=1796264929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zQlWzuu7QJmhsVW0s8/560AxfqBLNdrcweWywjJiqHE=;
        b=WTwInxDev7mnOdveGbw3O4fyvarPol8bov3t9bv/CV7Yxn6f09jmV0Cu6D5FsN4iRk
         S/J5EC9u4QmQm4GOOOpn0LIs86KGsHWdZ2MCeKP2zIfJKe18EdL+p+1OUZlHx7dBkb7K
         wbUrWkuRv38j5HfQ2Y9At6xoqyklmWz95hSYTUjxtifTP7rBqzVxhKMMcFFMrYSNg9QO
         f3xhXoFyE+FbDQZe3sOTckHqnZXKDHVdNW+ihbA6IcPabtDHfWWwVpg9T5SWG5W5o9a9
         90RYbrBwqPmC4kMFnOZHKrJAZFEuBxtcyszIUkcy9whc3cKC7W6LzhMldhjpaZa/yf26
         chtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660129; x=1796264929;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQlWzuu7QJmhsVW0s8/560AxfqBLNdrcweWywjJiqHE=;
        b=T6NaXvYWJ7JHniqMKE2FMcrcWfwze+XB3jZjIZxhorjckksopbd4blFEPKd/n/bIoV
         6VXoC6grPaoaKBe2HEayAwXTo56PFuUibSXt45TXBbBAUZM19dBFWEstfa38S/1j9fSO
         mOfAOYotrdz0DI6mXgPROfqxEiAbLEe4yaT91J3yhqJrmFk6uy9P7wkp4waJsdAOvr8T
         GLQ6hWbE713pHxyjXWhGp/zimxi7avnMMTHNOLr7O61U9S9m1KsvWfHuM3NYhYcpWyu3
         Fj9SqGVNtLzPllV31YtZg5L8l8lDrTf6GPgoiLrunqSVOlor30KAq4eeCs0dcGaK+UjQ
         bH8w==
X-Forwarded-Encrypted: i=1; AL+hErGP/1lnQu/d5cqLsFoFt/s6Ny6VPTKZi3XHAWPcFMpqaW60YhPqhLqjB7uTdQL1oijwlPDx72dsQrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GulgoOITH/nvhKTe8bC8gVLeCLf6660cqRZ1xYKIBhkXG1g+V
	19Ugk3LZIKbaI/BBv3ouTZk+mS7WbAzfizXFd2P+x7ZVsrbdx4EhaJdnomtpuCAaAbAkuTZ/EPy
	2lWGg9PqqdutNHRrftEm59eXs2kV2g1yf62Tj4Jo17b3WSe8C+amalEL0Of7lBaU=
X-Gm-Gg: AZFdTZfm9nci435qz3Z+6wHJ4FI85q9HcpFNJj8QHxs1ZiTq5d6d2QK/bQSuIb4isaO
	YIJBra/YWMCzfoBK4zc4ecM/sRfP7hG4PI0a1Q2xowDdfPuTqmSLYpyMEEY/2sQrSCOgvcYvgLL
	l3Sf1TAa6JYEbtmTsnjsCMsAKK2ktfUVPq0RV9qIxONSs4ZeUOh+tQbnPYHIbrhrwk44H5Fi966
	ukK9Clfp/FEfDOX0r8xoWxFeFJg7lqFzeFxbVgUcP59AIzaCNfNfMHm4C8twK+BsrRAlCAFurmk
	zdCzFC/I/rYjrhuzAOnIIAu/+Zfak8+GN3PNnk82VYYkPWP7KOSMqRcM3AG/Axq91e1rG2qiQ26
	MS5HaYCkzHsLHp1xvq8ALW5FVjuCB+CZuk9sizChmXUWzj89aHbXzQfFPJLQoQQ8E460f2lgqH3
	8PNnJrp0v1nKYrwPkk6jz2ajk5llcoYMyI+aM=
X-Received: by 2002:a05:6214:3ca0:b0:921:7875:29ac with SMTP id 6a1803df08f44-921787529c5mr86599786d6.12.1795660129136;
        Wed, 25 Nov 2026 18:28:49 -0800 (PST)
X-Received: by 2002:a05:6214:3ca0:b0:921:7875:29ac with SMTP id 6a1803df08f44-921787529c5mr86599566d6.12.1795660128716;
        Wed, 25 Nov 2026 18:28:48 -0800 (PST)
Received: from [10.38.247.193] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d383asm177102666d6.22.2026.11.25.18.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 18:28:48 -0800 (PST)
Message-ID: <ff007bf8-09ea-4b70-8475-7a97ebdca755@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:28:39 +0800
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
Subject: Re: [PATCH v7 17/23] arm64: dts: qcom: sm8750-qrd: Enable S5KJN1
 camera sensor
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
 <20261114-add-support-for-camss-on-sm8750-v7-17-8ff2a11835f6@oss.qualcomm.com>
 <c4c72389-2a8e-4278-8667-cdd4d8f72225@linaro.org>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <c4c72389-2a8e-4278-8667-cdd4d8f72225@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b079961 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=j4L9U9e7tDSPgzuknP8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LlRpwij_gqz_hmLeOnUp7gf7vdXdh031
X-Proofpoint-GUID: LlRpwij_gqz_hmLeOnUp7gf7vdXdh031
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX6gD844DRubOB
 xuOGxtOWCpswkWZNdTC+BWtTEjbFGvUZw63ZJferUV9HsbSwH9ydu9/MvcAMcdZbuT0LTcMMAhR
 019RYqIAGVBVhUV4hd/lO/rx3uu0d2z4gfcAhgmqVD17w+UDG8PrAQ83gMpOIvoEQdQhi/DAEns
 FhLOwegr4SP25etYb7Ba3UjhhDqtntayBIDi08cAkLpzNVrPL5QQ8+nhn3/k5QlwvxijU7Tzsu5
 nau5+Yt4pPkobEAY9sm0UdpBXVI1Y5z83g8VdnkN6RaS+iBoCbViECSgsp31qbUsUk+3c0mO1QF
 BKbsqSxhV1i6ZMOu3vZTlf9H+xo2nYwpkJ3GCjwIDPvIq66JYKc7ELx3gwIDrrPK/mQsinI24ej
 BOoslAMPhUcu1hbz0eHIVwXYofLxLQVRCFezr9mVDm6bKj2X450bvlzD9XR+YGt531nRQmBQugb
 NAeINX3rDvy26IyFa/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwOCBTYWx0ZWRfX5ACqgFUZd5Pg
 GTK1ruWikTHVrcafrGNAhxJBdZFiIP9YVRDu32+z1hAJFdRWlJqGLm8cdRd81zEc8oRSew1fXtH
 ZN6vIEx8C3kC/qHhlsONjQNGEpjE/9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260008

Hi Vladimir,

On 11/25/2026 9:19 PM, Vladimir Zapolskiy wrote:
> Hi Wenmeng.
> 
> On 11/14/26 13:29, Wenmeng Liu wrote:
>> Enable CAMSS, CCI1 and CSIPHY3 on the SM8750 QRD board. The S5KJN1
>> camera sensor is connected to CCI1 I2C bus 0, uses MCLK3 at 24 MHz and
>> connects to CSIPHY3 over a 4-lane D-PHY link.
>>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 72 +++++++++++++++++++++++ 
>> ++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/ 
>> boot/dts/qcom/sm8750-qrd.dts
>> index 
>> 75927e1f7b9ab0316781c64dbcc82d3394c414f6..c92a1f3c47bd5cbae26854614682c3bc7daa0398 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> @@ -7,6 +7,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/leds/common.h>
>> +#include <dt-bindings/media/video-interfaces.h>
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>   #include "sm8750.dtsi"
>>   #include "pm8010.dtsi"
>> @@ -858,6 +859,70 @@ vreg_l7n_3p3: ldo7 {
>>       };
>>   };
>> +&camss {
>> +    status = "okay";
>> +};
>> +
>> +&camss_csiphy3_in_port {
>> +    camss_csiphy3_inep: endpoint {
>> +        data-lanes = <1 2 3 4>;
>> +        remote-endpoint = <&csiphy3_out_ep>;
>> +    };
>> +};
>> +
>> +&cci1 {
>> +    status = "okay";
>> +};
>> +
>> +&cci1_i2c0 {
>> +    camera@56 {
>> +        compatible = "samsung,s5kjn1";
>> +        reg = <0x56>;
>> +
>> +        reset-gpios = <&tlmm 109 GPIO_ACTIVE_LOW>;
>> +        pinctrl-0 = <&cam_mclk3_default &cam3_reset_default>;
>> +        pinctrl-names = "default";
>> +
>> +        clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK3_CLK>;
>> +        assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK3_CLK>;
>> +        assigned-clock-rates = <24000000>;
>> +
>> +        vdda-supply = <&vreg_l4m_2p8>;
>> +        vddd-supply = <&vreg_l2m_1p056>;
>> +        vddio-supply = <&vreg_l5m_1p8>;
>> +
>> +        port {
>> +            s5kjn1_out_ep: endpoint {
>> +                data-lanes = <1 2 3 4>;
> 
> 'data-lanes' property can be removed from here.
> 

I'd prefer to keep data-lanes here, as it describes the actual 4-lane 
D-PHY wiring rather than relying on the driver default. It's also 
consistent with qcm6490-fairphone-fp5.dts and keeps the DT unambiguous 
if other lane configurations are supported in the future.

Thanks,
Wenmeng

>> +                link-frequencies = /bits/ 64 <700000000>;
>> +                remote-endpoint = <&csiphy3_in_ep>;
>> +            };
>> +        };
>> +    };
>> +};
>> +
>> +&csiphy3 {
>> +    vdda-0p9-supply = <&vreg_l1f_0p88>;
>> +    vdda-1p2-supply = <&vreg_l3g_1p2>;
>> +
>> +    status = "okay";
>> +};
>> +
>> +&csiphy3_in_port {
>> +    csiphy3_in_ep: endpoint {
>> +        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
>> +        clock-lanes = <0>;
>> +        data-lanes = <1 2 3 4>;
>> +        remote-endpoint = <&s5kjn1_out_ep>;
>> +    };
>> +};
>> +
>> +&csiphy3_out_port {
>> +    csiphy3_out_ep: endpoint {
>> +        remote-endpoint = <&camss_csiphy3_inep>;
>> +    };
>> +};
>> +
>>   &gpu {
>>       status = "okay";
>>   };
>> @@ -1081,6 +1146,13 @@ &tlmm {
>>       /* reserved for secure world */
>>       gpio-reserved-ranges = <36 4>, <74 1>;
>> +    cam3_reset_default: cam3-reset-default-state {
>> +        pins = "gpio109";
>> +        function = "gpio";
>> +        drive-strength = <2>;
>> +        bias-disable;
>> +    };
>> +
>>       sdc2_card_det_n: sd-card-det-n-state {
>>           pins = "gpio55";
>>           function = "gpio";
>>
> 
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> 

