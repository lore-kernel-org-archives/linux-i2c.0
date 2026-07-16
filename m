Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593741E6BF
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205388; cv=none; b=MmrxxemkN0SUjMqztZnCbpiy+3PLI9/EdYJLOEuJTbGYb8IwvN6u85uvv0gW7a3MJub1qPVhGzwqx/hs+d1bultxGEVP9zYaynRhvj8RfKtoqg4vN3s0/FaWVo24ZDEa8isU2kRBM3L6w0Y9a5Rypt9LAiJXqNtiZwTOZYtsyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205388; c=relaxed/simple;
	bh=hxWWKhI0tQTive2CFXJWMVvPXF4+6eRYQnDoaeGQjBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faA+Rr3tSSNN3DbtJVSdexrs1uDrvLiRxOImEJkm1GJl5iAk5myudyCzXrCIhZX430B6lXhUpnObu/F7lkKK9sMr5vfuTdsO/llScSsaCk9kpSkaWrxk6L/lGdAhAN2HsIH14kZcqczzWezGEdjQNS/mnL3YDxEgNyx0D3De3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaGspmQt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=godTpmnl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaGspmQt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="godTpmnl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GBiUR62824298
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sqnCjoNOPvKjqbzSrJmJZF6GvgPuzdQC5JrhOmYheMM=; b=BaGspmQtjl4kSv6I
	q8bSLcrNH3Wnci4mYrNw/UXswFYnXxLRLUrqTCIZ9Euifri1kT8TVIiSqRXlgPAv
	Egkx8Zdf2h9hD4K5dZCpJlFM1DBeEDfvGcPSEfzdR8i74bO3+JnI4alN1OV01U5o
	KqASZZbbEWuJtjZL7DaM3UOEGnVEdMn4t6Icuiy6hD4rwoPllwGPvbMnOY8QjUOA
	GAtQyVT6aCsJmSFUvsdE+WxL0gq6Mg3aZIBxAIPcGtZy4M0OUuqMYbTdxZrs2N4o
	hmKPsu3ygyz1wUg13h4GaE83+kig5bv1QgBL7IbLwjpfYL/z78zaXC0cklK/zlPP
	NCiz0A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf1br1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 12:36:26 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca860baea9fso7758641a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784205386; x=1784810186; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sqnCjoNOPvKjqbzSrJmJZF6GvgPuzdQC5JrhOmYheMM=;
        b=godTpmnlHQXsL/jkiwinOfIdVc6MretT2Gyf2dLr5oGTFPfTvRq1hLmAjU3twY893X
         I9yFgG+MFsjOVMGEPzQ2Ct+m3hQJJ7QWW59rD9eTZG9cGlA2RmP5hL9vIauHVMMAfubD
         +u/Xkcg9Ri/zX6EBIjrfJG/gJQkkk4DBN+0zSiKNdPkww0fAwG+KxSKlwNYa7P7vBR+Z
         5emLR/Eue84a/nU8LudueODWVzbkGUgkLeC4Sp24/JVx/kTQ8Lc+WUj45Z07XrMoExSw
         4X3YRE86BkYIxlQcLuXaUbEbSFonT9ggUv7ydrQqof3lbW/XVD6HTGJkaFOLFYEk8bbr
         TuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205386; x=1784810186;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sqnCjoNOPvKjqbzSrJmJZF6GvgPuzdQC5JrhOmYheMM=;
        b=PUI8mxeXR38HgMG3zyvaAJ0Sv09NaYup09PNjxFWP+yxK5Tl7VKXSpTBZ3MDbnmv7h
         cU7SnYILInapdyx5ZvOYJeMDCOIYQ/+XEB2pp8w7ciIbNBgOAJVTOUICsc0W+YstG7YG
         ha79s7n1iySF0r3MWjKmKikkN3xCiz7YXjoo0BSw1MIH2ZhTO7jU1AlZUqAIFTqpwLdm
         RWiD7sXRG2gse08ZdRt4KU0F1F2GxVD3ksJPCN1E9OEhvE9qcMQsSdXXISrFs7S/M8nk
         gj+HgWS5GsYy/L953Re9aswyKM5PEVSHR7Ns5/PYPTL+a68JBKmPX0u7a1kA7vc8qBMR
         ww+g==
X-Forwarded-Encrypted: i=1; AHgh+Rp5eFVm08mliGQqADr97MykKYi9eENo5ax6wddNJ1HBIGz4xJdNDkNviXwjHt8DMANFXpm97JsGX6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJHIe7bePmyjC9EHsSQVW7kMXsiDymfvykVD6cm9EdFk1HGc19
	m9oazWPTMcYcEaNYx9eLnrxddeiRDODQSYSZiGCpninO+yc1dE7Y5YNpdZm4xFprUEGSgiK5XsP
	Y36sxwaFRkChYmQ/UF9gxlhtSAaKi9S35mbQxUyTA5og53csvk2/sEX0ib34Zj+Q=
