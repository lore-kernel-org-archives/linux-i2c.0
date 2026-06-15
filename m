Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6F36F42B
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781520904; cv=none; b=M4b1fKWDzVIhzj8eow1VZxm/h1A6FDiJAC0PEhxJ1Ef4arZsaZYEXycfgyLgTf6DQDbkbHTCJSblzd9bTolaUAq1Az9OYfd1+KizaIBW9d8vzK2lvRIIEq1y/FkBmVXt0nTNI1wXsz53tLuWykDAIz4DbYmJl3iq0Sy9JSuxMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781520904; c=relaxed/simple;
	bh=aOobQK20yua6U1wDe4oqjNjdHc04iURP9CqK2Qxb0s8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PcR3SH+BwtFlfsDhCHS4dMGh5rKLzyqy5nQPkwmxBfjcdtPblrns7k+/NuuWiIbkd/RXSkAGnLZuoyPkCxeYDokpJz0r0UcAD1xVFIeGmcc8hwtCWnFR7AJ7qbOeZGAq2jgh7L0cumFcaCoCOehnO1nVhoGk1O+3RiOrNNHKVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IlzXNYWl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kmKg3/zR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IlzXNYWl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kmKg3/zR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FApH3S359267
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 10:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Io1gymftJRX223MXNKXCnss6iPbXrMIBvInvnj4sz+w=; b=IlzXNYWlmbirizL8
	vVPYMvIoUdW72ETny3pXNfGEc7zj6xdkb5DCEkvsrAeAnJJBXJUxh2pe3gemm9XU
	ksRqae1fgMncGsxBILgRbgkUpaluRddEPreM7VrewaZ03/dNKZBCXMORXH0JYYyB
	Bkk910+CDlIYzmuE8aLH/LN6qhNicKTr9LcZHkncyjjmCuWlwjyqnlJYSGWO3WOU
	x8/3yzT9azu3ADyL5DVubnJyO3CiTuExseQy2oebu63uBIs2yVGsMD7mAML7hZcm
	tjeP7qXrntgckCOsm4otD1ZwcicWhKjKJPS3BgpxJ99EU4rALYLQxo7NWG/uOZH2
	ICB/Jw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2c8tec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 10:55:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36bc380fbf9so3246187a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 03:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781520901; x=1782125701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Io1gymftJRX223MXNKXCnss6iPbXrMIBvInvnj4sz+w=;
        b=kmKg3/zRHh8qcNX92rt+XDvicKlN6GnG4doPa/kTzFWfmSwA6ws2Bjp8UTcLaohehs
         D5pjFGtux2p8Re0FyC8AoDnnQv2W7baiMsh2rrZnfWqbyHGpINucSHeGXXCP5X4uxR5v
         7xsEwdN8NZHmChcd91dDYlbGIhGa82/dNbG+u1KuCv06WxQeit8xXSgO7psxpFkZCO4p
         KRR9i5Hbst1McvBerUSQiCAo19b8x/tXgtcKPxKYB0LAfqPhaOrL/DGI9WS+oL5j+ZCH
         j+57/EKJIYW4b82rZO1Nk0JD3ay8upy/KdZRfynxdK0rAaICKz4JNdIIzvKkZV7j0h3U
         vNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781520901; x=1782125701;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io1gymftJRX223MXNKXCnss6iPbXrMIBvInvnj4sz+w=;
        b=NWLax6+RSJYcncv9+PivFIdOmO801sTmgy0rwuFTamqRh3fd7lxVyI7adiLoUyidS2
         W/exV9EOGP84cgboaUG8194kxs5AF/co0SAX+gVx32bry6efUfgsWv4dZE8GyOKB2qvR
         JhPRDMwOjWAZOVXdhIoSFG4/IMktU5497H5DBaEDi3zb/N+d49ZaigLefl8OxJ9WgJ1L
         Ra4m74/KzgZisf/0bIuZqmxAObH+JPPUBcL+G1Q8DHJUe51VNRAbLlx5klOEk9eJ96yE
         ng2CM/KRhaarrPsqY2UIFa1e/rzA+RLsNlAwoQ5V1KGEI2aCwfmSX/DnfDUeaIAFYksY
         a+3g==
X-Forwarded-Encrypted: i=1; AFNElJ+UbEShXpMlTYlF7WKlaQQN9eESHVDBOH0k0q990UWKEDQwbRtKYMRjwp/Y9MlESwBBWmx7/WKLDGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxma8BWM+8v+QMyVWbl1sZ71LB71uSkCml3RZsVerfhOTkvOYJ7
	2VkzgieaZfYd7IbBknseL9qmT2jboREvxD7qnCNt+jTm9pbPSlCbzHFv/Vmae+WJaiK2se3SwQW
	BxabzelT9YQv1r99F6Y8AJaukO714tvqOtresmXAtvG0pXuwlvh2eyyhGusHE28E=
