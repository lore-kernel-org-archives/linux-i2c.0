Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F650376BC2
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775800; cv=none; b=lj3mrASW+rEKgTKq81jPTkkD+RBinGnqW6XYho0khmAU80jJHlGgWfwUISF3RY7Ji7X1OoqlUsnAmdGWUiUpWJZUGVr5DRnmxOP8CKe8o7YxNo5DuB0EkJVO7dNXfJTqIFpASK9pof97td/zAQcZ3fOQ3MhOjjvLeENL4l5uBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775800; c=relaxed/simple;
	bh=91K/Z6+56KvU3gzwKq0QrDmOr0Uz78giYQf7d9vHxww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf+h/3IRoYg+ef7DFskVohgf/dSdrO8DyuR2kqMdpyXyv19a/KCq+MpRUYGIhUEwgACA9kCCoxpDPB/vtXogMfqIeOTcxUU2h6BfAdwYn92A5w+kXAdqs40qEuOxFkdljhhK84O6N9xzCfAmF3gVLBYnO2ahNtWRmrFMbUOSRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jo9/DHW3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJEJAgWt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jo9/DHW3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJEJAgWt"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAbnwO890982
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qUd1oJ5o6OjIJRKQGNupcyS0Et6+1oBOnttCQIhUsK0=; b=jo9/DHW3C7kPJGnK
	YlvjYdqxwmv8+SQOhIdzAE09t+YM1cRNEu5v+pxspeqoAX9E7t4cXcTuw/g1Mbxs
	nMuCgvk0WULa0glhOTeBHxfyQ4dn4EHfmDr4e9nyhAnjz10dGi/ENPtz7d+RAu/P
	/vcKJ9qSevfHY9AyQNwWa3Ewt61qus9zEG4N5zhXcOtHonsvQaNmghgrHCNbss3r
	kiLgs0PLGn8CGjBs1WjF2DB9os4UEKKdS1Zt89oNB8oIl2rs8A/HZMHA2zySu8od
	3XGE160n9rjaes55OxdN6ZSrtAtcvdWQIFBUZHavxmFOtM5brxQPY0Qt7Y7YswOs
	nAeOMQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gs7t3vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:23:17 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c7177d4ab4so13159185a.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769775796; x=1770380596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUd1oJ5o6OjIJRKQGNupcyS0Et6+1oBOnttCQIhUsK0=;
        b=PJEJAgWtyp5eew7ngZT8oAQC+YlC9b8nRN7CZTNOuhBYU/RvIy0wPGbtkyAbdSZ189
         Iu0ghfVTbiBUpEiP8amh4gKIENH62Ouk2VJH9mrdSNN2SBfDenh9AX/KDerVqkvo9MfI
         1O4GPOp0wy8LXgbuhDB+9SXINZczQa3uEvy+GedUw8NXjCh7aHqDydzahfW+mfMPYD5E
         CMLgG+44i/tSNtnx6HVzfROfoXFgdU2Ow6thCvlzCBXEHTQY+IbkFtjKu11YPxsuUAEa
         VV+KTxfNrST51VN6dn4R3XXogDVI8PxwBeRijjHvKtgvR3tgioUUOepIzGkh3qNd8jPF
         orHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769775796; x=1770380596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUd1oJ5o6OjIJRKQGNupcyS0Et6+1oBOnttCQIhUsK0=;
        b=pZc8YhH2FZAVrKFnQZmyIvoBq1UtwznO12kn6s1ublwUqbpaVegvEB3Sp6MKsUUTqG
         4FXPy6x0EQu8IWRUFAOIWAKfZUQ9svasHEM82DC8d1hsaB2VvJHEWmQ3D1IMSrfWrUbV
         nW21WavBrPmgyUVfUMRFqSpRR8jBHvmBMJA43hbFhW+2yL1Vd0Npeopu3eJlgA/dt99T
         eudJIY+Gtjubvx70Ik1gaGVrZU+AtYfYLDcvYgBGvm8UA0+5ZIjBIKHE1wZ5bVwkJull
         N/VqLySK18OChlzd8Iv2/wRdjjWvjYY6hVopS0OJit2tGo+qp7dAWWAQJsgNlVrlrNsQ
         U5/w==
X-Forwarded-Encrypted: i=1; AJvYcCV/MODXI+PnjtwsymWtj45ZqgcNJBe9nvG7/KdLmTT4O4L7XgIq07Chmj3UHpYF694BA9r7o0Y/wa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKre+9RJjNTNJmtB2XbgRwPXNf0O68WjPSvBGbV+8BvE3lVWEo
	folDi95HnO9IVyrzeUpb+T9FsAo+MBc2QlDqhXtnpgjxrcIG62NDEy44B5EG1OlS721CaJP1bP5
	mga66MDchk7lZEvHNfJ+UMHl7AJhDXa+HgdbrifY5ra1HUvMMLkkVvlNRw3JoRks=
