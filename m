Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720D352F80
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 05:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181589; cv=none; b=OVxQgKCe23v7Mja4KPQaUjwha5S4yy87zD9amTcISLtX0IvhtvgvC1wB+fhLjQafMmF4l5FiJ6/fYwTo7HhSEfuQTbvADObvn/rdf1rHRqASeJJlrGPKN5X+ZO74LY7EZXznE1bBNdj2NEkvXDT2sp6m1sLWDcLuED4hfRQR2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181589; c=relaxed/simple;
	bh=v0Nc2YH5z1X149t1QdEpqLjxkN1uvo/AhimP14jLGsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNUCZh1H/Twqf/VKvNL4A6EyRwC4yE/adToZ09CRJa45DQdlvKwciS3UvFIFs2bA119OIAK0hh3s3rmCiesLMqPosyH4sovxMXqOt6z21FnomzGT1dK47ibRrZLEvYUFDJu7URp2HW9fvRlPs9rcqgQwpxXs1Zii2pD1bTXadT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hEhmAJTt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUXonyIV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hEhmAJTt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUXonyIV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144Mpcg2056107
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 05:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vaoYfgH1dPngMdoHN9hAnw+piYMLJCeQPOePWMinXqo=; b=hEhmAJTtPtKG2uOO
	fHDqNTClz4IT4m+FJPVWlkG5b+TT36V/KhM1CKk92wb6dGBSX3ViIEXg6RNvZcXz
	PLbb+dKu6xvWuZItTlXVdP9aoHypluZTlfcsh1Yi3b4nErw4FguXverwERvbckft
	2tizu3baEwjB0sLD3jMeFRhY0zNRLspR09ahM7o972xdZ52eVU1ziwzzfPgXkuvu
	m5a3tIzNuI/+Zikn10Fs23TgzOpQCqFszNwapVITtSqGAHAu+VDX3WslHPaRWksi
	VbFWEpnW9FxNzOPNbsORWPkQ0psNqdE71s7h8LlxMlfbKQFchSRCenKDgWPNM/Vg
	e7UCBA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exkbcqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:06:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81efa628efbso6445438b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 21:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770181588; x=1770786388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaoYfgH1dPngMdoHN9hAnw+piYMLJCeQPOePWMinXqo=;
        b=KUXonyIV61yspXE5sk/39///V95AFAcf6kwWAxfZc+gZ5MlSHe4yuD1i0/13b0W7e0
         b0lgKpVCDLvW8B0UJl4yHrvMEBmX+Bgnmd3ih0aN4GwPnCwTKS/pmFRmqDqVGyQkCERx
         ConN4+ZS/4tnhPstCRgK0ADwrUXe1BX4vQB0MeXuNAMmLewqP7EKAVgIJ43xaa7WkNJ4
         8l5Bpa3MB4Y7O5B/wZzJ6v1PT0aG3zqjWFOp5CSg2N3xbb8XqU9a2XplLdvCikl4lr2e
         vXxFaNcvhSwQbaXdGirFzCT2kd8svJ74+47C87d08UUFaIgMPYMNWbzAkNqzN/3lQc/T
         Ja/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770181588; x=1770786388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaoYfgH1dPngMdoHN9hAnw+piYMLJCeQPOePWMinXqo=;
        b=aT2ytHeESAzK1uw26Ph6I3CGIakuHFpp5pjWMhgND35rrZ/LF1ch1p36Zf5Jpl6ntJ
         4TLwoKn3I2CA/ANfr3VyJJFTmSeVBno8tPLZMDXoEUkEYOiLOJhAIWlIZ5S837CbGwIt
         gMEt8jxolusuGNv1f8WSGDaa3aP9Nr0q7l1awCIsB6u/C8FsR+EZycLUi+gbJ8EM4EF2
         YpOHXkAqmDjHsFDp/VOK7Oh55FihyFZ7YjJahrtJ61JvI0yBo5ud7r+0vBydnz9kTF6k
         Ny62GXJ7tAUMdVo1QRC618PoTycZNNNgpMw23enk6VCpFGOnWqKSbzD0LV9Wmj/J+GPP
         xPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/30IgElQH3vP4P4PUv04HnC6tc/na+XZgkXegFQ//o2jbtDqc5ynBIYM5PZcrFFkCHg+9HKcklLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydeFhpfZa0JaCYEtlVayoN7JQsCYlzX23naSHsRp8/Sf+NW23I
	XX8WBWQ9q5E9aiK2sM/brEXu1c/Sz+GulUFPoO8tfcwBQCW1ELDn4QoThzd2HdyIk3HFg+eKK/7
	5kZhSq3sfcMSI+Jn4TI1qG0/4mz6CzT0Q0sJvLI/Ao1Pf5R7Pgvl5DiRsr7UvRY0=
