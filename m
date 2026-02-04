Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D322DECA1
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181477; cv=none; b=Ria8E0LQrx7F9Dn32LMPvAO3pBSdAGKtYpw5ZxHzMsI/wsnqBk4lJ++qEo2AcHh7vDFyCB97vGrciZ2EENLHdqIk7rmPL8Ae3wlK/yXLoUECZ8iQDipTMTZ59YfKcf0df0mK7PIGhll6+cixUQ0vfJBawi68Ib2LepS5s29AX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181477; c=relaxed/simple;
	bh=XmFJIuFS/wd5AVgYfDUJizB7VVk4Xa+TsalDeRCDoW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLicXEOANYz2Bd3BWhVTbiUAM+mLGxI3jBCeKwcSFZGG86X2RgDtjKlUTOPIUpVx2bmCOnjx+6OMkaIIc2TGgubtM0X5VQVH6bzyZAZ8whRG7w2D1Nks6/Cf8zTtuinNcPtprDPshtBuqEYpPTuJXhOIt62IFp5x2GOi3NOcMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JIdDP+2z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OQG6tyH+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JIdDP+2z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OQG6tyH+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144pCoP2829155
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 05:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xSAiik096X5jYd7cFTlpkzc3bCH7olj7yaJbqdjszcQ=; b=JIdDP+2zh0G3cinc
	xCiDivaKwRWrpGbRtE0pBRjmA+/EVLUC3ZsS/TziqhA4vcMlP1y/9ffLsxEytEkU
	a9ZX+AGRm73YI38Si24xFkJRQUsoJ3pTdThfAP66+fbI0qevKaPq2UUlwezgKEvp
	X5gkQS7YhPXMw+UyPAn2WVNL6WzHT10dTV6o6UnC87j2BXSGZwlCDDsXON/BLPYc
	Wcs78sqQ/ukfdSIwD8Z8I9QtqhyQV+ztMIpRt4Tu9wQPoJN1N0SvNaq2TBmHi0Se
	+czWIOl7eDIYqGLkXMrc2astUbcgBuqOxBud1dJ8WwKk78jHNhJ69N88Gb32vzM6
	jquA5Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ndvhx1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:04:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a863be8508so84152365ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 21:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770181475; x=1770786275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSAiik096X5jYd7cFTlpkzc3bCH7olj7yaJbqdjszcQ=;
        b=OQG6tyH+HJnNvh8V00TtMGNWevbAbLyzj4vhc+AeSn12ZbLFxB1Kmh4dR4s5ISVxli
         3U4mFFPO26Vo8Pftblgw8r1O0vg/3pT0nAFmlP0v5zhpbld9S8sToSJ8nmvi27ZtrHtL
         L3fy8fwlbaQBy1wUSVomkJblqMib9CXSQnbPCPBwOa8l9ojnd6yxu2zcubBHBUrYiDiK
         KXKb6awW42uZczoWGx7IzRwlX2CVIocQpi3E57MoK0QHJq4t7m7uwmGckhsi5a61qGxf
         3IzHPg8/BwPSKdxx+ToJ4JlEo3mt7ThRdkJ0lFpdDWBFvjp9YO8uK4U7sCjW3nPR3e1F
         OlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770181475; x=1770786275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSAiik096X5jYd7cFTlpkzc3bCH7olj7yaJbqdjszcQ=;
        b=gnlVln9yvhh2YF+6c5DAb53FxcjrVhEGZbFlCWubCB5S5QLlZfmWzp59YNYv/Awe1h
         TLZnWL6fstgPdPAW4IFKIegFUU79IpyLV8rswNxPR5BtOA9OaJGC1UEBO0vFyD4mXz0K
         1oCayFtPsj+bM7rDTeU0hzw6P7EPFIj2gS8S5CQSZ8M6xFhOK5x1/JK25E8/CAFSAd4z
         5E3WgRry2+aRCxENV8J73MIMsX5KQyc0aG88CH7P5K50gtPUycm7wtIIp/rFxS8aKef2
         mFEECTUwHkZLKFSOa+ok6wKFQX+3R6/zMx96cmJemExw+/kZRy2qpoDDhEwwHE/aJMtB
         Ycjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4a+Yj2gDnc0OPAxYj+tmRCdgWdvPsIg9N2m7q1ue8bfjvfN5FzHuQkEOLgf68sX1NFdX5qjAMCr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71FxOyXsueKd0nPiSBW303ItLRrdutdrkMQt+pD0D3FR8DQ7v
	y37++vD60wCAXGGPo4ExC9RusQUoAn2+gsRSL8y/Hnk7GG2vUeIDb5/DHSIFx0IfgMusUM11qFU
	in9x0IDdqxXEACfsFBE09/BYXgx4Da3NyusTWOPGvX50xmXlH6qXTfOtwOqU7oPU=
