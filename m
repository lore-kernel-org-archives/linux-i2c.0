Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BA6380FFB
	for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722756; cv=none; b=sVByoJoWe5F5LmC+OlYMeDGfwNjZrxz6dE14mF0im2xaJswvdjG+xolpx3ENIpOgBhja6e74Vq9JpWDmyL3r9PQVOsA3++0Z3Jv7D1Dg2lU47TROchKJZz3oEUTM57INwFZxDm812zE3AnTITGRR10H8eA6RltLkASci4Xbd0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722756; c=relaxed/simple;
	bh=dqNLkYWW3gpedw8yQO06Nn2TvNDxzw6IotmjZsfjq4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZKJMOeAFkAANsTya8tCpXcVQUfjxOeE0x8t1ZlPFK0gowGUpy+b0169j3f3cB/WxnUyKmsjEpHzQMYRtebCJ/MnBn60IAjymFsObcvuXd8T57jQFegWmu0CiixbPBIyiSJZO6UXMZY2zJVLBScrDf75J1bsECrn9hRg1bvmscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCVq0oo8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CXZm6+iK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCVq0oo8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CXZm6+iK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xpCS910730
	for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 09:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=; b=UCVq0oo8hh3zpuNN
	YkqNqbz3333d1T73kirv80Sdf81VJxW51udbIcADdlqdimOPwFrBroXRMNZmCa76
	kAeBZfibEQL0ApMCmDR5Yli8Eb+1FTGBUYooe/kIfRqwteQSs/Q9Kkw/lOQPmJcC
	P3C8IMJkP61fVh4FHZ2v/Dm7Wj+kidskCGgUH9uRCWb5JOlb7RmHS3xb+JwgGWeI
	Gp1UtYJuSXW/GoRn0ybRNCpk0pyvklL31mHpqb48WnvgoievVWUZysFa0eqKW9nD
	JzzYetzT3VYrkLgMM2DHhuCBz2nVo11zppWkJAlEXh3mCCNygH+p1RyoFvOwI4V3
	gMIuqQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grtdpswmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 09:12:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9394ad7f64aso74603085a.3
        for <linux-i2c@vger.kernel.org>; Fri, 18 Sep 2026 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789722753; x=1790327553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=;
        b=CXZm6+iKFUl+TDKQmvTF03XLC+tqEHyFbdUs8DsQtC8MSs7+xL5OZ/K9G/heFHiUWX
         oQXaCG9nNVt2rIoYlOW0tkGZTbNFomAszQiYfm+Tj9/+JB56xfKb2A9nc8EMD647booF
         68RU8CIZ2TtaSQ03T0/UXZKy7PGgiTcJYOJq3lWWuspLlpIGvSRnnte6CdJXPREGfWqp
         4npQ4h4G+tvMVppnC9mk7wuRC0N9BG9Vmil1rsPIUDntTLAjrm8cJjsCosAGwQx3Mury
         +5sxbPZuCT3ttuxXNgqrmIpjZFQ0hpw1lR59cv25tMCTPo1xVkTYWePP5At16cAvBGgc
         ZTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722753; x=1790327553;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KWbZAe8YVsxv2ruoBpbVgqJH0J7SyBNe9cK8WaU73A=;
        b=HvMd80uVFN/a5pUrC3w1dSzvigsCSyIKCvdtYRQNiU5APW2kYFtehS/9vHwcULB1a0
         ElNp8QiWIC93RzRB5oe7PX/blFJdwaO9NhiUGvxBr/Th0FZVT1JLYGhc5eTw7aO/UikC
         IpICrdz5gA6ABJFLi6s4iXdbOF8MEJYNEHAXQNoAAE9qQ4Bh5ItCZCvfZcAfcZS2B3ZL
         Z8lEbFH/DQdksFhqdNge66o3FUV9VY16mHhrd/O+03AmVtZ1A0DqI7gzUNoYBjvz/ziN
         gIEBvfEtt8CQ77CaGSMI8Xhwb0Z7dv1GpY2kLjpgIo9eFVUm+IqBMp50a7VIFAd55P92
         2epw==
X-Forwarded-Encrypted: i=1; AKwUvBzl00Q2DrakZz+leMBCe5LWRAmkgHIfKHWef6Tm1OWenNG+u5nAaogy5AT03ellyP3Gdb62X8Z2GSM=@vger.kernel.org
X-Gm-Message-State: AFuF++kXcZ78lwf80riJcyy/89yLR+ynvzw4absXiilWipYDrbiYvFHo
	pbI9iPNi03LoQGeM/9Zj85yznpG/m2Zq7Ki5B4IOXtLhV5E7ow+mB/xAdFYAknkkX8YsIpbkpWW
	r1ogoT1tQ05wV4ybm8Vi7pz0gZyAJ0twrd9Yx7Rg1dXh7Llc+L5QdVYJpA6mO/EI=
