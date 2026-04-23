Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317F38656C
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926310; cv=none; b=ApE7OpxjvHnFx7F8wkx96qMrRaE3uW9QGg8VMdfDZX0xDorbtgvajhBTXA1ERSTXqkE0P+RIjOrjpSa58+kCQRTfaXR2DLoodNckuXwkLfHvcWyk95TTxZtNNIE6FTB3NlJo0A6DSME7+WFSQBHsAWSIBUIyC2SnlAgT31fkGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926310; c=relaxed/simple;
	bh=f9bB+QCzyO4SPrZm1hCl+G5k5J3z0zeRKWEBzruI15s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiDvbTFxYQ80RlZaELI9sNyuk+mrf570HRRB4tBo8b6P2BiwJosgwC/S1bRlY+fm8yuW2nFIAq1qtEQmnBY93fw/sHrSmdtSu8kYBvxVOzYCE3FhFKzPsB8w9frzxC520wK7wxiP6iFvEBLWU8y9KhJ106Dbbi5Byg0ahY6G9pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elGp1avN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qr5B5uc1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elGp1avN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qr5B5uc1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N5sAdh2630069
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=; b=elGp1avNJTiNsW3s
	3fcfgJO9t4TwXaPXAcwz558CRkOUbF/p6+V05UE6/QrmEuqXddNB/jWCO0EwIODE
	uwZhWC4tfw9xRWWKbpGgKYarqfvR0n28STK6KdojyEQ4wtyA4+cZgpI6Zi/WYSN2
	U/msFi/Wy0ylYfI+okkTpun5qvbxP/8GC52BcwuLScthnD46oFUYIvVqBncHXIXq
	b4u6o+9zPmW9M2GeLVArhO91Hk4h5quqHGlQ3wTa0p/FDvM4llSqsewZLSDAKC1b
	J/D1ZY5k6c0LBzgMLzOswQl8A/B1fBUZ4F/nkazazWZu8lhGgxa9W6N9L5AGudnc
	r0toOA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq35ra4b8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 06:38:27 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so7806634a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 22 Apr 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776926307; x=1777531107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=;
        b=Qr5B5uc1U1BNhzRQhbGjkaFzBy1qOLiwYaeceriH6dLXB3LTTsKZ2/Jmq06yKS5w1l
         RzZWJJppTyBBHSBzB1BURqtKlyOJbqUbudS+Yd68YOs8GXtuEcZhjfLxOZRztdj9uugz
         1RtXx0Ud27KLSBVdytpoCvzyKwqLe6K05lKCR7CDtY6d/O0huZp5w4C+hev7u4DynD6S
         /LdbHRvmBWBtdtwI29AKxbENl60r5mQU0YpLt4DWeP16srcyXS1xfXDermYYn0udV/fY
         yKgQp6Ux9S86pZYX5NMV2BJaZqXbQz54b4caBxcb+z5mM2kCFShtQAAj626M8D70dNT0
         +5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926307; x=1777531107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=;
        b=s+Tb+BoUiFcs1CyglXq8QAeHm5jCNy56QTAAooEwUiehxTN0UUb5EXUQbKZHYL24KZ
         pd9D6DnAdkng0UEhtCbWIbAK/5UuVqJZPut1IBtzc5x+k83mBMxieM8bkffOmDKJ0XhI
         5xmwRIZyYwIsWfTm/uGovJ+D5s870Ih8RB/vNVC34cKFOPLcmkBhCKuKBDbBcNhAPgix
         VVfSiTi6B9VeJTBbG5lKK2bcncyMLVEmN2kZ/euK+5Pilh5KuhSJdPWtX5teQ1hAsspB
         M0n44MwK+IMVw7DDJLYx/nuGFFbt2zXCowD2IjkAf3jSsK0apilQqlShd9W2OMIU3S85
         dK8w==
X-Forwarded-Encrypted: i=1; AFNElJ9gzsigHO2BBcSpqzTlxeMtCjPwjz3QPZRLvrJj+nkPYVapqIw+JfjyfRhD1j3kzpN2Dz8w69S/Bm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIvLChWGQdr4reKz7yx8Mt1lygCv7QAQwlpqqa3dw4xsxc2Ta
	rXgVPc2Qx6ERhMi/gPNEtCX2D5PztDgPedUpbTjb3fV+RPEuh0U0NTsxvgAKygfDkblc3lxF83d
	5BIhIBXH7ak/JDauAJgA3kl0a0eJSLjh0UOTeZcxRnDrk3bhCk0h/TvGrJCX5FVg=
