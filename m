Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A483542D4
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792059; cv=none; b=VUCQdGxy6dTZiHVipjyabzpiMEL5OQrTwm3bIubm2ZpKqEad4Vj04PniusQpMNZSs21exaDSIfgv/PunhIhd5XYQxp6UUPrwMV5Qicuyz9qhnDpDvu329GxqiJZD0R5hnGJanEvS3vfeok/kg95b4EZL6fPGwYQ5+MhRhNRxRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792059; c=relaxed/simple;
	bh=cW/CdnUqHSo8CZnbbZvcXwLLmwlTJ7iZ14B0yAcTM54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUsopsqr3qi1alVS4F3doX4zhq2HSk5y/gkWWrS2DQW6Zb2fh5FpGq3zPXAI6h1gF5rfnayex/ssGY5gVVP63sXsO4peUxa2GDSz3QH3jc5FORp6c2nBBDu2ZjpO1tNIWn+OYNefzABIBVM8UhwcZY99M5hsWjH6EY2k/uoYdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cm3AW8yb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qzvg/QRm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cm3AW8yb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qzvg/QRm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UC6VQF1485695
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	awvAk9dpp7+jKmkbUjTkfr4pBxnpPpuKXslnuuCHXiM=; b=cm3AW8yb00HVORLd
	OvwbA+Ip6FEQUvKzXOGqwCN5OznQjPOv1NVLK1A/HYFKCSuEdlFjdZiVDFwd5h3l
	EfRDCZqNJoYcdsjZiSa8yomBySoYYiITJwaDqKqyHO57x/bF0d+HkLym2miXHzoE
	8UwwEKmQ9+2M/6wWLUUApPqtq3vtW9Or0k2hBVv5uQjahm/Em9d4Vm5ithH0j8O3
	f9r3cJAoDDiHcENv5cPS/Hc7K6dDPleqMsfUY0RPbegxXgyIhAXQFnlkwt8e84yi
	YKu6/e3BABt8sb3EIfCePROs9kq9Ks+hTyhEXjRvRwO3kxfumFWzZTvi+IlSczl/
	XZu7rA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0nsfa52b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 16:54:17 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a76b0673dcso24386355ad.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769792056; x=1770396856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awvAk9dpp7+jKmkbUjTkfr4pBxnpPpuKXslnuuCHXiM=;
        b=Qzvg/QRm1mkUarPvSRde/E2C2tfWU30m6gcZ6E1eaxXXZFPVBqMePqcGTkg8jllvTq
         8J0FdY5YL2e5pMN2Eb2Qu3V3Ytrj61EHoN4Vc0MyjToRvgEytuyW5PfmX4Oz3Iiy0f7j
         N3ga4ACCHkUgphoRPp66q30SQl0+oPvuhhT+dqfiNCG1wmdwzgZnvPPzzQneoC0/tvyE
         jzhfwjYPXkQv1viSk/xclPa7pKEJRtlK9U84qWSYS/fgorlElhfJ1VJXeGN3LZd9d9Pz
         PVhOY7LqIqjNl0I9Ym4Z4gg5uBAiM9u4XuHxHIRlX89vgGZAvsAYtTQG/4j/3NFp9h5O
         Bgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792056; x=1770396856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awvAk9dpp7+jKmkbUjTkfr4pBxnpPpuKXslnuuCHXiM=;
        b=FYtSu3swkCnNRVar3JXkLAxo7SRH0VfX4sSft3HJi9en/vpyiia4C0RZo7AXANoiUx
         f3P7oKoaGAKkm/zztPIwp9fK02guMmNb2EVDEC2MS1gVCVSyQwAxLeQHy53YtXHVKmk1
         x2siEWl5GumRutI6CkClBwKfA/WquxiyctW/q9Eq1EkIxB+z1xWaxqre8Ni/dz1XypK0
         XIfFvxfsNJLK7Tw9pm0WZRXc/403cKaFkHyMgRKFivMts7LE7XwKwn5dFA99yE7afNiG
         Bza5TLwlqa7E4b7seYNQRJyG+tFtS3/SkGKIMvMXT8i4nUxJ+UkxmO+VcKmMTpsL0WqY
         QUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQAw+tkVljqt8MY1lYMD2GV0n1G51vCMdh1/WqDR8ZBt9JVZ+4GZLlBSR/sC1rc5mmkjEuWw3qvjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexsil3QTSJ+4ijPdOdJuHFeBd1sjrRbQDONoik/cm3IPXyYlH
	nClH/LIjHrFUgn6ruKLOSG6pdas2ZW/o4e9wLc8GZzCY+b2Oa60q4j6xvvEaDNXI8xqh3rrN8/v
	VVFMvfr6T9GOwzrtKLep5LfBz1SsY9q4UOHYAU8yvvUgEfifceRv5Z9updlhj6Bo=
