Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330B4534A4
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118263; cv=none; b=OLV+26t5GsXNQ7FPbWsg7Xarbnc+yUhG6SA+B0RpPQXZOyEmGIqvNqdvAuBuG6VdQqOKkjdKEnEHoGQQcmB3XH2Ub/RmfmMFU2HIRTRPxmH9RAD9j61LzcIgWD12ZIuozVl0rD+hZi8DsKvqI6JcBBbiB0Pi8tvXjNuG8p1MzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118263; c=relaxed/simple;
	bh=OiLW0cnorrZrBTCCbegC1HCSXh64/IHwTXjkwHMRpLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9XSoXGs8laZJdXzGfzGr0ChxX9md3PdyxQ433hYoFjoxQPwAm0jpD1i2vOEvOHSwVodfb0LqCwSMY1iYUBD8cIWzUsKmJTrbAKxsG0YQhY3aGGUPqDUnIbQKQI8Iux2v4ubV+qVRGpHk8IIvQUwCDm52jQPd10hCY1YQGNZKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0WOR4hY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtUN93Rt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p0WOR4hY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtUN93Rt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBcdNe3479982
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=; b=p0WOR4hYHW07HL2k
	OV+sr65xB0Q3FJ8TzTpGqbWYF3U5KjEKy4RPuE/muoVvDosiK4LDWr3oAYe0UdnO
	xB9OSs/hmQneWnIVxJE62bH/lDvjuufoJoXlPJD2XeBgkT4dEkLcrzLrFOmNxX0D
	xzijU/5Ihrw7JXDkUfPD3395jWEguz47346Vf0MGrzoLJOVWQ5hJrlwyWPnw5kWk
	S6qZ0++ZJo6TagxmkbckIubPqNs68ZLfTxze4D57WZddVNKb676339esjExKCYZM
	Mhrb8dBX0P66kEmeYRri1S2p1xA7slESSpOqAMDSoVe5BtaSGk7S1womcJGI+zyh
	zEO/Dg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h9a1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 12:24:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-903694fd3bfso12793536d6.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784118260; x=1784723060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=;
        b=HtUN93RtdEMX6Im1M70TvXS2eNSeINDQJ8NzrMnCsIKpFzW7X9heCPBnh+uBMSxErW
         2+cCTUUO9A0q8sBZdIIXXEsA4Ro7f8b2ENiQ5I2SgY4z+rzMJDcWUE6vR5g6uDST40nC
         qJ1lTdTqqxhidDOGzFMqRN/paTkihY/6yOlxURomh17mLHqSc7gvcRIH86OAgW3Scxc3
         GdgWGRvhJze9vWPuBGVCh9lp62YpOcnIGNlm1gy5b0pvXuKwkFfftZ8CpKYPixkunJsl
         12z3/wwIz5Tpcn7jflTkhdHKiwwZr3uQxk/2JD6hiWhy/YA8JAeUYPs2gnZ7HES2MPgB
         L7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118260; x=1784723060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=;
        b=kxnpPMGqkb8FVYTPKVIH2XTkWqgn4rhQerJBgb8Y0muxRWgCCQiWtw1Hw3oAueulia
         g+w5BF7plcRogL2ki90WaxhgIRL5R6/PVfJ2ZUc4Jj0LSjgmIDOQDVrWN2FgqnsNoW2u
         apP7D+xVQnPlTp0+0U4+uT/dXBVmd8UQpkvxxiAxcBStDqz8kjtWBf+2lU5tSHhLkPd1
         o7YukQ3SmR0IbSxQhSvZtjxt+INXWzgK/Y+mlDYkswADxOALltpojz9eZqDuwWUO44Hv
         lJfYKGkXSrfxvxMHlRne033py4O62//JE0JPOs1TDqJNHtG/E0oxIx+8o/t1O6Stzgov
         Mkbw==
X-Forwarded-Encrypted: i=1; AHgh+RqcJb5w9kjD08MjgnvWiYeWnSmVBHpQlnLUFR/Ul8gKEQ0k/V3Sc7X7dmoSzIn9SagaolJQaUjuQPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qI32rQ4C4IU7QBnVxGD5qADG23UZHncIfb94dbukgWKaMqwM
	GxViiD5jgUf5EtOG9IASYs6FQRDFdHlBkM9ZNg8q/XUBl/hE60ralAJ/E+ztQy42/mXwKml/dzD
	+Wk8LBHen/TTNzl6AWzrzUk5EQM8C/uCGugyJ2Sb0LkFVEOSwd41dfh7bSupTE00=