X-Gm-Gg: AeBDievVCruoWhwTSfy/+b1iKeDFmSDcBNfejWROZjxSqFMDWKUL5K9YkwZhiFhKqDv
	14KExjTEnstGiihz5YTdqBAJWE/uSHBKFPi8z79KE58ivaUMRs01rkI/ND5OMlXMY6zIZTcVZZo
	wy0gHh+hQUR1D7a/ixIxKaKSk5qlaoN5qS0zhrnE/m3xJBjWbew/dUIRmC+3bL7KFm/CD0ct+Hs
	RtkS607e7FhFbotGVaejw5uPMRvtYsjWmvVKu/v7SpqZlLFgBUjv3E5+KVmQqD0HNO/12wrZVrT
	6uwmWCAzeKM3ZEZmbT8g/+viUoAjrm7rIYSY9okmuSQSk4/qw809tVUMdw0slN8uvOYaR7pixTH
	ESV4PLk3gvjVfm0/hCbOxXEksM+LW4gsXzFRvsF7+Jvs1tEhwmsBWkqXlVHrNlDIxRtc=
X-Received: by 2002:a05:6a20:258c:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3a2f75f7de6mr9430740637.37.1776926306592;
        Wed, 22 Apr 2026 23:38:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:258c:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3a2f75f7de6mr9430713637.37.1776926306134;
        Wed, 22 Apr 2026 23:38:26 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f0811fsm14309121a12.0.2026.04.22.23.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:38:25 -0700 (PDT)
Message-ID: <8b2c1131-c05e-4c6d-bb80-55b812b0d132@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:08:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
 <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
 <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA2MCBTYWx0ZWRfX2U4qMT+TfrTz
 T+/37cvtozYPVP5HQ1ytAbXhP+78B87ShnOUgVFX3R+1irL6cTgWA/9Okct3kQlnhxSLvB/5+Mx
 Oreg9MLjmk/skV60o3SJnYOPB4UWPBc53Q8bwbdgBiSG33nmpDLtdX96guUhsCLHSwiKGtIT0Pl
 QT4P9YuoxWVat0zp91HasGy9+e2sFohWKfv6MFrP2k+kELH+eAeV/j+2JTxbcFXS1t/fhI8Yinu
 C7R8s5Elm+RngRDYKtIF6YaPL5wIpp2jd4uMhklBpQPfysShIIeebOfCoNxiVa0w1oq9ws9WhIM
 3HMksFTKoHvRdR21bl8cAsW/TjH8pyUwgjK6lnrwtoKujrLvjP1DAZ72+JoSPgJnRC225EnHh0J
 1pb7PleFiN4KLwATrGfCvCSaQAqFPYEpDTqmNm7fszwwiqnxA6vJ2J0skswDE3oX+S4wx9b5/Gv
 /GflEmWU8SHNuyvgZHA==
X-Proofpoint-ORIG-GUID: bAtAJYMYtKxq3ATndC9pDNaWvRVy13So
X-Proofpoint-GUID: bAtAJYMYtKxq3ATndC9pDNaWvRVy13So
X-Authority-Analysis: v=2.4 cv=f5J4wuyM c=1 sm=1 tr=0 ts=69e9be63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=NEtnsU5enKSBwt4-RL0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230060

Thanks Konrad for the review !

On 4/1/2026 3:49 PM, Konrad Dybcio wrote:
> On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
>> On platforms where a GENI Serial Engine is shared with another system
>> processor, selecting the "sleep" pinctrl state can disrupt ongoing
>> transfers initiated by the other processor.
>>
>> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
>> when the Serial Engine is marked as shared, while still allowing the
>> rest of the resource shutdown sequence to proceed.
>>
>> This is required for multi-owner configurations (described via DeviceTree
>> with qcom,qup-multi-owner on the protocol controller node).
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> + * @multi_owner:	True if SE is shared between multiprocessors.
> 
> 'between multiple owners'?
> 

yes, will update for next patch along with keeping below RB tag.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

