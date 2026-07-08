Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB253E44E6
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496167; cv=none; b=rms3uKgq3PLOfLaqYDrVKl/puid6kc6vviGyGCCzhWcooHdeOhca5/LAy7rAGjRBnMWn4bKrCbfrbi18Jn1rU9JqOM/FOw27VI3Ymu0VVdZWpXILFS8VwEe/+gfQ5O29GJ1xKpfXTLhimNqYnk1cIEJLtZ3Mg9av2WdzSTLz4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496167; c=relaxed/simple;
	bh=y0Cz+SxrOco+zFU9iy4Vm0qFLXihJyME9v+cI8jh0hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlWSHn/qILdvYis/aZAlNE7xDTB1S3BrQeMQePXMgtcC4Rf47TfyHwfkWDR+GPFpRsUdlA2OwYMqY/yjgOvWrKB0wuHSp+fnVx6q6x8pXJqbVDGIjwt/2S8d4flv3/RDFYo49yOe7C7t2E01jnKTZ9YCaP4hAuqhW6c07cWDyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kRY6/ELA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hAL58MNT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kRY6/ELA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hAL58MNT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6686qY012026446
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 07:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qwiky552pR9eMSaRRVwfUr/gVpyg1XLXJ6fZAH0mOHM=; b=kRY6/ELA1dLyHeYa
	UrdOVrMPpKwcl7qbnrpjad0f0ZYnlS6l2lR3VL9G6c9pd5g8RF2yrTTUdX4551v6
	bT9rXGBas6vB8mFnjO07ROegRrOrVxhYalFZPEq2BbSCHMgIvvIuRRO8NBLPTAEH
	TODzreIcCXJupZo+DdOMpXy2+MKgUUpK8kcWevQN6CpXuZ6ZQxxHzg85x9BynmKz
	4SlAyQAHZUdldheC4StgJbjPcaICZdRXhOH/2eGo4rHYFxOrdTXyt2Nie+JgwCL6
	Rml++x1khp5CAKWL9XzUH4sezLrIupvn3KNqX+y/UuRRabk21pCjBaaGtVK5QYsn
	JufrPA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv05qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 07:35:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8483e038efeso577115b3a.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783496146; x=1784100946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qwiky552pR9eMSaRRVwfUr/gVpyg1XLXJ6fZAH0mOHM=;
        b=hAL58MNT8vJSb+kwgmDmh/QrJNPbYxr0sKSQQlB7ZS6GpUOl7ERQxCoWQVwTepNor7
         0+epfpS/VJoiCoTpS2VhVlNoAcGrwvciciN/oHpm7oV/loSLhVNBIjuz9XjfbgSA3lW3
         VgvaeQD/ZJmVUG4SW+DER59KIPZa3u4XWNPXzchSc4BjrvnTKoyGx7eTPthap4shC0Np
         Vx5oEthqJw/ePPjnaiP4xAdsVsk48KspUC5mVTpXuQ7nyeI2U5RfnfnPGaaZgfrUeGHD
         SRcWr5ceENB2o8Kt4/CeDulkMahc10zAECTT2FMex4Kw7BJyIoj6gltbRVT4i8sJjxsE
         TGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496146; x=1784100946;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qwiky552pR9eMSaRRVwfUr/gVpyg1XLXJ6fZAH0mOHM=;
        b=mAt1Q4u3wy59B04EmblQdPma2/62APHYq//kTdm1bgo91+v3eIs34TaT+yMWlbQfco
         bziixzHiMP9SXxnQdA5Aze4xR3ZWQ5W7B6Lf+pvfVysM2jFz4p2gJ3QSAnuKDJCDnQ5F
         99JuUYX3bAnJU5PFSdIV5DWyUDzZiOb1ndc5ejqFZLvMeBpHpPPju3seqwTvlTPKTA1n
         yRNlYyOeYyHmHD25aA7XpUfsM5MtJldAW6m3d0C4VdFul0zBi/l7zjNQTpX3JVfdig5k
         SNzISmFDDX4zXmrO1D3bEWzJMo7EUNVfvGMtbuNck76ICK7AqgqT6+yFMieiy+SYUNJk
         wEvw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2GAwKIyrXeKNWp137QCrxpSpoccNR/G4SdUwHJgwMZ15NM2Cxrq46REOBn23OQykcN3lkpGYhlJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFq/DDpUUCt5BjXSleOo04GRPRIgdGlp7U2AMGO69BjqxEzVn
	lOIK+M/pPElLKUma3Kyov/3xBi2bg/WroigIVUAJ1De3TJOFq/ICwDuhNO8zuEdyYZAXP0jRk+r
	3D3MAPr77zd+tcxhy/byOP22Ngd7Gh4NYQQXD1a6VQFV+61uu+4KU/auWd7V9P7NZZe/vNds=
