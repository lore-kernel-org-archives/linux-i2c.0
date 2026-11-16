Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796700;
	b=ECmssdI4idwurwWRecCFPuQla+XhI+qfaI94Pm2/v9XKv0RgHoYRFSazxuGe+XZ7UFxJ
	 el+jL92X7uEDOzS/PccakZvuWNn3vr6iWGr33OnMFnveaWXWeMV2RE2TymDh6U4C/uGXy
	 kNAj2fkIMr45wBcYN7LbTd0wVmumsnoeMFMRb+a14fUHGuTS3o0a5vj1QEh+LJhQUTklY
	 SEFyUyjoz7EiiVw3YJNCWkmp9oOHTlbCrzmsDzusHh2rAEy3UM+5twQ36Z0Mgjov00WF8
	 7pAPXH5sWNCZRjQ1mom/+QZevIuu49eeNucpRGE0wvT4pH2fhxQMITHmg7V2VQVwffg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796700;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TPjyQUk+vMBvodq2mBZyZe6FH5D4rzEe4fEpLwevuWA=;
	b=bzO6dFls6kb2AdsDoCcEeFGbWzpm5/UCt4YjuGO/dcfARffHr9VxFOVFgFtPrQ2KmEcg
	 XvMiBa6J82gmvzSeAFQNFKhxtLpNY6OWa9JYfUX/e5O8FpvW4p+XMhTQkm9FbO+bYiNAR
	 I1X4MkkoUSibr6eC80RKqSNvJxarcFhjfSH4gfEOr0gD+KsgByDexhyWCgNfjzMshMzfR
	 4Xb6ocZJZ/MVnHiSgw+Qx3Is+tqo0kTJXlXjLgFFMCQIuVRkt4O8QDHrGmtGX6bJNeMBI
	 sLSUAkb+o4nvD96Lfu2dzf6W4amL3pNbHOxMucPikuDDChkzbm8Uo9E+6qTu5jjLr5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJrJOScF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L2MJ+PvC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0309F606A323
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0309F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJrJOScF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L2MJ+PvC
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG1KvQu3890758
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TPjyQUk+vMBvodq2mBZyZe6FH5D4rzEe4fEpLwevuWA=; b=WJrJOScFWbmhsj6y
	AXFvn9SBm43IzYWGZMwIAmxaGxjIXxdlt9wkxfaTSbQ7E07Q0BxLROlUAfuguA80
	EmRTzEg/vKjuBQwh6zpA3hekDlZWsN4v97sul0/C/d3k+hiHtr6ZpjPb5W7rnR9h
	cnJr2qP0IUs0zf5SZEytlzqfqrfUp5LKlRQXplO16NMFIyoV72mI7tBcyJ+9Kzsh
	XCez1LSHjOKwOQr/TscCiudCBtJdt903ne639VG+gBHMZ4Z2RAuB4fmBINzLHpvQ
	ivVLHIJWMnuTCc+nVuR4SNNNoosywSJYae8TVupwaAtor8SM22VnlQjRgUUtsf+1
	OH+qUw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqmhhv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 02:38:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-944138ed63fso470108685a.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2026 18:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794796698; x=1795401498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TPjyQUk+vMBvodq2mBZyZe6FH5D4rzEe4fEpLwevuWA=;
        b=L2MJ+PvCZq5kFb18qBpX7JTf0iQ8hVlYPEUP3yAq2FqFXfkLwDPiclDCRp6/QN6zhv
         ZEUK0xDimgat9/EIfD91bkycRHWIboTNAspoit94Oyrb3aWc3UTfVXQvZ623C4ywwLCr
         Q+ESN0ac8BwAafWDY6zl+TUr0PZ3Bz7FcGjs2yi6WnYGyzvMi0OMa3K3XP8SCv2MctlS
         yyGmsPxn3HBJVR90AvfjECN9HgIooxR2mqDHg1JORqCX3z3s1RNFP8XTNjIr1Bkvqk4z
         B3c4IXsVnuHIMiU2K256jDt6IRChLUxFFD0Edjxi/RHx3SnNN3oVsh60CY9jfpXzfD/J
         VL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794796698; x=1795401498;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TPjyQUk+vMBvodq2mBZyZe6FH5D4rzEe4fEpLwevuWA=;
        b=UZKlIzYJLoLyZVL4k2OTPS9thUr45MT3BQNXopvMJjgwidXaU6AXAL0rbN6DGFwV7e
         Kngxas202l07kVFNELWSDvmdXyeQtLzDiKomxk0/S4AUQjdYeBZVRmoE0stOfAUUZZN6
         V8f2mp9MkYtYTOEkjKXuDlx23miXpAiw90/vtPHRP3ZZ2sos3TLasW/5tAUwWNgVHIGp
         ndVjdMEbh15grnRrzRjBYsI2w5YpFW/P66SQSuum6NRJNqCCVWdEpk/7f5rHh5iWZZRE
         pWEuDNgQ2/sGJW6TG3AGKgBe6hagf8HUC2HC8c9lp+FxTia1dz8kyzgVFap+dDYnJ6z2
         XJlg==
