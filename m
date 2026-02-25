Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65135B650
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030294; cv=none; b=mTeav7fnXLpti2UGIZ4WSCjdgNN2s1R8QQ4LiGz/2ocR62rucbUxCYS/SCcMBTnPPdBlGu+Dn92S7BJGAyOFuGHWzFEWxiAshurVIC7+jCytI8rvjZ7D5Yw/lqbt0Y/Z4JQSSFdp3wMszKXQGT/7aGETl4dpaVHQvGBbMd4CJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030294; c=relaxed/simple;
	bh=digNdhj5ymvK93iQkbJJBvbVfxcIm31TqcqnBr+Bogw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLJXNdy5S72SGAhfn3BXjGoqBjUwVjNxsHTy9iONaM/H+simWEha4QXE/mQ8oYSf1GtVj/9y6Vj1XAHfKXDfP9VqTbS60RL+8dObR4tANLqNrDrStXW1yzmCihWacctRZLEP/SiQxQHHSlHzNAZqqtfqV8M7ysXKcWOIQanHI3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XjNagOxF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=is/INAKc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XjNagOxF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="is/INAKc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SuDn229861
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ICZwg1StmPCHqHGLiPJjTvu8ue8fmrDu8Hu6winZYZg=; b=XjNagOxFxIzW/NW6
	AWWksZKNcBl1H9VOudepKSFFYINVSKZxHJAWlBgyPYFh17CC/UhndiRDummVi8s1
	PGUz3uvWU+gllG0vyCJsmlLFkfEKFM9bNb6wEXvsp272Gzaem+ZSGhxcFVsr2TC0
	0JgShWdFhP6/3FfMXkno34eN/4ucLmKeEa9RK66uJROJ2ykbWlBL3ZLtYRkWOCxv
	oSB5YNhMo781na4aErDPzxtSWr3KWaO/GaIdwgpKNacDwjG6Z4JB6p77wPyxUlCZ
	R/Fx9T9fXpLjggG+/5FQXEMZ52rmsDD0MxfM7V88FReyVIceGsiAGzhMXJpL04os
	BIzA+w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg37uhkk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 14:38:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-896f5c90f07so71352206d6.0
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772030292; x=1772635092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICZwg1StmPCHqHGLiPJjTvu8ue8fmrDu8Hu6winZYZg=;
        b=is/INAKcgtxdGdaJEK3c7TOUpx2wLSGARiDkHlxSvQjQIm6lXHFVR5C/USa7Zo00Ap
         gkba/4WboH1o5bl4S4NcelchfalGuid06P7FSbVOKPtp1e2D/8QI0Ay90aLGLZzyzgL0
         AmyMjoe8NFEPDms+21mdGF/GWGHK7OTjqGaibuqoJrWHE9beCfJ6pzAQranlTQuX9a7H
         vZhNVBU+VEXDsadBPkPEfxI0q9d1u/8gkGQmpLrCnAgEvNLW7Me2nBTBTdO07txqgGIh
         9YtOCX9Mx+NHZk2CGDdO0oq1tA7udM3EKwAcHUfRlP81lU8PP++81gKqtMSFOKZRbBwp
         x83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772030292; x=1772635092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICZwg1StmPCHqHGLiPJjTvu8ue8fmrDu8Hu6winZYZg=;
        b=r+7dRjgnDCi7yYADepGLodG+vW/PybJaxweGB4TmufsThnb/WddvHsyfAXQSx3Ea0N
         UNK+lDUjcsBWTWJXTCQubdE09Ir2IZZg8/SSaL4fGXYUBAaaziz/bNC9UESg2LsjkusE
         XOHyrtQX/j3QQn++0tmUkdJ+gbobSljq8UVL7BY+Cngxf0WDiTHl65kAjI+H5Ti/5NGD
         PW+iWbJgyp2ARvqGIqIi22qEJKc5inCB9mQGR8yxEylsf/Wyzq3omEkcuXanKzw4Jf3I
         OhPX21GcY4zBEPN21g6KzJID7l3xf0EaH14nX896tcorjzWJggAi1fJWoBJSWB+HFNXh
         ONTA==
X-Forwarded-Encrypted: i=1; AJvYcCX2fPBg5ZyvHg1cF8a/1Me3uQ4M+a5gmAmRdNZ98eBhqLI3BAnB48fPpsodLTN5oS3qgtGulm5/HLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLg0UiVA3hYTCTffNDcFFDhE8uMKKlTgchGB3609MGLR99Wd5
	v1TArTi6vXR5nXiZWLA5jtaYVbpWC3/7EdA6yvCda9KINFXBHCWDPIPaKvfnrMw8NW0WOK6CqYc
	S9kMHqqyS2Oj9zLmyvuJDaiks7PC0JiJvCbTOwmcXS27PDpxHjBdDmFxzhkfKGCw=
