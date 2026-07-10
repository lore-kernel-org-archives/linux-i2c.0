Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BEE3A4F4A
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 06:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664926; cv=none; b=RyjKMLJB0JvT1HEwKj+1Tsrr36LYk849dciqNKmxbLEtmFBd39rt1QS6DuVw8HBTdfF4WOaAsTB70iSNN8PgP0SZbq3AHvtmrlC3FLx/MPgNawKxtFid0dBeEfJ/fgDgNqzsgRv/ykX2jQQcahgZz2SqlPw71BGEOf+ReAcWnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664926; c=relaxed/simple;
	bh=cnTWo1OBd71XYK+ry0dua9p6tI5aZnGavquzA1upFs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WondnXfYT7ueXjo/vCnPFKra/l6ppP1UVAW+etaV6m2QAcE3vzZaTNknTOyWLNsLEqULeMH+OyTgBMitx/sIo47ZTZLBrnWSQcgdzJElRNOmoX5jpSoWmuNfW7yOB6u0ib5CcXsOdwc9QWfYI6kbmUIRVTiC4ro6umOgWGDIzFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VomS/aEH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwjudaKj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VomS/aEH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwjudaKj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3n2pa3661696
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 06:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vCK4xb7+t9eA0fURCfui0sEci53MP/2bb0fASDaMvY0=; b=VomS/aEHPk14x5IZ
	dh7gEEphIyjdk936h3lgbJZRoOzHRvzyxi1+t3iIAoX3ZwiJ/QDsOeoIo7R6qpF8
	9kft49ZJffk6OC4wrCZizJWz0+1AIJmimOK4eF4pbwyaEMQe4nBlv/fvNJvG7+tM
	Azd3Ecao2vK+r+w26QyIqixge8qQpqrHhjkdOeHrSqxkpLgeLBFfUOtq+z1hwl9b
	oNDVolvX4P07WpvEJVD2AL1TgzMOWsA+xq6YPkZyKV9JpQPmoJHL+siulNapoay/
	BGBdtMonp5ATHsGDrp92PLPTrtRfx53E2L4WdOlfnXaBC2u3B9kEX45f2F9i5Q2d
	W3maCQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24tx33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 06:28:44 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso956120a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 23:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783664923; x=1784269723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vCK4xb7+t9eA0fURCfui0sEci53MP/2bb0fASDaMvY0=;
        b=WwjudaKj9r9qz9INLa3+m3PWlwb/Fgi2I4vG8pF8ahLoYxR5ps/BMu6/f6t51Fu5TV
         61ul6z+yHwdGaKTGn/jLeWNEiVRXwrUXYCfNT+Glo6i4ppeJHZbmCBD4wuuA5hEGDUq5
         HgeiYwjrQFrJ3pn/yVqbFpJX2TAHH0mJcfUZw/JykZ41uKnCwrTP5IxJg3hEwdld9YjS
         oI+yZTV614KvRnY0HzkAQZ3+qUE4HPAxZhzc7O3FJiCZUblxk67REwxW7Y0ep/YpBGXO
         1Qbpv+7Vit6uy16QiC2zPwPwM8piFTc1haIYbsSt50LiII+9MxI1RrHESlUHCaxH7wUf
         KfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783664923; x=1784269723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vCK4xb7+t9eA0fURCfui0sEci53MP/2bb0fASDaMvY0=;
        b=gLfRExqimbFieq3aYIzje70W+4S2XIogxOHrv2u2G1SEBEKqRRpnPlokSAWT/NmxNe
         by0Wfr3L8P8u2zK2Fdflo7u079YWGsB7wRhvfIQl9+Aja1ez3obzjc53M6SUUPvsOfC/
         bIgTAUm2SbV0mncph8YLPMBozdyJPVoGCdWTuuaIgfUdVdSJLNrUk1vjf9afTLcLbss8
         dH+phi1FZZ+zd3CJBhkowsRuQHeZkWUmbGsIwIeBTduIAfcgPoxVDAMNzNBRIbtrM36j
         r3D0oslBpQE0c8t1SGrDCJ2iGZcJ+NrJHLwd3qqMhGXswARkUMdlzkreaEb8WvzZ7RJs
         7PBw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Vs6nS1ufoHJw085a9VGt4zWH+75SP7Rg2HAwhB30l/frd8VcTKVmq1BQocTltP1CRNmwk0jfpKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KAjlSrjOpJZMgWUcxA+pwn9J9yNYPY0JIhL9wO7gVJefdUkx
	ZLAsmxr86IM9soHG6hMnuHwl/OX1ACuBHhF6JaeHa6vLaXs8BUt0HNY4wHU9l8OtxEH9wjc4ntw
	Bk3rIc6+sGba7MmjO3JRhJkWzZiBXhdoBQRWaxP/ut1+HwBsF7YE9xaV+X9TlbLSxDz5RBgU=
