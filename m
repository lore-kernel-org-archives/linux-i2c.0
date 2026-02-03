Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E78285C91
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121252; cv=none; b=ND77HymB70DaUv1ttm4WUR+eMrV/h15vv44hnMlmpey2Oz0YEFfBqf9PM2jZZg2V1y7KeylosgaMQbeBNYh6eOIxLX/3OXCzA3soCLW7xkPRVHgQlJvtP04idfqsc3IgD7LGLLfV/K4Mkja5GuoojWgje4fIsLwi292JnvW0tgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121252; c=relaxed/simple;
	bh=ZX7iLq2hz/l5mm8pzHPIEzd18ODFdAKZFQ1qn5i4qy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL5xBP/It7SwjjwBzLPOr9tHCiDssUiDAjXnpl/8RrRB1qCCgquqPQJT1zpbw2rvwR221TJIAxxsNp/m5cXn2TNdy0ku0dfr29NL2YOkccdVE0XAe2lWqM4BqBPe6KdPWYRYAy2G19MpFobYr+2kYVeIi9hzSrR+sftgNIz5les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxO+crhN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PhKqMqSs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxO+crhN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PhKqMqSs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613A3uKq1591673
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GpI5WvoJlzYOz9UIPVv1v5bpeUv7kubf99JkM4paiRM=; b=CxO+crhNy2o2AJJ8
	6d1cqQeRMfVNTGb12pJuO8U83BXbrstevPWjCOGSpkjCLlOQa6YJkmjtkuaKF/Jc
	rz4VCF2B0YZ4AQ+0H0Voe66Qm2XQPGBxOW1/Sa1zIHfWodzVN9kP3d8LYfFrNm0z
	FWX0lN6rFwS/AF2er019a2hvjcfr/Fsr9Q3H5vk0k0aS1YO87NWg1U3yfOVbHQgP
	+c+a4ufDGAJypLRTMtnn8dkQIuL0L+6YB555b+XXtlyPSH4JDWuoZ5TSG1vlh90y
	21HspuB9sozhwT6xd4SUt5o3LI2edwuSgLf9X04kTixvSe/IpInjJzvMURntyHvP
	GMvzLw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3exjgbpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:20:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c536c9d2f7so160764085a.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770121249; x=1770726049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpI5WvoJlzYOz9UIPVv1v5bpeUv7kubf99JkM4paiRM=;
        b=PhKqMqSsWEjbJqWtahOQnn7dZNKZefjhgVLh8BYWWiV/fpOf88CZphNziUhm2EpLQQ
         E57XWPy5WpsXNEBw5Bc0mTXt1iC+BMc5HJxaXamuL5Kr5mH7I5YIddds+q9bT8o2hJ+h
         a2+2RGo6EjHsLJC11gn5iZBBKYIBnE5A50TINx2IzmXRWwTYdTwa3m93ETmgsgdeDy/y
         tz7T8FR5chD6HSlOISROHQDDwiZWUXF8q4gGq72aAuFmKdrfPHBb+I03Axoy0gf5RgLU
         zcyG/iYqtco/su4aVTUKuqiUx/YLnS9KtBIubuMLpqMsGBugYZr15b8USX2D1Rz2YUo4
         y0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121249; x=1770726049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpI5WvoJlzYOz9UIPVv1v5bpeUv7kubf99JkM4paiRM=;
        b=SRaZaFU9uyk7tHadax732kSqvoyX6u0KklofYZuZ4wSQIhCQoBsyb5ayn3jMhxK64u
         1zznmim/YYtjhbM9J4XGy83tg5z6vDSHdKiqdRUklY3tykvrEtWzTR8BDxEepFGGkyEK
         yy6x7jLzSlKtyfbgAk8s7uC4Wb8Qc5XoPZCQFDX4l6Qr08kwPcO4fFtNGUeklb76mTCq
         taOqV1e2P0hp/Pw/nGUJ0wn2+VNKA8VDA6n5+Nyg4fVy+PbGGFRBb/mURdbevtEt+S9L
         fNpEXgoGS2oPSQhkpNApeTz05gNHTefr0xjeB0eJsjbu0j4PA0JBFSGJ943lHv3CsIdp
         gEsA==
X-Forwarded-Encrypted: i=1; AJvYcCXcFu2EJYbOHjTb/hdMG9V4/B5i5XRBs/r0taiIXA5RHrQtOQmztyPuiIRASq5U34pyQs7bOdRAuPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoas+9DfkeFgc1DW32smeWk2hqvC0Kww721huwml7mLdSc9lZ/
	CYBvjDZBsQZqJAadsfwnux8uRa2/tq2T2xlXehjfeDIfkSaPQMwp0874YgrO1mBiN7HQZy1pXeC
	PNKjiYS3Sr8eiN8oTRzDsN/+nSu9/pvvWfmbkhkBi19340g2nZpP/FPluAjhnaIA=
