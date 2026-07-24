Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAB3FFF82
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893612; cv=none; b=u6lSGTuA2LDA4fmfbicwAeFhEVDuFwxJr84JVKiiBRPwSM4YKK6A8uoyxck2ktudIGl2oEzqWC7Jm0wkf8y+aYLlTJ+xTWr7YKUMUQbWuhxLfmj1DuBDUyEGxooRygauVa2u1A2hedEBjqgWievEgJwFLDfs4KUD9rpGjceG3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893612; c=relaxed/simple;
	bh=8n53eoM2Ce+D1YY4Gy6RGiqQe9rphv7FbaKlkvmUtCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAgOLrZDRUWF6qLy1VSkOYrH4eGrFwIRtCzcvZrDc/EbrCWzIAVlQWmCBSgtvrF3NapNG62BjVXTUIVsdYwuf84KrrMFyePJ5Z0qkufiC6vt5dCJGiiPF+oLL4SSuXnWNf4uWY/JC0tu9e4lQI760C1WI1Esp9JCwYQM0LLXM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjDcms/X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWBrYf5L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjDcms/X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWBrYf5L"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OAE9Qv2889657
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SF5gXgEdawXvlfPdk58fGjZD60SZQ4PNrCV5dhNWsY=; b=MjDcms/X+ZpI52OI
	16NnNQLq0uHJclC587yRKX+/HSDGfcCu6+m2/5vw6NvD4zkhvxtwoxjDMq2MqwUP
	8zRbvJOaFbhX6Ete19Mgm3rei1yn5vJ/yyuCnNf/KccD6bLzdFGWTogkc9vxBDRO
	/aM89aF6X3R9hGTCTY1xqWGfpjS2eLT0X4VK9GeX/k48K7aqzG0tOoMwVAoBtS8d
	ZC0dbDSNG1z2fesRq7Pup/EYxpAa+31Reo9N3eyTQvu7MszCggsx2fj+dYZbHmZj
	E139o9+TTR4nmK0qhGrhju++fMY+MaFPiA5bXMf717LXIq1GzRZ8Ns+zd0w/LKi7
	nRCqEA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm61kgbpe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 11:46:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso4655445ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 24 Jul 2026 04:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784893603; x=1785498403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SF5gXgEdawXvlfPdk58fGjZD60SZQ4PNrCV5dhNWsY=;
        b=dWBrYf5L5G4PZkC9tFuL8mAN1hZHdYUJflXsLA2Fz/bgykGlktPfgyjmI8MbLnXCgN
         hmukdP+PtpbzmdrxQmkHtg+QNvPR4lMuZP6UzE9qUijscudd8y3aJrbOI1F4AqYIQke6
         i+woHyJ6w//oPnoa0ZJJsg7iSc9hc0M4GMfJjemqxz7SqglZFYfWSV+beqEPIR1XAZPg
         QYVAT+fjlPu5mV3J7R406cGhnZXGc+uZsJhhVrZzzylkGEoeIDr9NfMZstX8H1jwJ6dA
         /xCYOBSs596GA1jnJhLHhYmo241l0xAeHJTqDELwfpVzoerJltQIyVe6MqXWB/lrJ6wb
         jOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893603; x=1785498403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SF5gXgEdawXvlfPdk58fGjZD60SZQ4PNrCV5dhNWsY=;
        b=hfxSJMtLuUiNejnFKNSCFkHPPwA8GYiNu2CmQxOYUz02fwgyzfpY6k/Fvqkb1BfxuP
         N20vNa3wqsXoYm+1N4/yOtbYVgbA9Y6zwdFFr4x1+Z+fu7B51Thg8PTf2GwWHgNpP6N2
         MqiYHk1UleYN7egIhmZDOtFARd2QhDElMdDsSC1n/s2FnvzjK8ROX91LyYDgT+Ay/syT
         gKLXXhkKbSmNYnyGhzRiIrwRpwf9BBkTqArXFnrBMPn91qONmzOx8uJayftwvoLzobES
         KOcLUfsomlmWaa2rtP6tZec7Q1BNBe2L1m+yEjeBrrceRVuqfg5KI3ExGU0I6Br+aVC0
         5SJA==
