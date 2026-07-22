Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D92E738A
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697946; cv=none; b=KwWe4gG62Y+/a8NMeTpNP7Gfu45hReCHlCcmWigHJJNexIbVxlIhLkPTCzxSu3VjfrMZ0OXKGB+hahCdxk6DhDRBaQkdOZjHA3LUd3SPOltM32GJAz+R9oZ/LN2G6Azi3+9aXyTMgGg6FmzJotc9qLGcV4TBfAV34mF7L6CjzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697946; c=relaxed/simple;
	bh=8dOP4Ol+MxzS1oige15PQWq7tbq55uDt1yN2tKeA//U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siJBTM/FCmC9VM05I/OsGSv+Lpy6ybHweMbD4VYgX/N8BxNzG6hRlFVaZhy962eTe1AJ6B2QxCNq6iVkBTQz/ZVSVjyU3yX3OL72fAwM5zBmMQ2BkGK/6QIi064Mm0WWIgFs+I8r3jMDPyqjTsV31KQdcgZ191IVseZCfzHjcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxH3XsYg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CTfAA85N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxH3XsYg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CTfAA85N"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53fhF4027284
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BzQcr8m37xvJeT3LrP/YCQX3yjAJp9QHmunjzNLOzG0=; b=jxH3XsYgYZBR6OGL
	Aam3eo+YOsEK3LRJLmeA20+3+wm5dvBWgojdxh3P9ZH+fjcvR21Zg6KNejgZ9wCI
	2/qc3ZGPtzLvyvm8Is2s6nSsVhf4Q+9dW9pBfg3zXNTQZgQXJtKzinH+tgljfmg5
	49eFKdI5rP2Xsj+4sriKELB0OWFGgbJT/AhTySh2RfhMh3pAEYG+Mo3iO+4W6HHR
	65ShfqA4AOVPNg0nq+NRS/I3qTNyIy0g6D5nMzN3DcOI2qVHTLoEKTIxboK1vjt1
	QyWvSESCyaa8ezfmpGptlDhhSROD2GgKFwao4EXhIxawAc89zcpuhB1yTm3kCSqX
	DsaHfA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbmh6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca3673560so209863845ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 22:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784697943; x=1785302743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzQcr8m37xvJeT3LrP/YCQX3yjAJp9QHmunjzNLOzG0=;
        b=CTfAA85NKcJLocxL15LYIPjvHq13XGRdsznKdCdFms4uB/qvhX3+I+U9CNz6uVqPBp
         YB4o60sUHAPMb96s11thFsvwk17+4Y28dr+wO7oOFM/w6oltd6aHcNX4DZ1998Gkklio
         T6wOBhIz8T53YQu+PLctkdFmIMizII94jZz6SQrYsjWDonN+W+9JhcnK82KUNaAPPH7V
         mDuIdorEQC7LK01ajFxrB/E/xwTWZ05mR6H3HESLcF+tJOgSKriyDjAuAKYvx/spBsC9
         xRbDpMCUXRcoIwYJXOgq/nSzehkE/erAsQ1hAWIw0nRDOkB5NkK8oqsxWNHTig6SnayV
         H6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784697943; x=1785302743;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzQcr8m37xvJeT3LrP/YCQX3yjAJp9QHmunjzNLOzG0=;
        b=o7fmoYg8fS/uOGwHdibz4qIlhNv6MQYt5KmQ8+MSVRcIoCIuYQSUECmn9VtbTwXu/n
         7KGPzK7KQ2QJO8YCehvXONaALrzmsWfDjbzoU8u774GdlUa1xQ3muTmE50K1/1ih2Cpj
         p6DxdzW2IGf38Yq6qE8n6PiVJ17eCw77d9J1dkrEcSSiyQ0ioUlA5F0YTKNboRgLien8
         26UDd5zeo6Y4GUe4NWxWqoOlFhDlURSRXee8G/uNzmSLIvoqtYvokYTYoN8436HmtrSf
         N+g/T10MoYvH4tJczWGSB0wn794xHCAY73wD63ciDExtgBaV5Y28fR2A1I41rYDnmLeh
         SLeA==
X-Gm-Message-State: AOJu0YzC62+Oj8pKQGDFqDksoaSOcf4A/dZPhcG1kDACMY/XxuJR2b5O
	gazwOChTdGqkYb4kg3m7ja3SFkhFQOH7uWCp81Q10faQs00dPruW1KCD2wHPgAf7/8GYNPknA1q
	oLPTX0wYb2yRPloBOEVVXP4comSz2dcDX5KSPZ9+BZqXRPFi3MDIxuyC2U03nelA=
X-Gm-Gg: AR+sD11f9bWNC6fUORNdJDAl68t/4Y61cYfNbuGxrntaz5h2XTXKvRaT3P5yLwvg/MW
	kEz9XOtKstJkpLV4hkOIw5d7hQQxAWNOTZaVubjSXdQ3qVSL7RhMfyY091bWDKFGxQx0pxboA5h
	pzSYNokl6kkf6CylzrtGs5BeKzX21khOuitCQVG129uny6yz9Nmdi5icHZHeqEwo7OaUJIOAVUs
	E4qFXpvC+0D1sZuWJWNPDPkgxU2fbWHlVnZxNIFd5SGjP1wqmb8zOuzjcuwlNmQyfJ7cxs1sSXC
	VvVryp8LYIQ8O4xtwhwJfvjiel79KbGSQK93FMuTQKJwbp1KlmAa0JwKp3mV+PA2bE7aH8hJYMu
	kLR1kgfjABoa1QLaP8bU4zLG8nTBIgmGXJGw=
