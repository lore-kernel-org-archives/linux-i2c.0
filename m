Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1625B094
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088403; cv=none; b=CXnVeadFFDo3WCxY2Y6nK9fjPQE+e8/ZjFEXIWO5q+r0hABQ6e/ADY/IEsOAo2ikMtnKyAcDWDxoplF7NWKAHm5WqINDXgF7XA0JlqFumn/YnNLpxfKAtRWP2SE1PfPCRQv8Yhfsc4lpucFpiXgnWf0vpI8p/l+DatTsrDeY1OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088403; c=relaxed/simple;
	bh=0EFshVqSrc8f7OStgTf8hZCJkjVP5CzhGdQcqZKvRV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUJbK/NoZoYMUv7sUUIGcvOsi1IVyVzOWWp8g9WABRNBu8CUWAV853oBgQGkt4US6HVHtlFUqyZIsN1qB09XeLfG3oP5yL2DMJgTpA0SHRkDCVLbPhTma5DAfdiZx8I+f5Q8tIEdzg7Ju9wvoRHahJHHAA+DZDluqmnZpBDmVQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBX2aI/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UjROiSJA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBX2aI/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UjROiSJA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lE8r2588567
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 04:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=; b=MBX2aI/E267mc+Ri
	Ae2koslafqgvNgkufljnooxJZ/mYOzcNmTBJ1O/GCjLaXODOL5WMxsAmoeNgAgIE
	T7+FdX/FegTXjic/uied/NqaF7LWQDNJfU6Z6YMNMCltGUy1bNIjc9L6kPkMFrFZ
	0PTkWf1iKlUWhR/crNap7gH52HnFbIWZGWp+fcWYv42fyODmgAh32aswrBpNIXkz
	K2UbaBp2xUTQxdDOqPMJCL225uzX9oFNVb+WcMj/cf21/x0P58UnoF+IjHZrgMk/
	iF3LCwyM27PRzeKEwuDkKgt46NW5UhMR4Thwe607JpSy0awSC/QxOrSjpiQOmvsp
	AcvVnw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9hsu27-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 04:06:40 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so7448158a12.0
        for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784088399; x=1784693199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=;
        b=UjROiSJAdTRU1jHdyKEKlBHAUM/aRPkVkhsT6lIrHFtYObK0ujpxOyzGsYm+t6Lqy0
         qcMOL5yGUaMfPfVMA4VZlJ8zXJHDGT6/9NaN7V0R0hk/+HYj97UtGwARK6mBywpgsJHQ
         CL8/vKcHD+vP7lOFJDGGXtrTeCk4t4l+K63v61PPDWIFFXflQqbkQe32BSvsIsmgLQpg
         7Oi8oPQpADPtV4fUDOTqa2mCtUBp5L4fAzcGIWzpgvqslljtqqis4cNtQkvT6i+2TNUH
         0kpJwavRD+h+jn7643po7F4z9y8AJLOu+Q78sVUcXOMBsdLq1sihuMKHdMCTEhy8N6B5
         AFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784088399; x=1784693199;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aq8pKEu+zdq3GBZfc94BkwVIZ1D/MyJMoeF2wETynLU=;
        b=KE+AjNjg6FdOGklQJLYkUSr1EHdyF8ORWHNzXdYFFblfzLZIVc4xVAJXOJXdhKX/HN
         EonUl17fQLguGF4NT1lVRWZrFERuvNnbXrgOCnTeVM2iD7EL1f9Hqb7M11fdrEtJ+Z4z
         10rE7XkcuSmrhMF8weV590uflqz9Dbbj70cZxLOD8sheGK5e+sfM4AgTMpYKtSnpy4sG
         YXOu+N+EjBvVrP5+4qo6A6u+wTj7kKmndFPgbebBsllQMqPidVDH1D1Sq6UH63xNMM7I
         rtL1dfHr0cfqgJvRPZPUtlkgspFb7rNmfIs8oq+Sy6MT9ksy7IyHZfGtPDtstTIx+KqI
         1vyw==
X-Gm-Message-State: AOJu0YxwKXJ+xcCIIoPYenIdfNKpQdP2/Ryr9nSP82BNWL5cmcuARtIF
	vourgz75vJpCqjBOyZhrwC2FQynXX+cGA6QzjxETts/Gl5bCuEC2H0Ah2UWsQae4DZ+4HNMrG6+
	B0ENJWMmgkdnj1IrflRBHF2xE/iwNDNCeX3VVfVkVI8O7JyTQgNa0sGivHiFaAfE=