X-Gm-Gg: Acq92OHB9I/Z9dfR2Bjhs6oMY7+PE6Bf7TDKHp7sto8f81CPEVviWVhYQ1jaYihg0Ex
	iz9Wk5F1LvT5BkM6FfyfVjLy2Hh3MtPUU+EOEdBXZk1TxIGPIoNHqwZ8jlaTqU9sMEN2RrEWTvE
	xkiNzGq9nKem78+ezIPLWnOC9gpBRFQrLgutmGqFzfDlH4HhE12jL1t+gcMCCKTc3Oj7lLz8cPI
	UGb3L+xLJF3Fv/Jy3ljUAK+Mc1pOHEUEDZHit1mu1LRmT5b4FszUwAER4whWA+Frl8QU4g/BKiM
	F4bCoLI4kPyzTj7u9TRmQKxygRoButdBUD6QFDd0Wrs9oNhQxHqbGSixouzdOnOLI7WNO/YoBto
	DOmNYJfniOH/VEaWn+zmK2FRucfJPLOz/hMKuGBqO4976T37Ot5Y8NtA=
X-Received: by 2002:a17:90b:48cd:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-37a0497dc45mr14457459a91.24.1781520900648;
        Mon, 15 Jun 2026 03:55:00 -0700 (PDT)
X-Received: by 2002:a17:90b:48cd:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-37a0497dc45mr14457432a91.24.1781520900191;
        Mon, 15 Jun 2026 03:55:00 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a212ab3d0sm12470200a91.16.2026.06.15.03.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 03:54:59 -0700 (PDT)
Message-ID: <4d8d8c44-6611-4333-9906-580b70235a51@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 16:24:51 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
 <20260423145705.545552-4-mukesh.savaliya@oss.qualcomm.com>
 <ag_HGVQjIQuMoKO6@baldur>
 <9a0a2ba2-4f1b-425d-979b-fe59192bb2cd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9a0a2ba2-4f1b-425d-979b-fe59192bb2cd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDExNCBTYWx0ZWRfXyfrETM4nc8m5
 lyMB6UM+qfcph8NYt+7GIcwfKvAWBbpP3blpGYdSxUmfNanL/TP5QTE1fTFdQmAcKyruMFRam/P
 tzA2y/HNBnxB2Z6juKRS96PCBh/gvA6ii7zRMV34DV28T2Kq5MswvAV1ZVablYfUeXeVdCHxXf0
 K6vmvzyEajSDPH/AgEQEIVdXpEELI0EP6jlV/XPeCttqOVJx5GdkTGmhmgpp/tGqUfx3D1QX76S
 SAyNtR5Xod8XdQhnDX62GJ2XCPniqFf3YAz1P70gfOftW5OXdEHb0eXqTWWrvmPpU0t7f1SkVcF
 laKuFThn6ZGk5WpU76EqGsHsjtqyPaEx3LfwX6nrs1m+tKjGA0y0Fl7IdvYmAjSzM++o8UhNHab
 Nym4GBIXhyqbyKHY1H+JYq6DUHZOLMHN0V3fqYJEZlOGSZEgQm+dzuCHIb0fsRnxWEhjFCmMbCs
 6UPxmf8ZfhlC1Vq5Sdg==
X-Proofpoint-ORIG-GUID: d6U1VgnWMz9q0IBTUM02huBIp1k0SXzP
X-Proofpoint-GUID: d6U1VgnWMz9q0IBTUM02huBIp1k0SXzP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDExNCBTYWx0ZWRfXyItqyQ802sa5
 N8Zic9CyzDT++HVIt0UyC/BJbZMpqF61z4GN7RaEjN7/N90IcCgweQS/kyK50pfAdPDxMPBTiq9
 KBTNylWA+43NgcEOhp4Lktij40lSzew=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a2fda05 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LqfbpYqSe3J_4supPSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150114

Hi Bjorn,  Please help next with the approach, accordingly i shall 
update next patch.


On 5/25/2026 12:46 PM, Mukesh Savaliya wrote:
> Hi Bjorn, Thanks for the detailed review.
> 
> On 5/22/2026 8:36 AM, Bjorn Andersson wrote:
>> On Thu, Apr 23, 2026 at 08:25:50PM +0530, Mukesh Kumar Savaliya wrote:
>>> On platforms where a GENI Serial Engine is shared with another system
>>> processor, selecting the "sleep" pinctrl state can disrupt ongoing
>>> transfers initiated by the other processor.
>>>
>>
>> Isn't it strange that the DeviceTree will define a sleep state for the
>> OS to select, but when this other property is set the OS should never
>> select this state?
>>
> 
> The intent here is that for multi-owner configurations the
> “sleep” pinctrl state is not safe to use, since the pins may
> still be actively driven by another execution environment.
> Selecting the sleep state in such cases can disrupt transfers
> initiated by the other owner.
> 
> You're right that this constraint is currently not described
> in the binding, which makes the behavior non-obvious.
> 
> shall i update the DT binding to clarify that when
> "qcom,qup-multi-owner" is present ? The OS must not transition
> the pins to the "sleep" state, as the hardware is shared and
> may be active outside of Linux control.
> 
> Alternatively, we can also consider relaxing the requirement
> to define a sleep state for such nodes if that aligns better
> with DT expectations.
> 
>>> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
>>> when the Serial Engine is marked as shared, while still allowing the
>>> rest of the resource shutdown sequence to proceed.
>>>
>>> This is required for multi-owner configurations (described via 
>>> DeviceTree
>>> with qcom,qup-multi-owner on the protocol controller node).
>>>
>>
>> The requirement as such is reasonable, but you don't define in the
>> binding that when this property is set, the sleep state must not be
>> selected by the OS...
>>
> 
> Please let me know if you prefer second approach over the first, i shall 
> update accordingly.
> 
>> Regards,
>> Bjorn
>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>>> ---
> [...]
> 

