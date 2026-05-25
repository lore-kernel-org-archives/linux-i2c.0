Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A78340283
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687090; cv=none; b=hw0UUPtG3DmAUUwanKUrx7I2ymoC9XMP0RIkRAcYm8bS0NKrqxglEwGhBoBIKPAnornSwbvMbYedtK7ZaZDD2FffNP2n/YYGg71aKlQ08lOv4bMaEeZl1v62D0KXrwImKrOStRJ6etGaGVOqq+6D4CH3UzOxaBFloUDi6SWeXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687090; c=relaxed/simple;
	bh=ng0GzwL+SXuNmFa5pHkWjm1uNpGAuR1QWsTTWpgOp4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrrzyvVSpo6/kL1WRGgDvkIZsk41w6h7PsVReK8ErZag6IT3ehNNVjXnnNGYlSct7SiwGGYyumpv4fZgZ27IUpRFXNgLlIVXaxS5uKRXOes1sMRev+pQvu9BeV6kikHPltIYQVCOGFbHwrchmJ2V+gn9hJEIYBIopp1wNTARKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mrnidYhy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q35npw43; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mrnidYhy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q35npw43"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ONI6R61851654
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 05:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=; b=mrnidYhyVHk/r4CW
	uWJV4XEZohM6XYWyYSPlnNKiztNL3kEpw8M26kONxWLi6sqLTzOyhCgre35GYzI3
	bpDu0cx8o+X6AMzvnkHjcvFOgF60zzUBk2uIs/ox/IBZH4pAZ07+ntm/vOLhIC2A
	nZ2eUc++wk7BwUynwix/TfV4iEywx8tc4zTdAK6UlmromSUjKDDEGJZJIJb3w8cs
	LokZZhp94443QaZcSsBPmFhTOg9Sm7o7NL2IMLMfnO5T5L1JzDFVclIhs1g0ZaET
	WVB3jdCPhnJya6s4DIq8JHGjN70+aQ5zMRJfbOU1V9WIjx2bf3BkGC9jvFHJBtXE
	irIm1w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asw2rf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 25 May 2026 05:31:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so2281153a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 24 May 2026 22:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779687087; x=1780291887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=;
        b=Q35npw43viprb4c1GQmELuB7UDQygQShyC0QgTGlVknDk2Xdtz4hjp4NiJvBTtoqeC
         YdoVVoGt2YGzEW0KMsSV1tOtecs+AhaOdDjJPr+Xj9BL/rKsLlCyOSuzYJYjOzgD/Q6K
         XRDvvyvORJyK9qMK/8Fl6lhr2ftEVNGlZoPFxmeE2JgVZgUpMkScYi2wKCIlvtQrk+kx
         /AB/OrbUjDXfcMrXuZpC7AvNG0xPZR+H3RnVHU8dHuzQT6YQxKrn825mXcw0XK0UMzhV
         A5r9GaeOHHLzkE9wSheHLdogYr9aF/5okcUUejKwYyS2yaCnykwo/VcHlmLO5m0rhS5u
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779687087; x=1780291887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nflQI87m0NpjbiVb4vx6MvwkK+5xuXrtzoNAWuqcxo4=;
        b=sQdkdZScu2R0cqytkkjGYpfInQCh0u8Vo2GqD/Mgzifjbnnyh26oKMNBhhq7Bp4vXW
         zHtd6BZgikP57Y/ZwOr6Pkpgg8fhle4pbco8L+gmmfCEIU3SV4/GqWqrIc981JHMeHev
         AOxCZtAzWwkaUQ1/ehYwJ2Ajg/CWUe10eS/gDIct7IE8iRWEjwJi4mhdcZyTG0L34y/s
         Ot0ikUCrQrR+Wpkegq7nMeJnqHMZjkmx7UsV9JTcdQDAQejKTeh7Y0aBd4dzKPAf0gld
         cQ6Qzncio3k2wg+jwxstNMIc7ddveAgSvfh6p8E0B+W3OYn69ruMlJW46P+s8+ctYuVY
         b0kw==
X-Gm-Message-State: AOJu0YyQAnAcr4bRWT7qZPwTqobpGdX++BdkBPMor2lDzA6bdx1oUfzi
	UQszdbQAPc8WWoNMsrf51hwgVCIuGMtmchCzktJ3d5ObeJigFGytsRp86lsJ523td8R3/oPHn5v
	zhYynQ2Oi9JBl1dM0esZh1OWadokXQzwSui1s4IGUoh6MOM29dfP0bOVCovQfGZo=
