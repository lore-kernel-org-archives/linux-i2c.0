Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86C40E8E6
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923439; cv=none; b=rLUUdGo/7nJ1mGiILGmcIeCi7rlRKoF0foQKasPiSRG3KXW2/pukCqNqiIx3t1W6ePNxGQt+JJMT1uMjBEWMgagk2RlhQ4q8sIntIwlMSZVhkn4J+f1dnsfQhqKSGVG3IRT4L2fJTXNwtEnbCllgpRXocT2ggB6zRR9a0tG8CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923439; c=relaxed/simple;
	bh=8WY4QN2W6qXU/apeZFwDDlijPkuEzLifAETEMFojEHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M4NOKrTg0C2CfF5s1T/MmoA8/6ls9UHbreb5DyvSOrsbYRX2TlNLem1KvYlIkjEyus8UdI5cXvb/vOdWiQH12Ve0vP60H5wiWmu6EFhVDGj8/07//yH29kuBgDb2ilDpEY+2Orl27U1MZODVUJhV4OczcOf1HQHg1pYsWGDos1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfhwnLcM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFw3s83q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfhwnLcM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFw3s83q"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758dfBO2663924
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 09:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cYpAYMBxhmYWG4FryXoxISPE2tBRB/gj8bjb22mVs9o=; b=ZfhwnLcMk3+0hODH
	r5UkNXqlaXNE80AUK5m5WOXxkSmANXEpLeeLfJO/wGsDteDUcSKlMKgCdUd3Kn0K
	hfSRNWBTrY8Ywzy+if0HSx/12zdlj6LDcEWI4WXWR/q8xmiXRi2DBRichMoM47f9
	qRSU0WNTfhKkID05OF5xqtzvTwKyBKxaxyk6yCK+Eq3klSpFluoWYOhVfcUXUV0d
	wRoJNHosiuAnM6mPcoT001LlLoy3yYjDXEF6lE8kTcI1QGqxpM9nLJZHMTh1Kx4w
	CGpjRepaZQYk6LBR9aENHYNcArO97OR4INlGbA1lc8WMs+wcjWU2KPI4/zjAPw5X
	GtDUsg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14w8jxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 09:50:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfe48ca1efso12578305ad.0
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 02:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785923432; x=1786528232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYpAYMBxhmYWG4FryXoxISPE2tBRB/gj8bjb22mVs9o=;
        b=DFw3s83qKhzhqyLZ+u46KXHC0Jy/4H9oB1DDr5RTqvx4cirCDAtnckcWij6u4mfIuY
         S48QrJNQjuaVrOWzzCxKYRGe2XuxhIgh8tCEiGR0+bmZAwh8jwGTopW2KCJuEI8GA9ph
         px7J17TuUrRiVholF176qAa/+xthqmNlpd6t/M45x9JbOhq+7YnyJjlyNbXeeJ9rzm67
         uKTfxhHHIIgjIwmiBa72IGSYTbUwvakR9Yx+lIJkiOqvczpszF0+/55EgVl/dkAXOc03
         nrWdwyqREgn3avD3KN+kQHE2qqNXTuGPd7Q/+gqGPzIgqbE73WS7y6gWM5yWLezQfAns
         Cf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923432; x=1786528232;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYpAYMBxhmYWG4FryXoxISPE2tBRB/gj8bjb22mVs9o=;
        b=UAzlSP32mIh8tRlIEcW1L+JMOTXjhbjDQLPyk57TnKnJ3tvSy/sv42VJIpPala9pqE
         7qpm9gvkxQfUji9M4rhhAUhx/UcvHLaGsZg6T1+P1kwuvkTYzV8wIyX6nCFa/P/0qA14
         TwPRk4Mm6STt4i2ZtgWwtMxFpvdMvf3v8wmqgkAq8/8pfWwT7NSUpivHfFfzLfY8Eidz
         QEQtLPvloDfZH6f9k3fT5XtgBWDIPaq3DXjab61B9MbKtNuYNrqJJLHCPES9dy7TLJn+
         xn+nyFUEK9JpSpjyaMTH03VQPAPL89Wbp6c0SSD0N0mJZYIHQc3Q39rr8x6X0UgE4uNn
         eAoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp14hQ/6q52BFnHmPrHZliIqDlI5rxyN3OTSIxU3GiEx+5JLzpKXGxp1G2t015MqcdNbvQrJ2Ej8XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykC0JTnWcPCL9ELYeIJbR2gYvfOz8YU5P5tNamFQHlEi6CDaJo
	g6iRW5l3v2s1XBaXgVszr4VdcXT1ZU1FJUAVwtBSlZMReUEAsrD6fWhxAtm637wxf7qOOIRamEl
	l4MTwVP4oifCBF1lyqB+F5qtEhlasnZlU8sLuFwk9UGziOy7Zm6/6BtbZtSlStiI=
