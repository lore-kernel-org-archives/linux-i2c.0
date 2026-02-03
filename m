Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C5340283
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121536; cv=none; b=TmiJ6dmGMI/vD6CvFPHM5OGQ6FFa/E9cLh2ixpMO5FoujNUpk+Hv2XP8vzvAA8TNqnpk2Eq2ITbWH+nFo2gukyquR4BHh9RC/XLTQnvMGTgq3jQ9eiHalhS9VtrGJHbU/kyUWkaJj8osHo79xm18GsqLmHKUyj0KVS4QtqY0qEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121536; c=relaxed/simple;
	bh=q0BC+UNwqgkm+AoQaAiSVdLDeuvHClDj7duIXglk7RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfZzHt79ecJ+FybnsA8JWUuqoZhB6JV1CeKSI97FSqyIe33g/VROIUAgifuhMjzzz/KIDrN2yea3fDKIg1WxKVPKeFkKbxy0iNizw1GbZj4/8eccEfSmk9MVocBF5asPadVLA1EnLcaMGw7MrZ58wd47E50gdjWfLQQd5f3phsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGj0sV16; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q00qQlC/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGj0sV16";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q00qQlC/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613CAGe31192253
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kr9VkLymfmxS+ULRZoGX6sAx4XQrg7pGqU67+DmAAfI=; b=VGj0sV16COHQZLLJ
	bTb4nKpwOXw3jgTPBBQws41x/U6s3Y4GHDkTWd4XCppUqUa7kEzcLhPlFUxIC3tG
	0ja51DKluhhIqSGzXkEVPX5huOXPMKcIMFtosy62cKcN5RFX7HWYJzNfd8iZn60t
	+wXJg5qTXs6Tnrr9ef0R1u+BXA+ZYWwuvLLDtYiQbwfbb8ZCEkrc1wh9lrSHXVo7
	/YBj8OJmGetGdV2Bv/rT4uPuf2uSIUD+bgp5Bag05yntFq2Ry7nzDYZuIr9WuNeJ
	yGU4FRLlh1eBqYyDtTvU9rIL0OyymN2VGXkmiRurFaxpvXEwJMvgdXWUz616/occ
	Y75BoQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3gsr01ej-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:25:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6d6b0f193so102158685a.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770121533; x=1770726333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kr9VkLymfmxS+ULRZoGX6sAx4XQrg7pGqU67+DmAAfI=;
        b=Q00qQlC/6pzHN2a6IuqWeRInUzVhEz6/PE71B6LD1ndLLglFaTeA1RMiairbeWCsJs
         5CEYZm4WWLye1BTR7L1Zubo44zPB40Q26/Q3Gh6KLYex7U7tdODkncgjmndn01kEQCdL
         XBKDwA26zjZOi2xPmXXlSM03kWIGHGzYOSbA8U2natxY/mmkGBA1yNWaTYfOrpJ5al2i
         PyCXx/Na70S3RDuG1in3Vp83cMOKOoeZ8F8xm1WJmKardkSJx8w963ciFm0O7qU+h3X7
         gjSYQ82bz41ypvNrYiGha9pc74V4XBzB8pTdOc81ad4Ob55hi8EHCYoR5JZVPzodPq7w
         fpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121533; x=1770726333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr9VkLymfmxS+ULRZoGX6sAx4XQrg7pGqU67+DmAAfI=;
        b=fTJ0Tk0B1/o0UBmOkAWHknG/9f7HcUXCMhkJcQXQXOkOVvHe2nl2hZsc8zpc6QhdSP
         I9WoXswm0oeZMwvayOnjAkOwGlHfAgWg3rQjCocOxSkbM628bKqO9YpibPoDeL1khA7S
         bx4ZdpKiFDUSm3mCIYwvzbMJAHFHgE/amRIX5r0pzu9DbshSjIYyL3DoeBSmFeiyFqGq
         m0Fvm4B320X4ToO85QY5OFKje0YBxBwkogYkmbPOdAYfBp4WjS7Jwa6AuHAqXSWEtvsA
         1tC3JkacnMvBObuEaUjlijZulqJFOMNaJUGwaWasmav7cerrBHY6MMAwqBHxdHyUSAwP
         V0GA==
