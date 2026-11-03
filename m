Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705063;
	b=pH0JlDRqOETdd81xvOTSmjkEh8b8LZV3kXzjM1YOL7ZQhNa8ehZZ65nIUOLuUqXjIZd3
	 0BMvZl+Z8q7Plg3sAgr00cNrKUrrzn0DOA6vfr+dUHlgEi1Xwz3HhVFpPX7mXDzNH996Y
	 hOp/YWv5zLiX7HKwJgCPSmj5qTXezNwTnXBgOYnA89vIr7V52BDOKvF065tmys9Z57+Sl
	 t/ynb6cZ/XfIzCJ0hUNnkZc9wmcjBoqp4k9AFq52faG1+X3ambE6DNO/5o2WN5M6aeW8L
	 osbH63vOddQ2ZCoWEF/1X/rzw5wRYuA5IM+/70ndo5DihNmtACE35ziPwWloDlRZBJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705063;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8oAkjaXnaFfUyFpwVtYsA1E6QVQ2RETjVoO0Gm7QsyM=;
	b=LVYgAN0kaTuFB4bpS3PrvfEHIDqpMvyv1JdfbjaQ4kBShI00Xxvfm8r52Nzy/35AX2Kw
	 CACOXBJe0qJLYbYmcy10PBkhlZWPjCfsAYXnY9WTvdY9/tIv2OVTLjWz1S0bbDncsfKMf
	 THPqXC+HLWzA0KXNxV+5tHEn+Q5jZNO6JEKO8hvKkpfsn+tv9X0VYQzCTQbslCfk6b+dC
	 Sb4CebDjs38DbPthV+J2LdJ1Tgu/pp2K72SeUikqPze7oCJBH5zsp4gK+F6SGiCmWiXT6
	 pmMAX+t68HT6UB/8LmdtlTs1YWrY8nrFn9biprBBRZ4cntbjn0noLC1EMfvOb3JcVgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPmaW5ke;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aFB13n1E;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD0606D838
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 11:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABFD0606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CPmaW5ke;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aFB13n1E
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAQbL2522229
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 11:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8oAkjaXnaFfUyFpwVtYsA1E6QVQ2RETjVoO0Gm7QsyM=; b=CPmaW5ke1IkeKpYk
	VXbUK5oTUJ5F5O1457dkRyQlMpaMe0BfRafH2gGGbDKEmNs1n0L0rqqN6BZleU5s
	BSi/bJ5Po7151VgvWgojQP7PDpfF6wGD6qmm4YR8BQ+omSCCoyGSu24cyRzlLtWv
	IeeZNjbYQrL/EewqjIt30Q/TvCGRsplw/ZByFjFUHDE6qjhDc/rOIxNcxeOzZY5B
	Cg2ERHssx48UZHCY3XHPwWP7ELYc9glfZUlTE5d5VVbbHzKrCAccWpIT/rv2CgKr
	zMAWfeRWo/sYrbp5rN+0cFv3Wx8F1fgQdNXFBhnhOGadodCmCZmXd/XPPNHnSRgo
	xqa6Jg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jdf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 11:24:21 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad91787a1aso2631697a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793705061; x=1794309861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oAkjaXnaFfUyFpwVtYsA1E6QVQ2RETjVoO0Gm7QsyM=;
        b=aFB13n1Ehtpq/w60bI11UFsymdM8pDW+9/8pFxWNiO4bSZeSqGVg4/yxOSfseupm/M
         ZXqh52TIcm/ApZtOrJC8pBZheKJ6Y9LzX0vUjzAj45zi5dvydpXcNkL7X4zqFRmQhUrV
         iuNwq5+OD3wh5Y5etUJ8yXZm8lh51+1XSc4qxkRJS3XKe9PddJmsZZyYbqAlAN1ZuFml
         TfPpxTlq2RVWJ+mWLRfb7v5r07KCqjAlTrqe8n8aBJaeJXsJwsyPvWPUsC0Dr5+HlF3k
         vdj7SxZ1zVPMFW26g2WyWuRLmIDTYoerhj9etkaeLiB7SMwcy1tYackyAcTPJ6yncvSl
         VfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705061; x=1794309861;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oAkjaXnaFfUyFpwVtYsA1E6QVQ2RETjVoO0Gm7QsyM=;
        b=fzagFdCIcjYeczueiJMH1JwrXRLEtY8TjZdpo9nGUSzyaZjcR45lKFIa9Qmiw+aWCi
         4UNPZqBDSHuydJl0N637eyAx1fwaK3dBM838IkVgRJ+FLgKEX4c1X9hdjgSbCWSHQXxu
         WT8aBI5DRacSV3/83hLInI/0igFlI5Zvg9A71pbE4mcdr1n+p71hN1PvmgaGQnRa7bNb
         cy1rRBrMZGlT4akK+w1E3g8CWiMS4H2rGaJHlmG/cdgElV/frWegyMLyzhbl3dKTsAPV
         LsYkr9x7m62exf1FiWrg74QDd8HMooNKDu7YgKr6kX77pmwARKRC9rzjJsjgQGefHGtJ
         xcVQ==