X-Gm-Gg: AfdE7cmWDpQ+bAEt+cCIMP31vjSBShvul3FZAw4U8OFBv+sUvgfrQOYvYExAiw0EcAL
	as006CUEbQy3nbrUNiyR3hlJmERZrZh3rRE4/rOqmAL5gGYiBZf4VGdSwDOzUWjSjbQgF9n2HkD
	to6ONRy9EQCnCnYjCTAFjb9AaWOtoko7xgBuQq1blMtQr1qq0uRtaz/+8Ot9wjVfYOhvd2oVuvt
	EPy9QrDSc03+8129oVGwINXQJwxU0rDVRDJxSg/op7SVUgkuB52VJnkHGaJQoM/dyRZq8NUFxWy
	m/Ysqz+I+Ry7hYfpwdG6QQvk7sEQOjdrTik8zpSQxSgNcwe/IX6h8GqDYIhwI5LNbibzdwVXpFy
	kL49KJohY2/pEQUfLdInC9lTpm8ZHYi2yNeL5N1x250Cu3Q==
X-Received: by 2002:a05:6a21:8cc9:b0:3c0:9c18:d5a6 with SMTP id adf61e73a8af0-3c35729077fmr6943837637.67.1784088399582;
        Tue, 14 Jul 2026 21:06:39 -0700 (PDT)
X-Received: by 2002:a05:6a21:8cc9:b0:3c0:9c18:d5a6 with SMTP id adf61e73a8af0-3c35729077fmr6943801637.67.1784088399121;
        Tue, 14 Jul 2026 21:06:39 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b9a67c217sm27006165c88.8.2026.07.14.21.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 21:06:38 -0700 (PDT)
Message-ID: <e53ea721-bcd1-4d8f-9b7a-ea6ec3003f71@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 09:36:33 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com
References: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ib+3n2qa c=1 sm=1 tr=0 ts=6a570750 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ENRykshp9vPgoFS4LJQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 9N1SuWvs45uTtYxPvP-yFoI37ekHoQAz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAzNCBTYWx0ZWRfX1Y1pJirh0YgF
 gB2tbpdT3TrM4hiJCifwE1XYVbRQmxHp6FoHhUSqppjbQuQ65cnwnp/pe0TG0GvPSYB0lZSU+VS
 fkDxBBnnWNvK1baKZcVP5HvTdJ6ki0o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAzNCBTYWx0ZWRfX4Bk43OBEIo/e
 IWCgwqAS/yD47JGrr9IK6VLWCb09zNrWKmoRjczjU9MCoDN7Rp5NJKcdmDWk42KUWcK8ClxC8Rk
 jcgGX350cseBPewi8dtq/iP+f18uyGvnCkGY1A4IYGD+XJtjXL76YFQ0+77kyuyvxxNM9s9obY8
 vhvFaJZZufP8OwtDBPYsUucF9X0J+WNTJCLMbP98jkXnfpP7te0VSKAK1GHwE3SoC3IT071ZsTz
 je3FDKSx+MOCbWSyu9IwK6jU3itsPwNzGm5sx5AtQUi+VIk4PWbkLy5cwrkBqwwHNuXEC5GPjrb
 UlNIibCkW8fvXBni9hHzaEajqFS326I7HkIqv70AokoLFUInNgmqyr0CqSZ1MvUPsektRxgemDd
 Q1VtPpZproq1aDYzFXoUia9lbpuX+ZN2VGh0A0nqACsWKGgdF2qMWrcaPbcdUeWWapiK0aZw2yk
 ODLGBeweKtR2mEdjYuw==
X-Proofpoint-GUID: 9N1SuWvs45uTtYxPvP-yFoI37ekHoQAz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150034

Hi Aniket, Thanks for addressing previous comments.

On 7/10/2026 9:40 PM, Aniket Randive wrote:
> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
> regardless of message length or bus frequency, causing unnecessary
> delays on error paths.
> 
> Compute the timeout dynamically from message length and bus frequency
> with a 10x safety margin over the theoretical wire time. Add a 300ms
> floor to budget for I2C clock stretching, where a slave may hold SCL
> low indefinitely during internal processing. This detects real hangs
not only internal processing but it may go bad holding SCL low indefinitely.
> 3x faster than the old 1s static timeout.
Meaning, in such case/scenario, don't need to wait till fixes timeout.
I guess, 3x faster is relative to the 1 sec, but for larger data and 
slower frequency it may not be 3x. Hence, correct it accordingly.
> 
> For GPI multi-descriptor transfers, use the maximum message length across
> all queued messages as the per-completion timeout.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
> 
> Changes in v4:
>   - As per konrad suggestion used mult_frac() for bit_usec to avoid intermediate
Do not keep space before starting, directly start with "- As per....."
>    overflow on 32-bit targets.
>   - Updated the commit message and added a driver comment explaining the
>     rationale for the 0.3-second minimum timeout floor value.
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 96dbf04138be..c5c3adc8ec77 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -74,9 +74,13 @@ enum geni_i2c_err_code {
>   #define PACKING_BYTES_PW	4
>   
>   #define ABORT_TIMEOUT		HZ
> -#define XFER_TIMEOUT		HZ
>   #define RST_TIMEOUT		HZ
>   
> +/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
> +#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
Add a line space to make it look clean
> +/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
Already explained in commit log, can remove second part.

> +#define I2C_TIMEOUT_MIN_USEC		300000
> +
[...]