X-Gm-Gg: ATEYQzxvp2/CnwZ4j4tKO88ZtSKyGyjcvGZAps5THs/SLjEUePkBxJKfs83ll2k6cIA
	/fH0p3TSeL9m+Gdy/4g0cNrYmUlr8DqJQPQZ0N1XedpDh7dRkgAek2xca7A3EXf800fALn48nX2
	iK9YyB+RYP13/NE5LA4o5njvKZuTthPotLFHhMUW9BtyEHkw5rmRUNzb0EwXAkD26irVO64C0TO
	RAJf8umztmefcDqOMHVKgCGaLJZSDhv7s7ANKaBNdd+mAGxmO9QoXZI5DCNzGlIlntgLeSha8GC
	ORXT7Tb1JZTfeo4EFg3xz6i3EdckyHm9/FhYVcT9uHFktV/vxp6nIVvjaMmEvpk9PMMx27SJ+WF
	NuTZHhbvHET+kfi6G66h/+1UbLiXoeBL8nDrlHOUN70VX0SL1ltYr4Vq76iQXpZT3iJYeNmlLfQ
	nyCMs=
X-Received: by 2002:a05:620a:4154:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb8ca8a757mr1520290885a.9.1772030291476;
        Wed, 25 Feb 2026 06:38:11 -0800 (PST)
X-Received: by 2002:a05:620a:4154:b0:8c7:1b40:d096 with SMTP id af79cd13be357-8cb8ca8a757mr1520287485a.9.1772030290963;
        Wed, 25 Feb 2026 06:38:10 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084eb912dsm536073366b.55.2026.02.25.06.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:38:10 -0800 (PST)
Message-ID: <c7469822-5c7d-4040-917c-e40533d0985e@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 15:38:06 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
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
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-6-praveen.talari@oss.qualcomm.com>
 <05340972-2013-45b6-801c-7e52fe48cef0@oss.qualcomm.com>
 <9b49a776-a65b-4210-b335-627a296049a3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <9b49a776-a65b-4210-b335-627a296049a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=699f0954 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pvrQjcnNlfa1hpXBJfkA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzOSBTYWx0ZWRfXw7B1HLgR61Rd
 SxFgiDeAu89G4dAydop324rh3BnlGK8/ZqtMfrR91J6vlHW4+9YYwKdhiFj/3b65FUsPLLmDc+9
 AKz3ZIDLEwJHBBxbfGOlWbOlLEE/dB71JSu2RjpQD8d7ZAZuK/h9hsr+gAlb73fW9GilTXFlWNj
 Lq46wyiQ6QAyptnX3iEXYEFzisBBr6iwQu6zI2fna7Bk9CXGnwPJdytS8+AoVPnLgI6n9eHPgRZ
 yTaUUymBv9S3kpCoFo+zGXXaB1cF+UnhvIwRbLcNB6loZgNHVL7cLOhS5UPus0CXZb07HIi9Kji
 wMPppxhKEM6HUbQe6x2vwnovrPdf6vQZTADxl93ceHFj0NDxG6Sg/zIHPhtSO2xgQAYPbbaIHfP
 8iBrTYU12qerLKJeJVHC/cDl50JUZ5/CxKtZkzN4rXlpF34Fbmm1dJL0m7oVJjVDhUNUYTKM9Q2
 FGDqGBpNyCueIHibzag==
X-Proofpoint-ORIG-GUID: 9tJqbirtKBi4aJFTvrEn-91EVPq_J5J9
X-Proofpoint-GUID: 9tJqbirtKBi4aJFTvrEn-91EVPq_J5J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250139

On 2/23/26 2:39 PM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 2/17/2026 5:32 PM, Konrad Dybcio wrote:
>> On 2/6/26 6:41 PM, Praveen Talari wrote:
>>> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
>>> activation/deactivation sequences independently, leading to code
>>> duplication.
>>>
>>> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
>>> power on/off resources.The activate function enables ICC, clocks, and TLMM
>>> whereas the deactivate function disables resources in reverse order
>>> including OPP rate reset, clocks, ICC and TLMM.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>> v4 -> v5
>>> Konrad
>>> - updated return value as 0 for geni_se_resources_activate().
>>
>> I would really like you to include that kerneldoc bit I mentioned it
>>
>> https://lore.kernel.org/linux-arm-msm/ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com/
> 
> I hope the below works for you.

Tracking the rate internally with drivers potentially doing more work to
change it introduces more room for error. I'm fine with the current
state of this patch, so long as you

> +/**
> + * geni_se_resources_activate() - Activate GENI SE device resources
> + * @se: Pointer to the geni_se structure
> + *
> + * Activates device resources for operation: enables interconnect, prepares clocks,
> + * and sets pin control to default state. Includes error cleanup. Skips ACPI devices.

use this kerneldoc and include a paragraph saying:

"Unlike geni_se_resources_deactivate(), this function doesn't alter the
connected genpds' performance states, which must be additionally handled."

We may find a better solution to this down the road, perhaps including a
factoring-out of the clock configuration writes in the non-scmi case (they
seem largely similar), but that's an improvement that doesn't have to block
this series

Konrad
