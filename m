Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A148303C97
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512400; cv=none; b=M8w78BuJZzJ0o0FiQlCIKSS55u0nnm29ZaxY8C2RxbIKmtva22EOysXXgG26dhewIZvm4YXoCmgdc9ZjnbZUZkMLR2bZMsxrzRJ+PJzEGuXmeBn89a2Lf1e53AuKou5vUWt7StzHZH5B7pajZ3yXHGb+qj5JH32dOc0NlJYmHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512400; c=relaxed/simple;
	bh=vNW766IFB2+DzF8pp6Pv6LonUz6vSFc3tsbmLtLXQ6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hva1JG4mJiry9Zshyz2cBn6kMY6e/gauFt+ZNEWEJpLZ5zVihUTEWUDdGLPG4zJdP5Em1ib//8ETefkmsvFTMVVFyzpkvc6zMvNguhdYynmheNceDaS+StkgujmQC+u6mFvimHjMi4kgSHmxro1meGoQ4DJrLo9Hd3G7Zf3TGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N3btbEW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X+zjEEkd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N3btbEW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+zjEEkd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JA5bAn1624211
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yvBjsS8dM/m2taoBUTBY+/d+yJGb/O9XoBnXPJK6BXI=; b=N3btbEW+NNZnFii+
	1uWI90VEzMgkCX4UAN75fDIpRegoZ94H4jHGDd2E1qLacqacrMPRYC26PrrRm9t/
	rcyiiYIYNceNi6DkYHu9rsOcwGuMzIoGsJpyD9o1PpckYyZlrxAs7YG7nPmNMXUe
	eIpG/hi/U26AssqNL2Nf4y+FOvApf1sw+cpPz78nIlDeCCoCdsH3RnsNX2e7/CqY
	m6fO83abjUrtU7wmx/Srcv48pAlN+Zo88NO+oIrQd0VxoIst7mxqRa3cTXEb+SNb
	DgWFqm2QRRn4BB6lz5xxaT08gs0+3mTjF2LZ4OBThNqKa0hwzJPfmW9nM0YEj98M
	b8Fxyw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdc7uc10y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 14:46:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso985019a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 19 Feb 2026 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771512392; x=1772117192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvBjsS8dM/m2taoBUTBY+/d+yJGb/O9XoBnXPJK6BXI=;
        b=X+zjEEkdNvcxc/xbH5qcVJ7iQIAp+twEnN09yIJs8lXtULJfRgztbWX06VLLESTITc
         z3B3I5PCDSbyXuzhyNxqoGA45+9hPeMbYq9nHJZVTELKfHj1D2Yb0uuRc7v1yBFqEiSP
         IOMilo5Z5BNYeqLl1scHM9R9jabUXt+n1ExnBs5lKluSrYE3MXUMXZA7Zp6ka9b4P65/
         0FB3kEkMcXs6P31Vl+G9Uw0raGF293PBGJ3Lja/InvCvFmPV65hjeLKF1IB40HdpOLLo
         fkMzhb5iZ7jwY5tHWglrxwzEbVB5N58CHFSY1xSqZA1lG8NsVDBD4WIxm0xtIaSK9Hfs
         asWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512392; x=1772117192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvBjsS8dM/m2taoBUTBY+/d+yJGb/O9XoBnXPJK6BXI=;
        b=piT5Y+lZd3squ1PJF81gLP3YpUdtP/fyhjACXXJW7h6GrVyEJzw5bKwRSFdBqsE3Pp
         8GG7qJY8LzXIf6UmnWjpuWb7Pv6XSUI8ga7yTvn9o8cRjjGFnAA+4w44JkzZUyKLo8Ml
         VQhVLBTziPBfBEW+AOQeyhjmCzPJBtBjQ0w+tkiVN7J32VpJSvlYYdAzK3so2a4+ZKVJ
         T0/yKq54i/j69hIWLBQOySfWc2JoYCPU0eGHQ1ZI+ZA2vSfSmUu3fIyDV2cIXtEA4oKT
         G4RCSLtWGmOD+vJsZFsX7KE3rfsb//K4F/S38ha84FZDG/BRHGY7wDq8wTObaZfOb5WQ
         iqZA==
X-Forwarded-Encrypted: i=1; AJvYcCVFFoYrlMVXq3+ZA07WDuFq/g90NQw5qfieHCg4ditzatrAkvrJ3tUAT8KaexfS2l7sfp6lus5GppE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjnCnOxX1DSNNEOZgwwJVjRGCiJwSSAdUEceHip1VN4kE5QHN
	POFLenDUEnpdmxYbx9slyP8+NjXPA10HLjQDOywg7+E5wLJODr7H0z9NLTz2hsuNw+aCAlmHNVG
	R5IsmTV4Ft9FO3+Rsfwhycp92hxxSg62r4CtfTkAfDcnB7MyJZ/gJF4dwsIZJkMk=