X-Gm-Gg: AZuq6aJchCgIzdGGbHk7nomW5LGwjid6vcHxHSrbeXSonEyjKj+EonwHYUjIfDknpJT
	mMg2sOrFCb0Ru9almc8luZbtDGbWyblF3nubzahoOIOGKPjXuhFvLgO8u8xd6c/QGJ3l+jPeHsS
	vyPftoKt3W8bWiRJDsucHQUtaCA3uckosE3xe3qEU2n/6zPryKTVhIlnuRYW93n3xUiDCTgmHgH
	UUbbgY4IrBhvIXmcucviQIVTmYDhT2mW7hWCt98nnN4olFTZ2/O+fH4v2jXSgjA5VlyYCPP6fnv
	tWe7n5JTilSggejtUbkbHTAZtZBwlDYpUlLVmEFF2X67iO1DocSdPvgfk2s+mYZiGtSsjAXlKy6
	z/g02BT2ZtKSFzzWIaM9dXrp7zTUPJSLrJsijCcpFPMZYN+Nvk4y+fh1VEPuPrWwapmE=
X-Received: by 2002:a05:620a:2807:b0:8c7:110c:762f with SMTP id af79cd13be357-8c9eb289217mr276708885a.4.1769775796361;
        Fri, 30 Jan 2026 04:23:16 -0800 (PST)
X-Received: by 2002:a05:620a:2807:b0:8c7:110c:762f with SMTP id af79cd13be357-8c9eb289217mr276706185a.4.1769775795870;
        Fri, 30 Jan 2026 04:23:15 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c0213sm418023866b.48.2026.01.30.04.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:23:15 -0800 (PST)
Message-ID: <af0eba46-329f-4979-8b8a-fb5dbe2ad992@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:23:12 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] soc: qcom: geni-se: Introduce helper APIs for
 performance control
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-7-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-7-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwMSBTYWx0ZWRfX9+72vuwPqloL
 pKdwls6C7kNkKQGE1WWBSb0+sEpdL0V4JS3NcoL5iW7VxEt6yGiFCAuDGIsjVuX9/kvW76h51P1
 13xiEieAb7lq+p240IniR0Z1OJrSthXLBhn68x4CmLiDoYg0+PsAyH6QGeDNNM+lyaYRH8uHjLJ
 xLPwbpo5PVfxRyjo4tYFaanGFsz6WbLGjOpYYKwaTjHn52rPahL+YWPzSqVJ7HGVE3MG58FbRBr
 WrXNAZKTVV0pZHR7S9DVOpEzF8uLKz/9pt3doKtaUiYSR2eJwBzlnTA4lqeCmpWNFa7z4qyxZGQ
 s4v2aJ29IqB12L2rMwbW4nk+8W4oYnmb5ifLdmTIi6UM5YwVJVBnc0LotgZZ0F/IRElhogMfMzd
 WYWTVx4Hop/TaEJSJux1ZO8bHIqxjBDBHBJuaSIPsRQgOHnFwpElccCCvxsnJy1P8uJqMKAV1cS
 qI2B7iNgNGx7qJuHm3w==
X-Proofpoint-ORIG-GUID: 0eoRFdO_JDez3F0Z6aXjQC75jtJXlLmG
X-Proofpoint-GUID: 0eoRFdO_JDez3F0Z6aXjQC75jtJXlLmG
X-Authority-Analysis: v=2.4 cv=UPLQ3Sfy c=1 sm=1 tr=0 ts=697ca2b5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8UfQzV40dBNW6KkxgPsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300101

On 1/12/26 11:47 AM, Praveen Talari wrote:
> The GENI Serial Engine (SE) drivers (I2C, SPI, and SERIAL) currently
> manage performance levels and operating points directly. This resulting
> in code duplication across drivers. such as configuring a specific level
> or find and apply an OPP based on a clock frequency.
> 
> Introduce two new helper APIs, geni_se_set_perf_level() and
> geni_se_set_perf_opp(), addresses this issue by providing a streamlined
> method for the GENI Serial Engine (SE) drivers to find and set the OPP
> based on the desired performance level, thereby eliminating redundancy.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +/**
> + * geni_se_set_perf_level() - Set performance level for GENI SE.
> + * @se: Pointer to the struct geni_se instance.
> + * @level: The desired performance level.
> + *
> + * Sets the performance level by directly calling dev_pm_opp_set_level
> + * on the performance device associated with the SE.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_perf_level(struct geni_se *se, unsigned long level)
> +{
> +	return dev_pm_opp_set_level(se->pd_list->pd_devs[DOMAIN_IDX_PERF], level);
> +}
> +EXPORT_SYMBOL_GPL(geni_se_set_perf_level);

This function is never used

> +
> +/**
> + * geni_se_set_perf_opp() - Set performance OPP for GENI SE by frequency.
> + * @se: Pointer to the struct geni_se instance.
> + * @clk_freq: The requested clock frequency.
> + *
> + * Finds the nearest operating performance point (OPP) for the given
> + * clock frequency and applies it to the SE's performance device.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int geni_se_set_perf_opp(struct geni_se *se, unsigned long clk_freq)

I think with the SPI driver in mind (which seems to do a simple rateset
for both backends) we could do:

> +{
> +	struct device *perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];

Then, we can do struct device * perf_dev = se->dev;

if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];

and reuse it in both cases, completely transparently to the caller

Konrad