X-Gm-Gg: AZuq6aLRnHJihD1mpRe+vIi+A9593VZ5Xy28EjFwr/37j/LIIp2t8kOgnF2/wWcOm+g
	mvyJCWcRaAPWU8eHPXemXyuNRIxjAEveF0B1/8fMEDUvMZR7G+gg6wpLP+ptXbWWOuWHXbn9LNI
	D/wWcEFCS+F6UHM1osZpZ6XwgAk7eHoQYUpV6CHY5NR9EjfroaLYiuaD78LMrTzAE5I3zMeMwGU
	S0HBe6BHyQPKDd2kLKczKbUPmixQe/gMeOlqozJtt2qm0/AoCnia9U5P3QuPd+gZ8qFA5+enm99
	4Vi/bWrWc7LHfV6/GI7BvYJz6bFKcfv5mTzKfwcOjFSsfz9X3K+P1h8JrpvHb4mSkUZp9/ZZynP
	hqsP2KZLcULRmzZaSHfSjMEgOhWQ0fQON/0GDpki66h/hZ47n4zVzbUkMGucY/HHXemg=
X-Received: by 2002:a05:620a:bd6:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c9eb34ff20mr1532687285a.11.1770121249440;
        Tue, 03 Feb 2026 04:20:49 -0800 (PST)
X-Received: by 2002:a05:620a:bd6:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c9eb34ff20mr1532684985a.11.1770121249020;
        Tue, 03 Feb 2026 04:20:49 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dd99188adsm891757466b.50.2026.02.03.04.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:20:48 -0800 (PST)
Message-ID: <ff9a2aa3-1b2b-4001-82ce-198c61a4b637@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:20:45 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/13] soc: qcom: geni-se: Add resources
 activation/deactivation helpers
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
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
 <20260202180922.1692428-6-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-6-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W8c1lBWk c=1 sm=1 tr=0 ts=6981e822 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=v6fWVTfWKNrbvxdKqGkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: bHYREnPH0TuVBHdofvVDdP1praSVlFbh
X-Proofpoint-ORIG-GUID: bHYREnPH0TuVBHdofvVDdP1praSVlFbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfXzbaH6ifi9ldz
 E5vgFDDOtbk0Jawsp7iDwTo1C03vYmtSFjU7a6Ml99G8h/51D7suZODjarYCXclJcfHp+ODNrAa
 R4AfJYEE0XG4Oa6dEKdAnwIxnsg8VlzB1kOEIaepOoOPDitJlJ8x6y9VrjUvxywyYa6Ugsjn1qj
 vO+9W0zenir+mSaDH0o0OHypl+g+Rl/dryUff2FbmRcTUnASrOkqPj4kiWDJHSNwBdyJ/SZ10Ql
 ScO7Jn8DfsIGt3cI39nK1U9zHo9UD6a3tzoXEdAePkIj1mWoekTJ4EiIpwGhYumhUNdclYWsJxC
 UjxFexzGA0xDPVudiedGUq9udcKZNV2G+kWDNiDcxfRHCXUPnQuZ8lbPOPIZtRESWuh0ZBiLqQB
 BagG0ok73Zin7ehr59jopoOaCwBX1p+P/m2SBDFRJKDBtlsTDPFZ3gt0zZ1ha6ciEkMQRar1NvX
 zJX6iwjKexuhWz1yxsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030097

On 2/2/26 7:09 PM, Praveen Talari wrote:
> The GENI SE protocol drivers (I2C, SPI, UART) implement similar resource
> activation/deactivation sequences independently, leading to code
> duplication.
> 
> Introduce geni_se_resources_activate()/geni_se_resources_deactivate() to
> power on/off resources.The activate function enables ICC, clocks, and TLMM
> whereas the deactivate function disables resources in reverse order
> including OPP rate reset, clocks, ICC and TLMM.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +int geni_se_resources_deactivate(struct geni_se *se)
> +{
> +	int ret;
> +
> +	if (has_acpi_companion(se->dev))
> +		return 0;
> +
> +	if (se->has_opp)
> +		dev_pm_opp_set_rate(se->dev, 0);

This is still unbalanced at this point of abstraction, notably
keeping the RPMh vote at 0 permanently after the first
geni_se_resources_deactivate()  since there's no counterpart in
_activate()

That said, the serial and UART drivers do rate calculations internally,
so perhaps trying to be overly smart about it wouldn't be a good thing
either.. Let's add a note in kerneldoc that the activate must be preceded
by a dev_pm_opp_set_xyz()

[...]

> +int geni_se_resources_activate(struct geni_se *se)
> +{
> +	int ret;
> +
> +	if (has_acpi_companion(se->dev))
> +		return 0;
> +
> +	ret = geni_icc_enable(se);
> +	if (ret)
> +		return ret;
> +
> +	ret = geni_se_clks_on(se);
> +	if (ret)
> +		goto out_icc_disable;
> +
> +	ret = pinctrl_pm_select_default_state(se->dev);
> +	if (ret) {
> +		geni_se_clks_off(se);
> +		goto out_icc_disable;
> +	}
> +
> +	return ret;

nit: this 'return' always returns 0

Konrad

> +
> +out_icc_disable:
> +	geni_icc_disable(se);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(geni_se_resources_activate);
> +
>  /**
>   * geni_se_resources_init() - Initialize resources for a GENI SE device.
>   * @se: Pointer to the geni_se structure representing the GENI SE device.
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/geni-se.h
> index c182dd0f0bde..36a68149345c 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -541,6 +541,10 @@ int geni_icc_disable(struct geni_se *se);
>  
>  int geni_se_resources_init(struct geni_se *se);
>  
> +int geni_se_resources_activate(struct geni_se *se);
> +
> +int geni_se_resources_deactivate(struct geni_se *se);
> +
>  int geni_load_se_firmware(struct geni_se *se, enum geni_se_protocol_type protocol);
>  #endif
>  #endif
