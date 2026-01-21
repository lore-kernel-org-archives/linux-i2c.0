Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E154418EB
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985983; cv=none; b=ICQAjOp3dVX1aRHXEkDyh081L69wHwS7LZzV1p7jUkaCP1RpcqIegtL5DeH8CaLGpuhhMnQeTNBGbkm/kegfrtHacDG/ra8g2IfH7F+B1AftUE1x1nAx1oa9YXb2zcnN34inynF0BVlxW+ZU2YsksljTnGsuXz1abELU0q00sXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985983; c=relaxed/simple;
	bh=VAHueLdIbT5ABQNTOeVMqxqykObxMf2Uxq4Gb27sYcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpgNIcQ9K3Uzn1dk80gOL/wneTVTQpPaYYzR4Ie1FXftfvPiaVoyg/AlDRvPPi4Vi3PUIqW0lttjQur2xWXmrQOkW/Y3Eqhq6mkW8Q1E3cURLZLe8WvowUNH7pLUpCQjiv8viPT1ZHj+nxGdt6EqN3s9H2LJkbgzTHB4LBHna1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkTHSKxl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWhgKGTC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkTHSKxl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWhgKGTC"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L6XNA32938563
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mTXNVWhTbjXAhkX2Ow60ufGWtnR7Uy72/xesvBbUNLc=; b=dkTHSKxlfr/rCvZm
	ixq0MDk663iD/io3sR/NHpqrJxMu9W1IVHFB4Ytt1Dv1z0EQDA10jpOl+3V0kCQE
	szMgHuDy6nnCxMSqGayNP3kDgVVqFK3rf6RCRRLrOLFojaBMMY3LvHfTaBY6wAdQ
	X8EKpvieDwglytsv371M/EScNQn94Fze+EEomzGptVLL/rRaBneZwzIbMODBGdRY
	GrItI4dApkNG11N5nW3v1JSxdu62Ho02yNfz2Mvji/6fqfNr5wIpKHZVr+7QTs8k
	e414alyPAANBPSMSxh7q7illTtfa2HLW2BCn2qj02isoXdF/FQhEx66TbnU+Bf4L
	SQXfSg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btsmu8g9r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 08:59:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a79164b686so12925055ad.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768985980; x=1769590780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTXNVWhTbjXAhkX2Ow60ufGWtnR7Uy72/xesvBbUNLc=;
        b=dWhgKGTCFcz6JMLh4YL1xlmTmwtWLkDc3SE3gRkoLRwA5yI0s0kJfORbC20M0z5ukP
         p3XUllDPFpkXVsu3jWyeoAKHpMnvPxsiD77GPi6tevDGOt8MlDFvWV+6YCJfPMKYgz+w
         gmER9ihOep8ZNxLZXFfUFn/suEY5C2YDbdELjjhWumGDfGMFlUE0HKaeH0XO1wYdtqY1
         u1fG6iZRihXXkc2MqXs5TL8h0KExBfI4MXk/i/oxDxJoPvR669luqPboQ9d9hcCQGmly
         J0TKZZjUi7Ye5xh36b1VqYMWABrl/z6wj+/OVuRXOg5PZuF7uMlgu1b9uxSaxON+QWQm
         OVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768985980; x=1769590780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTXNVWhTbjXAhkX2Ow60ufGWtnR7Uy72/xesvBbUNLc=;
        b=Cq0oh9/cwS4Yd6Kc95DxldB59HM5cu0gS/2DBim5+h8vbyrih3aeGgFy/6a+HzDK0w
         4AWpqYqpt3FziO+9QONLZCcNOUX0TYzs94CVQ7wejAE2c3TW0fAmwPhrMSDdPAiGvbix
         hQ+vaxmsC4JoXASVFS3Qw/TCIv4P0Q1lL1X6olagqYopwLKWARxqtsCPpqNdQqlApDTx
         PIZIK2ivsGM18mjkt3Lc6HjzuoGGTT/R7l8BR9SnnTUAba+Tv5oJLsTjygsyDp8dQGZp
         6t7T9/qJA6fwnaKk9uocy2FjEUea6fUbPjy97X+1rvyZSiqvlNM6MotV/x5I/niSg0jy
         jfMw==
