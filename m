Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39013345CCA
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917687; cv=none; b=Bz+Gn32NmzVD7cwLdIMcs3HveoFWnkigsPNWNCTFMHeC6ZdLI1LB5EN7JE2B3P2jY84o/3q9tG8L8E4XwcPOUDgAlgqnu8v1FsDUzJqaS2SzbJpun1WSrijW/XTljpmOGG/u+j7Bx2T+adQColPsEV3lCeDsZbLL/sfYpMXWbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917687; c=relaxed/simple;
	bh=OhZ5bZyZvFv+YVsQqcgwaQ8I/MktFfOiWecpFw+qzXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ori5TrtB/UrRMTy8/J+M4VCMDluaS3uGQ2ex9SceKs6tFDCf74fmI1uWPARQWzhRZ5b2APQzbe9TN40+NwOdr3Yl+raVNAflh8glHkjCamNKq+KF7FyglNAnRCW8rZovYHJUJbpMJzcL6/mTo6Gxz5WG16HTpIDAt6l0SFFkU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OTmjmnX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JA209Aom; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OTmjmnX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JA209Aom"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D39xM3240487
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 04:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e1X9sYCmRIupKnbxrpidxF27pK1+M2JGSFT3RpKkUgM=; b=OTmjmnX0tnumLCKP
	eyCTtYLky5XSstw6mKB7oO5pd58tZnUZwF0lEln7BqoXIEb+LmmZvxyqZ/t4OR3/
	aMzCK4eaoRqZ0QJk5gdoqUG/63AlJ6AZbODUvavyBVZwrZJMzTPJG/8a5EH8Hm/y
	o5slhQ8f1qlD2D9w/oBdqhdAFg3PSGCLRKgdKCyElT1QBaLLasTCfszxLbLZJfjP
	I314mbPGArMxT53IARzbOSS6GMNbbwDwdlDW2Ajl95VheIyxw0BwHWx4E+Gbx9T7
	+9/Sva2XRqKYhZWhD8QvYkcRnqMsYnPsE2qBW9N38+U0t1Q/AU1t5W21ZYqq8LNC
	3CidPA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbecgmcnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 04:41:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so4090361a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 12 Jul 2026 21:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783917683; x=1784522483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e1X9sYCmRIupKnbxrpidxF27pK1+M2JGSFT3RpKkUgM=;
        b=JA209AomCVCsKcUtE+9vAWwGZku9XdQiwAqDGJ9LLwvD1eugrYlz7PBCiROKRWxwzE
         6QxKifQPB3OL9Ky8iO0PpceBCS7+JtQ8rwV8lGegIAxfJrC1eL/G7w/N/LTtoL+oHBqF
         nFU7fVYmu5NWiO0mjqsXMfbHPUZgDKQSGTqKiOM/3jpufw4zwZ2ifGRZlOz8Jn6+EpwN
         P7IXLtCpom2trFMsRJlG9xMpU0uV/Vp/8xVsRT5EApk81+n8QzJ+02fh5WPJT/hbgP5P
         C80WCCFhZXIIvaguudNaj1z69F0YR2heVUv+0T+4+NEIUY9aix/XXa18CWOjnb4n62L4
         XI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783917683; x=1784522483;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e1X9sYCmRIupKnbxrpidxF27pK1+M2JGSFT3RpKkUgM=;
        b=PnslJMbQve6XXN9wKBLAOjv3YqjZjUOZ8XZSDjy//WCRPqWBU2z1JbmY4R3pBcu9Ko
         49CUnkdKaWz0u/jkCY7RX/DHcGStA4GKcBnw5mtc+3oBuCNBRLxMWHVNrfv0ugS54hX6
         rn4jaaj5fyLQrBSrzVRtzr5MgH0u7yElijsHbtb83MreLNPRQzGHbjHEKOwyOkZbIeTh
         EK7H0WVnjsMACfTUtUKsewJp11CSmWdvzxCK9LdLvDR2cwv+VpxCuKH9+BdYRgkJA/al
         G0qzZBToe9j1A6brTnSFb2dxXgalzOF8G0jmVHV9tRuWlLfBS9nt/HfZvPfudlOfFAXI
         WZIA==
X-Forwarded-Encrypted: i=1; AHgh+Rqm93BL7l/R8eC5f/lLMeuW9RyptdwFOX+g+7RCVFyU5TR1bTBkYMVprkNkkPFO7KPG5gCsPQNchF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaf3GnRHG7DJsWFpA5mXxXblRJ2gkYZgLbFuNhnLQYW61KZMA6
	Z8JT/vVBWyzwVWl1nbT/HoRO4YT34rF9NrW4WryDhsSHlZrFVxWViyprtZswXx7+sF/lU/S65fw
	+USzWr33p4uq7SKdQ1DxAViS7LbHvoENlrCQmOm1HQE0/bs3meAvtM3Zp51Pw8qU=
X-Gm-Gg: AfdE7clvRzRypABYDuS0Osh0TMOwF6ZuuF7EmWIErbAIXryqZOJmV8cvafuRJZeNxpg
	DTZo8cbwmKpezWX6Y/P5Yq2TjUiKwiPXuDhw3xlPuCV6ssveRgbxjcV2xcAIFLVxEJWnkprEgWO
	r1REobdZQhVsbUuK6AJyR4HPbBTL+NYNTrtXJLc0X7jspX+c1/zHdK/hmE1wib9zESJNDqqBhUS
	8c2c62KVbOkMnXpgIqbkqvs3OY05A5pVCHLoTMY7bx10wpgWx0nvlOBpV+Vk5cy7yfvq4CyvvsD
	cUYi36jOA21jN1g9t9cn7gASPRqLRAXuBw3yWtCfSLEabIT2RRBiw0qL6a0s3fMzQ/RnX9G0fnP
	wx3TbQcwmV7loXQ52nQ0R4++AIrpv8r2IJsvN8NWIwdK5