X-Gm-Gg: AfdE7clATU8Thw7X34In2f1kTtA3APCfztb3t2wBjgNfNqV31JkirRxauElMeepe6tD
	n8lqafjD14AXUM7FYqcnGI28+1+YlIMSZ2N9PPAcL6HKcXVYlMeIFsibG8+Y544PvlrVgKOMw6C
	AoUP4wwCnFkIgPORGv/y3n2BoYSWS5E9EoWQ0LIHWndKUh5/rdt7GS8vKpvZewlsfx/IRdzIbGZ
	8WTxLRKlWkRUL1YKCRe3o29Ri0WcHk5ZFVVcDvzNMEWSC6As5O7JMr3xlLaV4SAgNstjf44RUCO
	j2rMy0AmJLRrXJjJ0M7rU6PTn+OVzXn7JlxC8dqtjD3XZyMIYgvkh0of8iEdXa/NC1I/ZpgH5bk
	HzjLykO/tBhba6MIJZgi3U0PYW4fS++X7/A==
X-Received: by 2002:a05:6a20:6a09:b0:3bf:d0c8:2a8b with SMTP id adf61e73a8af0-3c110160b71mr22835886637.20.1784205385592;
        Thu, 16 Jul 2026 05:36:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a09:b0:3bf:d0c8:2a8b with SMTP id adf61e73a8af0-3c110160b71mr22835849637.20.1784205385064;
        Thu, 16 Jul 2026 05:36:25 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.231.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4359166sm10674250c88.14.2026.07.16.05.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 05:36:22 -0700 (PDT)
Message-ID: <2ac2cdcb-f671-4f7a-83c3-bb05fcf4259f@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:05:58 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for
 multi-owner I2C transfers
To: Bartosz Golaszewski <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com,
        bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-3-mukesh.savaliya@oss.qualcomm.com>
 <aleoVNavBOrF9r7O@vaman>
 <CAMRc=Mc_4TZ6QjUgQmLehBb_6f90bamYFhE5S_6m-Poem0-u1Q@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mc_4TZ6QjUgQmLehBb_6f90bamYFhE5S_6m-Poem0-u1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2-zFULprOsiipilV517sm0SqIvn18MxG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX6M3VciDWeFes
 aCgQ4e1EOJ0j9ll3NE0r2maPrTfZSV9R/hP4m67uTbHUMdsKKskQIArQlvu8cOIyn1pvxtKKJgG
 gC0jmM2j3kpQvvqDX807OP7570rJOUkj1du0k9FUFCNV1Zq5f2vHef90hTrKIMSJa9mnt7MTRTB
 RW1oAt535P9JFCgEYFc/MfOCBRcUa7sgUF+XKsVMkJwLihciwnE0RkzHaGkQVZLSBoXwt2E9AIf
 /SyWUN8KvAEtCTx/yfur72yKRWRUMim3QcOlqcnIOUYBt5ZDIRomJE1mbrWngDiJ7+atM5Dbr0i
 gf8ks0lbjvuUaJ9rnZk5ukO4XTQvtmmt09VEQ7uHWx8DN5TRFlFV8vBbvKDxqnLspQJhr0ER9W4
 Sd+5opu3dTuNjnWq+jgx9u121jlMTMLo2CdbEmb1tl+SnyQSW0eSuZMLKkub42G4Vl0xe+4u7Ht
 B4biADym9T7FJAricAw==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a58d04a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=OlrBKP18NtReKxGUJ9moaA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=FuXMeDijB7eqQmb0U5IA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 2-zFULprOsiipilV517sm0SqIvn18MxG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX5C5F5AcQLaTE
 HSFIEiKb5JVpCIN2dCb4UCQLWqKctgFygz0DD0k83hp5tdigouo9xymGZRgp7GkBqhvnrDWhhq9
 /AJ3OEVHuob47pLqfurN342cL6zxUXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129



On 7/16/2026 5:39 PM, Bartosz Golaszewski wrote:
> On Wed, 15 Jul 2026 17:33:40 +0200, Vinod Koul <vkoul@kernel.org> said:
>> On 08-07-26, 10:40, Mukesh Kumar Savaliya wrote:
>>
>>> +/**
>>> + * enum gpi_lock_action - request lock/unlock TRE sequencing
>>> + * @GPI_LOCK_NONE: No lock/unlock TRE requested for this transfer
>>> + * @GPI_LOCK_ACQUIRE: Emit a lock TRE before the transfer
>>> + * @GPI_LOCK_RELEASE: Emit an unlock TRE after the transfer
>>> + *
>>> + * Used by protocol drivers for multi-owner controller setups (e.g. when
>>> + * DeviceTree indicates the controller is shared via qcom,qup-multi-owner).
>>> + */
>>> +enum gpi_lock_action {
>>> +	GPI_LOCK_NONE = 0,
>>> +	GPI_LOCK_ACQUIRE,
>>> +	GPI_LOCK_RELEASE,
>>
>> Can qualcomm people please align on LOCK/UNLOCK interface? This is
>> second interface I am seeing now. Can you folks align internally on how
>> clients should communicating lock/unlock across different qualcomm
>> dmaengine drivers
>>
> 

Sure Vinod,Thanks for your review and updating on direction.
I thought reverse to not pass transfer index to GSI driver.


> As discussed internally - this driver should follow the pattern we established
> for BAM DMA where we don't require consumers to be aware of the locking
> happening to any larger degree than is absolutely required (for instance:
> passing the address of the appropriate scratchpad register as is the case for
> BAM DMA).
> 
Yes, Bartosz, i understand. let me align on this and follow BAM DMA 
design, will review with you OR get BAM DMA changes.

If Consumers do not posses knowledge of locking/unlocking, DMA engine 
(here GSI) need to have some decision making knowledge. e.g. First 
transfer and last transfer.

let me share with you and then will upload.


> Bart