X-Forwarded-Encrypted: i=1; AJvYcCVyvgNlDMpTBc5EUCelFwGtgABN10a1fPE6K9yRORaKbjxlLMlDlGYJwgVoM7oit+fYlZlY3NroxZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLqcH5ezTR+CmxEks28+eREsqap914IV2cCEq8U4FhyBARPU7
	UmsrjJhN7vpFdTnYkTHe/8CP24dJtnU2OkPkFZFFqqFx+vPBqHu/X/MNHHwh/zBPcYnqEnMPdhL
	XuCf89bFIOgrn2LT/WytsvSIqPguTyNS70sEF+eUuGzv0m/0Mq+eNHIzYpQ1h4hz2FHvQvxY=
X-Gm-Gg: AZuq6aI+F2KMOGg+KQnQYkO2zlv5dr7V0rdUcjd0dpnBvQp3aoQPliCZURQ1TGOsEKK
	UDGEqJULhSg8YF1+HBrQo9b2zitlwVtPDZAqMgHrgt8pSs/SJCmmL8PvUyjTPXoRLIxsAwn7ge4
	yXlA8mBw50ecRrqjQ7RIlF6OUMmCJ7iYpHUB1LGFgr+6Cr/+Ez32nUlCk5AelNu88GajReCuvoG
	+ingVt35/Vm6MmALxHRga01OllCr3QW+YfGcrK1fSyVxxtPzWDP8MJSSqXWgBgdZRVwaDComC6R
	7Ifsp9IvH/m47LRGLBVvWLgsqEm+XA0nl2xy+SXiEP3dlhfZTpWNcrScTFvIHFyOTfqKg/HCcHG
	cjhZxCUcECPQ4ZdDhPl7vV3j81QXdAGd7ri1fd8rnuQ==
X-Received: by 2002:a17:903:1d2:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a76b16a325mr42072845ad.50.1768985980291;
        Wed, 21 Jan 2026 00:59:40 -0800 (PST)
X-Received: by 2002:a17:903:1d2:b0:297:f8d9:aad7 with SMTP id d9443c01a7336-2a76b16a325mr42072595ad.50.1768985979778;
        Wed, 21 Jan 2026 00:59:39 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fbfa8sm147509515ad.76.2026.01.21.00.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 00:59:39 -0800 (PST)
Message-ID: <82db5424-8013-487d-90bb-82f133cbcbf2@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 14:29:33 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] i2c: qcom-geni: Store of_device_id data in
 driver private struct
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
 <20260112104722.591521-12-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-12-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OaiVzxTY c=1 sm=1 tr=0 ts=6970957d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wvo1P1tB0sfHhNg8w_sA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Z8Y_D09IWcdTQczLX0CrbJqB_p-rqq0S
X-Proofpoint-ORIG-GUID: Z8Y_D09IWcdTQczLX0CrbJqB_p-rqq0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3NCBTYWx0ZWRfX4lwC68mMcEdv
 eF3JZYBayVgWRtYCqHaGQUL3xw+Su9Dji0Z91COdrGHnsnrgidjsz69qFDpqpH9ku5fRk4mriZX
 PKkP/+eUONJlTObxPEzz/FiX/MCzwv/4MFgFV1e9NuntBSRjHKvpcOxkbB/nrhjio4UfqY8hO9B
 pXyDgR5WYDK+2RVqXOt6anSPKAmZ7qrTDXlM0HAyxksh/UhoyntKsaofLLa5ubdPHnQI3Uibypa
 ks32CDkzPlld4rGaggDvHD64by8OYNvpGFdCP14ULmguCfCYiumzFlIjWJSsub2ZqDnPfI4TZYw
 CZik9W0fVaEBSDGmAI6C5ktx9KLbGuJRNZixT4WdZEyWOePfGGiea+0ql4aQgFtRMhMLNbRA9ln
 sT6tUu2oRp+1LwJags/+J3285H0N4yv2dwrdeAnzNFLiG3XsCYQUSKOa8g41mH2YChJwnIee8x/
 Zb7jK/Dylk6IdSTnSSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210074

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