X-Gm-Gg: AR+sD110fS74g8rwgFr9uxN+Tt9GECt920dUf59gg+eHNOg0j76sa8QrBsck+M7RI1p
	/TFC/f+/I/Tb2gSL1Zm9Z+eYHH6DGx8oEs7G0BdmxQ/ymLB3PiY9rVS5b/mCVxz4CCS8RdCOo75
	cA/Z3WsCxPe3glWgobFcAk9J8DeBwAQAe3CGa+rDRgnwuIhHdFWNgGpOe5jz6vm+gK3hJc4g4g4
	ldCXSelXLTZ5QtWz1aErnwyUjLg8cwponvz/wZY4KklhqIwRqVnPgXb5UVgukMpN9v97rMnTAl1
	A+g186FURzT+iAJVTa8ypBBEZoqReqoxJ6tPjMHz9l37WWOrbIb7VqCqIksByxoDGGuzzHKDScW
	Dm959gipW2ZzKAMFj99dRHdpc21UgZBtdlg==
X-Received: by 2002:a17:903:1b70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d0cc930325mr62385985ad.1.1785923432321;
        Wed, 05 Aug 2026 02:50:32 -0700 (PDT)
X-Received: by 2002:a17:903:1b70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d0cc930325mr62385065ad.1.1785923431561;
        Wed, 05 Aug 2026 02:50:31 -0700 (PDT)
Received: from [10.217.219.72] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4b94e4sm14897995ad.56.2026.08.05.02.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:50:31 -0700 (PDT)
Message-ID: <1f4f69a9-6418-48f0-b235-b23a589bede4@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:20:27 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: qcom-geni: Simplify PM resume error handling
To: Praveen Talari <praveen.talari@oss.qualcomm.com>, andi.shyti@kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, viken.dadhaniya@oss.qualcomm.com
References: <20260805070013.494426-1-mukesh.savaliya@oss.qualcomm.com>
 <19104992-25ba-42bc-a7b9-c45f4b57c22f@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <19104992-25ba-42bc-a7b9-c45f4b57c22f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX5KtWhXyQrGT0
 Q5orb1Azg5ZXIkOviLDgMZjD+GGYhCN6+QYVub+D1bhLfd2UdJ+Rbs3EWwosr+bA+3h5kkmp8Ix
 aK8dt3C7oyj4bnXqZ1VK1K8f2N+lXDk=
X-Proofpoint-ORIG-GUID: yEY20CPeMu0GYYaKg_MhN8NjPFyefl69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX0d5OZEXZULn2
 laQFGOCAsCxKlFeuJcl+LUoFrSfQW3sRkq8EFZLiFD1dkbGXXG53sRrgAaXvIMB+7KyZ72ZGgWd
 opb6rP44D3+KoT+Fq+I4eWEtiXJj3wva4SxAXkx0FGfLP2GYqYRpdss+zxSkRZVfXZ8kQW/OWk+
 fXCvXN8y6KZ6+JMKVsCeVuLzID82sdhrfQAJs2WTLUOoyIWSlmzsTX/IP9UXCSqtXL0jJofQol8
 PqWzo1FQO5LwLZJgqZqNwU8qPNnouut9b1Ux9Mu32SC1UyQ8qMqZ8VsJO+o4FbkkD1V6mLDVtlT
 wMR9iQFs/vgr49pmV3/m12Vb4FVkcthj7YPHSLY+KaPYRgTZiWvPpWaZ54xruj8j44/5FFf/n/m
 18l0MrrT34LPQJXbYXDrS9GT47g2Y9r4o5VKLnzszZbsO57SwoDUwswnk1z5PdUPpIDPOrAVU3s
 Yyq7Nlnj22h3T9dyQeA==
X-Proofpoint-GUID: yEY20CPeMu0GYYaKg_MhN8NjPFyefl69
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a730769 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=E5d2H_Tm9Cb6iI7BRYYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050077

Thanks Praveen for the review !

On 8/5/2026 3:07 PM, Praveen Talari wrote:
> Hi Mukesh
> 
> On 05-08-2026 12:30, Mukesh Kumar Savaliya wrote:
>> The driver currently logs pm_runtime_resume_and_get() failures with
>> dev_err() and returns the error code separately.
>>
>> Replace this with dev_err_probe(), which combines the dev_err() log
>> message and the return value propagation into a single call, consistent
>> with how all other error paths in this driver already report failures.
>>
>> No functional change intended.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
>>   drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/ 
>> i2c-qcom-geni.c
>> index d5c977e34994..96015e077b69 100644
>> --- a/drivers/i2c/busses/i2c-qcom-geni.c
>> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
>> @@ -994,10 +994,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>>       int ret;
>>       ret = pm_runtime_resume_and_get(gi2c->se.dev);
>> -    if (ret < 0) {
>> -        dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
>> -        return ret;
>> -    }
>> +    if (ret < 0)
>> +        return dev_err_probe(gi2c->se.dev, ret, "error turning on 
>> device\n");
> 
> This change is not required, as this API will be used in the deep sleep 
> use case to reinitialise the SE.
> 

I think this change is generic and does not appear to introduce any new 
functionality. Its more like a cleanup or modernization that aligns the 
PM handling with the pattern already used in the drivers probe path.

What exactly is getting broken during deep sleep with this change ? 
Could you elaborate on the specific suspend/resume issue that is getting 
disturbed ?

> 
>>       proto = geni_se_read_proto(&gi2c->se);
>>       if (proto == GENI_SE_INVALID_PROTO) {

