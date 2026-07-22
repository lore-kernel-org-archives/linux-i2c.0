Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E92E7373
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697922; cv=none; b=lkom/iJQO2ISQqHyFSoBm+Ur8na6mInXSqTEtO4elNqdYdKOaPhDhvgzUfrry8JCjvHSP/f1fGKODvhqXlw5lDE2HEg2oThzkPjYQBEUztsGEJg+bgesmq8smdYitDxZp99UJkd3W1oiU3uNeLC3l+5Nod+WegicBmC07g4B0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697922; c=relaxed/simple;
	bh=5ayDULpMk8hHG7OhaFCanS8CQrSX6NM2+R8ihs6w1e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKAo6O9Z7vLnLiZqPkdJGBStNgNTeEG9qbw0QkcZA2LPr13ScrY5CNIc7qDMjDhWnOZxtHxSEOhBweG5XyAP01NHol5wn4TEneZnqd7K+8HX84hDTqe2h0Hw501vIdtR5kujj3vY4beCaCC2k8OhuQB0UbfdHYURRiYiI0CRMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IGTSlxlx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MBOuwfFf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IGTSlxlx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MBOuwfFf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53fIY4027269
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0CPv89+vhijrrUJHLgTqDg2ulQOVqGpYMe53CZkhxZ8=; b=IGTSlxlxJG5YYkS/
	cceHnDqFUJmzi3Rgbf8UMEgfPJ+d0P54tjrN+2+U36pTQai7RgSckc7i3y2uhwUH
	RTJ77J4QyjBKAhOe+geo3EPoNgYTwCXvRma/vCUWiUitrYaA35HuRWRezXng2vF0
	LTmbJ+kU2QY4OeB4w+TzMvSddiIrS4cbxL8CQSb8UGWISukZchcxMyW29CrWQXyo
	PWh2iSnEpind9LIW1wCLEddATtK86HxAE6jyJmdVxbycA2FdPoVs0UJPBPThrXxi
	z+Th83MVArIgCvWTJhh+xe/Id59j1zoWI80jMAZTJR5llailY1LICx94ntyb3Obr
	90MHqQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbmfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 05:25:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8485d853b08so15827912b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 22:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784697920; x=1785302720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CPv89+vhijrrUJHLgTqDg2ulQOVqGpYMe53CZkhxZ8=;
        b=MBOuwfFfgg8ULNLJEFCvM2savY9LYJv4dgF/LVu8OVrrEgVay/8Qt+MSXHCma1tNDY
         HdPFy/DPTQc2KspdjHV6eL5AQ4z3Z3OQBiiOKXL/HGzvAgRa02WSMadbSo6JrRsH2MlI
         2D+FcW5Un9zET6oq5lnTtbLE6jliKIAMVnQkcXGqbDDT8araTgYnM+0pHlCwhwuUDLG3
         siNizQxtnTXM+ewUwd7S8z1NwUnSyvDWVyOOKL+U2jouFEI4WabFGveQyvtFoNtra5aC
         TiMtyYBYMj37TIlRiE6Ryp9qvAaGjpXwDY9i3ac2pHde/hwaB7zHhbLv4ngEu8mDRfFt
         pStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784697920; x=1785302720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0CPv89+vhijrrUJHLgTqDg2ulQOVqGpYMe53CZkhxZ8=;
        b=sHRyDOBCaDPdHLg6eKBrCWa/lRwJwNJvlSzZbfew7szB9hDiEppYE5CA17hzGIvwB4
         UfiKzXUXIrjT5lPN9BBPoq8Y5aN05aPtPYXfz1Cc2+BBTb8GWsiPgeURJoLMJJfbzazQ
         51p7ysTDIMI30PRKZNLKPiyRFNY4H5AKI4nBhI5IAO8gK8V4JyLRl44D8qwbgnW1XOpe
         hsPp5Uk8RkCC/UCMmdCP57Ry3izU1znlUEzMvo/9yFl83Hc8EtKBNyHZN6aD2vvl/EWd
         hC/DDSjG1cQHPlNfY52y+PWbW8pyS+xiiAK285R3JZ9ZG9Hn3xZpObtRoEJr4s8CpcpP
         RGGQ==
X-Gm-Message-State: AOJu0YzLfhSLaddikkYL4ZxSRGENNPRFohjESPhJtuLKpJz9NLytXc/S
	18a5FD8vHmgvnmkkKRQIuPhqjeoupIQKG/CIyI5GioVW/3BXYroLxEEeSTf0ePh8xKrVO94Wugy
	Qj7YVQn2Ik9gCyDNfffVFGwxMUrHuqu7QTqxVRlECKQKmpPaJZwgClztT/GQG2nY=
