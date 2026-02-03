Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30732D44F
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117194; cv=none; b=g/xgoYeOaf7ATMryyWtqWnDGEXZsZ4JmFuPmyovLQqwBKnVAaGwhhW6QUqEj7txkL8PtWy2wP/PToZ/W2zUNR+Giv9c6IiDHgiByWlv++sBAViMxqY1R31oAD1jYnDQBZEfVqgg9WKzgJua44IfBNSTDbLEyWLO64o0BNtzyaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117194; c=relaxed/simple;
	bh=UL5crj32LxmPG6U8bVc8ffJ92JGOhQqV7xLc7SgFcy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN/8BW/mp5o9jotAE0aG+izdb4nR6WzCwWziqPBMkbyGxL9YpwFEQWWsLx5L478iVTcMgZ4E0RiPcVEQ7LE3upoP+hS/9DKYw0+QvXsSM1ANU0blYh3dI4jJjyg/emV4zRv2TNQqo8RYnzsAU73Dnny0tg8fiBqL1RDFPXbxt00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6hPqAPt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L+N6mY7I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6hPqAPt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+N6mY7I"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6139eY3n3387813
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 11:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J3S60jnKUAOx2q0OJoK205tv21uIelwgA+YKFqBt1g0=; b=j6hPqAPtllLfvxyr
	sRknqsZ3WEFMQRXyMd33jiYqK0Igv4EdTVNmswayjhxswmVOMNRF1NZjPlj6CKZu
	IpiGdmAh6pss8wHwASBIa+lV4kXNajXAIfKJyc+NB+6qwIZc72LSm21D+j0lnMPm
	YYvDEa/JVEg1izfTIRPaMuYA9X4z3IFw4zNKkLBfyGR68p3JNdR1GT36/T9F9o+l
	8IQERMFGfGkt7XIcPix8OmyAL59XqWXKWMAatsVm/Qs3HFGCujOZNFhS/RgmtIke
	zuESccXa44N0rV7uE4LmBdeAsFVgMmDxxmqWMcl77oBSPErymMPcUA0rFFmtXzpO
	RuclHA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2xvbu7w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 11:13:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894662cba4fso13798516d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 03:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770117190; x=1770721990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3S60jnKUAOx2q0OJoK205tv21uIelwgA+YKFqBt1g0=;
        b=L+N6mY7Iy2TyYy56puNC5UyUXjlSbh5xB8DLH1/SMq/fyjfnNxieG3lFrF7Up5MCBX
         20ywFe3M1I6qCGh/Z6DLQaAXOW/VH6SMFHza77/OaouZR4BBtG32ZKg8ogKlygYWl5H2
         g0qE6CBeroJ3Cd9fvqb4c3g4y6JECtrvUU4gs6V+EwztuxACeO7cjjEjtvhSo15eU6zX
         cUVCoYDZrRTVFDfvShfmF5KP6KiVm5PxLTYwQ9Yu504iPt9RpDQdEr4AuBOlWlJxYlWB
         QOiApi0LnZnV5l3i5/3DsYvtIL/PtYEO97vwTTki2H+uU4UIzm/9YNVdctu7fXDjXggB
         VQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770117190; x=1770721990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3S60jnKUAOx2q0OJoK205tv21uIelwgA+YKFqBt1g0=;
        b=WncHDQCqhlTCZao/1hsZbd30UUK6jKhf4MK5RyGxQYZ3hVO/ZT+Iddy9MR+SNck/V7
         U5hH8YEk+Xbph/C9FRtxFVeSVGfLcAcXE9/x9PhKrDAKjXq8RugJXspqc82RfaiACd1t
         HJvlsrraaYEeWY1Ko0H4atigGQuWlBy18KvQHgsYf16Az3yze9efZjjSnK8g4y3HJ3QA
         G1Gj1lucNLhz5e/X+c1o6lg2bOL0Ze0mnDM/FdDBqn/3H7mQXFroU0lJj3Sh4kYyKb9L
         5qSU2wQV5qs3CVghqXPtlFEZz+WLsJ5C0OwAvfAFz598+KbvpmgE1WtRUvsP2/I40b1e
         kPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyOBfWKy0CQYsYjbbE5THyDXRH3k0Nd7ItFTtJit6JkJkF9prI0ARyOjxWEH+F/avIwQkg+fy3N54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0jBVG/aCv4a41khPtSMLlbeSM7jb/baRpiGH8HNO9A3VOKPm
	Xb6sQFVnpUVcNY1MQBOLzPVVHz7hRc018M4xvmi33FsTi10GC6llTdcXf0ViKCLsgasib8kqYbF
	LsDtj8IG+7/JR9IDpJY8wrp0Gz+urJU8ydXLyRLxu8FrOqVpD1cI5EsfnN/vUfeY=
