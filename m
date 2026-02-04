Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847372F12AB
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770222747; cv=none; b=bqEJP9eCyJSXyaToSSgLco7tonJxbwjywWJwi+RAe0o248ikf6LcxalGj40ky0M/NQWVuQ8uTD571gHThhe7ADzWULIdNI3I5wi0gbBC8ngt2XOW3CAmpGB25CmO+Ak7U/cY8Hc26RYRoB+hreXsPRip+aWcMBDIxQWGI7gJWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770222747; c=relaxed/simple;
	bh=/v+uNNItAFDssjN9spgIeJoAABxBqerp2c81ImyHwjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6L4h8pG5fd5zuA18mfDdpVoE+yT6wHHf/vugGKMg+B8UdNFzmqRzll7odf7sop5Csh8EDe6x7GP+lge55rryx51iX1jCuD1T7K/sTJwsdW1k3q1DV27qamYa9M4RqMXB7AiGDy1bbzOl6RlutyTQl5LdEUcZbryMfiIw14fYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctbbKg4L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDO3JSwD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctbbKg4L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDO3JSwD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIL1M898820
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 16:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QwEPD/jqCbRdfaU9YW/ilC0WxBkUaXrz5vurn7yTZbo=; b=ctbbKg4LL87hRKY3
	9syn1/CIzaodONUjpvoCFCMuYAmYoDdyXOXDqGReoSDM0OkWCLRsTpm64DuzHUVE
	/Ods4w6343ShQDZ+aRK6/ck15YZ86MyUjKwXCvOxW5tbcN0mIBcGPIbSe5K2l4kK
	fNI4PAj+VSVi9HvPZi0yEOhU7abAUcZjQ9wWTzaV3/rT4O1+mFvszG3gG6qlWMMM
	9CM5bhk1EELRtBLtgVJs5fyKnA0UTlYyf7vS9x0mQKt+VriK/3afQVTzsVZisNva
	R2MSS/kRJqfHdhe+fzfrHCoHZ/1Q15oEmmrsfg1Z+vX0SQqkEcPPgNIVGUE658q+
	K1SE6w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wh478-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 16:32:26 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bce224720d8so4183812a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770222745; x=1770827545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwEPD/jqCbRdfaU9YW/ilC0WxBkUaXrz5vurn7yTZbo=;
        b=CDO3JSwDwWMpAVySghY257WtBaQBRp1V5N0cxoJnP9Kv0AugTrbOOMXpb5Kl40CdTS
         F3AU+iD6l/dMo1qCqL+XBKqqu5fHPkPBdUyD2XB8jRCL1VVS5rvvnImSh7ie2Jjvicfu
         Tuq1awa7C36vMnLksLq3inPvQqVtJ81Jc8UycVp7TBbSLPtag9LQK1vy6JjQKhqeZKoI
         KQ8UvqYzj7kXZ8oPohgP30G8vz/hBvy8FMndsCKouo0yQxYa0uKc8J558GIj4kXy/rii
         3IJpfwcDCIHiJkReJ6FGwxw3YxPVexV6vD+Rp5fJvblkjQC7CUeXzAOWXoactl2c1iCS
         YNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770222745; x=1770827545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwEPD/jqCbRdfaU9YW/ilC0WxBkUaXrz5vurn7yTZbo=;
        b=aZDzShAwhdOP3S0WWLIW8UkGLunClQhz5n7H/s3FfkXBSZXrkBIF7OCvBPbjLHzpM/
         zwd7YhgChXwtZlLzKjshRzhj+29fbVh5d82Ze585AmYN16Sp0IHMsRrxFjNAtE4lmJh1
         h/x5YWaDYIh/A8ELpQnrRDUREQi3Nr2ocyvB624ocp1VWnnVJsXevY2haXCGUWAYQDo2
         9OAsl5SfwTOd5+bzqtWx2rbQitK2S+Jl7KK9D+ktq8utigSgHWE4zkgsIYhWD49pQUuG
         nndiShncnfZmL3VbPiy+pbkcwc332hQA03pVzJ/fmdygmqq0p8jYKcCk15F0sDLOJccr
         3+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUg0nfBRz9d2aqyF5x9p4B+4+SVfTaD5iDH0lwmL8DhAlyNvyLKUqZpy2GmwChLyBI9jeTtvuYaxBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4JyAsspq30IsKHzhlC3JOujpww/IMFdmz04azQ8Q/S1OfkZH
	bW1AgIeDJZHDSSCJdlhn1uNGqOxiwceBTvB0Vq+SDlzTS4lB2Q5wtQlQIiOK2yorViwHUdBPc26
	IeQhmnYurbQc388SmhrMCK4YRncvqyi6qiBhKltu0bAhYOlNsGUNUy+/STN5KGlo=