X-Forwarded-Encrypted: i=1; AKwUvBy+00ggNDAbC6+2Xzxvb/L8TEoSvCoPjzzDTUAZ+7P2SNRDhCp9gK14jbsB3++N2lONYFECk/Fwrnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jbN5z6ZbyTTDX7nJDt1yxZm78GrkrUk2C2sJcu4R7wl1uY+1k
	4M2EU2kaBgpXt8DIWVDXQU7HtO5RlLWeWhKm+4w4uuEs8jZ2u3h8TMLaLHoeyItICYuJUXt+6yY
	MTbKTEfEKj0P4Z4DuFJQzGofa6ppqwlNmBgd+kocSdI+/t/7VNExunE+ZaLN+/Y4=
X-Gm-Gg: AYBFou3NPj3+zkCLAB81Bd0i0Vypg3HZwWBkxmaiW/k2YrMB8UPjOz86R5F6WcHORnV
	4+HY63GN6bQ8IxN7RgB8nleboYtUuF5VFqu4dp4KjBL5SqXzjvVLFwMbfJMgpMke2G9pU2p2XP7
	fly4BQmA50DNegmGWT0tB2SSGGgwHoMbjWaTaMwGwzQoC0zuHBawUbUcDLXdDaJV5017Eg8DRGO
	MHzfGT241D04sX99rbuZizlqbz6eG+DaqL9LIIqmmej1p2NGuYEIrdlomp8LADnm5tf6MaesZCg
	XrSNGAAuNY8m8fNAP4+Y5n8TGDeibTNurjC2qtqOgco3+yCofsx/8OdOj2U/knutQB2rnd38XHW
	XjDEw+4INL2je3CJ3imq8qShvdsCm2vBT4cxLIKTl5lBloZJdW/ZD3aymLEgU6UE/WqR80fv4u5
	Q01MsUcg==
X-Received: by 2002:a17:90b:4483:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ae8979ba8emr10442370a91.39.1793705061189;
        Tue, 03 Nov 2026 03:24:21 -0800 (PST)
X-Received: by 2002:a17:90b:4483:b0:3ac:9259:1234 with SMTP id 98e67ed59e1d1-3ae8979ba8emr10442352a91.39.1793705060753;
        Tue, 03 Nov 2026 03:24:20 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c8329afsm3974716a91.8.2026.11.03.03.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:24:20 -0800 (PST)
