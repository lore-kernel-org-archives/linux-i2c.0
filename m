Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7E34D915
	for <linux-i2c@vger.kernel.org>; Wed,  4 Feb 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183840; cv=none; b=RLJbG4k+/4MWKw1etw1/Sxy+BxkK//YGQp6p4dGo1fBrcMnIEZw6T6wNDyar4izxLLtmWnz/CsRNcXrPlxoknM8p6MKhH0Gu2+SC0v2ZWfA1O+70VgtczsY71/rrjoeB/qGs/ZbFde3P4HTrDuvjovOTfOQIXAfpaeQn7b3WRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183840; c=relaxed/simple;
	bh=go6m8g8r//fiUrk5B79pQDICJEzKqS0qc5HSpLjpegY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOC7Vvg3Vhcax7rbD7PWG/lz/zXluXt9noCJZeu6uuhUaG9pPtkPSLLCKfYLqjoOuslwSXjr7y5TiFQ1R+sUBO3piAksVenXRYEH31ZkQYz3Monx65/FJJuClbSoFYipqhCBPfWVkJTlNnQISVxLcTklCioNt/ys7BtQz/n9++s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=htPMq55m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jc3iGYdm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="htPMq55m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jc3iGYdm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144Rgge2667050
	for <linux-i2c@vger.kernel.org>; Wed, 4 Feb 2026 05:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	POZ441e2LFMbxIQBK+YboacBpaYFysPEfDX6j0TRNhU=; b=htPMq55m0Y/EQ4Rf
	oO/D1UE2SoCF0JuHd5TI55XY9BQh0RoDqLs906WG1TCCee4UnauKZiDl+okExb//
	ngLSTRPfPO5ssMVIgLgCES7gNNn6S24I8igrHtKTf68j3AmymW2QsXANcJdBIWSl
	pLuRpwGjJN4n+t0rFE6YTOBVMQlpI6jazw5mbSVRSSGUoyxGsY0jg3Y28GeOS3h+
	il9ZHXop5mNHbsH3nDbHGRGYPDc1NQJ5nkrENk5OD0svTBXNcwnKkUOYmFtGz7BP
	aa7ZaQ4NkZ/YmGWNN4ACY7tXkqHsXWcsHxeClyiy0HrXwq6Azzhko84VCenqyiih
	BClj2w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3nf621v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 04 Feb 2026 05:43:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c63597a63a6so3957145a12.3
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770183838; x=1770788638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POZ441e2LFMbxIQBK+YboacBpaYFysPEfDX6j0TRNhU=;
        b=Jc3iGYdm6MY+SJBgggpd9RfrW6V7PYI7al33TzdJNOyXeviLTcJDEtgrP/yeVXw76p
         unYhxw4czJYx0N/KjJsYxSSMsbUDPk53Ggefn5rsN76lfswnIDUDtW6GRBvszvdzHa6/
         hYRlKqS7+b+rKed8ybecHvOk6FgqPJmJB5A1Czo7CeetWuuclY6mOgBBlgDq49LMDcrq
         xupDncWHi4J5FcXjDUGi64IeWfsTECOy045/40wjRImFlYGNsBZ3Bi9Z4xRVum6Vzxf8
         sHHv+eixVCyV94X0vPCkrclxB+jTZJ2BadaiKXpjvRjCQG35BK81YD/sY7mXYvxN4EZP
         78Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183838; x=1770788638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POZ441e2LFMbxIQBK+YboacBpaYFysPEfDX6j0TRNhU=;
        b=lGKWftVV0W3vRSYZqw2FLISqKiXjBws5dVWOqGiJc1X3SmIYCcpVOTsNWfpG6VPKD+
         2c3HmwA6h5qcUHXGU2kYMGOYO8xSNZAbMhrDNHNB/l/cjJoORm6+Mpswf5fCJXKHfEQP
         QKtynh8evzhTgLZXT1gjREErCv+c5H9XUze0deMvaVPeWy/iyFQ0OXRJ9pbp01d8bhnu
         I0yAcCj56pvi8e+bqBg67CqHm9k75+CbpX9L+a3OtW/TEJ9D1shp26x4Ph3uj2tjTTOv
         aHmN0dbjMWma8C3DvzOGqHUnejBSHPB1q9apD7QAVKLQkb2NEDMgpA0NIwQ7ZrgAjm3Y
         TLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/cKQpAqpJkX47v8PoH/VmysmaM5HeQnQ4PQ0Nz6aWkYy/fcO5yGelmsmAc3nwfgZjj3db+Xst7Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FRLXUpj/ph1H6dRVvtxq9yn9AvQDYTnJdxU0aUaAncAwRbho
	Q/8lXYQ5CcyqQICOG1ILJ58j0zsHbZEBZyGHFNV6CuBZelbDxoY1Y/VrJyUl2Ra/q528RvHI1pf
	jt+Z/lfcyUQ2yUg6yanb9hCHxGh7eAS1v0BOqZnXCHAR5+iWKeapWx359l3g2bLU=