X-Gm-Gg: AZuq6aKDiA3Hd/Y3ZaTUw51RbZN6SoKwIJ4pUrQO01xRQk5D0Ns9Ar11gebXBZ5Qem4
	cugOATtu+u/RImzW7vyYJkAJES2AYCtHqeEgGyUxAV2aJQpuxUocEu3Icm8sne+jSO5vAeiPPGt
	9qBjrFpnNqzO5CLFLf4rwwCZxW7e6yaV3uKoiKcf2qzmmo6sXfyeqbtx9Bo/AnkhhDCa5sqS6CU
	ylDHTSkVg0LX18sL7HX/ZHbLSVlMRcWa1U9mO9pmgaYHzW5bCuWHXuV0vEEQ4pmlPaHK1vzz3KR
	UEsSuMxI77GfJSbVJ2r+u4OFSDrD8r/6pk3am67cBI8XCuVTRisDIoV3Qi7Q47Mnbd/VsnisN9D
	hDKzW1cnBfiuSabwB5Icp3RbbhzcbEuzal8uBCPnjy0m3mb8Zj2pEEjLU9K9QN7/8e0A=
X-Received: by 2002:a0c:c3cc:0:b0:894:f6b5:4b9 with SMTP id 6a1803df08f44-894f6b507e3mr99932886d6.1.1770117190040;
        Tue, 03 Feb 2026 03:13:10 -0800 (PST)
X-Received: by 2002:a0c:c3cc:0:b0:894:f6b5:4b9 with SMTP id 6a1803df08f44-894f6b507e3mr99932586d6.1.1770117189615;
        Tue, 03 Feb 2026 03:13:09 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691db4sm8965252a12.22.2026.02.03.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:13:08 -0800 (PST)
Message-ID: <638daf43-d80c-493b-a88d-18bef447c02e@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 12:13:06 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
 <ce78b376-b581-4053-aa23-4f41ea0d140a@oss.qualcomm.com>
 <e887a7b5-d2ed-435a-9961-5a64b0494351@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e887a7b5-d2ed-435a-9961-5a64b0494351@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0FxA6SpTSk8iSiXx46TS_eChBUsURSLy
X-Proofpoint-ORIG-GUID: 0FxA6SpTSk8iSiXx46TS_eChBUsURSLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA4OSBTYWx0ZWRfXxU5gAdzNF1V8
 Wd36Q80u7pZV1g0cByAbPjtcSxQay4X9ed7GFj/Yyebqlt1zl0wfm70LAc235bybmuLGxRAzF0i
 SfQcSev8+byjxOY+xyZA3gkEIQgcK9aVxSgdRqVkxFFHmeqaTY0xfCo5cdQ0kshxdNI+nuzpE4l
 6cdK0LQnvdmRS+ifN1JxFh0INOqcX3DRfJceINbH5mGLt6gf76RrtljmtjsIdnf977TC2XBZ6O2
 YjRZiCUPfDBubhswym70xLnpRzkNPPdWAGja9XnVeqghJ6TJRldsYNB3G0PJCWTWAeMoZnqUNJl
 FAB2ufkwgJUlccVf+hXmFjv6UnhyfaVG62roecXogF4Gs6Ax5byjmOE/7TgQkKFqQWcbeiVw0o7
 kfa/AJhZDV0uwXFBuuytRVo0UTBYUyvjPTiAifponxifpmi0h5UGgX0cMu793dj9dpkJ8bKOIgz
 tbqjwz0WZeFdgWcK/MA==
X-Authority-Analysis: v=2.4 cv=AurjHe9P c=1 sm=1 tr=0 ts=6981d846 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8FF4YKaOkL51pCzONRQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030089

On 1/30/26 5:48 PM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 1/30/2026 5:35 PM, Konrad Dybcio wrote:
>> On 1/12/26 11:47 AM, Praveen Talari wrote:
>>> To manage GENI serial engine resources during runtime power management,
>>> drivers currently need to call functions for ICC, clock, and
>>> SE resource operations in both suspend and resume paths, resulting in
>>> code duplication across drivers.
>>>
>>> The new geni_se_resources_activate() and geni_se_resources_deactivate()
>>> helper APIs addresses this issue by providing a streamlined method to
>>> enable or disable all resources based, thereby eliminating redundancy
>>> across drivers.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>> v1->v2:
>>> Bjorn:
>>> - Remove geni_se_resources_state() API.
>>> - Used geni_se_resources_activate() and geni_se_resources_deactivate()
>>>    to enable/disable resources.
>>> ---
>>>   drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
>>>   1 file changed, 5 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>>> index a4b13022e508..b0a18e3d57d9 100644
>>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>>> @@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>>>       struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>>>         disable_irq(gi2c->irq);
>>> -    ret = geni_se_resources_off(&gi2c->se);
>>> +
>>> +    ret = geni_se_resources_deactivate(&gi2c->se);
>>
>> This calls dev_pm_opp_set_rate(se->dev, 0), dropping the performance state
> 
> This does not apply to I²C, since I²C lacks an OPP table, so the callback is only relevant for SPI and UART. All the refactored APIs were added as generic interfaces shared across I²C, SPI, and UART.

Does the i2c mode not require any ratesetting on the SE clock, or
any >= LOWSVS RPMh vote on the power rail?

Konrad