X-Received: by 2002:a17:902:cecd:b0:2c9:9a19:10c with SMTP id d9443c01a7336-2cf34a4c9d7mr224373245ad.40.1784697943537;
        Tue, 21 Jul 2026 22:25:43 -0700 (PDT)
X-Received: by 2002:a17:902:cecd:b0:2c9:9a19:10c with SMTP id d9443c01a7336-2cf34a4c9d7mr224373065ad.40.1784697942947;
        Tue, 21 Jul 2026 22:25:42 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e621dsm7960505ad.48.2026.07.21.22.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 22:25:42 -0700 (PDT)
Message-ID: <65d7144c-855a-4b3b-93e1-c18c12f199ac@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 10:55:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pEcytgwOV4RGTrgek5JzvM5I9--PJ6-3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfXzJaJCPAUC5DW
 v291xFe6skb51MaeRbDvv6mWIbPb70TNeTyr5TR97N6F3E1DivUb7+O5E+CvkPJ0jVtW6zrgyJi
 Gr41A9D52xAwp1f5mmnxOIrQMwoZzPhwQxEPXWHIS0UEoPcvAT1Wy0+gh63yfBT1FLLNALGs3QW
 qshvfhpF0PYxoI17L0541psonvtTQBQD6eGRPPPY7Tui/Gpzqj1vR8UirRjERlo5q7xiNa4IrI9
 DceecVb8UV2+NI+OVzz2u8nNZ4B4gb6+fSsZAD1RmG98NrdHfPuYSlZNCB5HfPSLzygul0l/eb6
 nHWO4Qytok4uz3fO0DX5KBBpRMF7SwYFMGvv+gsTP0OwMZu9Tt5MIpCpZn44S5gYcrLYAG+HBqH
 WXonGXAzjiEQVjcLM7koa/ZI0Gxk0hbGCXIcVFeTwu1XNdCxMdlvq8Zk2B/UdK4IeJpj/mDuio/
 SlBvH9GxjQO5+sFfhoQ==
X-Proofpoint-GUID: pEcytgwOV4RGTrgek5JzvM5I9--PJ6-3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfX20lwuP05fCuQ
 6UJ+YfbQY8mZ4fnDtFaRloFnB8cHSYC/K07C7AanDklPUPfsj1iXwFz4I1X2nXaYDlGcdtJZ03W
 qoJYIDU1e3vYzLeXpC3mfAAgg/lJnW8=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a605458 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=W_snkT02l9C0IohT3WkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220047



On 7/20/2026 5:11 PM, Aniket Randive wrote:
> The transfer timeout for an I2C controller should reflect the actual
> message length and bus frequency rather than a static 1-second value.
> A static timeout causes unnecessary delays on error paths for short
> messages, and may be insufficient for very long transfers.
> 
in short write as should be relative to the bus speed and data length 
instead of any hard coded values.
> Add i2c_update_timeout() to i2c-core which computes a transfer-specific
> timeout and stores it directly in the standard adap->timeout field.  The
> formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
> bus frequency.  The caller supplies a safety multiplier and a minimum
> floor so that each driver retains full control over its timing policy
> without those values becoming public API.
> 
> Storing the result in adap->timeout makes it visible to all consumers of
> that field, including the arbitration-loss retry loop in __i2c_transfer().
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
>   drivers/i2c/i2c-core-base.c | 24 ++++++++++++++++++++++++
>   include/linux/i2c.h         |  3 +++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 3ec04787a737..3280652e20d8 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -29,6 +29,7 @@
>   #include <linux/irq.h>
>   #include <linux/jump_label.h>
>   #include <linux/kernel.h>
> +#include <linux/math64.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/of_device.h>
> @@ -2000,6 +2001,29 @@ void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_de
>   }
>   EXPORT_SYMBOL_GPL(i2c_parse_fw_timings);
>   
can i2c-core-base.c calculate within and store into adap->timeout ? 
Current adap->timeout = HZ can be removed if we add coefficient and 
safety factor default ?

Any other thoughts ?

> +/**
> + * i2c_update_timeout - compute and set a dynamic transfer timeout on an adapter
> + * @adap: the i2c_adapter whose timeout field will be updated
> + * @bus_freq_hz: I2C bus clock frequency in Hz
> + * @len: transfer length in bytes
> + * @safety_coeff: multiplier applied over the theoretical wire time
> + * @min_usec: minimum timeout floor in microseconds
> + *
> + * Computes a transfer-specific timeout from the message length and bus
> + * frequency, applies a safety multiplier and a minimum floor, then stores
> + * the result in adap->timeout (in jiffies).  The caller supplies the policy
> + * constants so they remain internal to the driver.
> + */
> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
> +			size_t len, unsigned int safety_coeff,
> +			unsigned int min_usec)
> +{
> +	u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);
> +
> +	adap->timeout = usecs_to_jiffies(bit_usec * safety_coeff + min_usec);
> +}
> +EXPORT_SYMBOL_GPL(i2c_update_timeout);
why is this exported ? you have alrady added in i2c.h ?
> +
>   /* ------------------------------------------------------------------------- */
>   
>   int i2c_for_each_dev(void *data, int (*fn)(struct device *dev, void *data))
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 14ab4d3055af..b52974eb7e58 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -912,6 +912,9 @@ void i2c_put_adapter(struct i2c_adapter *adap);
>   unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
>   
>   void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
> +			size_t len, unsigned int safety_coeff,
> +			unsigned int min_usec);
>   
>   /* Return the functionality mask */
>   static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
> 

