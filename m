Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE43876DF
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077988; cv=none; b=B/r9RvhleJoG8CEMzw7BETtem4B9Jb98OBqyuHE3iXWPqbOsNQAkWQEhUztZGZ87AWDBe5tD6LMZe4Nd9koKV9VBcEEF/V7xSTNZzfccJeCrRRghTj5b/iH7xazl6DrnscxTeDA5Ero/1sN8NWBtOeOEYvWiXos6RqtIYfatj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077988; c=relaxed/simple;
	bh=HWKsFl4MnTZYIIfzagaQmPY9LE3X3hHNz1H5NLijfLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ps3fR0mePjvfXIfB4cC3NO6sS+i/pP8wk8fkYzJYzz7RNBz1Gf62iE9bylwDdiAh+ippoYV7wNfvp3AFMN0qkuyzJ9BFjwRzwergTVwy7pVrYhfRJIFbe+NgpPIy/IaiexuBCwNR0JPWMcFOZZgagJBOHy2DWBuDBE25/wpA8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QSpIozLg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i38hVd+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QSpIozLg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i38hVd+H"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH2NGF3100987
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 03:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eFGV6PObFQPlq8Zm7sCD2brL4Y1z+9apzS4m7uWhVws=; b=QSpIozLgEQAKF63R
	oW0IPMMSeIHMhhsNq5Kth7IOcVJ+HNrW8oWjmOre595up+4k3aAjOGGSvoxCPcIl
	/HG82mn+CIOV8Fyrg3ioxfmRTQwDrQyAPlyZJpoeHHC6D6KK0ObkoxVKcknZRJVz
	o6S2rmFzrMU4T/Y77U2kuyTA8OwgJuYZWsFhcBqf8CT1LYRujP2CigmE/tUJyiyR
	CTe7edtGSC0yGCqGkle8D1V7Ry2Z+z+FzVhLjCwZWoF3ZQnMZ6t/mZ2cR85rFtiL
	rrqS7UhwLu2vAy43Kj92+vUauJkyjYjbi518Hx/2n8UE973NA9WKu/d5pCajJgK6
	yO6dNw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p9pq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 03:53:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ab4de9580dso20781275ad.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Feb 2026 19:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772077985; x=1772682785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFGV6PObFQPlq8Zm7sCD2brL4Y1z+9apzS4m7uWhVws=;
        b=i38hVd+HCvhFG0pF6tRe00zyiJYBh9IEJ+M9rAlpTxN1wnGI6udSu9WGzoC0WdLHty
         QTV2zWG3OOHQunkO5aY5RIkAtQSx2VI6xPuI5bR21kp7OfDw4SX8gx+LVwKLLCh6GTRl
         +O8vo6Tubg6yVx/uEwr0hQfNn8vX9zLFs6To/AWP3vq4UufavKlRJby+78fZWcBs6lYC
         ViPg6wBPmDtvuVslusu3gWg6wL7jKgPD1DVVI8DciZpJFWmKSa/nRc+SAkhQZbSxyO2y
         wep7PwXbO6klhdB9xG77OzTZ6naRnAJGl1EmGp5NII6ZzbGg6ZeGwqYe+HR/mlIyUkVp
         7QYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772077985; x=1772682785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFGV6PObFQPlq8Zm7sCD2brL4Y1z+9apzS4m7uWhVws=;
        b=Xstt7Vd6I2a2yYrdnVVsL+qxKQIVH4rS6GH+zwKPfjWD+EqZowW56pjDdS2WHJ88aH
         K6WF12s7BPycUml3y8zXhf19SNdnUDsoHa4v/aOWTKRAZRf5h+FVAIHUCoaxUooWK8s/
         3u889s9mobpTYafSg3yrrJ0AOlJ6QMZuPcEUAxxOnrT3Fs+QSi+kgA9DaJHzu3SoB4X/
         HNbKk3TFdcZuHwNkZPF+b7RMxlOVbCMvpsHfs17ub24HtQgVvWdYemkWdKQ0x9eZoE0H
         cubPw36tyY0GSt2HMCtfjZiFaeNNHuSqaU5r6TNT0HAAW9AGOsv8nOT88SteEpRDbbfV
         I+sA==
X-Forwarded-Encrypted: i=1; AJvYcCVCFkYKqeUWomLwW+KJkBSHVsM+HT1Ngm94A0Xx1WbX3EESOFXxLwa4YT1t0yOpFuoPRLMVchZxFi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRyMl0yLiBKzVbZ8Cc9kff1yIR8Zjca+m5Ew8o5ElGFMfqrpy
	eUzqgQ0l8788I3eiOLFIG5mocKi2Ut7yXn2ag+czJV6PD1vfmznotevdBmM9FTMbW50plEQDfFq
	eb/ELNwuqWCU/EXY/9GyOjZrXBBl+WsYvJtipt2pgH6shCgU4FIhKEFKpBAq2OHM=