X-Gm-Gg: AZuq6aJrgbAXC8RQN8NWazeJ4u5Nu3HI0L+cTpDptto0SE7WhwtXGGiAbzAV/YDV7rv
	nhXcTDhvyMnA5jfdFsyWmhN7RP/2y9aprSxJWlUq6TQt34s+iMC4/iQo2PzkD6kDQ90QoruwlEG
	XtvACNTEpcN9aEuBFKOOqv8Y8lPmFGw8kMujiz8IUdAuqFMGWvyI33XqVf6zSqlwgV+al6RnB3L
	GLApr6gLVzG8WjjIZ345eHCkCaCQ00iOHN6krO7FP4Tnis6Df+ZbUrDPUdk7VnHKszLxgpzyyF5
	kZdlbL83rAyHWAm9SOo3cKNnOvMnJ6RjWYvg7nJjeJXaz5uTKyI4nt0QKHVe0uPcgmqSDU0vX/U
	F488V3tEzIm6YXXiqMfVS7OQ13XuU3lZvTYNx30/P
X-Received: by 2002:a17:903:41d1:b0:2a8:ac0f:9ad1 with SMTP id d9443c01a7336-2a8d7ec4e83mr39817695ad.16.1769792056415;
        Fri, 30 Jan 2026 08:54:16 -0800 (PST)
X-Received: by 2002:a17:903:41d1:b0:2a8:ac0f:9ad1 with SMTP id d9443c01a7336-2a8d7ec4e83mr39817365ad.16.1769792055824;
        Fri, 30 Jan 2026 08:54:15 -0800 (PST)
Received: from [192.168.1.7] ([49.204.111.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3afdsm78616215ad.61.2026.01.30.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 08:54:15 -0800 (PST)
Message-ID: <b918cfa9-1f40-4aee-ad91-d6425798bd07@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 22:24:06 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] soc: qcom: geni-se: Introduce helper APIs for
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-7-praveen.talari@oss.qualcomm.com>
 <af0eba46-329f-4979-8b8a-fb5dbe2ad992@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <af0eba46-329f-4979-8b8a-fb5dbe2ad992@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vz08fWPZc7N29sX8MEgmGWMhcot5nLOw
X-Authority-Analysis: v=2.4 cv=EvjfbCcA c=1 sm=1 tr=0 ts=697ce239 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=10aD+GSAjGS7IfLbEAHBKg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JTZeKb06zDgOFcaq6ncA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: vz08fWPZc7N29sX8MEgmGWMhcot5nLOw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX+eXTWF08aGdd
 zoURgSN7gxkAg5i7aIF04qiygsBMJbZxYCIQnPVin4i2jr8+yidML11VAQK0PIwSBfbHO9VGhOj
 Cl8KBfclYZgaHsADmjssicgBtKM9sZvt8FbZG2f9o1H575cuB3EdOU03v2QOqUgb9wZar/98Wgp
 JNuCdiaEdhvDkfV3E25W/FHy3b4TWt4fqS02SFmXbt6+Zgi9aFTPdDDdQ/+r9IyTInTmabxvt/7
 zIHmIfmD81Ar3p5n3P0WCLlrCXvG8yE8B6KR9D100X2mOqWuTp/foV+r0GNH6wVJXInqCCODTgk
 ptTYTrhVepyd9cXuCfEUFpjFC3QRsgyBPOenkoZt2YCtbJceWZ9eC4xtqbdD81p529MlijvmIAK
 Oq38a3AD9eBiAjVkceaBfycO64rYhF5cezG315YNxJ7XhM6QoqYFZYxbAs/eGJJLBxTtFvtp9+5
 oU2ny1KtPSVog+UUhXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300139

Hi Konrad

On 1/30/2026 5:53 PM, Konrad Dybcio wrote:
> On 1/12/26 11:47 AM, Praveen Talari wrote:
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
>> +EXPORT_SYMBOL_GPL(geni_se_set_perf_level);
> 
> This function is never used

it will be used by UART driver, not for I2C/SPI.
> 
>> +
>> +/**
>> + * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
>> + * @se: Pointer to the struct geni_se instance.
>> + * @clk_freq: The requested clock frequency.
>> + *
>> + * Finds the nearest operating performance point (OPP) for the given
>> + * clock frequency and applies it to the SE's performance device.
>> + *
>> + * Return: 0 on success, or a negative error code on failure.
>> + */
>> +int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)
> 
> I think with the SPI driver in mind (which seems to do a simple rateset

APIs were added as generic interfaces shared across I²C/SPI which is 
specific to firmware control, not Linux control.

> for both backends) we could do:
> 
>> +{
>> +	struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> 
> Then, we can do struct device * perf_dev = se->dev;
I don't think, it is needed since this is specific to firmware control, 
not Linux control.

Thanks,
Praveen Talari

> 
> if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
> 	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> 
> and reuse it in both cases, completely transparently to the caller
> 
> Konrad

