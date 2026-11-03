Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704601;
	b=WubgyS3qpze0CvhQKB5KZV/muYur4PANe6EFJRHRQ/m8CbtnRHFFsYlMg+SIAgUJyk/J
	 qxQs2cb7OcUwzETcD494c3uQFd2R5WM70App7nKcAX5oYPTxtaKwJlIHu4wQsDE2FG9PQ
	 xPcOydDPABhG00yiTAHf8PKmEgpVmSTgT4pWL+6J9wzWPyICQbjRL1/2JqDKQmDyGRJrm
	 UyIBVa9kTRyojexvuSIjfdvZj7H8l3E1cFA7Ksoko2mqqvUMP9QCyT5Is39hin2M4M0rL
	 GtE8HJ4FnB+//p0egz9AWqCr0BEtnNrpoT4mBCZd/fV2LBKsfCUmEov7gQS5YiHUfcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704601;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WZMc20YxNSA038XzxMIhDdXcMHQhgcr2sLs98yj0LGQ=;
	b=nL+Y6kyVmUn1bwcUAI6rf4536dmbykHIXbOi1GM2S/NlPgfLsHOo6CzahHVg8l52dThe
	 nbyQ16HUmGkCAZ0B3UD8Abia9OBGuqd9uHQOOrbzQTrM2i39U/FWj0BXJd2y0AQ0e6ezv
	 1xN47WmOTikmLxeC3v0guiy7nnXGrwJpP+n3NdOT3e7JKy9oNjIyS5WaFt4ugwWTPM8Hl
	 7mUKV+cp5HlTV9epKXCJ/4CtntRFC8e81TGco+nbAa9Adv5UK4VzMLdBxsTQhtjh2q7Ah
	 J2Awfc2K3yz3TIoIEWwim44rOdEnm9ODoyxUsO7mUHTgKhmf6AG8EsJu/yJkSPSzBzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4JBSjZG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XsOz7DvO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B52606BFB3
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 11:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B52606BFB3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B4JBSjZG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XsOz7DvO
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAC8s3161604
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 11:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZMc20YxNSA038XzxMIhDdXcMHQhgcr2sLs98yj0LGQ=; b=B4JBSjZG0T8FX1L2
	oATmBTyT/weawRrq7g2radriuoyPOTZAqu4qE3pxRHKNbwvyJo8CoLVlMT3K/LAT
	5YUYt64rz+hZ6GyqLH91uUh7aZdR83cmCRSPl1WzVLjbetjKOQG0cbVA+J1KaGNq
	iUd0ywrL5rUV8DKBAtXktScDuTrZETSLw2b2wqsi8R3Uw4VSDzf7WB1x7Vxc0Ped
	gw5hKcFIbV40/N7tlJ3UA6Np1nH4vaSNXYoeIhARO3UM7iTFAeA90etuxKCXnFay
	km58XF1myvt2EzM9eNXKtfR7jbx9vto1oIu53MR+DekUc0ZMl5JT23yvOgU9qJm4
	zWPEJg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m99xve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 11:16:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abfcf726dcso5193655a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793704599; x=1794309399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZMc20YxNSA038XzxMIhDdXcMHQhgcr2sLs98yj0LGQ=;
        b=XsOz7DvOp5A5562khzfnVzU1lDeXw9QAFHaqb7Sv2xQ4qqmyduuXy7gq1IdShBMA4h
         fv8bJWS2TucemUTEu56u3uM7kiWZj8rNuyHujk6J5OnWZAd78JY3xFtkGXHCC39anCU+
         FfOx7KBF8LHTLYMl4a9f3DYMvwJTKdzXekU7j0Q9gMBhfoMmLVOPIIouxfhi1foca6ut
         82uY5y8Gs0yZUu1fmAsAiR+WY4KM48Q2w4qNu+kfc1tbigi4anm3rjwuShr1quwGl+yY
         l6p31fUmL3RoyMy20Uid49L/sND6L7Nox0z8hSIWYt376mwfaU1oTdVz1U+L1SenIQqo
         DEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704599; x=1794309399;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZMc20YxNSA038XzxMIhDdXcMHQhgcr2sLs98yj0LGQ=;
        b=q9WhpIfpnzxWzTRAYp7/sbPyxxUkSJRxhW8vHv7Cni/o5UnWyHzzxBWE+3e1KoYfYF
         V8YMNeDwPMLoYEB1zPludGrk2o4i4aYbQMAvwyrdyihAUWud8xc/xeEKuusDcNPTuM03
         cJhQTA6anqcTyKk4fjIKITi9WaHDPQgi2268IeTZVcyVhkIpSI3VqXSFQu8W2eANIXl4
         qhCCYj4dnwWNJ24xjE99ILqIjnui9lz9vuKv5csCqyVXN/ElPAD9dBe/ZorRW8QptvX2
         pKH7ifcTGM8Z9DLa9Y6l70mGwdLfaqEli1+oysrwd9CznvFWqnD5GKv+zA9QDj/5Sisa
         OMng==
X-Forwarded-Encrypted: i=1; AKwUvBylMu6q7+xXhoWOa63YZkmWIjQAYG6CJBok135lPfLdGirO+YeY7xm2p97nn1syaphRq2ozRFW7zHE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BKu2WqXFHHia65NROxU0UzyBzzOZRVZs2Q2NH4CkZfW94rnay
	0uL0IoJM5Gbdc+X8RGnHoNF11eDrehIMEKzH6ZNLTq5o0hMF18OTc4gNtxDHHKtmOFhbSKcU/cf
	ChitD77VAbPbh5W9czgdIoXx4AG+oja5nUWLNlaGHRiRo4rnZadMWMYTCsV2tBLI=
