Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110086;
	b=mCXo2f+3KO0E9nVn2UyUAgrTh42Vst80zNXhQvEtmUCSD9A0vVRH8veqsRaNtaflQKeE
	 dR9LXOji7fq52zeY3ZbEwP4IM5HNqXRyr8Rp1n3ccWkxKx2bWeOZqALly1M/PkwhxGbku
	 CGDVGuYcb6OVNPXU4voiVHQNI6GCa5wY59U5y8Ts3VFNPB1fULxk1wIvvvAYLtnv80s1z
	 vqneJq+b2iirJfBv1Wh2+JUwgILExfQGXSp5Hc9zzdFI/MeW5iiQced2a3LlkpxlsVsD/
	 NG5OQjukTBFPeeyHHqzzZ0TMBQixvfZea0bH6wFRC8IqP8DS4jgP+y6BAiEp4wuYuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110086;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=c1Z/CCgCrrgHYNEhc4GFXM6iDrjf45bsGeiV5sYFsHU=;
	b=lBkwV3ORvOU6VqlEDRfDKarenGfP8pgpp6i55cBothKuMTfNOQCyAtTs95rB69P8Gria
	 S/TqGDugo2TnERbUU6eaNw4mmie3tEvvwRiB6RF1M+6O28vlXZxwTt/CjrS+G5OZELqg+
	 tRHA1MOwQu9nUOxs3utVF5qgRBjQA7Y1xOMtbp+uQBLVWnamf+jt5v6Qq54CxdUCtBz8a
	 /dMHpCaFL9bmqUhvWhub2Dc5zSJeFv79G7BTiA7zvsvJsiCnP0gWKbpCcA8G3LgGQsVsu
	 VjlK/81w5PR4n7T+KlvVFYtG2y8uq2Cppkq7GL/HLtCtQKo0lmcMTa7+PtXh5LNf0+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJyGDv1k;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGdaW+61;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C780606A31A
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C780606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CJyGDv1k;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PGdaW+61
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDo0uc2344196
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1Z/CCgCrrgHYNEhc4GFXM6iDrjf45bsGeiV5sYFsHU=; b=CJyGDv1kfrczv5x+
	zzdeblWPnV2nNUKN7sdqN6M4N4qEmTYV7S/skWsonIPJw2mtEWnbh53MF/gQHttU
	tVJtu/ehaMmUHUTq+Y1C0VCMfVHt/pbflC27WTzfHK9C+sxvfTMIgthUvVSWkFas
	xvKYTVBOdG9uCNpiB+nrmaMdctJQ/oaVj6zupB8I+saDbwR+sgCwccv/M6WDq6DC
	8gF6HPzAuijyJ6ighWZntHCj3WWB0WMHYHLBx4yuA0eYEHyaQY0ObD8ApJuxeX8O
	OMHMF4KJZ6uuPrPTaczxzvKTKa1+ZVrygUkJjtzpNpGPoIeh0muNwt2w+opoDOGf
	7pHYLQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq698hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:08:05 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-869553205a7so66538917b3.1
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793110085; x=1793714885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c1Z/CCgCrrgHYNEhc4GFXM6iDrjf45bsGeiV5sYFsHU=;
        b=PGdaW+61CvtJ6Ew9w9m2fHhLsj4jOqZHtO/F8DVZgYIjIKo6EzOQPDyGM3MrDt8xLv
         KiwOy7+sRI7UEfYamEl4bn/ztsQulvj3b9jOQE6HdfyQNsZ9sBEQOgbGc2eJSW/Eog0p
         nrAa0tP1FXHiXP+zYngQd+Bph7iaeQ9otsoKkD5YmiHvZtqdWzxNcDkN6qNd9nf/z57D
         en4MTJiyb0FI+PCvbT3f0tC67e4KaOcRTqR8SYFCL2Bghr9JUkhvnu7ufZ9TftWhSdyQ
         XVlSqOjdkh6w5qwB4eCClpfeo+fdXDtEiXMQbQuS6R4LqvbxptGwuCnej5pI01iZKlqi
         P23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110085; x=1793714885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1Z/CCgCrrgHYNEhc4GFXM6iDrjf45bsGeiV5sYFsHU=;
        b=os/GI7+XozyJ+CNulOzOpZt78CRYfsW+OC2xg/Vx5y1kJS4SJAFOpkSuCuokE8LZX/
         V2QkXnqDVeMEemahBes4YWBE1KDmnhMptVG/AJahYy+0ub/RvHjYIcnMEx+nC7N+CwPX
         FAv8AZ6+peTanvsXEceLCAonh0ez/kwJyKBOsZafIjUU06urctuviFcDQwQyYtGQ/e6V
         M74b5VLGVOr2agzGSpZDabc8TqkfHs1MBMD1vM5ekmaUj3faZ7aM1J8Zv0oEFaSgYonx
         L8YCPh+1gHV3AwhxG7X8u3OM9Rya4n+2CvUZZDQrp5VUm94dcCfo9/23i8mGmrXVo7g8
         9BaA==
X-Forwarded-Encrypted: i=1; AKwUvBwJu7bHD3NIgpMvT65Q02dHVqBVx7ibKNM6UQCN5m43uf2iRYBdHfF7I0mDpSV2ddueGuE/+XUdRbE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5QE3KvQIGEQunOhQY4uDKmUEmBwH4QZguC7NrqXBT+KeqljBj
	rJb24D4Ki4GCG8VatnvC90DrsHGp4SpTnWK9W2nZYQpwvEV4tqPzSAXrK88IDaxySD6f50znWQ5
	XOl4TnHn8D/3b2wyomJYuqj6jTSw1VaZLaWtr7z5CU1aGTxrc2t0KAdfyOn06CcY=
