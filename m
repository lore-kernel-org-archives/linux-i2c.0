Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA03EFD00
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981653; cv=none; b=KJYz1v+AKosDhdaQvpd+hJomGJql/1W0bpNy9dQiZviglDg+ySl9FWpQl5lXieAblCrTx3UFpyQe/UYncUNbQirdR+Vd4ILIssUwViKV/noizsUE7t5eJ5oKF8PG8Q+8yoU2dr15YWdcWfVspRTRI9NEnMbniGgFbOCXoIUuA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981653; c=relaxed/simple;
	bh=OsLO1copfDI7UNXhjs/8qoFniZASEhHK4kjvMKyUMCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIRZuvGMZiwBsr06tSLGH33ACzFUus5Ctpe9NAZn1uXs9zCYxcd4VmkQMTCbiCtgOKkYg5HSeLuXVA1qW2FilfDup7JERR5HrsWHrWRg3ymkte1Ebwphlt+1JtdPsvbmUYsHQ7KDlg/zyJd7ar+HmqcznjP3n+etxxXGQhFQYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D80a4ULT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtUtURxE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D80a4ULT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtUtURxE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L5g8JO803735
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 07:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dI6CvH/K4XzoB9yWVh3TUf4YLFRgJueU93szPqG5mj8=; b=D80a4ULTQyD3gadB
	WRRw+iTkowqWvuORR9hXNYy2tYZPG1LiPasmeVfFBrKBqLT7V5gpLarOx8XxtxF0
	SEM4mS7SAC71ebvtNzyGls0Ss4E2wEhn1Xx/kM2fdtt8ErTkmR2lj+2fFvCp/zox
	3KTWim0BNjAsqsmgiFgA8VCz94lbjtElh4K24jKMKczjQ8b0MTKCvUQfIV8Kguo9
	yAiaQcUw8Njs2U5F1L52z86cNgjxGHu0D5xc4bZ1AiuznOcU0mrSUU1Bk6gryk9Y
	bimScwAH5ynHOfGJsVV35/yZymlOba3YO2U5tkzd58ur5FhmpPbtMYhaL2SFGvRt
	cBYhRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q3jca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 07:47:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a77040ede0so13381295ad.2
        for <linux-i2c@vger.kernel.org>; Tue, 20 Jan 2026 23:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768981649; x=1769586449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI6CvH/K4XzoB9yWVh3TUf4YLFRgJueU93szPqG5mj8=;
        b=RtUtURxEXonLNUMyFbD9foOs5p8EJf4iadzM/i3sBQYuLFhV8dXusNti/28QRNfvuV
         opwMj5eHkLwFscNaOyI+nGR9Br246ntN7A15kSm8nTtJwh3fdirM0+nsSQT+JyQLLO6D
         xfrSOKmihk9Pi49icvdjUkYUQLXJQK5zE/ptlYj+341fLolmXHjWs48LbK9wAQ8So6jK
         uo2C2IFU0c23j/zx45hsPXU9eZe69oGbLbytn52VpBe72NC+sxZEhpE2vAZ8iz6rfLDK
         a4wp36uOTPQGhneFVeYMWKzI36MRE2wrjOEevHYgn3Bs704iVwXGKalMxal1nQu+pm4A
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768981649; x=1769586449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dI6CvH/K4XzoB9yWVh3TUf4YLFRgJueU93szPqG5mj8=;
        b=nNcfXB73NImzSDTDUrWOBgW8QT00ZPnqIA7wmDwMQECKVEXkE+H19qkCgBA/y8Vdhc
         cgdUjZpJYB1nXp7XE4/478JfE0LjEzY/zU1OwMNIjfViga62ZH64pUbGC/TRrJlR1IyO
         A/b4vUK2a0MsrDZOzp7KYUNMz7nijwR6TqbEfMukNzjJtQbp4CkkFKl5fTo55yTRX0Gt
         dJ7ScBcoEYPnOlUvSzS4WkttxWnIHWnXf9IHMF3R6KaHjrB+qH86YIQwisXNUQiwu8mP
         4qbPzR74CnrY01FWY2CbdhGbLedGCv6tf3n9fS0YeSd6wzZiCaCPt5XUS+AYugaFG6Cm
         tOfg==
X-Forwarded-Encrypted: i=1; AJvYcCVhGVlA7lHvx3+YcUpsX4VEQi4curPTp4vD1ezlsmlZBmLfYvu2naiE4+7ewZOEbjZ2M4vME0bKAvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybH0nO9X4pxdICUIkrcfnoDHp26/73zEnP/4PZkC25j0MNV8l4
	TAPykmUg+WrdiIWnlcQ2yCHDgizgxCmQx+H/L3xFHh30yD8XPLW/OQiktwK/Mi1C8YDMZzH+TeA
	x2Y7TQ72z1IIAiEgsrKB7qJRtf6kWERVp+gNxVMTJuoYDm1uoP9ARqDiuJaPn1A8=