X-Gm-Gg: Acq92OEcKKSWDCEfpLjapS5ah7zNBbq7b9dKjrIhy7E9UYiMd3tBDYLkZe5tJMUeTJ2
	AO5p2neTYNB33YSyW2GT3z2+lCBpHyVsd3WvbJ49Xq94pIM59QazN6m7bmvV+ypIa3hSmZ4fPzJ
	c8Pf89zSMbR7PQzoe4SgbxSKi9xvT8AMO3Piuzkoktf81/mEmp/beAXPiWcCguuAfZ84/js4ttj
	LbLPvv1gxJnrnen9TToEyER/GI3OWOpxNimZJmkxEI0FfJlhEz92kgl5Zc4EjxItgrNPpyDM15S
	m/zFaqH5q8DAKA5KimltFC3M1XdzgZ+OMK43lJcBUnPySJj49fjL6tyPVK8VgAPuotI0Ummlwwl
	kSh8aKXKswwz5xhyDf1bAAGh6/RjC9r2UrybzYiWNJgjnpfo2hQE3+A==
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id d2e1a72fcca58-8415f17bdefmr12189652b3a.17.1779687087028;
        Sun, 24 May 2026 22:31:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a17:b0:838:127d:a168 with SMTP id d2e1a72fcca58-8415f17bdefmr12189626b3a.17.1779687086548;
        Sun, 24 May 2026 22:31:26 -0700 (PDT)
Received: from [10.92.183.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ad2ca6sm8175618b3a.5.2026.05.24.22.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 22:31:26 -0700 (PDT)
Message-ID: <16ae5bf1-6124-4644-9e54-4fe45aa1041c@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:01:20 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] i2c: imx-lpi2c: mark I2C adapter when hardware is
 powered down
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>, aisheng.dong@nxp.com,
        andi.shyti@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260525031450.3183421-1-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1MiBTYWx0ZWRfX/7ga3Q4HFT2S
 s0TyekqKQMOUacjK2Z/W+mEkkGEzZKOx8Gq0SxTr+WDVoGE6KEkkS+JasEUsnHhq93cIumQ9S1m
 NlZAV5Ra/Egr4ImpCMIWjazvz5I2RX7qX7uJM4BIcFvJE2dXOK7VHlJnnzeIcoaStEec6gJgbmj
 KnSowswvtysXTx4QQJP6TpBKCc/n6YYCUzwvxMMbPL0q7Pcf85F41JFhuklwnp8Ihm2swTtcoUf
 0vmxV6TQECfFpLYmwCk1OtSoFRBCwsfzkZjIyOTZatJ+DCgQtEiOuVO2DdKmRSDysmJr62Y4LYZ
 TZ9hoc9hfbBrDdRHgHMgLsfhUvX/C7xrz5ZGLJerPdli7/DpGoNIjcdzQft50/btMpsFCxn6YlS
 Lw1aK3yceqcx4vBtDVXNl8Loa9TnFXJbFbeFqP1HiyXYO8LjfN71u34HNM+ATtBRnSwngoh6VUI
 y45K8twZ2J360AjdRSA==
X-Proofpoint-ORIG-GUID: ahMSzKREEvcmjI79J4PbFwTNhtPeSWTn
X-Proofpoint-GUID: ahMSzKREEvcmjI79J4PbFwTNhtPeSWTn
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a13deb0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=elOLNqXY3ezWbv45m3UA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250052



On 5/25/2026 8:44 AM, Carlos Song (OSS) wrote:
> From: Carlos Song <carlos.song@nxp.com>
> 
> On some i.MX platforms, certain I2C client drivers keep a periodic
> workqueue which continues to trigger I2C transfers.
> 
> During system suspend/resume, there exists a time window between:
>    - suspend_noirq and the system entering suspend
>    - the system starting to resume and resume_noirq
> 
> In this window, the I2C controller resources such as clock and pinctrl
> may already be disabled or not yet restored.
> 
> If a workqueue triggers an I2C transfer in this period, the driver
> attempts to access I2C registers while the hardware resources are
> unavailable, which may lead to system hang.
> 
> Mark the I2C adapter as suspended during noirq suspend and block new
> transfers until resume, ensuring that I2C transfers are only issued
> when hardware resources are available.
> 
> Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
