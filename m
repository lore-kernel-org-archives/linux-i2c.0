Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE00424662
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683444; cv=none; b=eZGpzUqCscFMcQDD/TZt9oOLtfCzOyE0oVvMCSZJSsilnaX9CM2+iIkUgcXI/4N7tj7dd+zwUY1ig1rEi7n5FHzGPs2hk/vCeDRP0LZAzExtn0VgUFTtINwbjjEgSrJ0nzurwL1FsPNUd164XZX2sPTZrm1Chlwawqy2fxTLht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683444; c=relaxed/simple;
	bh=NKNAUXcwP6pv7fxKpjJQQinyKR34mhn8fdPE2GbAtZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6GVwSQN0icL4G5LZvVqZnq1kWt7pJcmYQc9i/etZWN02moOXX544QIJw/mUiSukz6ixDUff67Nr6nnQppxbxKaC6TOSIWQavfXCIbx+8LGrAs5zaAhOt13N+O+5SCAwbcn6cky7MAgHkDbG5oFdcdaZ35Apmjr7XY56OQy++VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKXnjau2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ET8MMHcw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKXnjau2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ET8MMHcw"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmnfC520643
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7xIbB/rIZz3qHMIAEcV7pGTL9ewpaG2D2x5j/gm5fM0=; b=OKXnjau2YedjSBp3
	UuX+xdunvyN7Qvws7U/u/5+TSIACGakQFqHDGUIu+e/xkHpRAZgJ80f7kb5tIEga
	15p6uek5i+x5hlkO/Xex5hRKuKJKLxxC6DmnnIJekJ43eQ3hYxn31wdoE2xeHFT9
	DVd2RNqbTKyGUy9ljCOJlHUEDzyfDg1W+7jJxp9Wqxp4StHXgBIqG3I6eM2YNeYe
	QLcbXqp0f2B/+SgjnQ3unxIN6GBsgHmi+otE2jeQKFRm/B1c2PSa/wsqKywtNWQb
	K9Trs5Q9ujaHRn4SibhTBJUsPfohwOWkuYeGWFPkBH7uMNh8CFdyxjegdLIJVIzp
	Wm7nzQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjceun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 11:37:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8482b95574dso907991b3a.1
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783683425; x=1784288225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xIbB/rIZz3qHMIAEcV7pGTL9ewpaG2D2x5j/gm5fM0=;
        b=ET8MMHcw1jnv6R2GMT4yJJTU+phSMl4bx28Y/rl1b75tQibV6t5AotT9K4Gf2wlW/G
         30NuSKpBkP0H8NjGbTgt2lJP1wncCjwfdL8Sn1SvQEePDzrUG0JU8C6qDjqEV4AWBtpN
         AUjEr/7Rleg/6L9R0mpwrD/sWvJCpy3KhX0stWTL3n0hdPUCaGRSzMsbUdiNGrs3g+vs
         O8IXoJiqta4P6UfFg1kg+AudCPkaWGZz0HIPuZ4uf68T2NZEko/GCsN2PkSb9wV4+CZd
         J5wM5ZoCOjdusz+PwIXWJbkOrVM9qaxHb5SKoWHJGNus0pfmLHiy4WdPQ4QwgLM7bKXl
         hrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683425; x=1784288225;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xIbB/rIZz3qHMIAEcV7pGTL9ewpaG2D2x5j/gm5fM0=;
        b=BFF7AFT2vE3303HGXtzWRaU00e9fHGGGIsM7henCqEJei40/MvTj0lWHQXnhAGffYo
         KM7YM607k4Dm/Ki+T7ZQI/TXZHUorwNxaDSRex1zTji+uVtTRF+g5prd1hpVnwmOMqeT
         YcKgET4vNUnkbxV3wTeE8Hd6OPZgnc4eQuYTnEE73XT+iFRrHNmONei8FdtVXOSAgfJp
         gjz8pvdk/Q2lCYI5TZaQwcCoCTyF8uHb64aAB+ZkqOcXyLl8qUGPMBjWtORICughhM/r
         uM0Fx5UtnBH3M5ZCJCxmLx2q3C4PvGhLogQmNXFDwwyR3VCdge43ibJ1EsjLKxIOgJKY
         xzfw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8bBppr8vVSLJEN4WV0+TRgDd7BhL3VpJoaFovIHi6RmhnK3MkyapHA1tiHz92uwVBUCfC/XpRAbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT3H3Y+icSJn4P59jIuKNU0PMpbXTDkLq8XXJ7B7e2NJE7TzX1
	+fWEStTlG/tE7dY4FY2GDcgNKLi9F7qK8mPx3TMlcZfvQgNmYRMDZpU+aBHmjgyp7bxWP4k/iTu
	/+KqwQYcIXhPcBTXB+JrP6PPdEMOdCobMi1JXpdoHE96KfEUZ8lzjO6FCSwm/feU=
