Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D2481ABE
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990889; cv=none; b=SHsi9KlaIEwxAwlYpY+VxbRL55ZbQQ3itjKkivVWsOihy3voxO4niy7MSPEm1EYKkVA7n/Ovfd54FWH03qgYXvtPmnS07LaCc1e+sbIEBLWufZItPcxtr2IIHp16VH89smzoURpBMuIKllYXX0PMK0M95uvtx4pRRavwZ6tTbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990889; c=relaxed/simple;
	bh=uYxNW2Lns6okZ2c2uf4mlp7Tz+RdKXIkytf+9fjxIaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtrgUE9F1sHizlwKEcMkOLEu7MUjWMscVAsXPzmFPyLBNkB+RCoCyUwjqtt9vSqXuwO/axe+YdNL7bT3YyGg75XNaC3tN4LkxsnUbQCF/Ka3RH7ymzvc/BsKe7rjA3Ud6uGBQUsz1yOJlxY273lyVn2Ol/wTg8CcT06PX7Q59zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3G1l1Zb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LX35PPgN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3G1l1Zb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LX35PPgN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9b6vp824257
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V/YGjOa5xxVPrcdBiB2BIK8n5bGPdJoVpsazA00txKE=; b=Y3G1l1ZbiEkczCnt
	k3iKfe0Et2VHA2E/Bvct+NdRwiYUlpfCMB9sPCnnMDMYOYYWk4YxKfF1+VuSKGJw
	s8Z3hudT2NicDifn2ANsJHtYhWa9DYZ2X//v9ipYncQH78jOBXDybCi6LaNqFQLk
	ic1KT6qtsWdEl1Rvc6DyXUMc3X2Qm9fNM0HU+L0NeReWACgliTAN7ahs2ha+ucZx
	OZJsYycPWLDcCr8ngW3OfTPeH8MfOyvDZMd8BQnMOcQufFmk4ltQyHjNbfBm+Ao1
	pRyJSRMrFW/dGjjkwgFFHbbfrHy9MHbnHU5V/wMi4L/DT2NUtSNapdpXaoaeo6+k
	Nw4sZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e3gg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 10:21:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so57964345ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Jan 2026 02:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768990884; x=1769595684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/YGjOa5xxVPrcdBiB2BIK8n5bGPdJoVpsazA00txKE=;
        b=LX35PPgNaJ1PF9jhy9Z0l5WQxrqErzzT/tm0+2fw68ko9wxXviEXNjOLtAXIRcZHKt
         Fc3slWvf45rgyWVdaEwWl1LIbs9f5SO3mTeSAsyBy1VcqvLvUKBvPbvGWnVyE0M3pLk/
         tnpKXUtvR+jhZwaWDNVDisdklJX2M5iOcZ2aqEferI4PDFMj8FU8eH20FTLdE20j5rvc
         wAFEgbg0oWs2GsWjIlkRZnVsbEcbk2DQPP5oc7M3ywS28GC7sSiAGhGpyGaHnDTld/at
         IuFTlkTRggtya8GXfi5XgQArKCgWWAHIVphJOJ+D2E9vmnlgweB5Bq2V0iU/1VOZnWII
         RS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990884; x=1769595684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/YGjOa5xxVPrcdBiB2BIK8n5bGPdJoVpsazA00txKE=;
        b=mzpjbmuOAHtMevWC7N7mltLCdFoh7c4jdbSpaKn21tuHKFJnfUzFzPM4Kl/wzY6NUg
         3UPBJDt0a6z7nJWnzYbCncWR0QdqPMo+QiidvsAH1SOp3FWHFgcOySdU+CboMHmeXsor
         VlzNr9Ft+Ya4daccJSL4eyiviMclqEvu/tMqszeHGJtNY+Hx+m0qVRULJqXzMayhUTsf
         VFT+DINmHDjXZg5do1L0xHcLw/h03v43EbLieDPWKPbUYuZbhlgmhh4Yzm8zG/GApy0q
         QuPW2qcNNXjL3JvCV1mIUK6rZC9xeCoWT/Zmv5y1j0ixfxIrvfy8xkzWg1rp6rGrJOYh
         B43w==
