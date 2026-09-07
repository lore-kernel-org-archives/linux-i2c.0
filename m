Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AE94028E2
	for <linux-i2c@vger.kernel.org>; Mon,  7 Sep 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765842; cv=none; b=YjX3Mb7Ddl0ChjdV63H5bKssEuLiRwQtQt7QqZUb6KqsqRKC8dlaxKnZ1h8An2aJMOnaP84rdkmW7+1cicp1B8glCvm0mj7Pb7DyJIt1pSk8pHX2qZyVNyDvWj4O52F6YJez7h0CURbef0Mlj17WJjm1hNTmI/wOhcKnXhM/Jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765842; c=relaxed/simple;
	bh=KxMqKpP4pT773qfgW11vDRiBR41pjOdpqBHigF4X5oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZa594g9zK4EatIPobNvI+HItf0BecJN81jECiwIOWMMxEfGoj3CUZetjzGyx1SOibRrGnGJa336CA1qhiK4IaK05YRmdwJVAtSx15DGdL/+lvbUvI3VwCSEsWhfo2HeW9T5iUoyF0PnRHxrZpfN4t+quSBr7fWm7fnSMz3vMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EkCZwzII; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LvuWTSSa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EkCZwzII";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvuWTSSa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777Onx3363569
	for <linux-i2c@vger.kernel.org>; Mon, 7 Sep 2026 07:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VMX/yV6LzUMzO3mW4OB10xo2hXImRBI/wgtKMD2Jbk=; b=EkCZwzIIA5UgcDks
	V9fU8GiRgieVDTZaVUJeMU++AKNDCzUuBz0Gj1ii1/hCgAQQ61MrZwZ/CzyiCRcg
	5c03+INUELu7Qs1lfiVhZefYouaFVlJoFGCkaD8PBoWUHI0zP/z/DjvBJrWenUbM
	UA1ut2aeTHp1c2yefrK6osO40nz17wBwe9qsGDuqtel/ByE3VRUxQQc2jE52ahZy
	bAdG79TUTsqDSu88f5yO6PDcmNn31RJ/FPOjghbKcySZWPkvVYGzvbeAf2IVCscN
	U1vjUOZoz/lwHZxO2F4i5UxPN6mR8ooqTj0H2Ug5J/izlP9533eC2U65lo5Aq2/O
	LdAdOw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj0qvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 07:23:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc73f47bdcso40008935ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788765774; x=1789370574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VMX/yV6LzUMzO3mW4OB10xo2hXImRBI/wgtKMD2Jbk=;
        b=LvuWTSSangnkCnjs7RV/KNmZ5gKD9HfNRcYlzlvwUyHrHAqZ4J0SuYWQWwqQFegwJV
         VnBmdySuwl0Sp19v/Ea0VhpF5cPLUZbFdVXqF3ibPM58js7R2TuAMqTkrUnjxpAsirFl
         XOItU5FUeep5csZSikRaISrbYacYsf9YKaxtcoEMQUWLSLOLUEYrmpCdP3bE1UO0KN7B
         9zUN2hX+lT8kV5T5wat1/LEV+NmhHKs+3/zoPIJuSWjgxfx1P7lP7iSzgFgBHnReokt/
         pkV5xhu/jK2skCo9imeahnqAn2Fiql+xzNKczrbfC31cIw4IzQ/Uvn/aAr2H/tFPUSHM
         1dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765774; x=1789370574;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3VMX/yV6LzUMzO3mW4OB10xo2hXImRBI/wgtKMD2Jbk=;
        b=FOLmv1DJyeXlCL27t2Pe+5SguOHfdApaqzP4uiwChC5q0QQ6zxFzgjj39Cmv/QE0RH
         DwXMHhxf5I6OPHgr1Hak3NaTsh1UYbmBYp6INUQ9aNs7DvAwnV0btakv9hIcBcGqgrGy
         mXkr3vQbQZxbPQFIO5p4HiuqtfWrhYdL1KyL5Ylx2TGLpwny4fioMF3W7g25/ncW6s70
         rC3nOeutsnwF4RrBZvFuohp575BctQC34AG4MB6r58ZkYFtU2lLnt45kmxT1HaAxs99z
         t+8s44VHh9GFmjBY5PblP7PdbICEe5zIJlltEnX7Jb5igx4tNQ+IwJyNSRMv89J5Ym3V
         8UUg==
X-Forwarded-Encrypted: i=1; AKwUvBw2jR6CRNxPU8CxNR8QLSC5sGXUPWfiEb+CyGBb8HO8A2YPkwmGqiWw7EcPpbx/W9EJ28L9MiS2PZk=@vger.kernel.org
X-Gm-Message-State: AFuF++m9WZEZt2p138mMY6w8tzqOpMRMgCikAdffo5lQc9JyDzNbgpFB
	zcGIiDAp0bpeBChIbCI1+tbbylWZ4HjtWwcP+c5GttijiwOIy5I51hQFrB/O9psyDyxBep8Lz9m
	Cd/PcUSv1BaasnozLtrhBc3S/nt4CfpTU8gDFfox6MK44YbP3RUbkhzT/bS0743I=
