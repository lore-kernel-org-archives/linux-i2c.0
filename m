Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21231E846
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236200; cv=none; b=umBcbAbnWXZqGAOzGvfPb2GGki1tiXIrNrrR4kMyYquhOKZ+AKYulG7PLYNdWD1gxIw8n/e2Bryh8z47zKwBOyCcfVoS+0CgiKxZkw/Txj6SRPSyHxOlhGg1lJOctFcMiw/6x6e82GcfcouQLXciVzR7+ygOY5NAxyJ3BxbHNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236200; c=relaxed/simple;
	bh=IL5+CLEp0JTXBwWQDuoOZRJTYGpyVj8TwdziVEK6VzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxF1C0b7dIkrezGpLPwsNb8MOeEW0IsKQS+TlOonOfN4hycd7bVcQjGgptFjfVCdsJtmURosFSX+sipZa1ynnD9n4ynY1KKp+Yd9TDd7j5XJCWYLQ0jvsB8lJ0gOh72e4UbPoQXZ8bn+yrhfwwG0Dzcf/4wwNNTMp+qDArHUEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bK+PGpr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bi3a7QBW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bK+PGpr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bi3a7QBW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9Yx1T2179278
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KGqJp1HesjofSgFAEM+eYixHKEeYxMvdRZNezmTz1AY=; b=bK+PGpr/DQYgNlH/
	uTlQyduliYkNNp558wd0ZgwtaxSUByGiX+R+uGwV7yQB2mP2MgatumCUtj7dHdBw
	Pwn5A8/EI/5o/H0DK3+ZtpW5W+J5UljzxX62aWsV75yhNX3Ma7ATw74wz5BRnzo3
	frcv9kDkWIJWDJUlvvUPHR9YC9gF6QOivZ1OiyvtiBDoZGr3YPnmpz+y55WFEiHt
	rDmikLTbclnm+44WhNGYXoSTi5x6JA4qNVi2pYC5ZQ4I3WENAVqLCrr0bhBp4lzu
	EI7xGBij09WXnUEK73joatb7DbjC97blqyK8a0EF/POuMU9vfYfmSScRAPy15Umf
	XI2OYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvsuqy4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 13:36:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd93c91075so137453885a.1
        for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773236196; x=1773840996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KGqJp1HesjofSgFAEM+eYixHKEeYxMvdRZNezmTz1AY=;
        b=bi3a7QBW/fh4IY1CAHsc+MTtGtSTd98Zn4SqJuO4FCjnkea7LYdGCsDpAileK3GV1X
         764o8YAxiVSVQkl4DhYp/BMioks3+rLCOfIQlQqwYMHLIwILnMbiqQCWyHP/4uUIOIeF
         KyLMegLQCCiQQfzcmiChO3KNShrP0KK04Dvpwd42wknnOx2pjS9NPJ+QAjOiLTNskZBy
         ZbImGcwU/1M4N+ATADALMgt1cJT+LqdY20Vx8T0+50qGg/uu3uhBEUvc2FRiujWb3yEd
         aO1SQfIVsOhwNu1VaqMrjTRIDJmmOFa8BOHyN2CGV6odJP8/fNFbv1BIhpxJWQcJAHKu
         Ggcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236196; x=1773840996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGqJp1HesjofSgFAEM+eYixHKEeYxMvdRZNezmTz1AY=;
        b=UCfqAOzSUWHIAfJVaN4S2q6qcMJaF/D5Jsr//FyCQ3HA2tIu2EsT8Xcqwy9NFvZ8uk
         kiNVAfAm6J96xkJs/H+wIQiuDvquNP+bTRAyDgwTJ6KgsXgJnyJ4AC3xKj/NsOtvzq6s
         CXLaNYM5Qb4UMu/1kwHPKL+d7bQ42JewMGwaDouT/w5mmhmsArRCK9GDOxEwicI+YwFG
         y7JSbuf4ryAbVt3zaHEKH9L96qZ4QMLd96E55QoP9n3xUY3o83M9kU4+hjcqzJJ8Mwmt
         doOdXaX+Q7eeSa6GkPTMPTQsY+4hXUFYQ8FBDQiUIuVzbDRs5aeaeV2+9vgNh1UUcw2r
         rKRw==
