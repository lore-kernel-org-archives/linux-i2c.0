Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA4332EC1
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678429; cv=none; b=frDy394zMJGKUrBV6ayjkzPxVaafCoVwLRZBDv/X1sRan8sFdBWdTfThYdS0vxHC2acPOCOLYtF8cxTh1ZwhaQemuOKG+HBkuLVD21q+4kiZfeWQSOPmeBfLj17qT2R8jMP+3vn9FbBhoZErrBC2o7DbhkUsPrtko9cr7e2WAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678429; c=relaxed/simple;
	bh=76Qfs4fzFRJFWgUkz2WuCwo5cMQXqNI3Rd1HhYdAMn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iaCosx47Oju1t8nixi88jk4BVcQN5pjtENUgcdNcoBd7l1uS4z3jWekzVacuf5W+TDv9yk7WJ2vsJzJwsuqpL9/hzY24o1e+ntC6ofgCGM21rdpggRkj26YZdaQIaT44pnp+Ef8D11RHvxGlB+Zn6MDG2ItWY5b3HFrJALLGPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IVLueRP7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NSoihNFr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVLueRP7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSoihNFr"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PHFwLG1417996
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 17:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CV9FIhO/83ahE0BC2NxprFmP61XTEJfAfGCrazEmKfk=; b=IVLueRP752bURIc4
	U6EYF4Z5BXBYMRTjy7ZlEufrvEvcYjD9Wou3TTZUioa0Sfpz1sVWOeb6ZH5ksOFQ
	Y0p8+rnG7Q2zpp0es4JAZsRjOW6GLYJYEatFEfsPlp9ZCrVQiVGYBHwF9XqaGyEA
	OYOP2GZV9iE1MMeCA2JLMkjwSH165VUuQAjaQpD+NUN9/1IiHK1j2vCaZ4LQY1mR
	e2nF54zHTUYVYnuftIQqTwdiZV/3sHgAOnCpVxk6EsEKCKiNgNlNiqtfKD1ibuun
	tB7jP76mZr95pAXB71s3NMNqkAEUM/+0C7K8cQk8qsiI0EDKTtxqnUjuvbJQxTPJ
	cyaA2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9f9ur0wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 17:20:26 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so1087575ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 25 Aug 2026 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787678426; x=1788283226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CV9FIhO/83ahE0BC2NxprFmP61XTEJfAfGCrazEmKfk=;
        b=NSoihNFrtxi6btSS2fAMc1WHWuxl/ceOpPMNe52paJA+9Atgi3hyjyLxrGjSPCAcX6
         LBSuIom8kcvFrD6KfBDwQ1ALoGSpUwf4oYTivfV1Bw2Jdy3SnmTyrBHbMiFhDsekrI/c
         5Xr+tEVtmE7RKCfkL57hN1rtBgLnjPxocC0G5i2JO/xT2Vsstl5LzfEs/vI0jmgZ2f7S
         I+imTrKMT/S/w0WykP0zcSGHda4mHJPLH1Z6KGZI8iM+7jJOhxDNNifkkPaP4eLdlsyQ
         AAoBlaRE41wvcDSTY0WPy88k7bB6cifWxYIx2JvR+QOXGOPtcTUb9ml4D92YLyjeUA6l
         P8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678426; x=1788283226;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CV9FIhO/83ahE0BC2NxprFmP61XTEJfAfGCrazEmKfk=;
        b=kebfvfk1XuokmtciDXPBeOPywomxq63T6YKBqV5VVtk38xBj2hRFhRlbPkxa2hKUit
         a5UUCjuqxYM9mEPe0aeHnMMditqIerxlIzalp4XcB1WDjpih80KxSJfFke7LqerZxZrQ
         wtP0H2V3V6LxkPbk306he6KE2dfVkeqqdnNcBMZy2J07cR/dF9HsLLTiQUsFOp89fSyK
         S7QShT+W7VGSG25lhZmRRk0FNni8a0aLbRz5f3RVHDJnlu4XYP5PmqBFd3ZOC792321L
         O9a2npNHpnG5lffquwKJSjNDt3J7hE2SJO81bU98n/8VQpuJgptS/XF7f0N8bmXRdx4b
         lP1w==
