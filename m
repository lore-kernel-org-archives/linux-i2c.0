Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBB569F1A
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097628; cv=none; b=lS+1noY8vV7drC+n5ddnJzzBRHsCa6xkY28g0amQUciSxmbB/bDRa5eNYQPG91SQz8CDjGidNZrNmEWYoYK2UVY/mYuCHbQppIF/k590qd9VDKCihckrI2ukesGveReZnHRpdh65X3LjIk0BmDF9pEgfDxiIp95fBd8VLOsl7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097628; c=relaxed/simple;
	bh=ZgSvG6kKG9iSmJMEuAW3BWVeHh9wVylo4E2yoG96D7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPHUnUm1J9U8hq/Ez+/+JZdnOt6qnnZJe3SqepHFKRLGIHaH5PQJmjgYP4T/WbCvbdn7IhG4tz7OV7TojT289fQaI62Rn63E4ILmfJzBXvTrSLMk17TcWCB/rI1jEncUT6UjX+9B+N89CXvoFrHYPGtSpLHJEeA2rbRm4Fnu6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLH/+QUr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btmye8Ng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLH/+QUr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btmye8Ng"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MEjM9b3307554
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 17:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oHqvINvN9nNOcc9oXioULCP99cwRQ6NA5NU863Z+Bug=; b=aLH/+QUrcKEdduB1
	g8hbwD/QG3Lz6Kv7wEz87IGYoHZhTkAbB+/26So2s4RjiWefqzBQ8ViVSPuVHA+X
	D96kFcu/jpSnnrhxwl37TbM/ebJsDd0HVHzNDafxcwS7wFd95Q2LRCOYzYr6pcro
	6ECt0jJZZSIf+t2R2J8+tJY6jJB2Sqly0Zycd2EFNzVbKhsqdy/oy+TL++8Gluev
	fedAW/8OoClqepQgz5usalXYgcRRulEOLllXxid86JjbG0rmHNsllFjzMQ9R1IsR
	6NK0wU4G1Px7lqTyZjqH96UXE1vMloDa5dcNEK3v131c79bjfkiXemDUqbKjbio1
	2dsWIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj113f3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 17:20:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8696b921ac0so141938b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790097625; x=1790702425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oHqvINvN9nNOcc9oXioULCP99cwRQ6NA5NU863Z+Bug=;
        b=btmye8NgKa5uy9RvFU6Y+kq9WYU/wrOXXzITZ0fXLq4P0GWfZfsVfvxyBTb2d4olb4
         WVkhH5wBky+Na1FluOeAzpd22yV5BNCUdj7i3z1Qu822+gwfIspxbjxC+fIaTndvxlhJ
         e+quch9fAuQwApx/Y1F7+XNzoRz8SBbeCdL7TJR0rMC/ZuNLgdAaDBBENK2LIIPdROs9
         Y+dEyjoKfBLoH0FeyYRyCRahT0GhBa6jen/JkG4mvFF54xIJDi0nT1UVrreypxuruNXb
         HIubUJcU8NjjhymdBBcsFXGmVLdx4ptYAeIGF3JlVYewywJkqwvfTZBizDZOWvBufFpi
         2jFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097625; x=1790702425;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oHqvINvN9nNOcc9oXioULCP99cwRQ6NA5NU863Z+Bug=;
        b=DIGFMnKNRxClBKzGq2A2zYvskdzCEyMI87PGOpdUOWxr7FRlPRej/9wUZr9z+zfd9h
         wyyIYG7zt54YC0Hci6pXBDhsiVeEHVuETy/tfgcESPnMl7X82aEeBhr36zEV2F9LqEXZ
         633Zq/A+3GgT1wmB3/cBCGlxI3dUC6fVefVNKy5dtKU3yHFenYFP7eda36Lpks4FIyt4
         +T/SUfxRWf8A4CybguSZIVrOLhEGRle4mD4TYKn2bhmMp0C864N0UkjXD8SyB14vFHp6
         cNt2zA3+P05JTUpIuQFAdkXEiwT9MhF8hk7VkAhNCvSwgspnEAVZvdsqrOzi+eVA+W5o
         t3pQ==
X-Forwarded-Encrypted: i=1; AKwUvBweZ1FXXh3V43QrMm3kcPELOYTtWnTGh6jDDKXiIrirbgO8whuDu24dnCm/5po8MIub2TSPX3RFbOg=@vger.kernel.org
X-Gm-Message-State: AFuF++mo73V4lEnGa1HjBf6+ifGZsz16wziNJqkS4vSj/RUR5wJjAfgF
	AEZKBODYwaA40DP9v7uG5+639xv/b0S0aqE4PB6Pl80JQZBf1ODd3G6bpfxtYFOD/1SES2e915i
	s2tAtneWfHy88cD7beG00tTKMmhVH8rjn75yQX78zE3NEkj8Tm5xugteyXcDzsXM=
