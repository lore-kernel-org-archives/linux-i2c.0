Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643603E9F70
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212869; cv=none; b=Tfcht6bDaq4vjIlchklz0jDZb0Kw/GFv/ePivXcz/u2osmLMdWqxMb1wFbpcvDebYu5Ax6OiCtGAkXQZaCuQYH6ocgpmPxKVNgqQqQbxGoV7UY2Vd0fvMY54vIlcrSCgIVoThKeNzR9RdDVw6dnHH2JZwwRiYuKSGoBlTVqvU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212869; c=relaxed/simple;
	bh=yu9L+d/NKnOZPCAeoijRwUSB9NsZEdGlJw0gmHRRJmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clWBqzyhhqsnLzoNLbc80Yt2EJylgu28oNpqowCCegxhWEAD1GKMGuigLxsw6jYmLGW1TlSs3Jd3B3W6XPTWwxpnAiUWo1ERPOh1nbeOaZsx9L7ACeZCj7EVLdGoEDYtxrQfWXhIjwqgbfV21XrIM5oew5ePGeFnSC/w0aZvGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKU1cwhJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbuAxVSM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKU1cwhJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbuAxVSM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIa7I200240
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 13:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmQjygrGvlInql0/zrmdguNNjU0MyhM6vQvuIR3ecsE=; b=ZKU1cwhJizuA4SgR
	VtNfQ1Vmcz1PIeepUNPH7Y6/mljCSC3IcvOIx7wWdzDqxl6p3a7+jmKaUD4x5ZsQ
	8qQiWUkQxrkenuRs4ifxZrVOJSoXvejSoyDKHJoUVJfCI4uTFxwyRPuxCqYBGZr2
	4nbdu/su4XZEZIyTquipK8Zt8Qc6FVmx7EniU+P2btc92jKNQ3qb3/gykZ8QQycC
	sJRnj/4MsrAva4MlJhPVSoM/+6VdkgssxqdyEgX5nc/0PFaT3gziTTfVxsXfQnkm
	mzZGkl05b3Xgz3zuapnBhKM+8BVlSUuUFCWRLHiWqQPF3T7jAZe03ePo/1y1CrYA
	rPe4JA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3yp59fg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 13:47:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c70cb31bcdso166138485a.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770212868; x=1770817668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmQjygrGvlInql0/zrmdguNNjU0MyhM6vQvuIR3ecsE=;
        b=DbuAxVSM2ABQMEI8n9x+g5cFkyigksf1P+6X97zQdWBVOGpUFAJX2btDs0k5lysBhK
         71pgvx9Ig0338fYVikyHLbZuiA02HHltmdyV/ozcEB61rliUxU3wTDt11FZt22XM0+g6
         /Tj2bKOUICxNPmAo5XeJTMcmNR5YA6qF3mvagJ0cadNLy/73kZsvG3aP0WbS3sUOm/GR
         C5ArQIOHY/g23H517dOqKvOzvFDEjQL3jeXOoTote9piw3nUyLUWgzJMC3GjoOJ8oUqL
         HLs4YFa/Ft0WenQVMo75nnZiRdYBXkEJK5zJWHQu9bfq6FD5L7GEk/g5bDdGg67Ff9YW
         WgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212868; x=1770817668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmQjygrGvlInql0/zrmdguNNjU0MyhM6vQvuIR3ecsE=;
        b=Y8MdD/gqInKYAQRxN7AOlkBvMS9fgNjOzneM3aKt4UmjniSulyV3N/jYs3rIToJk9v
         PhrjgEFXgUjIuCth+eQuGX48hBZtb9c1+mvuhceEs67MogEiBd52scDK/ZfznShcfvu5
         DH0Q/AQhgWiUJe1AM5qjQzfo2q1UormGkZ4Z8OHsh1seUfzNlCyyqb4aIKs/Ez2+hv98
         h9eGcydcyZnZW3GYYCQMh6tu/EHMsscoYSnyNjovC7akZZoKnyqfstIogSxYHPbXhwOX
         cUrgCuOBxI5y4LRnpK2l41T40TiSU8gzc7sYrDsC+rJ2rpwYVr2x34vhgfrfZmpUCurj
         TeSw==
X-Forwarded-Encrypted: i=1; AJvYcCUVjiOts/fj/dQDH5hOkCgdTpm89S892RsEeyvJIHnzl57uE3O7EqkVOCOvDnoZFyUxNgfVw/SMKnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHF6DBTMM3hpRTHXt0WkBaEE9V+cDwl6OX8izpd6cjU4aV5UtT
	a6rOqRIX858/uMWTxCg5RI5TZSmOKWOYNpwakw7Cl8NuIvgdVOjBaR2Qqba46Lb/cWeu5Pikotm
	sUaFxlVj6dVt2NDBCM7Ak2ZOG6bfWTZyooVCGkH0zG9O4JSi1owLu9egCl73cDek=