X-Gm-Gg: AR+sD12iDmwoZqWDgrnCFcRMXdjdqdP/S7Ncm2IXJuWlw8TVEDFccNYLt7nkDl4Rdgm
	S7yheUUS5kb+QWOxA08EkB7yxj+J4ZxHsJ+N3T9H2MscG+Bt50TN+hGmh190NskhdM3+4udd2Sk
	o+mBVywLFMBsrR/L3cYbPoIzziel6wQ73/K0rLuYOMkpQUcNf6nC4sDmNq21JRriNt94PKG92q4
	+0bMtMnHi1ohViAIkKdwqZZwu9aO/n69GNKYzePeHyFQcVCgzi09WgA54TzghECuDNR8DSuDoUi
	rur+pOqitoea27F5Rk/4kL95jWzEklwFTJq6Ylx3g3NpYLM9APYSIDZjacaJPY95gCoqJBDzNXz
	ox+uLDv6jLsndgnD+7GwuvTDP1YnN9h4ZzBI=
X-Received: by 2002:a05:6a00:438d:b0:848:68d7:c673 with SMTP id d2e1a72fcca58-84c2948848fmr21272971b3a.47.1784697919637;
        Tue, 21 Jul 2026 22:25:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:438d:b0:848:68d7:c673 with SMTP id d2e1a72fcca58-84c2948848fmr21272952b3a.47.1784697919169;
        Tue, 21 Jul 2026 22:25:19 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e172376ebsm736724b3a.12.2026.07.21.22.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 22:25:18 -0700 (PDT)
Message-ID: <e1e38c71-5f79-406e-821c-ce37904102ba@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 10:55:14 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] i2c: Add dynamic transfer timeout based on message
 length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Hxnjd3tUMUYDkhcxuxiwHZmrs1GsdVt-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfX0HdAz8sst/nF
 A89VAqI+9SZmJVA9vNfk8gU4pdOqo0cUj3JM6DxU9gXCSePkhYAWGhnAcUmWvtax7adcUnFWyN2
 RN3T3J200eHcOnOxh8WTuLeFouzzJDO5bZFjMuZEknvQ2/4fh071xsf6ASAuh1e7e3rHP4Z40A9
 +rgXdfh5orxOhuF9qvDw/aYYZI0UrOOYGsxVAm6bjrvgFh0EoajYSRS5v4spaFttjwxIqIzzCrc
 Gk0TOlsrapWr/IezSzLQpTGBMkVqgDK/4EK1QRFdrjtJkYTAzCaQHI8UZY5joSqSd/6qD43/V/J
 25fLaQMlWVyPd9N7Aj0FUSTDTT6J21vCtcETGRNyYMTOh1P8aqLHcHDNa5x/wbDXQ2F9+EWQ0eW
 GJzvEBL3ccE/kSbUuQ6UaYf43JdJYjOOm7CKKCxFDjVhv/xOIsHuXlafJ57Ffawy8TY6a2bmkK7
 M4n+nhI3yzTyXwTGddQ==
X-Proofpoint-GUID: Hxnjd3tUMUYDkhcxuxiwHZmrs1GsdVt-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA0NyBTYWx0ZWRfX7ZtqO1xCEIbO
 /bWg5wOl29PLM3sexTtlt8ooY17+dcsUa9XR8fA+VB08V/NWZmc/W5SE6tcDbzU5BrM2ap7s9mh
 tCimcFpqObgChKnrf5kbYxmjnnljE+E=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a605440 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_aoH3E5U2PYf42VYXqgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220047



On 7/20/2026 5:11 PM, Aniket Randive wrote:
> The I2C core and most controller drivers use a static 1-second timeout
> for all transfers regardless of message length or bus frequency.  This
> causes unnecessarily long delays on error paths for short transfers, and
> may be tight for very long transfers at low bus frequencies.
> 
OR can be more than 1 sec for big transfer at low frequency. Hence 
better to make it generic saying depends on data length and frequency 
which you have mentioned. So limit it that.
> This series introduces a generic helper in i2c-core that computes a
generic helper function
> transfer-specific timeout and stores it in the standard adap->timeout
> field, making the dynamic value visible to the core retry loop in
> __i2c_transfer() as well as to the driver's own wait sites.
> 
> The helper accepts a safety coefficient and a minimum floor as parameters
what's the policy to accept ? i think should explain here.
read from dtsi or hard coded ?
> so each driver retains control over its own timing policy without those
> values becoming public API.
> 
> The second patch converts the Qualcomm GENI I2C controller to use this
> helper.  The 10x safety margin over the theoretical wire time and the
> 300ms minimum floor (to budget for clock stretching) remain private to
> the qcom-geni driver.
geni i2c driver
> 
> Changes in v6:
> - Split into two patches: core helper + driver consumer
> - Moved timeout calculation to i2c-core as i2c_update_timeout(), which
>    writes directly into adap->timeout so all consumers of that field
>    (including the __i2c_transfer() retry loop) benefit automatically
please Add suggested-by: dmitry guzman < >
Also add reviewer into to/cc list specifically.
> - Driver supplies safety coefficient and minimum floor as parameters,
>    keeping I2C_TIMEOUT_SAFETY_COEFFICIENT and I2C_TIMEOUT_MIN_USEC
>    internal to i2c-qcom-geni.c
> - Compute timeout once per batch in geni_i2c_xfer() using max message
>    length, all internal wait sites read adap->timeout directly
> 
> Link: https://lore.kernel.org/r/20260715101805.3615166-1-aniket.randive@oss.qualcomm.com
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---

[...]
> 