X-Forwarded-Encrypted: i=1; AHgh+RqfTul2dEhsdf2tA6zQtz+beU0MoUaaw0Gp9uO6hbmTmlYEXKK00sljmIc2V69POn/t5aUtEDdru7I=@vger.kernel.org
X-Gm-Message-State: AFuF++nq8bY2QFjjvWgkwWcPaVc2XTQLr9N6+3M+Pk6bnt1GMiHOL1xi
	oKrtcvcyOV5ibW6MYvOrllzwt8YXMCnRoNMZPVfMwGi1aOYJRz3tD5nLiI3u59GEgeWd2H3is3/
	2rsDeQjZJKvPVdIg5+NNP01HmhD0d55xwGSiSqD0iVcZY1zV6wgEAHxKzbUaL7a5rG0Q/h+Y=
X-Gm-Gg: AR+sD134LIytZgKBoKFB2v4ep0g/yjZZdQnOAGj4DackSRjqMd7CqC4vhHrLTann1zE
	J+x2iG+AimUKMX7/MpqSnezclLUadu53KNi+gK3HfnYOQuyJdrb2WbsNvDaRN2FWmIllObS5riJ
	yYiiKhlwqxPWnIroK5S3xazT3+FwS16pL1YzTvpWKHdIulsrfHbppwxpz4wS8ShMm4S344Xx54r
	FpuPZV8r8EFps8cmV0e0yNz0J/v7q6TAzltGId5PbJhUeHj5a9OZZDAvAIf6qbjrtKJw7PZIZSj
	1xjKvMfkgUZ+v2hA704/UAq2pNWMGR5Pm+3HEukzI+OcJD81DZLgXRiAiyT7Zy5FfnJf0ru5Snt
	FaDcfLDYbxeBpDN6OTxwvx9uy/j7Lb8XP
X-Received: by 2002:a05:6a21:3398:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cd9122fcd0mr14279020637.14.1787678425829;
        Tue, 25 Aug 2026 10:20:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:3398:b0:3bf:9b61:f7ae with SMTP id adf61e73a8af0-3cd9122fcd0mr14278929637.14.1787678425187;
        Tue, 25 Aug 2026 10:20:25 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.110.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d769d81sm428872eec.13.2026.08.25.10.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 10:20:24 -0700 (PDT)
Message-ID: <fa199e71-537e-4bce-a0d8-ef59fe871bf6@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 22:50:19 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: qcom-geni: add I2C frequency table for 32 MHz
 firmware-based SEs
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-2-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qFwcBOd20hVAVtmMyj9R5tqwUPkNF2O4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0NiBTYWx0ZWRfX1pPOn9SyU0Ui
 E09G3ercFujS9IG3K33ugXm/VgyvTGxA4DyjndyJxNZfees/hfPgdS/zeP5f72hUL8lKPa0kOQ6
 eXBepI9OeBEUPwmKvxQet665wW59+pRaUd0GZL3OIGOUIAHV2zxxDyHhwVWXAzi9Xid3Ofm3aRL
 jjT3Yf1CXKKLaT3wNk/70r+DKM9cnlJaIbYHabz5M9UvHXNW/XV3SS7V4jZ85qTpofwjwWwopm9
 vaRt8OYzWA2jVrokofhvCWzO7TNTALfI9913I3sfrP3IKaT2+130Tyd9KKFf3KBC9LBpRk2NY5L
 OFjGyV205naCL8B2o2FyoQowxVX7OuBWJp2b7fmlxmpOgpH1mH/JJWRor/2ii6QeooxNyzxDQS+
 KRaGgc66KRXw4Z+dmGbwz7uhJMLYfiLGnVFrWpNfwvCFgNXA/9JbuQYdZx1iovE11aTGXK9iJa4
 5MBMis8gBGOSCSXQAvw==
X-Authority-Analysis: v=2.4 cv=acNRWxot c=1 sm=1 tr=0 ts=6a8dceda cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=T2iwtsF3Qoe1cvxaLfjbZQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z82qHJ9NIKfZ-gyr7UoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE0NiBTYWx0ZWRfXxpNovHCtJQMi
 jJB+61a+T5zQIIn+bccjCyK2h/0LfCWZOBF7jayHcgnI4xoHaUo5NzgBEN8FmMU/lFQNAxcrkU2
 bbykphTtrGtgxJ0tPB0vS+FPik6qGR4=