X-Gm-Gg: AZuq6aIzNh8C7qGdrgbdtk+YoX/p+FPw98IfX2bMeXfjQEjddrBGerbhDa4v6E0TJyE
	/vn2w14HqvtWyL3zr7+3pcwuwGMBCwJ879nl2E/rRp+QUKQCii+FqKNCajni20S2lpGfJkaQUA4
	lX1+FcZ9y5iJy7zq/HkzJcKrKnKqhzlxs7fEFbAgsduyCp8TAHpLyQbCT5ciQZzDZ0pEbowAn6B
	Ds8n0MwC/Hi1xRAiRAlkPzuy5DVfuuxwHoVH6B3wySEazQFlcX6K1C/c1tRJuJB58rOB4iLd3/o
	BFLJ8eI/6b+dAtSLYEK+K1t+i2BCqqYpoET91JC+y4DfMzn4imUaA1YkkoSwB96xA9WVye07CLe
	qNVAwUMv/mNXGAckYnNT8cFo3++44d2FQ+LHM6yvQD+YuOPew7ICbH7w731yfMW+rhXI=
X-Received: by 2002:a05:620a:288d:b0:8c0:c999:df5a with SMTP id af79cd13be357-8ca3311995dmr181098085a.6.1770212867830;
        Wed, 04 Feb 2026 05:47:47 -0800 (PST)
X-Received: by 2002:a05:620a:288d:b0:8c0:c999:df5a with SMTP id af79cd13be357-8ca3311995dmr181094885a.6.1770212867196;
        Wed, 04 Feb 2026 05:47:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea00250f5sm119002366b.52.2026.02.04.05.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 05:47:46 -0800 (PST)
Message-ID: <37905097-ec5a-4922-a34a-7cf0ddce33f4@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 14:47:43 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] i2c: qcom-geni: Store of_device_id data in
 driver private struct
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
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-13-praveen.talari@oss.qualcomm.com>
 <df7cbe46-153e-4959-911a-14600b3bea21@oss.qualcomm.com>
 <cf2b7624-eaf9-4ba3-9b2e-81be3adbb53f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <cf2b7624-eaf9-4ba3-9b2e-81be3adbb53f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zzCRnY6Kl-Ve9-CraPqP_YMDmUXHLHCb
X-Authority-Analysis: v=2.4 cv=cquWUl4i c=1 sm=1 tr=0 ts=69834e04 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DvpAP8q0oNssZ-h8920A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwNSBTYWx0ZWRfX/U+4vWwc2jXM
 Wmn6HWIPEM0EtE++FATzryL0tUyhex/d5zPYFUCTHHIW6dqqEmh6RByHJb3Aa9wNeSdImMO+zvk
 HnAsbfiT2qUCqPVCH9I/VqA/OrDFumAigVti6zI1IotpzRv02h7GyF3GNxTWH1xcmeV6hX2wnls
 M58Cww/gXk8ptCxxF6/29HR/9G572t0HsYJtIN4TYnb6WiFRIR0ZpO3Yr55N+yCgPQpaII4SsIr
 c6qK4s0TW/Z4xrNfDDqak+AcpmmbSHxBKXDSTcOwRBm0hRrH4BZyqGasSb91xKAWQvRedorNROr
 APpYXFA5G2I/YVIcV5/CfXFjQR3wyawLfkWne7cvbt1NaLpbYXulFp3mQGV4pCtcX0e0I5dAKw/
 niSP0/vqx2EhiOpEbxmWwCOt6660qcjpi54fpBfM1SrZHIQyxUUm3mkCwGC52uA+0Ea2fhKwnAM
 K+vWmog+CmGT0e/xw0g==
X-Proofpoint-GUID: zzCRnY6Kl-Ve9-CraPqP_YMDmUXHLHCb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040105

On 2/4/26 6:04 AM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 2/3/2026 5:55 PM, Konrad Dybcio wrote:
>> On 2/2/26 7:09 PM, Praveen Talari wrote:
>>> To avoid repeatedly fetching and checking platform data across various
>>> functions, store the struct of_device_id data directly in the i2c
>>> private structure. This change enhances code maintainability and reduces
>>> redundancy.
>>>
>>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>>   -    desc = device_get_match_data(&pdev->dev);
>>> +    gi2c->dev_data = device_get_match_data(&pdev->dev);
>>
>> Because you dereference it unconditionally later, this should be
>> null-checked
> 
> Initially this was added, but based on Bjorn’s comment like there is no possibility of getting a null value here since we are already adding the platform data to compatibles

The ACPI match entries don't have it, which I think gives a good
example of how easy this may be overlooked

Konrad
