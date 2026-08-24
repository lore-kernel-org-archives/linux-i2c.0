Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313284964F
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579060; cv=none; b=DAjcFA4BhpO9HrwIVRQwrKFesbznGrVuAJ+slwxDxKRN5thpd+iIAEvwP8XqxmVmY/wPDIB6xSkqZ+MteTmwB5XF5q+4sLzUEnc0fdvvIfM5iJmBghdNohVtQ64axpc7xpEtG7dqVm5G5xi3liqTznBphpId8oEAcKAwn2QFCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579060; c=relaxed/simple;
	bh=drVhuBxQeShpDUOyhOfxcT08VPuo0dfiuRftN0uOQDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeuKyDPnYt8aU0/d+xg7zbVGF30W1zSoHwChXYPYvxAm/2U3tevUsR31zqqdVpUa9EQ3mCiJ3/vpsmNlM4SxL0d69JWpAEdSKb2/Vav2Vi4Nv/4b5+zQSGSBF7TvAfHJh9i3XsDthL+Secw5w5WALPbxis2wnOA0I7KN4qZ5r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nnyFdS6U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL/4iB0o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nnyFdS6U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL/4iB0o"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCurnQ3613384
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 13:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lKMa1e5vKvj2ijBkWIx/18zNau1rRjql4sCYPc/YlcM=; b=nnyFdS6UPNZWC0e+
	MgDNvc7nrm7C30gyxlOUfJEHh0CiRoCoqZvYE+3/JqhIFhdSRUHVQxaghq2qCBEP
	S4krOmfrvCErv9LN14pJ7aPFyBSZALKZGVgtdKk/IlmHuaXZ4SOksAl5xfqGPMaw
	fjii4zInmPpeTrunmE3KHboUP4MYffwFobZZx8PmOf7I1aEcNdgymw3QXb4YaT70
	AuVPSeJQL4Bnr3+7Hy0AC3aaIbigPhe1GE3tU3sZ7572JH7EwxCuGef4wCQrAsfA
	T/q04f1nkK+MxdogYC3q4xYATL3XVoH7PWuOedjB5a5jgnri83EexGGvjooUNVwz
	4qrbvw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk1cb9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 13:44:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso4414728b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787579056; x=1788183856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKMa1e5vKvj2ijBkWIx/18zNau1rRjql4sCYPc/YlcM=;
        b=fL/4iB0o5inUVpjE23YBnbSDnPc3HWDh/MofgMk0gdd8LFsOl35/G5zArFMseF3ZbI
         +9wx0VFjcH5HR6sZJC2Mz8I6eyROnhJTJo6Pn2qGGL6HtB9gdmQlGqYgPdqy1OeMQFy/
         81HykE8HxBuCQYzgYwh2MdXuNu20bMKiCfX+J3l4g+kqdPCgisJKyAtM0D0T2bFLSbPS
         KCIP7rDkU47i1AZa+2chR0NHJBRMyyCjUR8LU0apabsT8tOT7iJiPtS0s3A+gNuauGjm
         3DJ2qEmt7clscAAUMEBbbI4Zhcyn8cYu6SfXs3TTv8yYVUnGQKcwEIZ4f/eslOCePKlI
         JrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579056; x=1788183856;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKMa1e5vKvj2ijBkWIx/18zNau1rRjql4sCYPc/YlcM=;
        b=Y0hdWpZ41eczo6ibuts9TLJFwjL0NWEaeRWtSel7U0WAh3sQkX2RWIQpozH4ONMbTb
         Zj2DT7s/OlG8E0WMIFkngygBZCiKAO9SNJM/AHhnHPVvXKdJzbe39P3x1yz58p2re6LG
         LXui7siRDz8yBUcyYDEmXbY80oxFiHbbIcw4/YEvpjPoCbptabV3p52cyrvRqOIPmSSs
         VCvL4eqZXup8GOuBZnb+rcq8W2qQfRP98u9BI4j2RN5e55R0pn87Wz2p5lzVaGXlWb4P
         aF0xOeA1LWknuGY9djjavFr/9p3B0EKOtdzn/0O9zyqjq4m6sINLLBZfbeaLJ9nI34lA
         YnEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+ctTeRXn/cyBv7pAgTssM/beu1t10UnNaip5fBTSC/8Bo311nyJCzZ9Tat8Xy5wtK9z3p/TWQtsY=@vger.kernel.org
X-Gm-Message-State: AFuF++lOHnkEDpI4LmmRII/9q9pjd0VoE6cBm7BXWC7MIUgE9yU7avpA
	r+H8gmyGqCy53Di3uLbF0jJv/kXltqnU0DYz1vgrx1kzq7VFehcCGyF7v4fVpECyK5b6s0Wf8Yg
	UeJqI5cXiqqgL01PVDBfC6rbsyRQ1tavJMEE49nHlg4iypIcy24Y2vzuIoJiONb8=