X-Gm-Gg: AfdE7cn0eeu4ob6vDF7CxxI4CDs3shJKYjIQsXjWhk9FQ3SribGznhmK6akQR5E0nMs
	9jWUDitYHy2yf/pVEeozOxykcNRpH/crm3+PKwmvLDIuo7CppG+DjFbgdbLjBTKqHrExEXc90Fh
	5i+tTzIjNQdUeWPxnvTMpnKtoZQOe80YviagcekY28byfVwYHMyikExcJOJ6LIFGAnROYoUINqS
	3J+x6dqefnvndueMN3NdwRRpPPxfyXtEecXKEvxZMYLxNUcT+Q6Vj1ZLLKLitrvnhUkdP2gGooq
	6QQ7tBdPMXwyMbaCEB9ACq4X/48PSQBmMF6FwgHnj15P6EepWz09NjV77GfDn1vjSLB6EtOs2m1
	+se92xDRK50j1pXBpvF0U6VgJMVXtj3CUVIKAVtjJb4JA
X-Received: by 2002:a05:6a20:d708:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3c0bc9e3763mr12485217637.29.1783664923431;
        Thu, 09 Jul 2026 23:28:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:d708:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3c0bc9e3763mr12485191637.29.1783664922993;
        Thu, 09 Jul 2026 23:28:42 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm18237605eec.26.2026.07.09.23.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 23:28:42 -0700 (PDT)
Message-ID: <974e8000-79f7-4713-9fd1-3398269e0951@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:58:37 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] i2c: qcom-geni: use dedicated completions for
 abort and reset events
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com>
 <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-2-1db178c695bb@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-2-1db178c695bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tCDcPjb2iHco6JM3PMxgyeeNy9uKzUhZ
X-Proofpoint-ORIG-GUID: tCDcPjb2iHco6JM3PMxgyeeNy9uKzUhZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX3NgxqsOStxa8
 O8A7xX8HYP8L5VjG5d/P0slXeG1J2p/GnINDo1nM42Y9zIyGbBzNH112oZs9llamG7DFb+SVItZ
 FEkDXHgDKudYTjGpSdGmmKlPg3M/pSk=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50911c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=yZg5s6-rMQmTt4nTBlcA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX9MiAiEAhyFNn
 ZmO8JFNF4ehLZ+ihnGMwMEyUwMNbwU0TM02JVSul2KtZNXRCfdvwJOlz+JPjNvo8ag7F0guxdmH
 lPRhC4tJfPQK/tcgGJ1naHPKuFTfwCpAvr4wsJrIHi+ZTNNDZnD3NSlum5KZ5J72Ivpp2xdlXuw
 dRNvmMO5fSSTQYtDmeZwPzTDfS6sxv40L+45W1NKMLerBUB8F9XqcFELAP/npR5OAfdEXFupJbM
 AvyG87mezJMnsXMmzPFHcrb8BUzJjd2Us4ZFXA5EpBLFdekVMczTzHF6hSxWb4RU8dUR17zB/Or
 IjX6fttDkhowrnsfYswFxpChJIKXeexRqDc21qZn6RUvChyKkdSdU13G75GdrCHaJTqBH3lK3Z1
 zSPRGXk+SLCiIo2T5dnc7+UvKpoobjX+HhoJrI0No+uh80ouyqjZj9Q/JbzjQi8BVasiFonzBys
 /p94QOtRuy8StfYyrng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100060



On 7/9/2026 9:50 AM, Praveen Talari wrote:
> The driver uses a common completion event for transfer, abort and DMA
> reset operations.  This allows unrelated completion events to
> prematurely wake abort and reset waiters, leading to incorrect
> synchronization.
> 
> Introduce dedicated completions for abort, TX reset, and RX reset
> operations, and signal them only from their respective interrupt
> events.  This removes the dependency on shared completion state and
> eliminates the abort_done flag-based synchronization.
> 
> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 54 +++++++++++++++++++-------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