X-Forwarded-Encrypted: i=1; AJvYcCUrIAPjLnhnaMRlKkUVzjbEiEj9zXHyLtqeeeisaUcVQ5npA/VGecieNGXoQs+eBym5DDtw8kqd7AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgxwP8P7DTBGuKDlshyYyZI8HOM+nRNSW5GDHc05e0odSOFHi
	0AEKkoqWQUcQoZ0H8EAUsTtXk7mM36RfZhbt0+URc/y5hmh31njks7PhJmber3jQr/CWFQALb9u
	LC4g5yLIldOkCMdrKM3tqf0cvbQ7AYduxqv9QQWNhG78Gq4pFlcRBxn6G74UahhA=
X-Gm-Gg: AZuq6aJhG18rKcGt4y0YyCdmBjYtvCJQcJhvx0uNHf8+uLCQXEFfSAQo9EiHS6LtjBI
	1x/LDPA92nQm3xBNcHcG8eVj5kjpJiNbm01Yr2F5S/FO5HIXMVnYgS9oXX/+0YHhh/xUQ5UJYaE
	FXj2+M9jU15wHi55zcT6NaFbjJmgBbUTsguP19zEmteF0HGxfRwmkrlwSrjC5+EbJwKNyVpbra8
	LCfz4VrjOOR8/8ejv1sutNtCiB7m4g3dwuueRU45TwKWp0K6DHsALMRj0pe/jJ8YHUxrufjRs1w
	xP88wynFK7NMbIPcw2oq5VC8WCwBOXMNkFUddSSHr7iidXBCLr1Am0rBmy+pRLQ369QQHaWJOO5
	y9ZUQKLlrn11on5L6qyRVntWOvFYhtlXDfSjaUa8Alw==
X-Received: by 2002:a17:903:1aa8:b0:2a7:8bf3:5677 with SMTP id d9443c01a7336-2a78bf35a7fmr29420355ad.59.1768990884309;
        Wed, 21 Jan 2026 02:21:24 -0800 (PST)
X-Received: by 2002:a17:903:1aa8:b0:2a7:8bf3:5677 with SMTP id d9443c01a7336-2a78bf35a7fmr29420145ad.59.1768990883774;
        Wed, 21 Jan 2026 02:21:23 -0800 (PST)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190aa334sm96168515ad.5.2026.01.21.02.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:21:23 -0800 (PST)
Message-ID: <274e2140-606b-47d8-8ba3-b848658ea5e3@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 15:51:16 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] i2c: qcom-geni: Enable I2C on SA8255p Qualcomm
 platforms
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
 <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-13-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=6970a8a5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=isDHjFI0VZuljSFwwbQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: FSgB4vsp9VVUtKtRiO0zFE7EYEiH3EyU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4NiBTYWx0ZWRfXyj5kRejfXSyp
 Rm0S3OxKUigv9O00bnWkPoC4QL+pP8hKEL3IUSLvOZUck8mr+60UOFIUMaLED+Wlumt6BFWWnES
 2ATA2k9CAQDILVg3LByyELD/bx7p05Qpc7TtsYinYtEwC3MuY76IgcEHPu6k/SOdNLhMQig7QMN
 VY9vXpjzyfBZAOPVaqreQ/C8qs6Z7BnpQBVx0vFFp1yJMLd0IbxbYtiuvNpQAAdFeTPxDCd0/jO
 7zKUOSbMp2UQTzeoPHQoZXYy2Gyx4clnEowfQ86zRT/DJKpFfTJ1hoilSqmetagizkTTon3fJ1j
 IXVHlEG7gQyhhxOVMtSm3W8AJKHHhkJ/wHN7DeyKnFCGsj2bi1ZCwt97Zp025jHiVQKspBEpw8s
 cp8HmDC9dDYGLFLtFUZzieELyfPEJfppFEC09AW5TZZas2q8cXvL6HCna8iY3xQ7+L5Xsy+aIJ5
 APyWn+ig623Gfiz9rEA==
X-Proofpoint-GUID: FSgB4vsp9VVUtKtRiO0zFE7EYEiH3EyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210086

Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