X-Forwarded-Encrypted: i=1; AJvYcCVmLZwTrLfw4r5qJRXKn/xgez4BDtFKkeFxfPHPeCsrrSG9jSnDzOB7mVGhONGmF9lHMQtSOsbm+yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0P/FMfpSKoT+kFTGHSVySTt41KRxQb/zjFo+nyes5oO2BeR3Q
	HcFVBSB44YKDXSjqqSDXgAwh3TPv+Z5vhyAZF50m6A5Fzfwgdz/Blbbc8po7vyQf2yBz8xSMB1N
	Zlrnv8x53ZxgiowEsFUACjf7vdvdZVelsE/XlSpWM86d2EqL4EE3gJI+DS1BbCBI=
X-Gm-Gg: AZuq6aLH0epE+DDT0UzeWwEf0fBbmeB7Z7B2bYSVPBiI6GKQtEex/r2+ZIKwJmgGcmu
	cqG0tQ/adsZUF+65Mo1T34H5hw00ZmpuyQ/NaZYMx2Q+lqoJ90772WsREy66OdugujjoJ5Ew8fA
	3fuuZ8+mbiYYokP+lf/LYCkhSOw8/xLGbHnA/4zKGxeT49K6wfc/16W0u8C4sr/0/nQPccHblCa
	EXx6Gbr0Zwz/r4Dkv6+TyxhQsBk5JJ3RA7gzPPb4XFNq1LQnjm8WP+A84xBQDVgAlAOeb4tn33Z
	Muy6HL20SdTJBcsnvYktsJ/SbWKkyKBOfIYwtrQWBaSnGRhc7TGWGNh3SQqqODk0k6Pkwm99HGj
	/E3iAObsLDXkAO2j+kXb+4fBT/eeIJMGdh78zEBxY0tOf6J3DsC8JMFL1xBlrrJLbpCA=
X-Received: by 2002:a05:620a:454b:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8c9eb285634mr1499523985a.3.1770121533590;
        Tue, 03 Feb 2026 04:25:33 -0800 (PST)
X-Received: by 2002:a05:620a:454b:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8c9eb285634mr1499520585a.3.1770121533149;
        Tue, 03 Feb 2026 04:25:33 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffedd3sm1003274366b.29.2026.02.03.04.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:25:32 -0800 (PST)
Message-ID: <df7cbe46-153e-4959-911a-14600b3bea21@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:25:29 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-13-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=A+9h/qWG c=1 sm=1 tr=0 ts=6981e93e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=LkbPghAf8A_mGgTKem4A:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: ohgxsYUqlXrKldGSNP7ZiIT8TuLFDWwo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5OCBTYWx0ZWRfX5jvSPJnjI9/y
 pYxBc7DD6p6A8MQEsdw1HoiUgcbHrpO/H6ZSoRre3SQADwYsY5kil1RnkOHLP6LGh02RzG+x4R0
 pVwX4IJGBmLqJtZ92rI873uNV85DjRF5S6tchnHOWBwUpmBpWww4xa/Jciyu/Q3X24+xb3O02Y+
 a+6yr934k1sGlCpmzafQZ07S2fojxHqd+xEaDSVE6DLCB5SUyoG+yM4sw1B01O0YS9QD9Vx+Tct
 wnU94260412xgToguvf7tzcyZQgkugOFddDhRHKvo7GWpe+Vh2oh1fq5F8g8d8Lkvht7NOKgyIC
 T1GbpyVuJ3qcdJM51lbYH2wgHk40SQrGduRi9sjY1+h86I/RcLLYzw7RLCQ0xNrGoCePQSieZHH
 lWXt9J6c9DIXi8oe60XNXzMw0U6MboqjACwznvkIKJCJFTWmiO+cVvv0BvLZBuNKSo2u0NluI7d
 ogxnnHCye8kNfmMBb+w==
X-Proofpoint-GUID: ohgxsYUqlXrKldGSNP7ZiIT8TuLFDWwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030098

On 2/2/26 7:09 PM, Praveen Talari wrote:
> To avoid repeatedly fetching and checking platform data across various
> functions, store the struct of_device_id data directly in the i2c
> private structure. This change enhances code maintainability and reduces
> redundancy.
> 
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

>  
> -	desc = device_get_match_data(&pdev->dev);
> +	gi2c->dev_data = device_get_match_data(&pdev->dev);

Because you dereference it unconditionally later, this should be
null-checked

Konrad