X-Gm-Message-State: AOJu0YyueIrWmr9QDFZUBkSQvaQiN8+xQtYhm9+uBwDfEtriNnoRQvCn
	6qsEeWHKE9i3n0LB8x/FtIBkAJrOrB3HqcubJzDTSjRFv1VzVd3ZVOZhiZMbPr0UTxFTRPvVf1G
	XtFisbvAdSeR8S49zrPNq9HwhL7QhsAdYG1W1O5407YLZA90/VxK5jtOEPiXzictPjM3+K7o=
X-Gm-Gg: AR+sD12nkjDL+CDHYCGgNLUP9A77t+ozGDuSWbHD4r/yfEu/J1daqSSBIuFzsfR2Zwv
	ndJxV4oAuQS0s2N2LR/sACkK70pA1b0Kb3MgIkcO935hzN2lnesGrbx477XDlGEFLcuVL6vXCpL
	+4gzAbL5MXrG6TQ6c6vk8bPgBupgHSegneZmXSUG52FJmJ8k8SrB20D3uJRmGgcQKkiL6w8L0q/
	wb9Yqy8nxMg5Svofhae3JJB8Fvna13FUvbaBEzqyNWNNC7wnobUY359lxIr3R2PA76GJVotw9PV
	1ygQZUq+5fFGnK9FCNO0Qn9Fr9ErDcJZlwQQr94Z3yP5VRYRZ3ilaWuL+0Qyu3FIrmD78IubfU7
	zSrGs3QoDQZ4+f4SdxIUdXnr9172hTLjG
X-Received: by 2002:a17:903:1246:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2cfa6f821aamr82763805ad.43.1784893602487;
        Fri, 24 Jul 2026 04:46:42 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2ca:4cfd:a6df with SMTP id d9443c01a7336-2cfa6f821aamr82763465ad.43.1784893601895;
        Fri, 24 Jul 2026 04:46:41 -0700 (PDT)