X-Forwarded-Encrypted: i=1; AJvYcCVJnI23NXd6XJDqobTsWlj733WXxAB1qSuQ7QqzZbT5hGqeZl3/CgRQwC3a4V5qcrz1fU7Kk9CiFcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3J+IWwePW4zvlSYg3yneXYRUyDG+LZ7Vj+SVHhCkUt1m+szXq
	PhPr1bRSE2YpTTFIFSS/9Hxwy1y8Cmkmqyn7Vkx36O+l9/CifubIETCDx73uzHGRU0roqqUZYuB
	U2gCc/qhRGsW53T/XgXmJoUgR33qWb/uL1DfOHykN4YMF4GJuEMvg/gPiBOGilm4=
X-Gm-Gg: ATEYQzz/B6+mwpijKWpWcW/FstbcZJGoy+KZSrNcG4lb/lnRkqlrWPJJuQROCyp/3Er
	Hyji2vkUpQPJqegR9udMkD8+DEngrSDdkVOgwz2sEqLWlchZOk4BoDQTDUZEuDbIFSKv8tLShHl
	GxoRV9DK86/6YlDcAk3EobLzHoVKRpaH/E9OmM0kov9j5V2r82OO3NQ2KlMoMA6HYdDkkLt2lUM
	Dj3tCZBBKTouJcIrR24zBlHaC6AkpKdQNG6KcA9zSrv2rui5RyGVW8ZrTjos06PPbksiAtY2nRY
	z8mdij2aWEUbqbtjTqzNgXUgXe0SCc6MzQL4/tj+5mf/Ns+QwzytnSYB3bklR8MJOSXrVLn3vXB
	uwbkHBbLXRMMcvSKYOHyLR+pk7f3Q69LDKwbhy4H+WWdh8AOUSjUk8CsPCGX70vUp7Qh5crPISf
	M28lI=
X-Received: by 2002:a05:620a:1720:b0:8cd:7fac:a2a6 with SMTP id af79cd13be357-8cda1865d9dmr251601385a.0.1773236196484;
        Wed, 11 Mar 2026 06:36:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:8cd:7fac:a2a6 with SMTP id af79cd13be357-8cda1865d9dmr251597285a.0.1773236195987;
        Wed, 11 Mar 2026 06:36:35 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de092dcsm56411066b.4.2026.03.11.06.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:36:34 -0700 (PDT)
Message-ID: <4e98781d-9382-41f9-98b2-2c5a25c1bf06@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 14:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
 <20260227061544.1785978-14-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260227061544.1785978-14-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDExNCBTYWx0ZWRfX1+K7V1Oy9uqA
 P8mQNL1JpqkfvJ/kGPY/1OgkoZreA+2trVr1T9H3vKU77DnOtISWEny6BLHrQZdyANCVGVjdOaZ
 9balPtw1BbPP+sa+OW4UQ3z1DMsBpjvXimL06h/wzVeYxAWc/rhyWgiv0BIu25kvtlV8RyTbMTZ
 TcirMnm8fYK6Fc2ZBU9WJl72NNKJSmrDN6jwob+Axw6lHB6v3A3PAAFrwzVMfjIBhsLD6nF3pJS
 mtoyTrF5FXzvTMWPnDpsTTKCFgtLNLwUIwK+iOEm9t8R9zZdWnlMv2JpaRMCSrXpaOjvxqr9PNv
 UKBXh7NwQ2qiNM+6ur6SvEsSFEYR/WU5ll2JN4XVdie47RcdCJSHF8JUZzULekw4DYlas74Ou7m
 za/E0Tn0ggGcgpNFTBJtEFLARccBy91fxOYEg9t91vP0jVyiEnL3KP9e3gPO/FoXroozd9uFi9s
 I+et3Pu/RHFEw86b3IA==
X-Proofpoint-ORIG-GUID: tRFDD8hE7K379SxQluCG_pCLqq0R0nb1
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b16fe5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wYGpMCW26V-xmeov4-8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: tRFDD8hE7K379SxQluCG_pCLqq0R0nb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110114

On 2/27/26 7:15 AM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power on/off.
> 
> The SCMI performance protocol manages I2C frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate..
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