X-Gm-Gg: AZuq6aIGgAKTkjOkP0Nqe/NCiTpq4r/tvFFXNPRG8meF2Aa/mhU54SfSX2egTURAtuq
	BEOacB/pV7b3A5Od63YnEIfxyTFy770AYVx/BvgZfWafvLfE5G2BilVBPxS7XwSo5H41yp3oM46
	vEJQwv3/VuUzkxeicHcv05T7RlpO048kb7X38dq5HgfKpCB3j/5RTKwKCQC9tIpFHVcTRfsm5XO
	ycmSy7zKJhJUCkoIcAvOeWuVLSsUCLOsf+uZxPpbY4J4Vt02P3Kpq+lZl4GNBXtSB0hd+n7h/4N
	F4DYywhpxB6SWLK8IJMjgmGHs3nJU9+TN7yoYk+ZySeM/hPfUlPQ7WE1F83rAsDc90BR16xyYGm
	PcmNL83rN9gUQLaPYCwDQfNMQ1fu31SSYlftjLUm9OTGYxIec76GQAg==
X-Received: by 2002:a17:90b:530c:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-358450eca59mr17324784a91.33.1771512391849;
        Thu, 19 Feb 2026 06:46:31 -0800 (PST)
X-Received: by 2002:a17:90b:530c:b0:340:25f0:a9b with SMTP id 98e67ed59e1d1-358450eca59mr17324750a91.33.1771512391299;
        Thu, 19 Feb 2026 06:46:31 -0800 (PST)
Received: from [192.168.1.6] ([49.204.108.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35894b32cbesm1520691a91.0.2026.02.19.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:46:30 -0800 (PST)
Message-ID: <12063990-70fe-4faf-89fa-c74c7bd97f42@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 20:16:21 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
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
 <20260206174112.4149893-14-praveen.talari@oss.qualcomm.com>
 <389dc762-bd20-44e5-a3fc-256b42f3c82a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <389dc762-bd20-44e5-a3fc-256b42f3c82a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M-YPud54ngYE51fx2fgOM7ZAFkk2vxDn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEzNSBTYWx0ZWRfX2dFuYswUs05S
 cG47NRmLefRid5XWC3grJj2bA0KjWGQMeckbztQXKAt0VkiOa+ncWr1lDnF45rwGt6YE7xLQ+mu
 MrNHYSwYj+CBUPkrEYCqSBZCIgDBn1TXmowTMCwvKmhOQig8vws5SqHjPr5qX0oxL5FnA9awaAU
 wp2QmAEwgE83NAKEY1ZjsQl6i9eDH/Pqc31JUZnFqjZNIZC+rcFwvQ0OMtwxE8FrAkuPef4b3gd
 J7N9ABVH4dB79MNGQtgNReWDVVxkcNoZ82sleyJDhcEnp2uI0RPmDY4Qj401eHQfS/arbtQtE5r
 elXVr2MNqefhDnNzKvAqMLmklUMblKXB6JhviMApab/pWgxtcgXKeonLdneMzNu3D5jLgdxC+XT
 y5CCVQ1rtBjMPHjzGzkRYRkUW3+PXFrjMhxxbPSC08nggrZBZ1ENMYn2Nh5hnECUH0iFOSrRnJV
 ar422gsnQ+so/vBYAhA==
X-Proofpoint-GUID: M-YPud54ngYE51fx2fgOM7ZAFkk2vxDn
X-Authority-Analysis: v=2.4 cv=daCNHHXe c=1 sm=1 tr=0 ts=69972248 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=SEi2w9hYDuVaAARFuk79KQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0Va3wKG2juJEggPPLkUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190135

Hi

On 2/17/2026 5:20 PM, Konrad Dybcio wrote:
> On 2/6/26 6:41 PM, Praveen Talari wrote:
>> The Qualcomm automotive SA8255p SoC relies on firmware to configure
>> platform resources, including clocks, interconnects and TLMM.
>> The driver requests resources operations over SCMI using power
>> and performance protocols.
>>
>> The SCMI power protocol enables or disables resources like clocks,
>> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
>> such as resume/suspend, to control power on/off.
>>
>> The SCMI performance protocol manages I2C frequency, with each
>> frequency rate represented by a performance level. The driver uses
>> geni_se_set_perf_opp() API to request the desired frequency rate..
>>
>> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
>> is obtained using dev_pm_opp_find_freq_floor() and the performance
>> level is set using dev_pm_opp_set_opp().
>>
>> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> @@ -215,6 +220,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>>   	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>>   	val |= itr->t_cycle_cnt;
>>   	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
>> +	return 0;
> 
> ultra nit: a \n before return statements is preferred

Sure, will do it in next patch

> 
> [...]
> 
>>   static const struct geni_i2c_desc i2c_master_hub = {
>>   	.no_dma_support = true,
>>   	.tx_fifo_depth = 16,
>> +	.resources_init = geni_i2c_resources_init,
>> +	.set_rate = qcom_geni_i2c_conf,
>> +	.power_on = geni_se_resources_activate,
>> +	.power_off = geni_se_resources_deactivate,
>> +};
>> +
>> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
>> +	.resources_init = geni_se_domain_attach,
>> +	.set_rate = geni_se_set_perf_opp,
> 
> I noticed that because this lacks .power_on/off, the
> pinctrl_pm_select_xxx_state() functions are never called. Are the GPIOs
> managed through the power/perf domains of the QUP devices too? (I would

Yes, GPIOs are managed by Firmware, not by Linux.

> assume not since there's a TLMM node in [0])

I don't know the exact reason for this node in DT.

Thanks,
Praveen Talari
> 
> Konrad
> 
> [0] https://lore.kernel.org/linux-arm-msm/20250422231249.871995-1-quic_djaggi@quicinc.com/