X-Gm-Gg: AYBFou0gvx66kqpxLYmz9bP3y9PVEnLuHlz6+OdScz1yPDkgrZlWJdThZ+f4rdOCCOR
	QCMhuNZ+a9El3RdlWbrEb1cBYPjqmxEH9T5F1EJ5SoDLrXrgz3A7GCKW1jcBUMWZg4KEnVp76/W
	GqG+xUT1Xc1udr+Au12py1fIt6B6b5qG1NYVuwq6fEMBtH2HHPPF81MKDn7Op/Cahky9yKOIwl2
	mGq/klPZ8cjW+qcFkilTv5k1mhNQUejgLECCIDTpKO+rdmp2hmw0wGHX3Ab0rY/C8Wz9mAZH+JK
	fXNjrT7+Bx/vdgOJESF66KiBkowfZZNjhqbiMqmA+wFalD7M9v7lr2FtKcmIm84ale6w2BqWJea
	rjkncwNRrixyNlW6AOH+OBcdvf9oMeniNAw==
X-Received: by 2002:a53:ac8f:0:b0:679:a650:a09a with SMTP id 956f58d0204a3-67a45188986mr7162442d50.6.1793110084902;
        Tue, 27 Oct 2026 07:08:04 -0700 (PDT)
X-Received: by 2002:a53:ac8f:0:b0:679:a650:a09a with SMTP id 956f58d0204a3-67a45188986mr7162412d50.6.1793110084117;
        Tue, 27 Oct 2026 07:08:04 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a07e163sm127917d50.8.2026.10.27.07.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:08:03 -0700 (PDT)
Message-ID: <acac5cec-6fa2-4465-9f66-a5e533404978@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 19:37:57 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
 mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
 <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-2-7f2a6e572de9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-2-7f2a6e572de9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0b045 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=qTkQnuk-FKC89O0zAyYA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: HRlkz1s3n-y3sqgDG0knAVpVnexlA6Q0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX5mr84MMpubDb
 zyIpMIzOiJkohKitbLjw8gR8PWHX3ZqQGL4dTZCAUhBG7nlHjxpICwzqFHtzpUDG5x47qLdXwhk
 eVXbog+lfsVcrNtjdNtZMYtMlpCos28=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NiBTYWx0ZWRfX1mYSb0jCany5
 CikvQ+5wf9uOSbnWQ7o4/BweNmXKbKbT2IZp8380s0lqmbJ8Kje3YWHk25j0HjhD5tSPfZj8vR1
 Qwk/rPVR8olZ7MTush9z4pEH552eFBtfIWpspIORibquSymyh+FWxBxPwBhfoVlZWUajRCZB/Ex
 sGgh/6hpG/s3WVfKpbF0l6ixuZRlvhyMaz3/tkPzO9+ysMzXPphUjNodyF2B9SBYt27y9UBnR7T
 +1DrqInL71pAFop8owzE6HftDyDI2jAT9UUVQEKpUR776aRPEbe+2IqgDJYuQNPt9OHSe+dEtP7
 Mkf98XUfGM/1gpKTUIFWDrUhn/dBuSQ90dKzf04D8E9MJ46mIv6F9ab0sQDlxt/+apihonZ0SWm
 26b7dBsrFgY7ZZjPX0WOUltyjikjcLlVgVWO72z2RPRPjVCSNxqctspLflcOhfH8DB/mx6qAH8U
 2MG8IY0pTyZPGe1rkTA==
X-Proofpoint-ORIG-GUID: HRlkz1s3n-y3sqgDG0knAVpVnexlA6Q0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270056



On 10/27/2026 10:43 AM, Aniket Randive wrote:
[...]> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 127 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 60b6273f538c..d9e86f110ae9 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c

[...]> +static int geni_i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
> +	u32 ios;
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(gi2c->se.dev);
> +	if (ret < 0) {
> +		dev_err(gi2c->se.dev, "bus recovery failed, error turning SE resources:%d\n", ret);
> +		pm_runtime_put_noidle(gi2c->se.dev);
> +		return ret;
> +	}
> +
> +	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
> +	if (ret) {
> +		dev_err(gi2c->se.dev, "bus recovery failed, error setting clock rate: %d\n",
> +			ret);
> +		pm_runtime_put_autosuspend(gi2c->se.dev);
can use goto , jump there at exit with ret updated.
As 4 times i see pm_runtime_put_autosuspend().> +		return ret;
> +	}
> +
> +	if (geni_i2c_bus_is_free(gi2c)) {
> +		pm_runtime_put_autosuspend(gi2c->se.dev);
> +		return 0;
> +	}
> +
> +	/* Bus clear cannot recover a target holding SCL low. */
> +	ios = readl_relaxed(gi2c->se.base + SE_GENI_IOS);
> +	if (!(ios & IO2_DATA_IN)) {
> +		pm_runtime_put_autosuspend(gi2c->se.dev);
> +		return -EBUSY;
> +	}
> +
> +	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
> +	if (!ret)
> +		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
> +
> +	/*
> +	 * Recovery succeeds only once both bus lines are released. The bus
> +	 * state is the authority, while a clean opcode status with either
> +	 * line low is a failed recovery.
> +	 */
> +	if (geni_i2c_bus_is_free(gi2c))
> +		ret = 0;
> +	else if (!ret)
> +		ret = -EBUSY;
> +

Please simplify with ternary condition ?

> +	pm_runtime_put_autosuspend(gi2c->se.dev);
> +
> +	return ret;
> +}
> +[...]