X-Gm-Gg: ATEYQzzZMXl+uLzrFrLtpbzgK1nsknKwvXLamxcgz3BqPgB9SZGe87UsLn73qJWIbGJ
	MTHMMuR/gMtyQnRe9Kw9YPdZ3ySsd56Wq1tPwwf4o/SFJktWrDWwZiaLLH/b1x1akWvEVyBON4m
	LkH8mZBrfSC8pFMiYv4PC32I53gpRwb8nNO9u3TrJvszrNsf0rsxESvdcOKx0jjW4KUU6F5CZpG
	yNu2J3wrC8AN9kbIt2l1VmZGlqcsggnfsTrT2we27oJUCA8+5pqrt5KTkWyYLAlG5La+TDtThyH
	43ozWC22lEADvcnda2BOGr/SW52tGfwOW02VKz8hDmQKPQWM7BCnxQx1NxY1hcSCCAtCQWLk80H
	yyy0MP/KVkI3c4WWlrp+Eeqm2deoy+oerGIVlWWmeDrQNJIkI0UiCkA==
X-Received: by 2002:a17:903:22d2:b0:2aa:d6a1:e18b with SMTP id d9443c01a7336-2ade998e04dmr30034475ad.18.1772077984878;
        Wed, 25 Feb 2026 19:53:04 -0800 (PST)
X-Received: by 2002:a17:903:22d2:b0:2aa:d6a1:e18b with SMTP id d9443c01a7336-2ade998e04dmr30034055ad.18.1772077984304;
        Wed, 25 Feb 2026 19:53:04 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1ba9sm8262105ad.76.2026.02.25.19.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 19:53:04 -0800 (PST)
Message-ID: <d9eda4d6-b9cf-4525-be4c-f718e17b61d8@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 09:22:56 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/13] soc: qcom: geni-se: Introduce helper APIs for
 performance control
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
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-8-praveen.talari@oss.qualcomm.com>
 <0b969abe-d9ce-4a87-be61-212a1b8cc8a9@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <0b969abe-d9ce-4a87-be61-212a1b8cc8a9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzMCBTYWx0ZWRfX3UeJFruLwQmE
 AjJPQLFj0Q7zt6LX8dVvgVtlmGyxRSbCUkjc7mZnqJeWezOeVkhr+0QEbt30PYgVtDlDbtH+M+h
 XTzqOk77E2lim6k/UMa2cHfybOPcyNNNL8hjfA69dWNryM+PwavtsWzxDe7xqcMbWNaOhWHbybT
 SIAfiQErdZQcinGUaD6Ek6drCwxExYNCi9hb9LpHMgW4zQx8xlVu0VUA8wo+nJych5zwJsX/NXW
 JJtc9t10VI7iscIqqdZl5iPLIt/OFSkgdOexCHgwCUUoGYcl8MbpweTNJX+rf/Ih/zc0/JoWDNB
 sl1ehcXPypAC4RVc4GiLSJhVUWpqJzJbMA5IjkAHii6CXWQRB6pyWHnqLqfwImmiDPtSc783t2a
 7VH7G2jLHlU6uo97CODQDPUcWO9hqF4/CuAWpZPMoLP/pgjTIDjODaVt70bsrgczEo+H2BVdYxx
 TjXTyCh7k1M3C9zuKIg==
X-Proofpoint-GUID: PqNql7Hm2FDjTlkWWkIGQT1IOx8dwlnn
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fc3a1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=anB5c4ZMOrDm_4fku6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: PqNql7Hm2FDjTlkWWkIGQT1IOx8dwlnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260030

Hi Konrad,

On 2/25/2026 7:58 PM, Konrad Dybcio wrote:
> On 2/6/26 6:41 PM, Praveen Talari wrote:
>> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
>> manage performance levels and operating points directly. This resulting
>> in code duplication across drivers. such as configuring a specific level
>> or find and apply an OPP based on a clock frequency.
>>
>> Introduce two new helper APIs, geni_se_set_perf_level() and
>> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
>> method for the GENI Serial Engine (SE) drivers to find and set the OPP
>> based on the desired performance level, thereby eliminating redundancy.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +/**
>> + * geni_se_set_perf_level() - Set performance level for GENI SE.
>> + * @se: Pointer to the struct geni_se instance.
>> + * @level: The desired performance level.
>> + *
>> + * Sets the performance level by directly calling dev_pm_opp_set_level
>> + * on the performance device associated with the SE.
>> + *
>> + * Return: 0 on success, or a negative error code on failure.
>> + */
>> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
>> +{
>> +	return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
>> +}
> 
> My only remaining concern with this patch is this export - on v3 you
> mentioned that it'd be used in the UART driver (which currently does
> more or less the same thing, open-coded) - are we unable to leverage
> dev_pm_opp_set_rate there too? i.e. are the OPP tables produced by the
> SCMI servers not populating the rate field for UART specifically?

Yes, it is populated, and we directly pass the baud rate value as the 
performance level. Therefore, there is no need to convert it to a 
frequency. Since we already have the performance level value, we do not 
use dev_pm_opp_set_rate.

The rate_hz (frequency) value is equal to level × 1000.

Thanks,
Praveen Talari

> 
> Konrad

