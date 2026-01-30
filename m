Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86636CDEB
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776494; cv=none; b=XpT0IHKnAvhqHBwyPSuH/Qx4zJvqW45jJSmtUhlXiFehCWlGooCls7O1GJkuhJzY+vOoWLwXUO4/d6OmSdbd8/1haSBz34dduxDSAGUOmZTNeJvwC2RajZ7gd8+/VJEH9FueKxC0Q1Q22iJsSPBuAXW/DrFHGWz4ozRlj7r57Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776494; c=relaxed/simple;
	bh=9bVtYDJ82LcVsDRivF5w5HY9lRNo++pZxqNM35eQX/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiHEO3bKFPT6jwsOAWUyCTftk+V1y4aIVFS+OIkhKC/IxcoeUqAZxbA2K2Zb2d57BGy2cbksx3hYuSkRQa7A6rYorfMspofZWzXhGkxGpQ3SHYffOVKIlQdtcYcrEmGrALnHuM8p3PMykuZsxYddPnMYqFSNKTrn7pvy0I70u/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OHL/mtrW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hp+9EMU+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OHL/mtrW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hp+9EMU+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAwKBj1488626
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ul7akGCgjo+5jjsS/coxz7CBPgHvputuCOrKBFbRED4=; b=OHL/mtrW/xwJLnZy
	D/HGDOWVCMls3K5aArXt+HFtIo3hS8M1gD4bvGfg57VzNQKJ7//Mlg4SorR++++t
	zsPQ0SW4yGxY+mpaHVkTy3dubtnecmO82cHbAtf0EH0KE3ZvobgX3i9MgutczUmu
	5IfnEvfLtvvYOSJa83wWXy9OsCnmdLi8ngQt70TjKBXvXGlqXlkRFmXbmF/sXxlb
	+eCoJLB0xDWGT3N1DSACqBOJiGvBZ6w572OddSRqiFNEZD9ahtl7uVmUqinIpKR+
	ahg3JZLWMKA3tCzt/CyU1505hZOXQFayr2klLFf3uEo1+4584dIaK9CCRC1pDJvU
	qp/5+g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3u5xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:34:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89496f5086dso5346336d6.3
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769776492; x=1770381292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul7akGCgjo+5jjsS/coxz7CBPgHvputuCOrKBFbRED4=;
        b=Hp+9EMU+ec6QaFullTwYvYSxXdy4uJUKxnLH+uKu4xXiavNRyHWsD4s2knDWvGFuSI
         KYafxOGyXID4pcHVAUFTMOUIFCEx1YZQt31wwltCdJYAfYbjRnwiyjh4Y+22eCZiWevn
         uM8bM4KjVkR/dLMRcksmdIpyooDKq00xSlf0dUy1tthqcW1vIId8oVgLLwB4lhtwlUiw
         k1Uh0+dzP+4nPoN2ytebunesNckDgdK5VOuO9h2llgPAfIQ66gphO8rN9gxB1YQNFR5P
         B6FfMh2bLeH1AZIc2omDpT5O/kweMvUZQfxq97LkidFa16frpOfAhMySu2upaeKZnJ7h
         8b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776492; x=1770381292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ul7akGCgjo+5jjsS/coxz7CBPgHvputuCOrKBFbRED4=;
        b=UDbF1DsL7B16U8jPdPsFojzdkxU4Q4L61F7FC1c6cOkEBilt4fBFBYnKWg8yGYk+Qg
         TkS3w71rYCoSeJp3UzLmRup1yyJPbxr7OYDxHQLLlz2QOaRyCFIbaNrlVGCwRPX+aMsQ
         PGdXwBCm57D3n7NNNqs7a+Gb5X1qlRKXVP9RwPe7ZZpUlkoEUl3iZcMvUtHrDvr2ubsP
         grCMFIHMEOG3zoB6oXLzFXkOnxAOOzsFJ1HRA5bkJs3H3ZgPHpsnjZxqRWuze03/bbXS
         jeSn/SNmMm/fRl7YTUHRjPMBrJDVlHO3RNEG2eUHr8V/qjB/iZrxZes1h43q4qp2Jl1i
         lHzw==