X-Gm-Gg: AYBFou0dkX0sdL0bzxRoMTH9MnyxB10r7KpQDpxpPYnmTniSdQG46DB1XIM7ZVFtG5d
	pZtKqyquLMB6//ErPkffyp5j4A6NcbS+QYPcwL3+4Gpdsa1mOxD30BwJ14l5ypOAwD3EXbcYWe4
	Hu9uXVyvmtV8PkDb6pBvDb66S57mGcZyKoDrXdv4zvWQkbU2/IVzrVCkSOasWKIkb0KrzoFC9QD
	2E5rg1bcXXuNf/tidJIIAyAiWpFnGJjemOxLXY/o8dL+ho2Sdl+gWANKsasS1Bv9AmO3Efk/GzM
	2/JyTwg7rgMMKDL1oHloqvY/IlxSPI00RfU98nUK8ErUKN2PJmi2WCyu6XsgYFByd9o9WAAyZD3
	driTh4TC/byP7HIsoqF+l86W+9Mv95/8w1Ps+wq0g9xD7lKEvdwCCbqOB8ZQzy6EJglaIcrAL7M
	EqC/41
X-Received: by 2002:a17:90b:1f92:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae897c8014mr11155423a91.16.1793704599091;
        Tue, 03 Nov 2026 03:16:39 -0800 (PST)
X-Received: by 2002:a17:90b:1f92:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae897c8014mr11155402a91.16.1793704598639;
        Tue, 03 Nov 2026 03:16:38 -0800 (PST)
Received: from [10.217.218.73] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c903df5sm3978846a91.11.2026.11.03.03.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:16:37 -0800 (PST)
Message-ID: <c96a6c5e-45d8-47ba-83df-d956bd2e06fc@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:46:33 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
 <2ed54730-75bf-4368-9391-5452d0a31fa9@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <2ed54730-75bf-4368-9391-5452d0a31fa9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y7wMGQzqZAu7mypniKZCyCJKG0Yl5qgy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfXztTdEged4+Q/
 TLipVvK79N7dKGIwNXZlF9uV+35azFLtO8s681UcDEzjeuoJ3ZjmBkwSAw00nFaShINoJRU5yLe
 RMQHDnE6w229anDlYkAsmKBQil5CR9U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfX+kPNJGqN91lC
 YyB/Yly/EetnZbHzY/fo8YdxZ8sZJ31t4VO9t6McbRTxTv2PWiws2F0oDFTlTLQHsDcw9WCpYc1
 dXsf+hnmBoL8WomI9GpMg54yBuDmiok4mUeT5kHgZS+nvz2uUPWUKPDTqu3MLKjDJ5DJyh9Vui+
 H1y26z4cky0Wi2n/8HiQJE1OngElH4Gr0+cjk+KGWUd3JDwkd52BQ7wSwqxOgGU+d5Kg0JT6q6w
 b8VF1GpzpRKb7gOBQyQ5CuEj0Spgbj6Kp2yevjmig6g7XXqyjZvbMiURiH6zUqXLKquMN3bluqh
 PysMxbNnNFu58c/rOw4x96lZ8xnT9EkXZowMPubv+dEI4qkOHHxL2jYiYJixa3IFtUNcl74E5WL
 e69wzShIVOIJ77GzvDPOUnnNi5+O4KJrG/5Y77irzdmOuhhV/0pLKcpjB8Nig4dLf5q8fk5sA1U
 KrT+iHJZwy3nLdqY+fw==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9c298 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=wUFJiXBcSWTcG4vZAq8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Y7wMGQzqZAu7mypniKZCyCJKG0Yl5qgy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030044



On 11/3/2026 4:14 PM, Mukesh Savaliya wrote:
> 
> 
> On 11/3/2026 2:26 PM, Aniket Randive wrote:
>> I2C transfers in GPI DMA mode can fail with -EIO when a target holds
>> SDA low, leaving the bus stuck and preventing subsequent transactions.
>> The GPI completion callback reports a NACK and a genuine bus error
>> alike as -EIO, and the existing recovery path switches the SE to FIFO
>> mode which is not valid in GPI DMA mode.
>>
>> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
>> opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
>> trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
>> SDA and SCL are already released. Extend the recovery callback to 
>> dispatch
>> through the GPI DMA path when gi2c->gpi_mode is set.
>>
>> Use the adapter timeout for GPI recovery commands, and preserve the DMA
>> configuration error code when GPI setup fails.
>>
>> Stop recovery on a GPI command timeout and report DMA termination
>> failures. Do not issue another command or override the timeout with a
>> bus-idle result, since DMA cleanup may not have completed successfully.
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 107 +++++++++++++++++++++++++++ 
>> +++++-----
>>   1 file changed, 94 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
> 
> [...]
> 
>> @@ -1356,10 +1439,8 @@ static int geni_i2c_probe(struct 
>> platform_device *pdev)
>>       if (ret < 0)
>>           return ret;
>> -    if (!gi2c->gpi_mode) {
>> -        gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>> -        gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>> -    }
>> +    gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>> +    gi2c->adap.bus_recovery_info = &gi2c->rinfo;
> 
> I guess one more time this. Why patch 2 is adding and patch 3 is 
> removing the change ? keep it clean way.

This is intentional. In patch 2, bus recovery is supported only in FIFO 
mode, so we guard the registration with !gi2c->gpi_mode. Patch 3 adds 
the corresponding bus recovery support for GPI mode, after which the 
mode check is no longer needed and is removed.

>>       ret = i2c_add_adapter(&gi2c->adap);
>>       if (ret) {
>>
> 