X-Received: by 2002:a05:6a21:6b12:b0:3b4:6f7e:d0f4 with SMTP id adf61e73a8af0-3c1109e29c6mr7736341637.15.1783917682672;
        Sun, 12 Jul 2026 21:41:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b12:b0:3b4:6f7e:d0f4 with SMTP id adf61e73a8af0-3c1109e29c6mr7736319637.15.1783917682173;
        Sun, 12 Jul 2026 21:41:22 -0700 (PDT)
Received: from [10.92.175.104] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm15318537c88.15.2026.07.12.21.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 21:41:21 -0700 (PDT)
Message-ID: <0e13982d-8eec-4662-a53f-cdfbcce5fbba@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:11:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Use devm_pm_runtime_enable() for PM
 management
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260710121356.4054600-1-mukesh.savaliya@oss.qualcomm.com>
 <cf80fc3e-2cfb-4bf0-bc20-dffecd347817@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <cf80fc3e-2cfb-4bf0-bc20-dffecd347817@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfX7mzqNv507YQd
 OBpL9XMn2ASo0DilM0WmngDg0i7JiWhPB13Z3IDaAsFLzJoXoSX4BtuVmbzZ+aXtYUPyjU9cq3J
 JuXLxTA9n9SLX1lFSXoBjEHGub7SIH8=
X-Proofpoint-ORIG-GUID: FJZiD4nEEpH-WimervE4ndM-MXoe8tQc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA0NSBTYWx0ZWRfX0MXWMSDUSkoY
 KNWRpg3Yy2bisUT6BmKtMgKvDSyaEEf4b9Tycrd46QjGu/ekugorTaP5C+ypO9PMkV77ezTN8/y
 eH69UWCc7aE32e0kvMyBaB4hDI4KdkmMhekagf5YuZFZW3cD/1TAXrLbCmhD2RQaGplvk5DRLSp
 2KUxWO8aWhn/di0XDjOIbzhwxv+/xHKxNQErcpvwsOIIQGWnYrjQv5dA39WuFAX2xk5nEqJBcFb
 zX0w5rVZlMDBsLyYFFHJLUWxuIHKNmDzC3QtSA86TaZZMjBhh/CXDE8RlrjTfwUIds5gDh/Fc7/
 B2kQjYReHBRIWsgZAIDCX+4Bpkh+nm8xQaum3TqiSR3gr6ZZICteeJ52/ctDGEfSeA+EYNWrywT
 6aaCyY39yIA+8xAz70m8rWBH27SDhZsLJ2v5sZ+kVO4hZOe9a/G+mFTpQWaYjSLoMi3rNKz06jA
 vIh3qufTzYu44NB30RQ==
X-Proofpoint-GUID: FJZiD4nEEpH-WimervE4ndM-MXoe8tQc
X-Authority-Analysis: v=2.4 cv=KM9qylFo c=1 sm=1 tr=0 ts=6a546c73 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=J_X7UomFcqM4Xp8SbNMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130045


On 7/10/2026 5:59 PM, Konrad Dybcio wrote:
> On 7/10/26 2:13 PM, Mukesh Kumar Savaliya wrote:
[...]
>>
>> Changes:
>> - Replace pm_runtime_enable() with devm_pm_runtime_enable() in probe()
>> - Remove pm_runtime_disable() from remove() function
>> - Remove pm_runtime_disable() from probe() error paths after
>>    geni_i2c_init() and i2c_add_adapter()
>> - Use 'dev' pointer consistently instead of 'gi2c->se.dev' for PM APIs
> 
> Drop this paragraph, describing changes like is unnecessary since
> we can just infer this from the diff
> 
Agree, will remove these bulleted points.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 25 +++++++++++--------------
>>   1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
>> index 96dbf04138be..6d6c2fa287ca 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -1126,27 +1126,25 @@ static int geni_i2c_probe(struct platform_device *pdev)
>>   	gi2c->adap.dev.of_node = dev->of_node;
>>   	strscpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
>>   
>> -	pm_runtime_set_suspended(gi2c->se.dev);
>> -	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>> -	pm_runtime_use_autosuspend(gi2c->se.dev);
>> -	pm_runtime_enable(gi2c->se.dev);
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret)
>> +		return ret;
> 
> This shifts the enabling of runpm> +
i had doubt, when i tested this, could not see any impact.
Thanks for the pointing and correcting.
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, I2C_AUTO_SUSPEND_DELAY);
>> +	pm_runtime_use_autosuspend(dev);
> 
> 
> ..which is wrong since:
yes, agreed.
> 
> /**
>   * pm_runtime_set_suspended - Set runtime PM status to "suspended".
>   * @dev: Target device.
>   *
>   * Set the runtime PM status of @dev to %RPM_SUSPENDED and ensure that
>   * dependencies of it will be taken into account.
>   *
>   * It is not valid to call this function for devices with runtime PM enabled.
>   */
> 
> 
> Konrad

