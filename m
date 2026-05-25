Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320CB3CF677
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693382; cv=none; b=MS8cLPSv0sHTvJLMIszuA93EbvBtJqzfMdDbZ0mnBTIbTABTNHR9at2L39KTLN2q7tFyZrIoV7YTN1aX15fNXO39CvJdWr6r44Pee7uTQXfeP/vFmB5ms5vUq9idL81ff1sMCrFnluco4/Cg2fKpsyP1ZL/16uxNycZdm6Q8c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693382; c=relaxed/simple;
	bh=I2CWT5X/+wO3lGtzQ8XKY0hFFrg3LJ5WWF0j3IQr0r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y65VceXe2f/YG0aRLPfbmGNX7Z/Wc/F0S27iCMA4OY8xG1a9Iz5jZjAtaEWgAVoT5d6HiX8V1Le0j8Zz1A7bq8lJar48jjnU6df4A13DDwFW3YzmC11wiVa38ajWH0446hRNW6xRF/v2GjKF3Hy14wHFipj4Gq2nAMU7oqG3M4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ty91wsRl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aVomSAs3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty91wsRl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVomSAs3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OLSwJA1791995
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=; b=Ty91wsRltsoE2oun
	2PO2cc/LxU2VicEvx+xhM0DT1g56wkfPJwiU1b/ZPAjxt1kDHLFBcBh/YLNrgNPe
	2W9NNSG+e90RgsV3NV3YOMOsADAg/1ZZbA3FI6DnlIZIIsxl1zP9tgsZhSepS9gN
	+1q41CXntP3uvObjVjkhXK3oAe8w41fKifJTv4MZ/c/7BXINH0cDtiY+ocxs4dIq
	cZ5aNAATzdtRuq3p+9UM+Cz3oav1yCd3FpQqRyh/hqi3cZWI2Fkni766b8EEFShR
	2/xPYY72UaBiMggSRrdiRdiiIoaxI4k6Oc/fubaDSHs3rTPW+XlD2Bf1iH+PeO7n
	IAbwbg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgwm71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 07:16:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9b8137828so94969585ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779693378; x=1780298178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=;
        b=aVomSAs3bxb63VmdX5Pa1GuIrA72a+ZzgxnDM5DfOjF/nv6IYCrhh9QhpftFswP8mR
         13zlF5PuRX6J7xmqFlzv3iadCMKPOlpBOedTDAJz0ym7hnnLBu+sCLd9XLE2JIQz8hQE
         xPw+dbCFSrgnrMdNLw5kSDqL3+VvqzvVa7X3Jpa7Mr0cWOSGaoRX/B03wysG4QDfNh0I
         JIef0SspXLGD4AOPl4thtd67vCFhJBduKRknmjz6wYLKweuDtr0BBvHMOz2MCeLVrYm3
         ZyMDF7DlNUlgnH8ZjoppjGE9kLC3C8ZZiPVHcxn9XR1HqBD4tKvmKavDAL3NOxboYdz1
         sAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693378; x=1780298178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfFX/9N/HJ+7ZdKXlPX+dckwA6rQWh6qJncjMyHbYV8=;
        b=TLrptm66uwdfNsSwwoC2SANoF5sigwX+Dt2MQWMz9jDUM3ipsU2uAv1kyYLM2tLQVn
         Bqg1odlV+8hQ6zVHGW4a0s/SB+VM/ewRvm68KU/KVBHLETStGZc8SBOXIgXuj64Fx/4a
         wtmF/T3RQHU1SjY9xORHCRyg5rPLL6K0e2hr1zeLqq3ZqqcI1/Bc79M/ZO6IjQPHZbQP
         PpdbvdPpql7/YH0VJGhvhhUusb7CkqiisVFaha90WNzmM7Hn4mjtR12LnXMcFWL1XI+j
         gQ1s5YQ6wJ/HWC5NoOhqu/WgODs6beyEzA/A6o2V+HNqQVESgTvcRMncUyN8qHXDQEyl
         haTA==
X-Forwarded-Encrypted: i=1; AFNElJ9W3WAcEaH3ZPN5v116A7q6dBBEIIqvrUgj0RVp2dyqazZ72VK+99pFK7av2XdKqSLSz9rZeJ3hUEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi47fqNkcMvg9rjJMFypdgZQ9K5i5dvWh+RH7uXjV9C2Z3Uj7
	o3U3akXR0iYCXXNE3DpJ3Y6Jc+KhEfHthboJqkrEGiHGJq5St8PZn9F+6zLgIuJKsrtn0jtyCb2
	LBk9jC7aCwLl5rJqW6AfnrQOV7Ro8HCLkf8VXz/JC+ryNI0agDBBOyyMNBSoDWtk=