X-Gm-Gg: AZuq6aKc53bVDiEV6MbaNM5lyfXv5u4srHI+vrGiIQUPDB6mKDbEWYBAhKBCxsjSCYH
	yBoEJ4uUuVlq3TCdIvv57nZ1nSBLdIS9KLukUv6WtCfY3L+4sgFp+Jbenpw7xukJv3aNATmhhFp
	a4+FFPvg+76SHSN9RC7nSsMZ+uS7fbXZpiNkD1rQUo0+9ivOJvn1DPqWd3xrD8qoR8elJCaIuEB
	C2sWSTM2wFOYKZwsVncInVoildIPJJyHVRagXlNQFQlFxQVPSnsg2orqTwjSK9royAnqe3yYEnf
	YOhxbwBMHyE4wzZ/d3LE/bFXSd7nzxmLZ+7Vo+CXMVhyCX1IajdBzGc9waAxnJxgyB2uv+NUx3A
	60COVK17JQ9tYDc669gDDZbjXUkLGpUBEv/+0jbfTmQ==
X-Received: by 2002:a05:6a00:9290:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-8241c1973b4mr1811714b3a.6.1770181587680;
        Tue, 03 Feb 2026 21:06:27 -0800 (PST)
X-Received: by 2002:a05:6a00:9290:b0:823:12cb:f5d1 with SMTP id d2e1a72fcca58-8241c1973b4mr1811676b3a.6.1770181587115;
        Tue, 03 Feb 2026 21:06:27 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d45b996sm995034b3a.45.2026.02.03.21.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 21:06:26 -0800 (PST)
Message-ID: <3466212b-802c-4ea3-8661-794da34c6c3e@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 10:36:19 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
 <20260202180922.1692428-12-praveen.talari@oss.qualcomm.com>
 <7733eac7-8158-40f8-8887-44e458d33e9b@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <7733eac7-8158-40f8-8887-44e458d33e9b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzNCBTYWx0ZWRfX6ddC7KPTi7dx
 BOf5A/+7iBJRV6StWqaVAOfDqPsAVCuxdheNbupN8o6LuWtEjUorNgKir4y5cAgRRYnlj6MuNAB
 jO3Hg6+TvvxIacZuHoYfWDWL0HTwAV61kHln9UwfuG/Os0kbzx/lZhV4gYjadZIy7e5pZxCGbj4
 IA8894FGmkytEPepUbd5WxrnKyIpYyfj7/eA4/WmuceySSF8KsqEwo1s73GYDkZYOMW954riUcy
 Bd0kFUCNACIFsqsHdsdWkqFADYtu3ThChV7fNAP0J9bH3+pjuXm0X7bOeRN41JWnTV1pi1Jd5Jc
 4TgHb3uQkECmjNlmBaFZ5YPWvTZzfK6owLLMiYxmSvHg1p9ICpqplZjVkXaiEjv6ZGLQkeZfAAA
 Mtw7pj5UTQ1N0g5cb00vTiel24ne6GU4uQ/MK1btMBRBhgKvvP8uKhffxEsoHJUiGFSKdb/7tGO
 9cnkMAgKnuf3DkpqXQg==
X-Authority-Analysis: v=2.4 cv=XfOEDY55 c=1 sm=1 tr=0 ts=6982d3d4 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7loHADMVyoySppEGI2kA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: BG-9al89ViwS7bi9YT3Te4AFTjkiLbY-
X-Proofpoint-GUID: BG-9al89ViwS7bi9YT3Te4AFTjkiLbY-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040034

Hi Konrad,

On 2/3/2026 6:18 PM, Konrad Dybcio wrote:
> On 2/2/26 7:09 PM, Praveen Talari wrote:
>> To manage GENI serial engine resources during runtime power management,
>> drivers currently need to call functions for ICC, clock, and
>> SE resource operations in both suspend and resume paths, resulting in
>> code duplication across drivers.
>>
>> The new geni_se_resources_activate() and geni_se_resources_deactivate()
>> helper APIs addresses this issue by providing a streamlined method to
>> enable or disable all resources based, thereby eliminating redundancy
>> across drivers.
>>
>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
> 
>>   	disable_irq(gi2c->irq);
>> -	ret = geni_se_resources_off(&gi2c->se);
>> +
>> +	ret = geni_se_resources_deactivate(&gi2c->se);
>>   	if (ret) {
>>   		enable_irq(gi2c->irq);
>>   		return ret;
>> -
>> -	} else {
>> -		gi2c->suspended = 1;
>>   	}
>>   
>> -	clk_disable_unprepare(gi2c->core_clk);
> 
> I believe you can give gi2c->core_clk and desc->has_core_clk the boot
> with this patch since they're no longer referenced anywhere

Sorry i didn't get you. Please share more on this.

Thanks,
Praveen Talari
> 
> Konrad