X-Gm-Gg: AfdE7ck0JfL+P8cvY4kCefdw0uFw6ESjSzjDgerE7hHEvfO/OVMq7B8nbjlK927Yo3M
	RbeYeVCbhS2yzrgr2Zq4QImRhWTVMmOaDbLHAWVebqbXETxmqqXyNS6oItbTOLREV57UJ4HJpVX
	y6lwGCe0k05WGhui+3gDeDgCumWx0OIPtjwjp+j0pGOCjL/htZ0JEDUWRU4qc96ZB/OhHgcFm8j
	ZNlFqwXLd2w/N8ec5UlZ+2rDm5km0Yc7GNfcLomgTynOhn5xCZUwZ/Nx/N1BTg4/5vabqz5OCtY
	QLdGZCX9KmSvZ1ko/t+h5UwfG2L+wORrK8GMu3McFHNPt41OFqg/kLTd5rbWEo7VwhoNu0XaAA4
	T3GktlPmh0JM4jMLG7VdrzFQqpLx/vdO1wen4X/MEWVUA
X-Received: by 2002:a05:6a00:4405:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-84842fe8cf0mr1626491b3a.3.1783496145880;
        Wed, 08 Jul 2026 00:35:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:4405:b0:847:7f7a:dd18 with SMTP id d2e1a72fcca58-84842fe8cf0mr1626467b3a.3.1783496145378;
        Wed, 08 Jul 2026 00:35:45 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6bcf03bsm6588179b3a.26.2026.07.08.00.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 00:35:44 -0700 (PDT)
Message-ID: <6167cdea-50d0-4319-9f4d-1f1b349600df@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 13:05:41 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] i2c: qcom-geni: use dedicated completions for abort
 and reset events
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
 <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-2-dd8f841f36a2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-2-dd8f841f36a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4dfdd2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=f0852AcSgLQ1KUP9AosA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfXwBdyN66TADqU
 dqU+CtW5yCM2TpcQkD7iwSvvGwikedM1GY3+iOWpfNZ7UF8R1sTRA+NKdSYrLFzsLhuTT93rRtm
 EuisvTkBDdo/ObHiXIB9jW8AD6GfNMs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA3MSBTYWx0ZWRfX0ms3wrgl9kXJ
 hmPoxXDBar4QTZrqxr33e1ONsuoknudWZNqcBbZz0mprZO9B/lwnhmMPR8aNvt1ogyH9fadpzK2
 hWM3qhCQZBABF3TvV3Ri997SyPuyS++rpLVFsPMBZFKvpEdVt+efjbyipO/Y/OYpOEZx6DjuJX7
 AHMApvLlTl/xSCpxchLPIVqwMhvCRKpthuev5vcS2KAeEPknZG368ovDSmyh3ArxHAkNGvIRhTA
 zWmDL2sbyibifD2ONr0LF2vKDomxv/B1qzH4N4IsU8EhA6V909/KbcJlFUwOACfR9LRu2EPMctx
 Ry5fv1anRIWdHS23pEMestyhGKrIcs8x20wha3TsPDkh9D+NM+KI3vO4C63DmC11EXQw84gSrxS
 NwrttZP10NyV0uoEGMGZv2IinNVGdw0Vjp5qLIUP4Zrp0wSdOBP9z6nzsngAzGIKOVxMl283rPR
 nATFRhQ8KJuU02KSqTQ==
X-Proofpoint-ORIG-GUID: TEXpVAz24BkkOWb2NeOMuUsSS9E00yGE
X-Proofpoint-GUID: TEXpVAz24BkkOWb2NeOMuUsSS9E00yGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080071



On 7/8/2026 11:45 AM, Praveen Talari wrote:
> The driver uses the shared gi2c->done completion for transfer, abort,
shared => common completion event for transfer, abort and DMA reset
> and DMA reset operations. This allows unrelated completion events to
> prematurely wake abort and reset waiters, leading to incorrect
> synchronization.
Aren't they in sequence i.e. one after another ?
> 
> Introduce dedicated completions for abort, TX reset, and RX reset
> operations, and signal them only from their respective interrupt
> events. This removes the dependency on shared completion state and
> eliminates the abort_done flag-based synchronization.
> 
> Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 54 +++++++++++++++++++-------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 15403edb355a..9490aee4928c 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -113,7 +113,10 @@ struct geni_i2c_dev {
>   	int err;
>   	struct i2c_adapter adap;
>   	struct completion done;
> +	struct completion abort_done;
>   	struct completion cancel_done;
> +	struct completion tx_reset_done;
> +	struct completion rx_reset_done;
tx or rx, any one would be running. Not both right ?
if so, i suggest to keep common dma_reset_done.
>   	struct i2c_msg *cur;
>   	int cur_wr;
>   	int cur_rd;
> @@ -127,7 +130,6 @@ struct geni_i2c_dev {
[..]