X-Gm-Gg: AZuq6aKQvAT8bCfS8dva+2TUbWcusXeKM+GJx1MdEu8vW7aHrzh8VDgLfqbdztNupAJ
	aqRYaAg+qZGaaLsp6Yzlw0IX1rE6W5mGTToxccwRBeccIxgY1AwkuOQfUZn5QoAr9ovgiBOY7Ct
	Q+XeWiBogLzqWlzxmw6O59y2k61xiV14Yq18LTjwVplC+UHvae7L2sVdFvZzBYFxZT3TijmnLsn
	NsB1190Xa2D3KVdWkBMnNrftx39FbB7hK1S8N5RPmnVULa74SDYjqwymlM7usmcSMR/SsuDEpwS
	L5px+BqCJMBwWLt8Vog1azNc+oIpgKOXy43rWM3KM/BHlhztGL3ccUJ4TDOzgo3g8piNmMoBqji
	N982VWSH2CwaazjvqOL9XOR2evqntOqlfd7l8ABvvPA==
X-Received: by 2002:a05:6a00:4c92:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-8241c79edfamr1857625b3a.68.1770183838554;
        Tue, 03 Feb 2026 21:43:58 -0800 (PST)
X-Received: by 2002:a05:6a00:4c92:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-8241c79edfamr1857609b3a.68.1770183838024;
        Tue, 03 Feb 2026 21:43:58 -0800 (PST)
Received: from [10.218.32.171] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4a5c28sm1239114b3a.62.2026.02.03.21.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 21:43:57 -0800 (PST)
Message-ID: <bc743f55-75ae-42d6-82bf-593ad2359134@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 11:13:50 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
 <8e410852-37f2-452b-b851-19b7c4222727@oss.qualcomm.com>
 <e9d3c0b8-2abd-47a5-b594-83f0288d95ba@oss.qualcomm.com>
 <6e5924f2-a9e0-45db-8a79-b328ebd12a0d@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <6e5924f2-a9e0-45db-8a79-b328ebd12a0d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zuke5gcDgtHwsSppitv8logGO7y1bCum
X-Proofpoint-ORIG-GUID: zuke5gcDgtHwsSppitv8logGO7y1bCum
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzOSBTYWx0ZWRfX3JVoK1SxuRYp
 gkgVtsh/RvOySFnfoNUTN9vNCNEyx5wV5SfH7rLhMjqORrfa9WxTyLcMJrjyOdPkp0M6UYtLtMZ
 xCodcWXIjo81Xq2+cXOxiBD5XNqVgj9feqvPX5y5N3R9MNVzZCSYMnRYUtPH2ZFPur5H1dI1v8J
 sQun7T0REdcB6r4/JxrL0/hOw2YM4//11Y/8wtmfDb+X0LFXiDo4dsJXZgOSJna+aKzjAADQqge
 imDZkiA0MCVtR3bRkj9j+DuSIZAQFboyQBaJGb0++falQVlYYw7y8v+6RHDm0unyen3t2HzUXVw
 iyqS4J/HR8xQfbbA9xMfcNoV8BdmL30rSarOkzyMnuFwLtGtmlc5La4TY49gwDWdQCdGGLkD2jl
 P2tVyMBVzzaaOINKsCQgxYPmh2T1cem3CKAyXw8vn1TCMJFm34jkbZksS7L1vHk2uxUiAlvmi3e
 xzkdX/RXmxx2oWYJcmg==
X-Authority-Analysis: v=2.4 cv=doTWylg4 c=1 sm=1 tr=0 ts=6982dc9f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=WgL0-2sr_UKP2Gu6nnoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040039

Hi Konrad,

On 2/2/2026 8:23 PM, Konrad Dybcio wrote:
> On 1/30/26 5:44 PM, Praveen Talari wrote:
>> Hi Konrad,
>>
>> On 1/30/2026 6:04 PM, Konrad Dybcio wrote:
>>>> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
>>>> +    .resources_init = geni_se_domain_attach,
>>>> +    .set_rate = geni_se_set_perf_opp,
>>> This means, on SCMI devices you won't don't the vote on the POWER
>>> domain (or PERF for that matter) and switch the GPIOs to a _suspend
>>> state - is that by design?
>>
>> With PD_FLAG_DEV_LINK_ON enabled, every pm_runtime_get_sync() or pm_runtime_put_sync() on the device triggers a corresponding genpd on/off transition. These transitions are translated into SCMI power‑domain commands, allowing the firmware (GearVM) to perform the actual enable/disable sequencing.
> 
> Does that handle the >1 pd case too? If so, then all good

Yes,

Thanks,
Praveen Talari
> 
> Konrad