X-Gm-Gg: AZuq6aKKxkZqyPxnddTxR5so5I/ICV8GiDx+2EDiODZK4brZovqljDPovA8+svHGoU/
	a5vj3RJ8qsEZcdhOxJAWCbn+kwmIGbsJqfc1LFXn9p4saX6IyoUnZ4jGfljMXEW+hGwxovwJBd1
	cOnqCHNAqdX1KxQw5cizcNqkUosm9qCc5ojtus4QGisT8UA619EPa1fmAycYkmeTbHhTbPe1B2D
	xg9AmA8Td2mRucZnbkCCOqXgWPancm+MAFQNc8JwIgNHkQW8eeuRtUY3K2W+d1j2viWuXcruAwh
	qQAO2zOY55vXpbYO3HmtDRHNtz8q8PWVvOQCULhtzWvoZQzy4eEDhqPV9W3JjKQuXY2s1wSDsBE
	3URIbzaWP33oVSU59WaHu7kTO/rcKLqDQaRDCWD98Mg==
X-Received: by 2002:a17:903:3d0c:b0:2a7:5ad3:79eb with SMTP id d9443c01a7336-2a933fa63eamr19784865ad.35.1770181474799;
        Tue, 03 Feb 2026 21:04:34 -0800 (PST)
X-Received: by 2002:a17:903:3d0c:b0:2a7:5ad3:79eb with SMTP id d9443c01a7336-2a933fa63eamr19784455ad.35.1770181474231;
        Tue, 03 Feb 2026 21:04:34 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d468d73sm954264b3a.49.2026.02.03.21.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 21:04:33 -0800 (PST)
Message-ID: <cf2b7624-eaf9-4ba3-9b2e-81be3adbb53f@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 10:34:27 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] i2c: qcom-geni: Store of_device_id data in
 driver private struct
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <df7cbe46-153e-4959-911a-14600b3bea21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzNCBTYWx0ZWRfXycugcXgeP06g
 Dbrjc1vwpNnTdA4AJ+1z0i9df809qxjPy1Y9IesJh2nO6Td+o8i3ee1C+8JGoN99N8pDpZpdmjL
 LS75o3XDDQR2XtZ8cLVxgiX0+LHp6TngSZpKQ10zv8/983w+tUQjgO9PEn4UXCYxWElh2l8KK3b
 yR5VbGih+rf3e7KifKaSm7DXAf/oXZWI7/MW7vRREdXm3BKRMQMidCKnuCag405t8KLaK2xWWXM
 QX1K2Fjo8CqnpeTUGGq3ZZcItLs5tCF7lbpb+lJcnxJpXHgwb1fwNnSVRJk/9rfv/Hy+NMxn84s
 +VGZUWZhKuU0iNajUFQF4aZn+DW3lt11XsR7MxI/lNACSj8wZhvcqwY1PjxJpwBAfToncEnwpoQ
 MKcc10W72F3lMGj2O0qxJi8iNIGvN1IpWIpwGH0QjLujBzbYOiqZahB9avdWqtj1JGL3ElTZ47t
 8n82DXZli8ZVLo2kcDQ==
X-Proofpoint-ORIG-GUID: en7kHfMzlGMeLwXjzWTMjUW4rU_GvYQS
X-Proofpoint-GUID: en7kHfMzlGMeLwXjzWTMjUW4rU_GvYQS
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=6982d363 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Xoixdy55EFV0JJdjLs8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040034

Hi Konrad,

On 2/3/2026 5:55 PM, Konrad Dybcio wrote:
> On 2/2/26 7:09 PM, Praveen Talari wrote:
>> To avoid repeatedly fetching and checking platform data across various
>> functions, store the struct of_device_id data directly in the i2c
>> private structure. This change enhances code maintainability and reduces
>> redundancy.
>>
>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>>   
>> -	desc = device_get_match_data(&pdev->dev);
>> +	gi2c->dev_data = device_get_match_data(&pdev->dev);
> 
> Because you dereference it unconditionally later, this should be
> null-checked

Initially this was added, but based on Bjorn’s comment like there is no 
possibility of getting a null value here since we are already adding the 
platform data to compatibles

Thanks,
Praveen Talari

> 
> Konrad

