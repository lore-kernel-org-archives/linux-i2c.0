Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D6411687
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681914; cv=none; b=V4GavqJurvaGpHmHsDFG7vAgHNaI2p4qShB0HwAXeeDub9u0r32FzApc7aQ552YrrKWo5oKH5A8g2/lGBhmzMnTuhCZD0dorqi6+Fwpdl/s0XhRFZEeJXIbvjY/mbfeh20wepGaonbq613BCUoWPoeSpV2YmFakIazp6/tV70p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681914; c=relaxed/simple;
	bh=MKPke5BUYCTUcfxDA8duezcYg48WdqfGwObsktUR5lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqO0/gVE9IqnYIX7hTSNlChgwk78tibckJLxHjHKgIs+V/I3A6BFoKnSW1BCoB8CHxVdJ0Z9Rer/C72UNytpvfJHzeUq7/xJMI8ACmjBZvTvSFQP2W1iF7Llj9UowCtxLlNR1Pz9EDq/v1RlCux47SV1cye4ENRkiqyz1OqFIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCTgJ131; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KU2uoi0I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCTgJ131";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KU2uoi0I"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAn6b3570200
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=; b=VCTgJ131iEPM4MAE
	8AYlc6FUY8uYOy4BZ+QjxJUMPxwOJP1fAdceJXbGSle3LxdPLs/ci66EsO43j6Aa
	aCV35X4L1GQDnSm7oi2OXuH2GTtAB8jKnxUTqGN99GkNSqHGFM8BsOCG4XOOiG+R
	K6P28wi4JcS9YD5PpAJvsQNwH9pOd+mbfQXlUGRMwiZ+YRyKyDMRmw6q2tyBKrg5
	zcuhJAAZdqDAkWin8FUYJDLXkAYcL/t/TWBIIzqwQ9YloyN3IjqfdZdvcQWSUsJ7
	wUsiP0u0b/+jxA+UfqEZAI3Hst6y/HtalCKmlTL1+NFiI8dWKz6RLaOIlWWkSug4
	/z5aJQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faxyg84qw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:11:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc5faecf01so15537465ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783681910; x=1784286710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=;
        b=KU2uoi0IuETp1dL6Tf0Wt5O73+b6emnQZRmNod6hZ8nOWeNKhPGA4ZKw8Tt7KZd2Ho
         53vivZZYXn6UROqxW3RDhkDzur26XM7anpLZ8k0QE7t3VFugB1gYZKTEO64wQdzo6WZv
         aQHGqKYAaLvp1qgimb5b3EGsCbWnpxAraaRvMpk9Mk4KNrXpMUA2UxmkmGCoM7pYZXTr
         z5S2ZKzM/HTT+jSbr8ZPiXbDIyN2Xj6XNxbfCDKuwy7THPBA6yiEHo4WG+FGs6AAzjl0
         LOUt8esrlVB4gVcxNejzVUhM0gteJ/t1JWWw38t9g3GFYsoYvYRVSi2hO7RNkbzvGo1y
         QYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783681910; x=1784286710;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JU6YRxZVspUNbu+VKz/3WI7sJx1qZ3NhZ7bU7qRiJXg=;
        b=mSz7a1wAHH/lp3/gWrI0iqvlRcSmZ8hHOMGTR2hyRRYrNSE0pgC5EKwAKp6M0d4jpR
         JBsC5XAzQWljVJ+lXfYwKw3vB0xCLB3Y0gWGkgaG5CZn6xRBMl21cI4DpgPu+g350wsJ
         wGWyomtTPrVcJ+WHU75BAS1Oi55gZ2HTll/n88i9R+F9R0dFLHJ//4BjEX5CsUWR/FdE
         p9D1Em8QeYhqDA1AwD3ScwuMZh1xVkQuY0VlnnNa9KU8Pzt/coM7gPBrxDPl9ck0iJnP
         5Jd5NO3xfuAYReSE1N2L3ekIzKySZizCVXpkHxKzAzssY7VY1JivTqiHTbvER7sQwZuj
         jgNA==
X-Gm-Message-State: AOJu0YyhX8botX3Z5ZgwcIBzh1/Q40j+bR1sGrDQV4dQw/yZkLJhwh7R
	JiVdqTNGBYOhgWBDkhaoT40yiMQy+Okpg6P+NjcXYERx3s0hohMIm4O4zbJGRI6Qf7D/U+ZX2HP
	UWVw9M7xix/q5WFosZkQ37HKpTQ1gLWbd7ScMHwaXyZehUG2yZws87UKMN4gY2X0=
X-Gm-Gg: AfdE7cmBf1g9CGgbUZY6pDJHLY5euPBdqb29/CMURDBnKxZmOXbrbowNHMTW7AGlxFC
	LU7NUXp9OTMad331Uvr6e0NTqoqKinagxIC6IkDyvMOA6im1huzNuQus6InZ5KO/+ZgKYmU+zdd
	xuraSKsw3sO4r/zKxDocWq7tDW+e52rjZ/FtITVP5x7R27EuV94JuFg7OAYVQrSRhH6aXsCBzkL
	NQkNgc/bTHpFBrSG7W4xcsvUmXtMD1EKe9F+VGhtjNm4CF8NNILdYx9/epy8lRmxKn5prR1VdMw
	8ci1AKR3TzrPUiJQ41DbKXNOhye0L6hhQb0/9knkW0mdUSUTw1U7OBPop7RBZcfP9wXrURP9Sh5
	jnpPmtMdzmJEWHj05sRXMvMdaYGwW4newJJH62E0K3N9WjvRS0Q==
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id 98e67ed59e1d1-38942b786e0mr10762375a91.43.1783681910297;
        Fri, 10 Jul 2026 04:11:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8c:b0:387:e0cb:7f7 with SMTP id 98e67ed59e1d1-38942b786e0mr10762344a91.43.1783681909714;
        Fri, 10 Jul 2026 04:11:49 -0700 (PDT)