X-Gm-Gg: AR+sD12xzrv0s3Ee7UbtAdBgdhCoM2gFbR+T0dRhwrxIkFPq8JMXgK1Hma+DwHvMt8u
	PIp+eBLFJi7V6CCeKZojrlgypKi4RmCV8YrHojg7jNEjnCNZ/a0cEt0ZCgCEH86Iw+x6WPujhE9
	0y3u6/WwyAgTLQGfzpROUCOwVgJyoqHWLE2HSa+cnU0t4MUKTPs6uN/dN9nLi10FWsiOt+DONJY
	0kJ5nyBqkfNSL9B0NPAAym0SM8bvxENqUEdH5Qy+8lpNddgB1GaJVfQuIPtWTxjhowC0qNtGPXX
	Nb/Efl3cA2oJ9YpK/UMHIVQxj1muJpxfP0jq7xC/biSVhEbuuP2FSvxKBvgPCh85dX4AjEyEFPX
	HTpO0yNgVTlKTaa79Ny3vELr8DV6GcoVoMvA=
X-Received: by 2002:a05:6a00:139c:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851fa081399mr43335468b3a.17.1787579055683;
        Mon, 24 Aug 2026 06:44:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:139c:b0:847:9015:e68c with SMTP id d2e1a72fcca58-851fa081399mr43335140b3a.17.1787579055149;
        Mon, 24 Aug 2026 06:44:15 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed50d7sm1901620b3a.7.2026.08.24.06.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:44:13 -0700 (PDT)
Message-ID: <baa02329-ac3b-4e1f-aa74-72785af78a7f@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 19:14:09 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
 <20260813-master-v7-1-3f9010cf9229@oss.qualcomm.com>
 <29719c5f-757d-426e-94ca-c221f45c00cf@oss.qualcomm.com>
 <92e89073-69d1-41ff-8545-d872b6b0c147@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <92e89073-69d1-41ff-8545-d872b6b0c147@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qAt899Xn0JHzCrFGIzAYMXiVIZ8bYsAA
X-Proofpoint-GUID: qAt899Xn0JHzCrFGIzAYMXiVIZ8bYsAA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX3gK4OOJl+FSw
 tpSXyBHYvW/8+YJG1j/T2bhkK3KaJ84nDzSrMmxeY3Rq1uoORkpGfzUFS/2XzNSnc7awScP0QdZ
 jSbvbzB0wVDJ0O6QFVaakR/sw41g+lQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNSBTYWx0ZWRfX6EgyowNwyaAf
 1mNpgEJBzz6mMrUuFzJA0DV0rPvwwy3p+AH0BipR4NP39dIFdNmajRdeo7w4WgRSVmjVF6CHMbJ
 iLvXhZ3wMLJekgu8rSfikEhEc9sODHe9TFL4MI8LhnhjKFvwsjYZFHr/CAwHBMpd+/+GLSiDXQd
 19fPproTVRc/MxOQSHGtoLowx/MGZKI06MvjsCJvQBX5rPho22XC2BQoY85nQi7zXOVztR5Ta3+
 Laewy1NklUatxvv2FRsVNpARJJ5CVRionIeTNK9CpJ+ICDYEVksQh1fbOTquTFRzeOf5RsJ4hVi
 FllrhG5XBUezn6VP6fUg1cbG48y3R4WDHUp/B1Op1vqw1d7AXLTRkpVJaotgW7JtypnrPkr1UxH
 z1a8tsgyzB6ey+zJEVGnXAAQ+wdlpkl8NpzQCiwnTsb2uc3z1+1WDssOu6qyvKqos14afbPrilZ
 k4xRJyQDXpWPh+vUnQw==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c4ab0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pjdmtgn-RlP7ytGTrpkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240115



On 8/24/2026 3:36 PM, Aniket RANDIVE wrote:
> 
> 
> On 8/24/2026 11:49 AM, Mukesh Savaliya wrote:
>>
>>
>> On 8/13/2026 11:15 AM, Aniket Randive wrote:
>> [...]
>>
>>> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
>>> +            size_t len, unsigned int safety_coeff,
>>> +            unsigned int min_usec)
>>> +{
>>> +    u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
>> let's validate bus_freq_hz to prevent from 0 value in case of any 
>> abnormal caller.
> 
> This scenario is highly unlikely. Most drivers operate with a default 
> bus frequency, typically 400 kHz, and therefore the condition being 
> checked is not expected to occur in practice. As a result, I do not 
> believe this validation is necessary in this case.
> 

Unlikely but also possible, it's framework change. So can't guarantee 
about all other soc drivers.

> Thanks,
> Aniket

Please remove this sign from in between.

> 
>>
>>> +    u64 total_usec = bit_usec * safety_coeff + min_usec;
>>> +    unsigned long jiffies_val;
>>> +
>>> +    /* Userspace-configured timeout always takes precedence. */
>>> +    if (adap->user_timeout > 0) {
>>> +        adap->timeout = adap->user_timeout;
>>> +        return;
>>> +    }
>>> +
>>> +    jiffies_val = usecs_to_jiffies((unsigned int)min_t(u64, 
>>> total_usec, UINT_MAX));
>>> +    /* adap->timeout is int; guard against signed overflow. */
>>> +    adap->timeout = (int)min_t(unsigned long, jiffies_val, INT_MAX);
>>> +}
>>> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
>>> +#endif /* CONFIG_I2C_DYNAMIC_TIMEOUT */
>>> +
>>
>> [...]
>>
> 