X-Gm-Gg: AYBFou1hwqhQPmeGYG8sXVAkSLlDQXPdEY0TC5cyfSE1EFm0s36yecx+wzRAkfL8jCT
	eRmKSXMye46QfbDhal6fb8oHKciQPemPjyZtyFRpOgecjK3juAL1xmz2zQTVGFjpm4QcdMLlEIr
	cSvNk6Hf0L7GZdi62nAWhu8Sq7dk1W37WVNitWMOUNx67PAHTOP4oVBes/dTS4UbAkOC3//QBNW
	3E51KfygO5uaBIQ3JABaj0BqLVtyW2krFYO81klEKRLETqkq+3ZOlIh64QfIgWe7S0U7S7ra2pH
	R6TjQ48vkCySxrAdtzsDXLWR82oWb8PQL7wYliEcftEHGObIuQamz7HNhZOl2hTOySLafVWJzha
	aI7rcod7IwA/MrrA/dfG1qOz4R8T4CKblg3ihoGCHVFMyNOmDNptacsvaRucidys=
X-Received: by 2002:a05:620a:6010:b0:939:f513:cc3b with SMTP id af79cd13be357-93bdca3b239mr216696185a.42.1789722752756;
        Fri, 18 Sep 2026 02:12:32 -0700 (PDT)
X-Received: by 2002:a05:620a:6010:b0:939:f513:cc3b with SMTP id af79cd13be357-93bdca3b239mr216692185a.42.1789722752340;
        Fri, 18 Sep 2026 02:12:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:82ae:cd75:d970:e66f? ([2a05:6e02:1041:c10:82ae:cd75:d970:e66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc58a1176sm31018885e9.2.2026.09.18.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:12:31 -0700 (PDT)
Message-ID: <45768828-d0a7-40c1-8eec-3a1fb2d66a71@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 11:12:29 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
To: linux-kernel-dev@aliel.fr, Neil Armstrong <neil.armstrong@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Beniamino Galvani <b.galvani@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mfd@lists.linux.dev
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
 <20260917-add-mcu-fan-khadas-vim4-v12-4-497cd543a148@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-4-497cd543a148@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfX54FoE0X+bzs7
 dFLfuGZfeE9x7bP89suHGdmmyXgLpAEiwF2UUh4JjTdB4ko7B2x4MEAigMrActhnhVnTlk6cQrk
 BX8IeYl3yUF61DhzL1RkIoUbWBpfPoAcVvIADROqwkpwbTV2B3++iG4QC02i9+GdiENt8gBvv9B
 3IqiwutjhyR2ZVESG8R1yNTxl3q75YRSgTah8Wsx5WZo49w8u6/c+8rB+skievX6hegF/u2B+Eg
 Up/jw68A+/uNfeGbBIyvDBPad7XfYL6+7vAv4J11y6oWeaPlamFEiYKOGGYDa3sESEts4Jr63np
 hX1BadAs41Z6FfPwoMeGQEwzDawFkodv6MxCCIFhlhxn9gvawz1PjaucyQUGixby/jl3w+me2rx
 1YhhnqwrSIfJquS1bWoVsb97CJbc29uHlf85JxiPW9XVwhXL5u6Tbn0c0GfbCENOdws3hKBHc31
 Wzenj73a2OWEMxqscYA==
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6aad0082 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=YaFGZCiNkOP6CsGDcAoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfX3/d8PNqd97Q3
 gotnM4grMWT9Wtir0C3dTPCEinFgeBjrF6r0VCx/W3yDeD0R3Os5NzDucey9j2rMyHiY08TxoWR
 5h5gNyacHYjeTshYlnks8M10lIjS8d4=
X-Proofpoint-ORIG-GUID: t8SZIo20SE0XT2INr7f5ZVEWR2vwPuqP
X-Proofpoint-GUID: t8SZIo20SE0XT2INr7f5ZVEWR2vwPuqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180126

On 9/17/26 09:59, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Introduce platform name, control register and duty-cycle
> levels per variant.
> VIM4 uses a different register and level set (0-100)
>   declared as a list (0, 30, 40, 55, 75, 100) compared
>   to previous boards (0-3).
> 
> MAX_LEVEL is kept and bumped from 3 to 5 to make
> the speed change more gradual with the newer MCUs.
> 
> The cooling device's state is stored as an index into levels[],
> and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
> rather than writing the raw state value as before.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> The regulator is released via a devm_add_action_or_reset()
> callback.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