X-Forwarded-Encrypted: i=1; AJvYcCXPBj2NRm/3JenDbGxYhei75msDXL16i3UBkmhiWKZuj0Tq0rEUZeI5MV2dzHso0wG0aZf5mV79aTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGqobar/NH9NbsWaMWwZ/l91I9oVCjK2ScoeipadxY0NFD1TH
	J581ccWQiIJ80N5o/dKxNP/nE2DFTJnH7rN1CzjSDA0nRhz8IeoT6v7F2Xr3uHguZjIppk5Qnga
	VyNoYBwR0I1aXCcJj0wtLj/p24jVOwkeWxsIhLJcJstlHhhPsYC5WfAzlY05SL30=
X-Gm-Gg: AZuq6aKqRMO1OZQo6+gXfKKKI3NwW3Eal08FZQCIuJ+TjDGR8Dot59U+ULOrRskuLRa
	qBgC9GeyWZUGUlMlcDK6Jvp2z2K5DQdH7gPiYJj+mcWIyXXmKmlw4iVSPeEPKZGbnL2hFMV9heF
	KH+AoBh3eL4LzOTwaYiCSq4/256JxhUeMgSS0ak4kzt/LE7mDv4LJezuz1ysCgIpbAK8Il6YKZo
	5UdhjXWgksxMNMRqXzoJ3yG5uAhzqUJxeWwU0dNCLlAy9iHp9c7l4gQfWhg20Xzi1i9fhqPKgxH
	RMSQmovXWbduavgqJFR7z471uUV7k0XGX5zxO51FonwFRoqmioWnaHDAHhpwJ2kFTtNn04hDywk
	BXjG37wnJmCt9bOIj13XkgbtIpUSekaxJds7S1JIebYSnYEXCXyrHMdBNCTwkeoZbP8s=
X-Received: by 2002:a05:620a:4005:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c9eb33fba1mr291462685a.10.1769776491841;
        Fri, 30 Jan 2026 04:34:51 -0800 (PST)
X-Received: by 2002:a05:620a:4005:b0:8b2:e704:55fe with SMTP id af79cd13be357-8c9eb33fba1mr291461085a.10.1769776491417;
        Fri, 30 Jan 2026 04:34:51 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c5b38sm410530866b.53.2026.01.30.04.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:34:50 -0800 (PST)
Message-ID: <8e410852-37f2-452b-b851-19b7c4222727@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Iuq3Zzh8WAJjiMzVyqMZ4Esxfrhc4iy0
X-Proofpoint-ORIG-GUID: Iuq3Zzh8WAJjiMzVyqMZ4Esxfrhc4iy0
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697ca56c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_xJWht7u3x9PW1fQUNQA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwMiBTYWx0ZWRfX5onLwnNCk47b
 oFFn9e46La8+h3jOOV4tWAcgzu/fkcEzepjpdGvGrpnQAtLlHrIvMAro9bSsHfQAggnFSJa4/Gk
 8QDns5/bjW9xBt3z/weWCy87+M0A8RWcAzKGGPAh6SJhluSWengJR/vTJLhyItPKOY6kmqkNIR8
 7kVuuQRhZacLxR+WYwOGY4e/ABMTEO8beWL/HxLYH31WQEnvOItuxNugf0vxQ4rmj3f4RPp11dV
 vZm7hoh0pm//H5NQViFove9QPhxuzQ25zV0kQzljktI2sCyWXh3XAO0W4fi4wZauUmxg+8LM5Bb
 evHX+z5s4jjuy/Dng62riWYZQ6A8wyecndg9rGo5Fp7X8czPxjt7E5LJ3UewF7ZDJI9Mfx65P8x
 quB3esuAR/3tTxxAg5lyT2rXpl6uCb2B3UQ58BAIvCVWfLQLdLp/ml1ifScun2rIi6nyjvSbRaE
 DPcECgUUsPiL7r08mDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300102

On 1/12/26 11:47 AM, Praveen Talari wrote:
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
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
> +	.resources_init = geni_se_domain_attach,
> +	.set_rate = geni_se_set_perf_opp,

This means, on SCMI devices you won't don't the vote on the POWER
domain (or PERF for that matter) and switch the GPIOs to a _suspend
state - is that by design?

Konrad