X-Gm-Gg: Acq92OGvOMPPEU1dnS9sGZoRy0BLzzlGBdWed1q4SmtzoY8s9cBgPUvcZ4nONzUvQxc
	QRP4O88QkL4jXvdzRsFy+yMfDnDEXCT5ud9uTC8KMiFFfPtxLmCLnFnV4jpVtcQe5FbvwOoTvcL
	R/4/AYGNocgbWWiALOX6zCK6JfMEQKDIA34AbW8yTi/biAFiOlvaCoD4SpSE7fwEJkx4cHMXiYF
	WL0DLpZjwf7XvNQSjJhWZ5i6BXjBAqLPHPVGAHZ+eGWFmiMNw35enpPaqQN/rBknHg9me1xEphz
	/B2zFzPovG4c48SZpyR7DbFht2wo1szEgy7Wlpk00+JXdfd9/0ZA9G17DYDx42WVREtpfwF5vNx
	iSuXSbS8WaKd6bOaqMtV8O3DohOVHI54QkbdQYrwUsiOfbn/9yWGHRw==
X-Received: by 2002:a17:902:cf4b:b0:2bc:dc0b:ab1a with SMTP id d9443c01a7336-2beb06fed74mr142505075ad.35.1779693378046;
        Mon, 25 May 2026 00:16:18 -0700 (PDT)
X-Received: by 2002:a17:902:cf4b:b0:2bc:dc0b:ab1a with SMTP id d9443c01a7336-2beb06fed74mr142504475ad.35.1779693377420;
        Mon, 25 May 2026 00:16:17 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm28566265ad.2.2026.05.25.00.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 00:16:16 -0700 (PDT)
Message-ID: <9a0a2ba2-4f1b-425d-979b-fe59192bb2cd@oss.qualcomm.com>
Date: Mon, 25 May 2026 12:46:09 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
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
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ag_HGVQjIQuMoKO6@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LDvc-qPItaiw35h0iDNXSUIwAgCEgBX0
X-Proofpoint-ORIG-GUID: LDvc-qPItaiw35h0iDNXSUIwAgCEgBX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2OSBTYWx0ZWRfX6jZCLLVE9S7K
 coQQhti2uS81ogKXVVjZsvDFTLAwdGxc8q1Uu9G4D/LCyS4K+Dwqg1tAqsRTWLs0TvMz8795vnm
 hpUZRK1JBwxMdmt3LF9Ubn8fNlCkg2RKcYJ7uiyoSmUF9g3o2gbuJCpokoflXZRcWlqZKOova28
 Y1q53BHvgcL5X9LBq+DOnRz3bYZLo1BNyGFOTB/QHP00/BOApqry0vgOfM0fjSG7NmKCKJABI8y
 k+OIiwTjQfie1C/gG3tl4laoB3XMQVcJHgmqkJrDZuM+HxjlEqNH1RhzH6nh7VSKs3EPmIkWY9+
 6zPGA0JD+EOClrG0IGOTbFSwVSw5fkopvyRfLBWtaPLNZB1h4bfkLt9nVOn+ydBfRLvCE9b8Pou
 ujQYsJFIRHjsvbFufXlW11M0vr2FbFUy2cU+4n9xFIxLuwInNkO14rBVTneV6DT3jy0PaUiowOJ
 AimH34MzMFR8DkjdNlg==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13f743 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=XeA8sPVIX9ygFgyEX44A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250069

Hi Bjorn, Thanks for the detailed review.

On 5/22/2026 8:36 AM, Bjorn Andersson wrote:
> On Thu, Apr 23, 2026 at 08:25:50PM +0530, Mukesh Kumar Savaliya wrote:
>> On platforms where a GENI Serial Engine is shared with another system
>> processor, selecting the "sleep" pinctrl state can disrupt ongoing
>> transfers initiated by the other processor.
>>
> 
> Isn't it strange that the DeviceTree will define a sleep state for the
> OS to select, but when this other property is set the OS should never
> select this state?
>

The intent here is that for multi-owner configurations the
“sleep” pinctrl state is not safe to use, since the pins may
still be actively driven by another execution environment.
Selecting the sleep state in such cases can disrupt transfers
initiated by the other owner.

You're right that this constraint is currently not described
in the binding, which makes the behavior non-obvious.

shall i update the DT binding to clarify that when
"qcom,qup-multi-owner" is present ? The OS must not transition
the pins to the "sleep" state, as the hardware is shared and
may be active outside of Linux control.

Alternatively, we can also consider relaxing the requirement
to define a sleep state for such nodes if that aligns better
with DT expectations.

>> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
>> when the Serial Engine is marked as shared, while still allowing the
>> rest of the resource shutdown sequence to proceed.
>>
>> This is required for multi-owner configurations (described via DeviceTree
>> with qcom,qup-multi-owner on the protocol controller node).
>>
> 
> The requirement as such is reasonable, but you don't define in the
> binding that when this property is set, the sleep state must not be
> selected by the OS...
> 

Please let me know if you prefer second approach over the first, i shall 
update accordingly.

> Regards,
> Bjorn
> 
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
[...]