X-Gm-Gg: AfdE7clTEIMRRhS7jvQIjCs15uo+JeVlpNNiw/Pd70/P0ka3t+dOnh022sAwNACweco
	D8i/JJdp/Ph4/fCAIMeiKnaNhAkbRn9EGuWFpcXuBr8uyGRqnNKDSA5tvhPi5hlP36bFaA+22VB
	1L+J8nv8KptevMjPs01NMz1DjyiE6TSswCd1m/DgDAWHmdjlTNwb6avgkU+yxSVJSF/mck5fQNx
	SG+gzlL4D9ysqc+qbPNL+AF9rWoh/o+JH4WsyIo6zBem9dfjRv1PY18VxmJZI4aKkHzCUVyZCh2
	vx6C2IL8LjAt6p/veYSWc4U0WfQr27Ba2gPlhLpsbFj+xGTbP/z6OWMUcnsTV3FSoe6wAukxjpP
	pqgwpgTbJeLjXR5rYIN1g0fpR1b/6eqyV/6QDSxE11NQ5
X-Received: by 2002:a05:6a00:1708:b0:848:79af:8b2a with SMTP id d2e1a72fcca58-84879af8f62mr1764496b3a.27.1783683425162;
        Fri, 10 Jul 2026 04:37:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:1708:b0:848:79af:8b2a with SMTP id d2e1a72fcca58-84879af8f62mr1764474b3a.27.1783683424646;
        Fri, 10 Jul 2026 04:37:04 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a4abf1sm302906b3a.16.2026.07.10.04.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:37:04 -0700 (PDT)
Message-ID: <1ff522f6-88cb-428a-91c2-5f7f9fc9929d@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 17:06:55 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] i2c: qcom-geni: distinguish address-phase and
 data-phase NACK
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com>
 <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-3-1db178c695bb@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-3-1db178c695bb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExNCBTYWx0ZWRfX7s/1JcR2QBIi
 CAMvCnaombpRoimOMaWzbskllU4XeCnpWdEfsJaqdDOJzhVE8n4vwT9DOzYTd4dpPp0Y6qrCb2Q
 XG+A1cEAwEvi9edqSwBvMayNCFj4/Z9SdyZDzP1jGohD/vmE1+Ff9dJrLu502jpN5c6faN2amAC
 Di3JhRr3TAFuoC81DBmqrHIGLjvc2eW0PdAwpwaYdfuOPSInXrXSbgllJgONBGQ/q+v0UgRF21t
 H3qWoKIRkMx4rVQORtyCYWy3XLwogqhg5nWD1Bp7fZVgHHdcSYYz80dDW/Hh1t9qREiKU67WnqL
 OX9rFirtI5GJrBLFfI6n5vF0l86AORJXzgICp3KSgtamMHHKEpjriDhalJtpt6NLfcbciUOVHHm
 UJp6A5HnOTTj0p6jOmgmyxmV1+9xD1KAAA14GT0rpVlM0reZsuP57NvC7hU9ODxZj6ToxJ6MNnx
 nXSi6nTQ73M3Uwr/XHw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50d962 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QTIInl-oKmcOnA4cS_cA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: QUO3lxU8iP5adEgDuXun0Z1jGNih90Qq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExNCBTYWx0ZWRfX4tYYk2yNSTtn
 UTAJGeJDXe1lqTRtdBmAGmQr6ILUO9rScQECBYNqvqqT5HwhUPa9iF+RKQAZzCmj2h8/CaF/W7b
 ay40DOFaq1kkCOcZPcoBFqONQWVLFUM=
X-Proofpoint-ORIG-GUID: QUO3lxU8iP5adEgDuXun0Z1jGNih90Qq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100114



On 7/9/2026 9:50 AM, Praveen Talari wrote:
> The M_GP_IRQ_1 interrupt signals a NACK condition, but does not
> distinguish whether it occurred during the address phase or the data
> phase.  The driver always attempted cancel and DMA FSM reset on any
> NACK, which is incorrect for an address NACK since the DMA engine was
> never armed and the hardware requires no recovery.
> 
> Add geni_i2c_check_addr_data_nack() to distinguish the two cases by
> reading SE_GENI_M_GP_LENGTH after the NACK event.  A zero value means
> the address phase was NACKed (ADDR_NACK) and no DMA recovery is needed.
> A non-zero value on a write transfer means a data byte was NACKed
> (DATA_NACK) and the normal cancel and DMA FSM reset path must run.
> 
> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)

[...]

>   #define I2C_AUTO_SUSPEND_DELAY	250
> @@ -143,7 +144,8 @@ struct geni_i2c_err_log {
>   
>   static const struct geni_i2c_err_log gi2c_log[] = {
>   	[GP_IRQ0] = {-EIO, "Unknown I2C err GP_IRQ0"},
> -	[NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},
> +	[ADDR_NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},
Now slv could be target device, follow latest convention.
> +	[DATA_NACK] = {-EIO, "Data NACK: device NACK before end of TX"},
Minor: Instead of before end of TX, could be simply TX transfer NACK ?
>   	[GP_IRQ2] = {-EIO, "Unknown I2C err GP IRQ2"},
>   	[BUS_PROTO] = {-EPROTO, "Bus proto err, noisy/unexpected start/stop"},
>   	[ARB_LOST] = {-EAGAIN, "Bus arbitration lost, clock line undriveable"},
> @@ -258,7 +260,8 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
>   

[...]