X-Gm-Gg: AZuq6aJWnxPIrGl4pCeUsFzszn81qaDQ6l5+clrVLs5D4xjPJMkIR98M32y6QaIXYAT
	g2xSwDQjNdXeE5yS/b8YllIc4Jl7w2zsE/QSz2WWcomnNHHc6P+joCnExlbA4fHzV7Yrwz6bHq4
	sNuUeuHkC47J4JP3a9g68UZhixJ+jnFEKBOu6Yie0Xuv6zjpaRgiMOp192jFxVvdmg8vipQ9KkJ
	xDasbI7T0/mYYI7/uxLIa36NfZouGFTolpMR9a9zvsVjnyRQX7olGMnlaSf4M/QFfE39hoptlTv
	FCpdsVVGkrbVALjLZcoIrqOLwCarrZIsTYvusWVjz8slTnS3hvyV3wIhC6QnjThwLopqKFsAg1o
	R23EfK2TPfpZBw6xj1+IErjBGHFGEBNzzxKcbpxeAnQ==
X-Received: by 2002:a17:902:ea02:b0:2a2:f0cb:dfa2 with SMTP id d9443c01a7336-2a7698f854bmr42099825ad.13.1768981648931;
        Tue, 20 Jan 2026 23:47:28 -0800 (PST)
X-Received: by 2002:a17:902:ea02:b0:2a2:f0cb:dfa2 with SMTP id d9443c01a7336-2a7698f854bmr42099645ad.13.1768981648421;
        Tue, 20 Jan 2026 23:47:28 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd533sm71941465ad.66.2026.01.20.23.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 23:47:27 -0800 (PST)
Message-ID: <93eec05a-588a-468d-885e-5432c8c26d0a@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 13:17:20 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] i2c: qcom-geni: Isolate serial engine setup
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-9-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-9-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=69708492 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=u-HHVrLI-TFpGRdm_AoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA2NCBTYWx0ZWRfXzysMQ8vxVrNI
 mT56ZxO7OO/M/z9OIy1aEqeiCdIujRkNCvEWnz1xTwCt16PYzF+EhjqJRgzVI2kByuUpmEF9pAu
 5QXPnkIdxMiSXSdQL1pxaQqfVGHF+Y6YjUhfh/nrrGdZPSCOVfdC6FeRNulQE16iDMkQLw/qB4v
 kDgThSoF8MvvlW/aj7MdRNNN2FFPs5suuxWBdftKJs0u+FisbHSy5qHt/wJRP18xl1YyCyI4Q5M
 QmWhUyt8QfB5mBUqf0wSGkKKskUbYA7sjIk7GzIoAN+KW9ZvKmg+fHQ8UdqOOnV5xT26ARiCNwC
 Ul6GnlFxTCig9dujGU/5UQSQ4yWVczNHpl067gmmw/OBez3QTDoK6Jz4n6MX3XX/2RY/DyOXZb1
 m/mDlbIdFvSiwu1ia3yjW7U+bcJPdFfTjrBOIaIDLzp9qzxuFhLVfz1lTXP2gXEIwyYBM0kMrgH
 JzfirQhcUMwoTML5raQ==
X-Proofpoint-GUID: wRGEP9FIHSjzr7F3IDwpaD6Ay5NOzn6Y
X-Proofpoint-ORIG-GUID: wRGEP9FIHSjzr7F3IDwpaD6Ay5NOzn6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210064

Minor comment.

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