Message-ID: <62363ca8-366b-46d4-9287-674ced93ddfe@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 16:54:15 +0530
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
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
 <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
 <2ed54730-75bf-4368-9391-5452d0a31fa9@oss.qualcomm.com>
 <c96a6c5e-45d8-47ba-83df-d956bd2e06fc@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <c96a6c5e-45d8-47ba-83df-d956bd2e06fc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LuI_lFbELR2WE3XIvhNxEfYNBBnafjja
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfXyRgMA2zze1xv
 kpeep+fWtCN7M2Xihi3PZj0aW0Fik36qv2PPHJ8gOUAdRbM8L83OUqrjC1Ti1R9q7wCToqtTmMN
 7Mo1cgCeqkVRB7ipM4M+4v8qj4LBgJusXxIYl2kBB6ibBKQEjGmQvFoKRTmMtQyOC6XmHjA5+s0
 6wcF2Vu96WlmDMq/lMnDGa+fLJqHT3EylNtbTldvLnMD0+3rAvCo2tsqMfxuFJiB4L2JBoEfVHp
 J0kZRs/Lf1UbXb0Rf9gp2KPBy9H5zlxDndKR8pHGH6sd9MPOUp4RcuRIAKD/GtMp0P0A/lfCr7k
 /PXfA/17E8EiFcOFCw6i0laF4o2M4lJgpsZYmGFlvI4Sux9oT29st0k5YSKorW1gOadEAcgaClx
 JDE872Bud7q5pWZbSuIe7Gn9W36LVZKTUjW1lEhIWR/9YY9K+cq1R4yBT8dXDmPehnux/1Mh5dX
 wVtJA/pq2752bkZtgfw==
X-Proofpoint-GUID: LuI_lFbELR2WE3XIvhNxEfYNBBnafjja
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NSBTYWx0ZWRfX7S01XUuMAYfj
 k81Gt8Nqgs/gfAby/o0bYgdcHy/s84vTc1n0II/9z2dvWLdW27s76FqTR8/oineqbWth9Efo+OR
 7mffpG3bQj53YpXekuNxgNvwmp8KL5M=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9c465 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ymETMnJNZYboT2KzijcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030045



On 11/3/2026 4:46 PM, Aniket RANDIVE wrote:
> 
> 
> On 11/3/2026 4:14 PM, Mukesh Savaliya wrote:
>>
>>
>> On 11/3/2026 2:26 PM, Aniket Randive wrote:
>>> I2C transfers in GPI DMA mode can fail with -EIO when a target holds
>>> SDA low, leaving the bus stuck and preventing subsequent transactions.
>>> The GPI completion callback reports a NACK and a genuine bus error
>>> alike as -EIO, and the existing recovery path switches the SE to FIFO
>>> mode which is not valid in GPI DMA mode.
>>>
>>> Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
>>> opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
>>> trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
>>> SDA and SCL are already released. Extend the recovery callback to 
>>> dispatch
>>> through the GPI DMA path when gi2c->gpi_mode is set.
>>>
>>> Use the adapter timeout for GPI recovery commands, and preserve the DMA
>>> configuration error code when GPI setup fails.
>>>
>>> Stop recovery on a GPI command timeout and report DMA termination
>>> failures. Do not issue another command or override the timeout with a
>>> bus-idle result, since DMA cleanup may not have completed successfully.
>>>
>>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>>> ---
>>>   drivers/i2c/busses/i2c-qcom-geni.c | 107 ++++++++++++++++++++++++++ 
>>> + +++++-----
>>>   1 file changed, 94 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>>> i2c-qcom-geni.c
>>
>> [...]
>>
>>> @@ -1356,10 +1439,8 @@ static int geni_i2c_probe(struct 
>>> platform_device *pdev)
>>>       if (ret < 0)
>>>           return ret;
>>> -    if (!gi2c->gpi_mode) {
>>> -        gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>>> -        gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>>> -    }
>>> +    gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
>>> +    gi2c->adap.bus_recovery_info = &gi2c->rinfo;
>>
>> I guess one more time this. Why patch 2 is adding and patch 3 is 
>> removing the change ? keep it clean way.
> 
> This is intentional. In patch 2, bus recovery is supported only in FIFO 
> mode, so we guard the registration with !gi2c->gpi_mode. Patch 3 adds 
> the corresponding bus recovery support for GPI mode, after which the 
> mode check is no longer needed and is removed.
> 

You are right, i saw that as complete logical block removal.
>>>       ret = i2c_add_adapter(&gi2c->adap);
>>>       if (ret) {
>>>
>>
> 