Received: from [192.168.31.103] ([152.58.31.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5516ad7asm2610062a91.3.2026.07.10.04.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:11:49 -0700 (PDT)
Message-ID: <e775ae90-86d2-4901-8057-264953d25c02@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:41:42 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
 <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
 <6b53fa97-0fae-4ba2-a774-ae8df2c2ad4e@oss.qualcomm.com>
 <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <82326bd4-59f0-45b6-8f06-38896cf9f9bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OpJeboDGQn6bcnj0L59cu_GNe3atImdp
X-Authority-Analysis: v=2.4 cv=PLg/P/qC c=1 sm=1 tr=0 ts=6a50d377 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9AXozQ6IwN0d4JI31gUtBA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=52HooUGS_mQjH2t11kEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEwOSBTYWx0ZWRfX/HHCd+30qarW
 SGkXvEMyk0eAmMAdLvR0+OxWzSapZRWjqphnQE2CLiZ4QzJ6ROgsEQ49dVnNnswFjkAd4jJ4wKB
 9IGVtS7DxTZIxUx+20RI0dycwR+PIwo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEwOSBTYWx0ZWRfXzSqzK/zDJPl+
 KPr3fqykVzwVYMef7bDl3XjXk0DeV7tbqdsCjW92SnqRNGCZSDaTmElhzR8jpSNAzA4mAL5abU9
 w/1xtAgwdzELgV1KYzaCItkP8PWvIzVFWU13Ih5Zgcukwz24j1K0aln4kD9q3McTrZaYGcqSzcu
 jiefGcpfk+pO3rhoA5llMVOEvpadhBiRkpnvToC/ZdhersZwV2sigS3LIcV7yJn6bkO64QdOpjm
 CzLOSQAvCpziuhAzPYS/o/4EcUNgGreDj7hWklaO9rH/lOnTrJBo4fLZ3T+OeQwv2kW4tvMLJfH
 kliilSULOrRRHUUARpx+s3/qZDmvl2xOrjf2LykzLh8Rts7ku7rIzO2E7JVzXgXJDu8PsPIQRur
 zzIutyDCx9898bS1z9SWTcEtsl9AEMAeVuC+TL89Gn9mMM2pEMxBa9LlO4PxQ4ATO2zXknoajGD
 HfN5l5KcysPHcOG2Kvw==
X-Proofpoint-GUID: OpJeboDGQn6bcnj0L59cu_GNe3atImdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100109



On 7/10/2026 2:57 PM, Konrad Dybcio wrote:
> On 7/9/26 8:28 AM, Aniket RANDIVE wrote:
>> Thanks Konrad for the review.
>>
>> Sorry, I missed your comments on the v2 patch and ended up posting v3. I'm happy to post a v4 incorporating your feedback once the discussion concludes.
>>
>> On 7/6/2026 5:11 PM, Konrad Dybcio wrote:
>>> On 7/5/26 3:57 PM, Aniket Randive wrote:
>>>> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
>>>> regardless of message length or bus frequency, causing unnecessary
>>>> delays on error paths.
>>>>
>>>> Compute the timeout dynamically from message length and bus frequency
>>>> with a 10x safety margin over the theoretical wire time and a 300ms
>>>> floor. For GPI multi-descriptor transfers, use the maximum message
>>>> length across all queued messages as the per-completion timeout.
>>>
>>> What's the reason for a 0.3 s floor?
>>
>> The floor accounts for I2C clock stretching. The spec allows slaves to hold SCL low indefinitely during internal processing. A dynamically computed xfer time alone gives no time for that.
>> 300ms value covers worst-case stretching while still detecting real hangs 3x faster than the old 1s static timeout.
> 
> Please put that in the commit message and possibly in the code as a comment

Sure. I will update the commit message accordingly and add a 
corresponding comment in the driver as well.
Thanks,
Aniket

> 
>>
>> Thanks,
>> Aniket
>>
>>>
>>> Why a 10x safety margin specifically?
>>>
>>> [...]
>>
>> The multiplier covers the gap between theoretical xfer time and actual completion time (DMA descriptor setup, interrupt latency, and scheduling jitter on a loaded system)
>> Without it, short transfers would have almost no extra time before a spurious timeout.
> 
> Likewise
> 
> (Should there be a constant safety margin added to account for all
> that? Keep in mind this driver will run on a turbofast Glymur and on
> a notsofast Agatti so any numbers that depend on the processor's
> speed must be reasonable for both)
> 
> Konrad

The 10x multiplier was chosen as a conservative guard band to account 
for the gap between theoretical transfer time and actual completion 
time, including DMA setup, interrupt handling, and scheduling delays. 
Although the value is not derived from a formal worst-case latency 
analysis, it provides sufficient tolerance to accommodate runtime 
variability and helps avoid spurious timeouts across a wide range of 
platforms and system load conditions.

Thanks,
Aniket