X-Gm-Gg: AYBFou3v3qyrs89YNRwv2LU/FnURmBI6delq+Em1Z0+KXkNbmjYyRRKFEZBzSdK16T3
	D/DW+jwzwkBhn2Ivd4cS6J+CJ6TQvbKkuVme1vETgoUpeFphuzz9ibJPD93FDvg1+j9GOwXekUM
	XC8GoBxf3YAuxHQivxPFjlnUbTdKyMRIdvC9J6HHZAqGMx1G9bLKOoEBDrvDxPnoBg2+QfQdKyB
	LSSTjNs+YttpBem5BzTSdTTXxTwJbZTxR0onimBu2PdnSpTbQR7wQlnBeapV7CTnh1B6H5z6jK0
	vvxox1WsN2z+lyS1is32OGyIJyVIa9LxwCV/fR04LIiRefVFg2zyV4J+oASLQ+0GZpRT1x3Eqkz
	lptPEghczc6OmflwCxaDItuzWVgJvyTk5ew==
X-Received: by 2002:a17:903:1b0b:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2db12620112mr364269595ad.15.1788765774209;
        Mon, 07 Sep 2026 00:22:54 -0700 (PDT)
X-Received: by 2002:a17:903:1b0b:b0:2d9:3083:a3ac with SMTP id d9443c01a7336-2db12620112mr364268745ad.15.1788765773598;
        Mon, 07 Sep 2026 00:22:53 -0700 (PDT)
Received: from [10.217.219.15] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3385c056e13sm1775705eec.29.2026.09.07.00.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 00:22:53 -0700 (PDT)
Message-ID: <69e25f54-80a9-4f17-8453-c74b2e346585@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 12:52:48 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260827-master-v8-0-596bc81c5cf9@oss.qualcomm.com>
 <20260827-master-v8-1-596bc81c5cf9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-master-v8-1-596bc81c5cf9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA3OCBTYWx0ZWRfX1cSpT3uoeLRK
 VTqchVLLTVb+XCGiOc23tB3KSru3ATk9N9szNXdGFbxfhchoX8Cu1njfJn6L2+2oo8P4MjbV8n+
 D2vgkTUBdaP9qdSPuq7N3SFxHOpXP2RQHFnR9Kgxp1a5RB5tpWIbzGB9ljic1J6sLVKaGJG2BJY
 WUj2ZR1cSk7Dl8ziQqBwAksDTnikRXQumOmrlivOx6qI4nSvgOsxfDCwMKXgk3yoNQbSp3MvN/x
 1iUvGd7y+78+tr9gT+7cKV92+AF7q4rZn+7TruEAj2YqGYpIFt71LPrW8jXauAnJ04qJmmR+863
 dLvYDB3ZonPKAva2YgwJArgTiyJoCOXpmtj7VkuLR8HD9aSE9AsyDaspBoZ+XF3MqY5fTd2VIUN
 hmaGtbRCg3kfIgSqOdjRnwbIeCS/PQ9m59QD+W0Qlce/frTr+M/0H+bOGfdfnPxugBbhIJjxUra
 ghcTwjDWhIlsQQzR56Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA3OCBTYWx0ZWRfX5TaF8ePbUYEo
 //WJGyE7wJov7om7YWMv8UiZP/S62mgL1HNTdExj1gJHrUoeW9Fye44bWNCvbPVY3t0LqjJa/vF
 YHUDXjoam7+hFxmncHAd6IttHVijZok=
X-Proofpoint-ORIG-GUID: G2iS6cJiXUF6iRKS6DoMBir2yaUG0Byc
X-Proofpoint-GUID: G2iS6cJiXUF6iRKS6DoMBir2yaUG0Byc
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e668d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=HGiDy2AwKuRvI8HKZgoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070078



On 8/27/2026 5:57 PM, Aniket Randive wrote:
> The transfer timeout for an I2C controller should reflect the actual
> message length and bus frequency rather than a static 1-second value.
> A static timeout causes unnecessary delays on error paths for short
> messages, and may be insufficient for very long transfers.
> 
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
> The function is gated by CONFIG_I2C_DYNAMIC_TIMEOUT.  When the config is
> disabled, i2c_update_timeout() compiles to a no-op inline stub so drivers
> that call it build cleanly and the existing static 1-second default is
> preserved unchanged.
> 
> A timeout explicitly configured by userspace via the I2C_TIMEOUT ioctl is
> stored in a new adap->user_timeout field and always takes precedence over
> the kernel-computed value.  When userspace has not configured a timeout,
> the computed value is used.  The ioctl keeps writing adap->timeout as well,
> so adapters that never call i2c_update_timeout() continue to honour it
> exactly as before.
> 
> As i2c_update_timeout() is an exported helper, guard against a zero bus
> frequency from a misbehaving caller with WARN_ON_ONCE() and return early,
> leaving the existing timeout untouched as a safe fallback rather than
> dividing by zero.
> 
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