Received: from [10.217.218.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd828asm50332545ad.19.2026.07.24.04.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 04:46:41 -0700 (PDT)
Message-ID: <603b01b5-382c-4da9-93e0-9571721806ae@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:16:35 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
 <65d7144c-855a-4b3b-93e1-c18c12f199ac@oss.qualcomm.com>
Content-Language: en-US
From: Aniket RANDIVE <aniket.randive@oss.qualcomm.com>
In-Reply-To: <65d7144c-855a-4b3b-93e1-c18c12f199ac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bcCA8jJ7TW4mYiOKYzgqxC_0Spp4MKAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEwNyBTYWx0ZWRfX81qIRkeEMaJD
 3jrJHoADK2VVbq4J7kDZ5qwYqsz0/Jp8McJmJjo+REsU9lQ8cH0SZIBg+OqGzz+8m6YpmMtrA1L
 Q6rQmzyP8I8trxk7LkkV0bysQq5kgwAm/O4BytWoJws5xHEz4NwBNkzXtYSWRPJ5fw2ornkepAe
 FVcSsE3OcGljpH5it999vN8rBOBid4L5h46mtrcGyLyjXR7UmA8ayM8K4fzJUYPdTRguoez6ARS
 o72IBI8hZ+mlYfO/DGHY1AMS8XKopBdOTPr1mARauilQQwd9E7B23vzPUqYSCNA/qMikUmynz3S
 7QWzb7m7lU9YfIw7gv722g90b22ExWDMN+EVNIVH8Yjzn953omwsZAtmtXJEcAdlZCvIg5fTlQp
 kpGcJK71byLm32OZIKChD5rtbtZNIbp9ELskdjuEs8Q0I8fBUtp9ozElrGbG/pXr4XBXNLYXpvz
 lntyNTouMDRuBHj4wLQ==
X-Proofpoint-ORIG-GUID: bcCA8jJ7TW4mYiOKYzgqxC_0Spp4MKAc
X-Authority-Analysis: v=2.4 cv=JLcLdcKb c=1 sm=1 tr=0 ts=6a6350a3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0liSH36yjE6c7cn47D0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEwNyBTYWx0ZWRfX5qevYPkswHf7
 OvMIjFG/rU8+20IfezU/faWbVnf17BlAvbDkzOUS4PC0CgjfpwMzTrMl/WYp0EHvtju2KOMifgh
 qqM9weqfhQDgdddzCYMgOtMTUHzKg88=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240107



On 7/22/2026 10:55 AM, Mukesh Savaliya wrote:
> 
> 
> On 7/20/2026 5:11 PM, Aniket Randive wrote:
>> The transfer timeout for an I2C controller should reflect the actual
>> message length and bus frequency rather than a static 1-second value.
>> A static timeout causes unnecessary delays on error paths for short
>> messages, and may be insufficient for very long transfers.
>>
> in short write as should be relative to the bus speed and data length 
> instead of any hard coded values.

OK. will update the commit message.
Thanks,
Aniket

>> Add i2c_update_timeout() to i2c-core which computes a transfer-specific
>> timeout and stores it directly in the standard adap->timeout field.  The
>> formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
>> bus frequency.  The caller supplies a safety multiplier and a minimum
>> floor so that each driver retains full control over its timing policy
>> without those values becoming public API.
>>
>> Storing the result in adap->timeout makes it visible to all consumers of
>> that field, including the arbitration-loss retry loop in 
>> __i2c_transfer().
>>
>> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
>> ---
>>   drivers/i2c/i2c-core-base.c | 24 ++++++++++++++++++++++++
>>   include/linux/i2c.h         |  3 +++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>> index 3ec04787a737..3280652e20d8 100644
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/irq.h>
>>   #include <linux/jump_label.h>
>>   #include <linux/kernel.h>
>> +#include <linux/math64.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/of_device.h>
>> @@ -2000,6 +2001,29 @@ void i2c_parse_fw_timings(struct device *dev, 
>> struct i2c_timings *t, bool use_de
>>   }
>>   EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
> can i2c-core-base.c calculate within and store into adap->timeout ? 
> Current adap->timeout = HZ can be removed if we add coefficient and 
> safety factor default ?
> 
> Any other thoughts ?
> 

I think keeping the timeout calculation in the core layer is reasonable, 
but the core may not have enough information to derive a universally 
correct timeout value. Different controllers and platforms can operate 
at different bus frequencies and may require different timeout margins 
depending on hardware characteristics, clocking, latency. Because of 
this, a single default coefficient or safety factor in the core could be 
too aggressive for some platforms and unnecessarily large for others.

My preference would be for the core to perform the timeout calculation 
while allowing bus drivers to provide the required parameters (e.g. 
floor timeout and safety coefficient). This keeps the calculation 
centralized while still giving individual controllers the flexibility to 
tune the timeout based on their hardware requirements.
Using a fixed default coefficient/safety factor in the core and removing 
the existing adap->timeout = HZ fallback may risk regressions on 
platforms that require a larger timeout margin.

Thanks,
Aniket

>> +/**
>> + * i2c_update_timeout - compute and set a dynamic transfer timeout on 
>> an adapter
>> + * @adap: the i2c_adapter whose timeout field will be updated
>> + * @bus_freq_hz: I2C bus clock frequency in Hz
>> + * @len: transfer length in bytes
>> + * @safety_coeff: multiplier applied over the theoretical wire time
>> + * @min_usec: minimum timeout floor in microseconds
>> + *
>> + * Computes a transfer-specific timeout from the message length and bus
>> + * frequency, applies a safety multiplier and a minimum floor, then 
>> stores
>> + * the result in adap->timeout (in jiffies).  The caller supplies the 
>> policy
>> + * constants so they remain internal to the driver.
>> + */
>> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
>> +            size_t len, unsigned int safety_coeff,
>> +            unsigned int min_usec)
>> +{
>> +    u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
>> +
>> +    adap->timeout = usecs_to_jiffies(bit_usec * safety_coeff + 
>> min_usec);
>> +}
>> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
> why is this exported ? you have alrady added in i2c.h ?

Adding in i2c.h file only provides the prototype required for 
compilation. Since the implementation present in i2c-core-base.c and is 
called from i2c Geni driver, the symbol must also be exported when the 
core and driver are built as separate modules. Otherwise modpost reports 
an undefined symbol for i2c_update_timeout(). Therefore the header 
declaration and EXPORT_SYMBOL_GPL() serve different purposes and both 
are required.

Thanks,
Aniket

>> +
>>   /* 
>> ------------------------------------------------------------------------- */
>>   int i2c_for_each_dev(void *data, int (*fn)(struct device *dev, void 
>> *data))
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 14ab4d3055af..b52974eb7e58 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -912,6 +912,9 @@ void i2c_put_adapter(struct i2c_adapter *adap);
>>   unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
>>   void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, 
>> bool use_defaults);
>> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
>> +            size_t len, unsigned int safety_coeff,
>> +            unsigned int min_usec);
>>   /* Return the functionality mask */
>>   static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
>>
> 