X-Gm-Gg: AZuq6aK/rOSaLGTA56dSLhqRw7siIWoaWv3oAkyj2rW+KBPd/8iB6nvrXRl09Q6MK+j
	+37VabYWDMOEmNTzzneN02dMonJcdGwRq2tuGBpQH5K+9m6X01IXicwpacp5NOTkUQWLnwRzVSc
	xkpE+ECR/93rqbgWT7CZYjDBafuTa4pfrqdDZeFYUHaxyNBsHI/vwHF7u5ydyhx1PvXK1S2flej
	dyRQtx4y7Jt8L/unquIwT6PnsX6e8Teo7tsmgWRmu46tYkwsAAfyUv2goJcAWAAIu8KmfkffQ/l
	ImkRIyJmHY/wVbNr/srDJYte5RfvR44KAbPm30DwbzZz5UVoXPKrmfjtstFnqDkwzjOb0GVOIP/
	Bz4L9SG/74sy/icn9wOPy3LnQFdZNTLP6hIEYBIx6
X-Received: by 2002:a05:6a21:a42:b0:366:18ef:abdd with SMTP id adf61e73a8af0-3937206a59dmr3942908637.2.1770222745480;
        Wed, 04 Feb 2026 08:32:25 -0800 (PST)
X-Received: by 2002:a05:6a21:a42:b0:366:18ef:abdd with SMTP id adf61e73a8af0-3937206a59dmr3942863637.2.1770222744818;
        Wed, 04 Feb 2026 08:32:24 -0800 (PST)
Received: from [192.168.1.4] ([49.204.107.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c84c72e48sm2544895a12.21.2026.02.04.08.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:32:24 -0800 (PST)
Message-ID: <ded49af5-0f5a-4eb9-acde-7cc73db76e60@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 22:02:17 +0530
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
 <cf2b7624-eaf9-4ba3-9b2e-81be3adbb53f@oss.qualcomm.com>
 <37905097-ec5a-4922-a34a-7cf0ddce33f4@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <37905097-ec5a-4922-a34a-7cf0ddce33f4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfX1/4gyw0thyrW
 d9OHPVKcJs4l1GJ8ES0h6gEobbUFNXY9uYBp2Taks68Yn90lZ2SiIGNOcL7Bq9c+RSMn7BJGEhe
 r9KA3Njk8nByi35GC7aq+rZX9ARzBcCqio2q43k579eSVtxwFOzJCkcfHGxY+CY2jij3ndvOPRz
 FVqBpMFwF+zwbSZDYqH7zoELUGkSsHgQyFLJ5pF5s1PXZQJtaC9ClYC/i4zVy8BR1XXF1r8+PzO
 EyKUJYqc8BEc+5fJC1dfaX4MIGzcM19LdxE7kArX70wggYRDvazaV8ZCuBNUk/YIXL8u9ioMt0I
 xd3EmlIZx1yhPpc6hd8Yx+BeNG4mHYMfmGz33fvLMG9BXo/AGvbNXTuXqBvsv20FmG1Ypfi3TUZ
 9vlA6D0cvXz0gD5l6SW7Qai7/JHk+wbOpp8p2dnj02kvKu47hmvTXoZ1saspYtTExb6+339poIM
 dqARWCH+kgTM9ZbqWNA==
X-Proofpoint-ORIG-GUID: ExAddfhWdsL5gFFP87AFOdim2bD4S7bt
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=6983749a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JMgISmeAsz0pT9/O8qDBbw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=g4BVqhDYQOQbTQtDZiMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: ExAddfhWdsL5gFFP87AFOdim2bD4S7bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040126

Hi Konrad,

On 2/4/2026 7:17 PM, Konrad Dybcio wrote:
> On 2/4/26 6:04 AM, Praveen Talari wrote:
>> Hi Konrad,
>>
>> On 2/3/2026 5:55 PM, Konrad Dybcio wrote:
>>> On 2/2/26 7:09 PM, Praveen Talari wrote:
>>>> To avoid repeatedly fetching and checking platform data across various
>>>> functions, store the struct of_device_id data directly in the i2c
>>>> private structure. This change enhances code maintainability and reduces
>>>> redundancy.
>>>>
>>>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>>    -    desc = device_get_match_data(&pdev->dev);
>>>> +    gi2c->dev_data = device_get_match_data(&pdev->dev);
>>>
>>> Because you dereference it unconditionally later, this should be
>>> null-checked
>>
>> Initially this was added, but based on Bjorn’s comment like there is no possibility of getting a null value here since we are already adding the platform data to compatibles
> 
> The ACPI match entries don't have it, which I think gives a good
> example of how easy this may be overlooked
Sure, will update in next patch.

Thanks,
Praveen Talari
> 
> Konrad