X-Gm-Gg: AYBFou18ChRyLrfTjAQN5RuePOjyQs3eHHxcBrWpR07NWuOsiaNXT9x2Wgix6rg7oaw
	euWp+qidP+ymeajHfAHOee0O4rEN0xjm8l2BrRNJMkH6VhMyAil4cisevI9FGb11jsFaiAqYmez
	mMyixbrTjpIk1ejgERzv7pkcBFKqK60LURdOei1TbcAjm+mrXf5xxx3TgC7wV2W+0e2ZWLJnvqV
	JLjVjqAYxRgOnHAvXcRI6oMnaIe9pYUOay6ecLT5XjU+A5fa27momdi3DVzJqvqM5FSwj1EPz1e
	BEC1CCGmrBhnWN52TfPvyi4kJdErb3lQSP2zn+9us1TreVdh9doJ84X0G1a82o/UIOB8E2pacYx
	V9trLlWbcYEBK3Jri0mnIHES9+9GSeg==
X-Received: by 2002:a05:6a20:3d95:b0:3dd:a006:ed90 with SMTP id adf61e73a8af0-3ddf8278bdamr129797637.38.1790097625353;
        Tue, 22 Sep 2026 10:20:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d95:b0:3dd:a006:ed90 with SMTP id adf61e73a8af0-3ddf8278bdamr129761637.38.1790097624786;
        Tue, 22 Sep 2026 10:20:24 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.227.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a1d386sm1295837a12.10.2026.09.22.10.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 10:20:23 -0700 (PDT)
Message-ID: <39ac1f45-057f-418f-bfce-917d968eb495@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 22:50:13 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] arm64: dts: qcom:
 shikra-cqm-cqs-evk-imx577-camera: Add DT overlay for Shikra
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-4-9b9596221cfa@oss.qualcomm.com>
 <ff798c31-48ef-4882-8ca7-5b4c8bdcf9a0@oss.qualcomm.com>
Content-Language: en-US
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
In-Reply-To: <ff798c31-48ef-4882-8ca7-5b4c8bdcf9a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nTjxNQxVABoHreks2Oxg_prToQDac1yB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1NCBTYWx0ZWRfX1Uw+KHiJyaWH
 DoVzoFzCJ9CzQzxsTKGzqpiB6+qkCUEjWQWsvRnPzao9U/wHr1xoaY7aEA/1FTOhEB/wO82i3FX
 A7NwSFlW6u8Hweyj0+hhgbHmiU5jex8=
X-Proofpoint-ORIG-GUID: nTjxNQxVABoHreks2Oxg_prToQDac1yB
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab2b8da cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ISK6p04Y8w1qFYbiysbuaQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=sGt-zapad3vFaLHLuqkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1NCBTYWx0ZWRfXwqSxJbJ6itcZ
 4umHdZvrM3T+AAPOMZkvJq7DIMTY87FK0C2M8RhpW6K5bHRsr8Z53qVsUcD1ITB7DBZgNVZFz6n
 XjgG8gdwz7W0MAmVzUJtfHtPBhsEW26xEpmk5WWI8KrkQXVp+Czt7tL/WgjpUJ5Mpj8Y1Q1NSGD
 37A/wCTJTTrdInhVJVck2FCy5hO7OL1cvUn3a/4/bJFrnkMI4Ks37IB5eJ78Hi+tXCus2Dsi4kk
 0n3d0hRmE3jAt99vZYg3iXoCWX1cbnk7RRRsXpLvjsW/Dw403uD8otp4gwDpTHpXnbzZG1qTcOI
 /YYNnvEcblIyew+FyJkj50WAOgBDmGorx6g95EH+A8yENK73tB8Ctl0hCm0c3HqDMgubCWUHCxq
 f6TXvQc3vCYVR1VNFlbM7pYAX/G6IBty8ge2v42rRANCQqymJHGeV0l5UC/kc8Fh/SHXMqKF0qz
 PI7/Bs8/APrn8BL3BcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220254



On 22-09-2026 21:23, Konrad Dybcio wrote:
>> <&imx577_ep1>;
>> +			};
> Please realign this vs the hamoa series - define a port in the SoC
> DTSI and reference it here
> 
> https://lore.kernel.org/linux-arm-msm/20260917-x1e-camss-csi2-phy-dtsi-v7-6-1a63eb35838b@linaro.org/
ACK

---
Regards,
Nihal Kumar Gupta