X-Forwarded-Encrypted: i=1; AL+hErFTZPvvfv8nnwXELOn7RLZRHNokmwfD3Ga+8KhPGs/7Jx98/sMpK5VZFPZIjBgG0uS/xdLUzKAkizw=@vger.kernel.org
X-Gm-Message-State: APuU4Z974+w9zXxAO5136PC9JWoFK0R8SP+DLeeobJDrLGmGCvxxXo2a
	8Vvj+K3Ij9VBkPZoBuc2ECxJG30gnGhhDDipF16hXv6oxHunfOVM6zFQvs6GywgcJvmoyucDgCG
	1beeSVLdvFuC4cDGN2QI5OYl/7qed62fEk4CKy1pOhoODqtwekxMHn/GZ3AKCtrg=
X-Gm-Gg: AYBFou0o5Hqupv4HzROCa/79HT5TrQcSV8dgV99iLBWzv7zXkSqdrReTuU61Qfdc+cF
	HlZ01YpdRtv7rnd+UEUaF6GEGpIlUb3xCa7Woi5wm3NyC35hrvo+IVIaZogtBgxcH/3A15q3LLZ
	QU63krivM8DyjaShyykIwl+IDpTF/ydbJIR1q2XcXeuLgtKiRpxjYrD40mjy8ixXoHYg2dnj2sq
	wjKL73fdv6DYdGntI9MwrR4E4zUCNkgsGt4FFHmf6k1JWfLudha2D8PzBv7KCIQp5ffHV04HuuD
	T4k/6ExquvedIykEO2ac7LVMRzcpms+wUxskAlaEp6QR0NikyAql0Fc7jAp/VXv+DQok8Ywy/IY
	DF1mppk9VuL6SkFz0YcVMICAk5eiorrr5zowc3T1Z5MOJcrAwVeV5W0rbaoonlJeonghraCsKRl
	PhpkIHhZN8Hut4lyHLQvfFkPjOihePR/6hLw==
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id af79cd13be357-94975020921mr471817585a.56.1794796698207;
        Sun, 15 Nov 2026 18:38:18 -0800 (PST)
X-Received: by 2002:a05:620a:370e:b0:949:7502:6a8 with SMTP id af79cd13be357-94975020921mr471814785a.56.1794796697746;
        Sun, 15 Nov 2026 18:38:17 -0800 (PST)
Received: from [10.38.240.54] (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9497a4f1bccsm186560185a.36.2026.11.15.18.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 18:38:16 -0800 (PST)
Message-ID: <d784b5e9-af98-40a2-8670-6c12208983dd@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:38:07 +0800
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
Subject: Re: [PATCH v7 01/23] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add
 SM8750 CSI2 PHY
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
 <20261114-add-support-for-camss-on-sm8750-v7-1-8ff2a11835f6@oss.qualcomm.com>
 <20261114-voracious-capable-guan-99cacf@quoll>
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
In-Reply-To: <20261114-voracious-capable-guan-99cacf@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KelHIgYD c=1 sm=1 tr=0 ts=6afa6c9a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4xkCrKK1q9XhPcYNJToA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAxMCBTYWx0ZWRfX7u89F72JX2fb
 g610Q1XG8x1Ka7mmc7yOG3cyDTIefEgsBRG2G35wjW1rKpGCp0rs7vfKQ3IlsiJSsgc9CupHJeE
 Chie2TK6wT2mUaWj9ZMt3cMgMwxQKi4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAxMCBTYWx0ZWRfX53OGxnf5/nnk
 eNFpD1bMLwQtNQNYHvM8oJkFlkrGN9GIKfpKve8e6jNhWHFZYL0YhhWB8l6koQD9tFxqz2e6Cqt
 lQYTXVLrTRtxd7uKjygvz/H4NsCCVGCkxw6xQB412ZGu+XKuNs5HfwzOFeKou5PE8/QclbKFK/0
 fMQ80XiPWYO0xGv91123ujhsmPQ3UMF6JiBbAwmdouBQj8lTHhsHVbpuX+jbGrvLUpRadeQzHHQ
 x0SyL9z2JWDFqXPKSMlC7yB+Jxi0jydK4PgTzC3MKS+JWsy32hcc6+vGZH6aCriPzRujUdC/LNe
 I9UPEknCeQvBRqFHVCQKPuBH1vzkQLZwOcB0wmVUs5Y6Qjol/LXlzzD0RCLS1kSLe7JxpVRakG3
 iGFjsQb91lPheHBeoV0evbHwmIPxrmsfweKX6qXcrDcab3Xzk2u6FGu6x6yzpzlCegslns8gC2c
 VfMLb9R/1zXpzZgFNIA==
X-Proofpoint-GUID: g7iYVevYLxafPWwqzS3q7gMXPURorg8S
X-Proofpoint-ORIG-GUID: g7iYVevYLxafPWwqzS3q7gMXPURorg8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160010

Hi Krzysztof,

On 11/15/2026 2:11 AM, Krzysztof Kozlowski wrote:
> On Sat, Nov 14, 2026 at 07:29:18PM +0800, Wenmeng Liu wrote:
>> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>>
>> The SM8750 camera subsystem has six CSI2 D-PHY blocks. Describe them
>> with a standalone "qcom,sm8750-csi2-phy" compatible, so the CAMSS
>> binding can instantiate the CSIPHY nodes as separate phy devices.
>>
>> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
>> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>> ---
>>   Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Does not apply, so should be squashed with dependency. Why having it
> separate?

Since Bryan is about to apply the dependent bindings and driver changes, 
I kept them separate rather than squashing them into this series. I'll 
rebase this series once the KNP series has been applied.

Thanks,
Wenmeng

> 
> Best regards,
> Krzysztof