On 1/12/2026 4:17 PM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power on/off.
> 
> The SCMI performance protocol manages I2C frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate..
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> V1->v2:
> From kernel test robot:
> - Initialized ret to "0" in resume/suspend callbacks.
> 
> Bjorn:
> - Used seperate APIs for the resouces enable/disable.
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 53 ++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 1c9356e13b97..72457b98f155 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -82,6 +82,10 @@ struct geni_i2c_desc {
>  	char *icc_ddr;
>  	bool no_dma_support;
>  	unsigned int tx_fifo_depth;
> +	int (*resources_init)(struct geni_se *se);
> +	int (*set_rate)(struct geni_se *se, unsigned long freq);
> +	int (*power_on)(struct geni_se *se);
> +	int (*power_off)(struct geni_se *se);
>  };
>  
>  #define QCOM_I2C_MIN_NUM_OF_MSGS_MULTI_DESC	2
> @@ -203,8 +207,9 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>  	return -EINVAL;
>  }
>  
> -static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
> +static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>  {
> +	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>  	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>  	u32 val;
>  
> @@ -217,6 +222,7 @@ static void qcom_geni_i2c_conf(struct geni_i2c_dev *gi2c)
>  	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>  	val |= itr->t_cycle_cnt;
>  	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
> +	return 0;
>  }
>  
>  static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
> @@ -908,7 +914,9 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
>  		return ret;
>  	}
>  
> -	qcom_geni_i2c_conf(gi2c);
> +	ret = gi2c->dev_data->set_rate(&gi2c->se, gi2c->clk_freq_out);
> +	if (ret)
> +		return ret;
>  
>  	if (gi2c->gpi_mode)
>  		ret = geni_i2c_gpi_xfer(gi2c, msgs, num);
> @@ -1041,8 +1049,9 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>  	return ret;
>  }
>  
> -static int geni_i2c_resources_init(struct geni_i2c_dev *gi2c)
> +static int geni_i2c_resources_init(struct geni_se *se)
>  {
> +	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>  	int ret;
>  
>  	ret = geni_se_resources_init(&gi2c->se);
> @@ -1095,7 +1104,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  	spin_lock_init(&gi2c->lock);
>  	platform_set_drvdata(pdev, gi2c);
>  
> -	ret = geni_i2c_resources_init(gi2c);
> +	ret = gi2c->dev_data->resources_init(&gi2c->se);
>  	if (ret)
>  		return ret;
>  
> @@ -1154,15 +1163,17 @@ static void geni_i2c_shutdown(struct platform_device *pdev)
>  
>  static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
>  	disable_irq(gi2c->irq);
>  
> -	ret = geni_se_resources_deactivate(&gi2c->se);
> -	if (ret) {
> -		enable_irq(gi2c->irq);
> -		return ret;
> +	if (gi2c->dev_data->power_off) {
> +		ret = gi2c->dev_data->power_off(&gi2c->se);
> +		if (ret) {
> +			enable_irq(gi2c->irq);
> +			return ret;
> +		}
>  	}
>  
>  	gi2c->suspended = 1;
> @@ -1171,12 +1182,14 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  
>  static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
> -	ret = geni_se_resources_activate(&gi2c->se);
> -	if (ret)
> -		return ret;
> +	if (gi2c->dev_data->power_on) {
> +		ret = gi2c->dev_data->power_on(&gi2c->se);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	enable_irq(gi2c->irq);
>  	gi2c->suspended = 0;
> @@ -1215,6 +1228,10 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
>  
>  static const struct geni_i2c_desc geni_i2c = {
>  	.icc_ddr = "qup-memory",
> +	.resources_init = geni_i2c_resources_init,
> +	.set_rate = qcom_geni_i2c_conf,
> +	.power_on = geni_se_resources_activate,
> +	.power_off = geni_se_resources_deactivate,
>  };
>  
>  static const struct geni_i2c_desc i2c_master_hub = {
> @@ -1222,11 +1239,21 @@ static const struct geni_i2c_desc i2c_master_hub = {
>  	.icc_ddr = NULL,
>  	.no_dma_support = true,
>  	.tx_fifo_depth = 16,
> +	.resources_init = geni_i2c_resources_init,
> +	.set_rate = qcom_geni_i2c_conf,
> +	.power_on = geni_se_resources_activate,
> +	.power_off = geni_se_resources_deactivate,
> +};
> +
> +static const struct geni_i2c_desc sa8255p_geni_i2c = {
> +	.resources_init = geni_se_domain_attach,
> +	.set_rate = geni_se_set_perf_opp,
>  };
>  
>  static const struct of_device_id geni_i2c_dt_match[] = {
>  	{ .compatible = "qcom,geni-i2c", .data = &geni_i2c },
>  	{ .compatible = "qcom,geni-i2c-master-hub", .data = &i2c_master_hub },
> +	{ .compatible = "qcom,sa8255p-geni-i2c", .data = &sa8255p_geni_i2c },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, geni_i2c_dt_match);