On 1/12/2026 4:17 PM, Praveen Talari wrote:
> Moving the serial engine setup to geni_i2c_init() API for a cleaner
> probe function and utilizes the PM runtime API to control resources
> instead of direct clock-related APIs for better resource management.
> 
> Enables reusability of the serial engine initialization like
> hibernation and deep sleep features where hardware context is lost.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> Bjorn:
> - Updated commit text.
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 154 ++++++++++++++---------------
>  1 file changed, 73 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 3a04016db2c3..58c32ffbd150 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -976,10 +976,75 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
>  	return ret;
>  }
>  
> +static int geni_i2c_init(struct geni_i2c_dev *gi2c)
> +{
> +	const struct geni_i2c_desc *desc = NULL;
> +	u32 proto, tx_depth;
> +	bool fifo_disable;
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(gi2c->se.dev);
> +	if (ret < 0) {
> +		dev_err(gi2c->se.dev, "error turning on device :%d\n", ret);
> +		return ret;
> +	}
> +
> +	proto = geni_se_read_proto(&gi2c->se);
> +	if (proto == GENI_SE_INVALID_PROTO) {
> +		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
> +		if (ret) {
> +			dev_err_probe(gi2c->se.dev, ret, "i2c firmware load failed ret: %d\n", ret);
> +			goto err;
> +		}
> +	} else if (proto != GENI_SE_I2C) {
> +		ret = dev_err_probe(gi2c->se.dev, -ENXIO, "Invalid proto %d\n", proto);
> +		goto err;
> +	}
> +
> +	desc = device_get_match_data(gi2c->se.dev);
> +	if (desc && desc->no_dma_support)
> +		fifo_disable = false;
> +	else
> +		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> +
> +	if (fifo_disable) {
> +		/* FIFO is disabled, so we can only use GPI DMA */
> +		gi2c->gpi_mode = true;
> +		ret = setup_gpi_dma(gi2c);
> +		if (ret)
> +			goto err;
> +
> +		dev_dbg(gi2c->se.dev, "Using GPI DMA mode for I2C\n");
> +	} else {
> +		gi2c->gpi_mode = false;
> +		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
> +
> +		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> +		if (!tx_depth && desc)
> +			tx_depth = desc->tx_fifo_depth;
> +
> +		if (!tx_depth) {
> +			ret = dev_err_probe(gi2c->se.dev, -EINVAL,
> +					    "Invalid TX FIFO depth\n");
> +			goto err;
> +		}
> +
> +		gi2c->tx_wm = tx_depth - 1;
> +		geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
> +		geni_se_config_packing(&gi2c->se, BITS_PER_BYTE,
> +				       PACKING_BYTES_PW, true, true, true);
> +
> +		dev_dbg(gi2c->se.dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
> +	}
> +
> +err:
> +	pm_runtime_put(gi2c->se.dev);
> +	return ret;
> +}
> +
>  static int geni_i2c_probe(struct platform_device *pdev)
>  {
>  	struct geni_i2c_dev *gi2c;
> -	u32 proto, tx_depth, fifo_disable;
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	const struct geni_i2c_desc *desc = NULL;
> @@ -1059,100 +1124,27 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = clk_prepare_enable(gi2c->core_clk);
> -	if (ret)
> -		return ret;
> -
> -	ret = geni_se_resources_on(&gi2c->se);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "Error turning on resources\n");
> -		goto err_clk;
> -	}
> -	proto = geni_se_read_proto(&gi2c->se);
> -	if (proto == GENI_SE_INVALID_PROTO) {
> -		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
> -		if (ret) {
> -			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
> -			goto err_resources;
> -		}
> -	} else if (proto != GENI_SE_I2C) {
> -		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
> -		goto err_resources;
> -	}
> -
> -	if (desc && desc->no_dma_support)
> -		fifo_disable = false;
> -	else
> -		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> -
> -	if (fifo_disable) {
> -		/* FIFO is disabled, so we can only use GPI DMA */
> -		gi2c->gpi_mode = true;
> -		ret = setup_gpi_dma(gi2c);
> -		if (ret)
> -			goto err_resources;
> -
> -		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
> -	} else {
> -		gi2c->gpi_mode = false;
> -		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
> -
> -		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> -		if (!tx_depth && desc)
> -			tx_depth = desc->tx_fifo_depth;
> -
> -		if (!tx_depth) {
> -			ret = dev_err_probe(dev, -EINVAL,
> -					    "Invalid TX FIFO depth\n");
> -			goto err_resources;
> -		}
> -
> -		gi2c->tx_wm = tx_depth - 1;
> -		geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
> -		geni_se_config_packing(&gi2c->se, BITS_PER_BYTE,
> -				       PACKING_BYTES_PW, true, true, true);
> -
> -		dev_dbg(dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
> -	}
> -
> -	clk_disable_unprepare(gi2c->core_clk);
> -	ret = geni_se_resources_off(&gi2c->se);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "Error turning off resources\n");
> -		goto err_dma;
> -	}
> -
> -	ret = geni_icc_disable(&gi2c->se);
> -	if (ret)
> -		goto err_dma;
> -
>  	gi2c->suspended = 1;
>  	pm_runtime_set_suspended(gi2c->se.dev);
>  	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
>  	pm_runtime_use_autosuspend(gi2c->se.dev);
>  	pm_runtime_enable(gi2c->se.dev);
>  
> +	ret =  geni_i2c_init(gi2c);

Double space.

> +	if (ret < 0) {
> +		pm_runtime_disable(gi2c->se.dev);
> +		return ret;
> +	}
> +
>  	ret = i2c_add_adapter(&gi2c->adap);
>  	if (ret) {
>  		dev_err_probe(dev, ret, "Error adding i2c adapter\n");
>  		pm_runtime_disable(gi2c->se.dev);
> -		goto err_dma;
> +		return ret;
>  	}
>  
>  	dev_dbg(dev, "Geni-I2C adaptor successfully added\n");
>  
> -	return ret;
> -
> -err_resources:
> -	geni_se_resources_off(&gi2c->se);
> -err_clk:
> -	clk_disable_unprepare(gi2c->core_clk);
> -
> -	return ret;
> -
> -err_dma:
> -	release_gpi_dma(gi2c);
> -
>  	return ret;
>  }
>  
