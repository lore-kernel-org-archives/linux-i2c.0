Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2827473
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566024; cv=none; b=C7iJOd1BoIUPN4a3EpqeZ/4YQUM/leopfjMbJ/AuwHtgh1gDafBR2n7ZnrDYyZ6zvaPtg3hKfGJ92nqNBDfbkL5M9NBwsaJJYu3SzTu6zDBGlDgfFivUFLJL6C1SXzGaJZ8KJy1E8vLPGgE4mKlDXLr6gPPs5LLHL7cJa/AW1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566024; c=relaxed/simple;
	bh=m7roA/WbP9oE0Ivr4nqo1RVFQf4lNWod3EUXNP/EtQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCwRkTO2p0/qBIkdP/RfwqriHDXiNLpnYe/VOuCA66IBRt+/9a00eSuoGPN5MahBU5fBfdylRQHm7TNUmKxkxzHugzyH4tV24oIxNE8JmUFDuFS68VYiKbCBmPjULqSziBYTGErr5fArpz3PXLOe3YeR5FjKXa4om2UzlvK3Adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B70+cgdG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ETNIL/ZQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B70+cgdG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETNIL/ZQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OA3Edx1630134
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 10:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nqMW1kmMRC4PsfXJ0A+CF6X7lufuIo+KkppMVmucPMA=; b=B70+cgdGSs0AUqMW
	7p6ub6k3S2mN35mGcKW6++Bw0tUDU0LIgZknNzSN9xFKMD/++FWgFFSDxyluEJwA
	dDMXHX3xCRemexgxydHW9pV5LifNn9lHvA7gW8vTcNBDUNQVIz5apZAvzchlcV3D
	SDt2elBHqzJKITVir8jcW3PC7S6Q7bEQozWKNUxX9qu3WCdM8rCMJOkd4SmG1Rd1
	EoSg7FYLsGw8AV13eUbDdVrc21BZ4/fgyKLfrNPog+hK8HjjDpS1ISuL4lF78IHK
	PHodtsZgXVaMPuZWDKR2kUq3THVYng7rJRxq/dTzZK4ZdPZGbm8nqzAJoVaQetNV
	go+2Iw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv780ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 10:07:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39533bb224cso4009347a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787566022; x=1788170822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nqMW1kmMRC4PsfXJ0A+CF6X7lufuIo+KkppMVmucPMA=;
        b=ETNIL/ZQROF6riEUy+GhbAqOP9y1eJC+vFar6l0XUwEKKbfybXEZRmuBfxtMB3G7jQ
         JsI3xcQSEEOf0OZ+W1gIH1CcjAyeT9c0mYi58O3YCdKZBvCkVdJrMHp47Ack0bZPzlBv
         VD6xyCKuOY5L4619/3nu4EvuKMLN5jnDaXZnD/PFeIYgtAn+qkab0YUvWLpN8Jw+aRCq
         cQb1AqLpuGIk++YvgMcTIRp47rfp9k1A4bnQVGfrA/4vzh/GkZh+hxpNpxTrgIH6A5So
         nRYPdTdHEic7GvlEf/vtj0sQhFC1K+75dKz8mU18RrZelyM2lwkuG5t0tskWylbXqoa0
         0LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566022; x=1788170822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nqMW1kmMRC4PsfXJ0A+CF6X7lufuIo+KkppMVmucPMA=;
        b=ijFmVFQFryHHfVDLGdNQVKcoZUylEQEO16hJWIiqk66RDEx35wOiStoqKKez/GVIvY
         nGOlQ62kwSsl721QQcOlw99TmlEEc7BS/oU6Mt4fNCoZY8RA1TXDMtUYYIgZq6J3sLdE
         4GRB39BH0K5IoYfWGNmuUtDI039/UFJEFZP7bUECddEBsbOOjOYmAmDGli7SR5hsOhKC
         DH8cCklZLWyCGTREq1+jpScAI/mTUKPLhvfO6GBXbzAOoOljU0P1G0yk//z3LDpXPIa2
         D9BBtYY94FPEPpkLBoZ66Fxg1xCgRosTHhjaiqKAK6zviSVamxDi44o4usc/wwNoenRW
         a3yA==
X-Forwarded-Encrypted: i=1; AHgh+Rp5DZPj1RHoF3IKUfVsN9l1Ry1LPx8Sr6y7WhHNeI37My/a8CPtbS0ifNjq26qzXj4GBGfhtcGh0/o=@vger.kernel.org
X-Gm-Message-State: AFuF++nfovKvTWnc08vQLNMaXMrSxXmtRGRx+ymonsPCfK4ot7xBNcdo
	Y+gxHWeeLJl1rNbJzDcwoXs46AEjYAu7iMjOhPm62iHkm5B9O/WPk2DrTeNi6jtZ9eKCXQgn5w9
	ezrbO3I4Y9GCLyBgmzglRlgwzxwZ0GBTnod5FAezN2nmQCgR2VmXvUOKdkSwCUng=