On 1/12/2026 4:17 PM, Praveen Talari wrote:
> To avoid repeatedly fetching and checking platform data across various
> functions, store the struct of_device_id data directly in the i2c
> private structure. This change enhances code maintainability and reduces
> redundancy.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 32 ++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index b0a18e3d57d9..1c9356e13b97 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -77,6 +77,13 @@ enum geni_i2c_err_code {
>  #define XFER_TIMEOUT		HZ
>  #define RST_TIMEOUT		HZ
>  
> +struct geni_i2c_desc {
> +	bool has_core_clk;
> +	char *icc_ddr;
> +	bool no_dma_support;
> +	unsigned int tx_fifo_depth;
> +};
> +
>  #define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
>  
>  /**
> @@ -121,13 +128,7 @@ struct geni_i2c_dev {
>  	bool is_tx_multi_desc_xfer;
>  	u32 num_msgs;
>  	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
> -};
> -
> -struct geni_i2c_desc {
> -	bool has_core_clk;
> -	char *icc_ddr;
> -	bool no_dma_support;
> -	unsigned int tx_fifo_depth;
> +	const struct geni_i2c_desc *dev_data;
>  };
>  
>  struct geni_i2c_err_log {
> @@ -978,7 +979,6 @@ static int setup_gpi_dma(struct geni_i2c_dev *gi2c)
>  
>  static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  {
> -	const struct geni_i2c_desc *desc = NULL;
>  	u32 proto, tx_depth;
>  	bool fifo_disable;
>  	int ret;
> @@ -1001,8 +1001,7 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  		goto err;
>  	}
>  
> -	desc = device_get_match_data(gi2c->se.dev);
> -	if (desc && desc->no_dma_support)
> +	if (gi2c->dev_data->no_dma_support)
>  		fifo_disable = false;
>  	else
>  		fifo_disable = readl_relaxed(gi2c->se.base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> @@ -1020,8 +1019,8 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>  
>  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> -		if (!tx_depth && desc)
> -			tx_depth = desc->tx_fifo_depth;
> +		if (!tx_depth && gi2c->dev_data->has_core_clk)
> +			tx_depth = gi2c->dev_data->tx_fifo_depth;
>  
>  		if (!tx_depth) {
>  			ret = dev_err_probe(gi2c->se.dev, -EINVAL,
> @@ -1064,7 +1063,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	struct geni_i2c_dev *gi2c;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> -	const struct geni_i2c_desc *desc = NULL;
>  
>  	gi2c = devm_kzalloc(dev, sizeof(*gi2c), GFP_KERNEL);
>  	if (!gi2c)
> @@ -1076,7 +1074,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR(gi2c->se.base))
>  		return PTR_ERR(gi2c->se.base);
>  
> -	desc = device_get_match_data(&pdev->dev);
> +	gi2c->dev_data = device_get_match_data(&pdev->dev);
>  
>  	ret = device_property_read_u32(dev, "clock-frequency",
>  				       &gi2c->clk_freq_out);
> @@ -1215,6 +1213,10 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
>  									NULL)
>  };
>  
> +static const struct geni_i2c_desc geni_i2c = {
> +	.icc_ddr = "qup-memory",
> +};
> +
>  static const struct geni_i2c_desc i2c_master_hub = {
>  	.has_core_clk = true,
>  	.icc_ddr = NULL,
> @@ -1223,7 +1225,7 @@ static const struct geni_i2c_desc i2c_master_hub = {
>  };
>  
>  static const struct of_device_id geni_i2c_dt_match[] = {
> -	{ .compatible = "qcom,geni-i2c" },
> +	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
>  	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
>  	{}
>  };