X-Gm-Gg: AfdE7cm3jy4y3Mt3XIzrG0eodGiIGMrs6KGKE5PfYTuncJ5NEk/jQqPJJ7qKfbVW5UH
	Luu4OKD52eg2V4MkznFtEATy1ud1G0TBUa3lOKudRWNezoOMUilHP1bMgSpmnDuRNktspR8B61G
	XmJhKKxuPeMjtY3K9h1GausrPfOn1G4zXxYF55w0aWCJCQBYet8Wu+M6XwdZX9j3AJ5ohAEtD1A
	MmtU5CIMdTctPXxU1x0X88oTROG4x/5VWv/a28xrmolz+AsARiZaykXKGz6Erg3k/sR96S53iH+
	H3jwm2zP+uD2NJW+ktL5WdE5gC4m1LQC/UtxKt4pCBRPmMWpAnNEMv+zUv2I5U4jhCDJsYdDEid
	8c52lo4eCyjSDOnIn33nUInfcB0cpCFHs7gk=
X-Received: by 2002:a05:6214:459f:b0:8e7:d237:4aa9 with SMTP id 6a1803df08f44-90403d516e3mr172365886d6.7.1784118259762;
        Wed, 15 Jul 2026 05:24:19 -0700 (PDT)
X-Received: by 2002:a05:6214:459f:b0:8e7:d237:4aa9 with SMTP id 6a1803df08f44-90403d516e3mr172365626d6.7.1784118259369;
        Wed, 15 Jul 2026 05:24:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd287882asm2931930a12.3.2026.07.15.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:24:17 -0700 (PDT)
Message-ID: <ee424097-6f29-4605-bd0c-242190a7b376@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 14:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyMyBTYWx0ZWRfXzq8oFOec+Mae
 PXRfETZ11bvNd4WLnJS/bCyu+o4GvEBY1d8fnF9ZLI/BZKS48xVKVXpjiHPIIYX60Yx9LZliPJN
 YCIYBm70GjM5VXRcdKNKZKU9MhelzXY=
X-Proofpoint-ORIG-GUID: wrDRXrT-ZwhW83N_GwP3Su3BP7C9iucs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyMyBTYWx0ZWRfXzjhjwvlla7l6
 BvYO3FMrZyD1MQyLAfCCeunAzLAscljHPJJjyjDzZygf8E4J+trH7XRSKjGnleJzt1RJviU1idq
 6g5p0p6gTpimutWebnPhvAr3qcu2GrGVA1h5lzJ4bO+qecQGBDvAZmPsGGkcInTadQVNzWD1PsU
 7vgIBbkyby07k+OtUNoV42dSBamX4ExmwznqeMOK7cIeZBommJ7GbyjhW1qQqIvMpqv0lI65azy
 OLDtvse2lbnUgqsPDetATTGM0vUa0KrzR86TbAHZ1OKUAAoK8XWpDaf/BABDIv2/m4lAhJIpZcc
 kI10chjiZe8MTV+bGB8qViNZ8gtI/74OJZNfyBAcDcmnZaeusL0aPDHakqOO6xyk2sqmrFtibLJ
 +cRjrnm/XIY6g5i6mf8SWlVSqhgE8LXYv+/aRzvOtTprDaZjZ0Go9zw1rcjqlmsgOVXd+Dknn7v
 S1uZh21R/rMbjYmLPug==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a577bf5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Y68E4KffrGY8xuMxYjUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: wrDRXrT-ZwhW83N_GwP3Su3BP7C9iucs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150123

On 7/8/26 7:10 AM, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor. In this setup the
> operating system must not assume exclusive ownership of the controller or
> its associated pins.
> 
> Add support for enabling multi-owner operation when DeviceTree specifies
> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
> shared so the common GENI resource handling avoids selecting the "sleep"
> pinctrl state, which could disrupt transfers initiated by the other
> processor.
> 
> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
> driver by setting a single lock_action selector per message, emitting lock
> before the first message and unlock after the last message (handling the
> single-message case as well). This serializes access to the shared
> controller without requiring message-position flags to be passed into the
> DMA engine layer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

[...]


> +		if (gi2c->se.multi_owner)
> +			return dev_err_probe(gi2c->se.dev, -EINVAL,
> +					     "I2C sharing not supported in non GSI mode\n");

ultra nit: "non-GSI"

> +
>  		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>  
>  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> @@ -1098,6 +1115,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>  	}
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {

Let's use device_property_present() instead.

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