X-Proofpoint-ORIG-GUID: qFwcBOd20hVAVtmMyj9R5tqwUPkNF2O4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250146

Hi Kathiravan,

On 12-08-2026 14:00, Kathiravan Thirumoorthy wrote:
> On IPQ5424, the I2C controller can operate on both RTL-hardened SEs
> and firmware-based SEs. As documented in commit 506bb2ab0075
> ("i2c: qcom-geni: Support systems with 32MHz serial engine clock"),
> in IPQ5424 SEs use a 32 MHz source clock.
>
> The existing frequency table does not provide the required SCL timing
> parameters for firmware-based SEs. Add a dedicated frequency table
> using the SCL counter values recommended by the hardware design team
> and select it for firmware-based SEs to achieve the target bus
> frequencies.
>
> Move geni_i2c_clk_map_idx() from geni_i2c_resources_init() to
> geni_i2c_init() to ensure SE_HW_PARAM_2 is accessed only after the
> required clocks have been enabled.
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++-------
>   include/linux/soc/qcom/geni-se.h   |  1 +
>   2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 00013b41a6f5..15835f10b062 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -187,19 +187,28 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>   };
>   
>   /* source_clock = 32 MHz */
> -static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz_minicore[] = {
>   	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 26 },
>   	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 19 },
>   	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
>   	{}
>   };
>   
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz_fwcore[] = {
> +	{ I2C_MAX_STANDARD_MODE_FREQ, 12, 9, 10, 25 },
> +	{ I2C_MAX_FAST_MODE_FREQ, 4, 3, 9, 18 },
> +	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 6, 15, 29 },
> +	{}
> +};
> +
>   static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
>   {
>   	const struct geni_i2c_clk_fld *itr;
> +	bool is_minicore = FIELD_GET(GEN_USE_MINICORES,
> +				     readl_relaxed(gi2c->se.base + SE_HW_PARAM_2));
>   
>   	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
> -		itr = geni_i2c_clk_map_32mhz;
> +		itr = is_minicore ? geni_i2c_clk_map_32mhz_minicore : geni_i2c_clk_map_32mhz_fwcore;
The source selection remains unchanged when using 32 MHz:
writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);

However, what about the voltage requirements associated with the higher 
frequency?

Are they automatically managed by the underlying provider, or is 
additional handling needed in the driver?

Reference of konrad change for CCI I2C driver for 37.5MHz with voltage 
requirement.

https://lore.kernel.org/linux-arm-msm/20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com/


Thanks,

Praveen Talari

>   	else
>   		itr = geni_i2c_clk_map_19p2mhz;
>   
> @@ -1046,6 +1055,13 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   		return ret;
>   	}
>   
> +	ret = geni_i2c_clk_map_idx(gi2c);
> +	if (ret) {
> +		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> +				     gi2c->clk_freq_out);
> +		goto err;
> +	}
> +
>   	proto = geni_se_read_proto(&gi2c->se);
>   	if (proto == GENI_SE_INVALID_PROTO) {
>   		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
> @@ -1109,11 +1125,6 @@ static int geni_i2c_resources_init(struct geni_se *se)
>   	if (ret)
>   		return ret;
>   
> -	ret = geni_i2c_clk_map_idx(gi2c);
> -	if (ret)
> -		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> -				     gi2c->clk_freq_out);
> -
>   	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
>   				  Bps_to_icc(gi2c->clk_freq_out));
>   }
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
> index 29a53bbc0dd4..7e8c0bb6d674 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -331,6 +331,7 @@ struct geni_se {
>   #define RX_FIFO_DEPTH_SHFT		16
>   
>   /* SE_HW_PARAM_2 fields */
> +#define GEN_USE_MINICORES		BIT(12)
>   #define PROG_RAM_DEPTH_MSK		GENMASK(10, 0)
>   
>   #define HW_VER_MAJOR_MASK		GENMASK(31, 28)
>