X-Gm-Gg: AR+sD11aB/TddqjOnK2hj3Xxiho/fg4C9UldZYuv3mRV0BCI39WVZMtC7Ve/wHew4d+
	yBCEsXDJ4ER9owmnhD0fu7oA03yqdWZm6ABPKUMg/J87aOI15wkI4csZ3v8696EHyGvCcnY/Nb/
	nRULEVbLnbGnuQ4oE72aVoI7WiJ5v9wVuRqMqwu+4b5q+k4vLPBDt7i00F3VKfkqtsu3soEKBnS
	GZ3X95TPvxaauV6mYBNt/Hq8d1qcoqbjsyKmzKMBIu76vAIBWPvn3kxR+8GNWP58gIOcIRYYDuU
	62I7/MMagDlfWVUPsV+qDhhBMdvVFsslscGm9cOmWDAIeFdhxQQltfRJoN2Wg+Y72mu505jrt24
	44NeGAd/yukKsiYfSOoopat3PCawCdashnw==
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-395df289c4bmr32392462a91.9.1787566021854;
        Mon, 24 Aug 2026 03:07:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-395df289c4bmr32392369a91.9.1787566021422;
        Mon, 24 Aug 2026 03:07:01 -0700 (PDT)
Received: from [10.217.218.252] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c91849f3sm4676869a91.4.2026.08.24.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 03:07:00 -0700 (PDT)
Message-ID: <92e89073-69d1-41ff-8545-d872b6b0c147@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 15:36:56 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
 <20260813-master-v7-1-3f9010cf9229@oss.qualcomm.com>
 <29719c5f-757d-426e-94ca-c221f45c00cf@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <29719c5f-757d-426e-94ca-c221f45c00cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c17c6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Q1tV2UWingJUxihUqQ0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4NSBTYWx0ZWRfX7R+dCNQiJRaU
 V2PQtuMYB2uvr6AuZA4Yo2g5gFW6XtqgLdYRLfcvGS6FiYRIa3S14VaD90HQ1jxOAprA1bDfG2i
 v0VOfMZciWV78ccs1P07jDoHaIM772s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4NSBTYWx0ZWRfX95oBCEsH4iAG
 5DDdVSpvJaGwI3UQLW00JhTld/9XHuj+ATdYpQZ2BLqEhM/5QZD65ZMgM3h6F5pOtL406vuXxbx
 YzsQfvdKWNjdTJUVfXCQpHVJ+Rx5ocJtzHkCTIb0jrUWNMumEU6edrmhedQb8KCMGJ4FgnW8REb
 eHd5ST15aW9guLvl17jFMwVh98XA4zHR0aPLhTUvSprykduTuWIAfaYq9o/VyPWr2yQ2kAX/ybR
 w4kE6/xbJqZSKFUwS2+mJpP2Mnx+o/8OFd1M9oLD94sbOcp/DTieHqd3nsU1PnSIB9Bh8d+ihrG
 qFACFT4/Ef36Tn6WhDERfF8ar/fwe6L/anqJrxZpFVTA26Y/vonFWewUwRWodmGxLxIY15tsWF2
 xrNPwbVmOAXMQjWU3puPPM/8oS0IsiZUJYwO0G/XHkjwX4ltoRR2RXzlkz0qYjCwfZhGHT8riwM
 dkuj25kcym6zMggWC5w==
X-Proofpoint-ORIG-GUID: guevM35YBCKIk-lZxN1hCZFHIyF6ciJs
X-Proofpoint-GUID: guevM35YBCKIk-lZxN1hCZFHIyF6ciJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240085



On 8/24/2026 11:49 AM, Mukesh Savaliya wrote:
> 
> 
> On 8/13/2026 11:15 AM, Aniket Randive wrote:
> [...]
> 
>> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
>> +            size_t len, unsigned int safety_coeff,
>> +            unsigned int min_usec)
>> +{
>> +    u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
> let's validate bus_freq_hz to prevent from 0 value in case of any 
> abnormal caller.

This scenario is highly unlikely. Most drivers operate with a default 
bus frequency, typically 400 kHz, and therefore the condition being 
checked is not expected to occur in practice. As a result, I do not 
believe this validation is necessary in this case.

Thanks,
Aniket

> 
>> +    u64 total_usec = bit_usec * safety_coeff + min_usec;
>> +    unsigned long jiffies_val;
>> +
>> +    /* Userspace-configured timeout always takes precedence. */
>> +    if (adap->user_timeout > 0) {
>> +        adap->timeout = adap->user_timeout;
>> +        return;
>> +    }
>> +
>> +    jiffies_val = usecs_to_jiffies((unsigned int)min_t(u64, 
>> total_usec, UINT_MAX));
>> +    /* adap->timeout is int; guard against signed overflow. */
>> +    adap->timeout = (int)min_t(unsigned long, jiffies_val, INT_MAX);
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
>> +#endif /* CONFIG_I2C_DYNAMIC_TIMEOUT */
>> +
> 
> [...]
> 

