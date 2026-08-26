Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CBE448B8E
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757473; cv=none; b=axOngIUUVjNVzrlaq1ug25bzg5+CNcnYauRlWQ2mOq+a6xgZBqyi3ionslLJeYlfTCwf0qr4O1bZ2OIakVw1FXhKyonD27uqVaNCwQVbD5J0/ZrLgoyzdD8G+Yf7bssmxENCADqgOck+lsiBrQtyFHqh/l86A2cBOz8+6aRZS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757473; c=relaxed/simple;
	bh=Sk8am2Vtc6m9rrLeY1Sbj7klCd/qXHFyxywLnXgPxcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QO3reyZxe+V4kluSVAGdB6oBKY4bljfJz+vYnyNAyj6ULwf+34kecnXj74o3+laa6Q0+Anwo5QAuOqBI1AZr6vG3k7wg91e8O3ZSYXIRhbgGIJIETvEqMQR8A1u+FP+AElU2gcxjpISE4aSo08JRojQ6LK3DqOxSDIxmLwIcA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p5knkjHu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RT+Q3+DZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p5knkjHu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RT+Q3+DZ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuqZs611917
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 15:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ACC2N5csm/N7GWXhyzoNg/HYZa0MB3L4DHfq+Va9l/I=; b=p5knkjHuqaYpQxzB
	H7zvlxnKLQOs1cDx7G1/WbGXm7to0pWBWSR8OKDmeDK/7HsJo6q49HF3qCXkl2pE
	mjswcW8ddsNNA9po4CQBYyO8rO+rRWohR56Q+LFAFVZjRdwiWhUXmDLxtk/NH2SU
	I9Hs+ihAtA+F8wsEqoiEBuDfckytb0cP7TETqi/Aorr8CvVi2R1sLbwcf9TwJIQO
	Pu+iBTFoc/fR0G9oqKuS5sJSoJv1KrGIcf60TvK2XFasrc6EKxYsg1rtJ7TCkR+2
	Rzcaf8CJitCIJN6vpV0F/PM/IGcIu3rdEd+c4+XY8/bOhCJQVWufzo4zWgZ+zEXz
	tY/3uw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smxaew1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 15:17:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3954def0191so2190487a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787757468; x=1788362268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACC2N5csm/N7GWXhyzoNg/HYZa0MB3L4DHfq+Va9l/I=;
        b=RT+Q3+DZvckCun3HgDClAVd8dY4dqLTkoxXh1qZVVe977tkQOiKzwRyZKntbGyUI1x
         ze/O13OIps7tzbTyaTbLQcqtvacUQvLzF5fYyf6i1rO5uxSnKmHOMlR0hUtFZkg9BodQ
         F8svhi3OL60ty75CsrSsD6jj0ZvYFdbInMuUOksLx3PnAG+ZxHuH5em0EeoyA6wBAJ5H
         ehY3TFiKNQ2uI8wgcjiEnaC7bx7BWat7aJoMix1rCMyCUcgJU1/ukjBeJqBRZDc8N+Xd
         o1L6ih1edEg07pn7Py/Odff6sOJcUblKOfZ84mjY3zqXShEluTohOL4OasqwPhceNlVE
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787757468; x=1788362268;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACC2N5csm/N7GWXhyzoNg/HYZa0MB3L4DHfq+Va9l/I=;
        b=lJaeQe/GNCjOKeJ2vOmQz4EqgWOc25GQ4QJSMqehS2wc9weWETM14qYr/h3fgNfIJt
         xnSMF2iXygIQPL2q0RIjD+CuRBkmb87sDUz2CUyDQsUuTSnnYi8M5OX3h3qjdAd0tAb+
         LPIVchBqD+/pW/j+go82+Zy6O649WnMonT+zi9ZewXtWkU7EJxU/kTvgpEaSbywTkhD8
         w1urYaczM0LslJ2OBKUBN6HYEBXag2rfi5fk5pWD+UCTORyk8liWqCMcwBUH9VXMk+C1
         0MpmGKkbZUz7UZRVl2EqhRVwkKvD8lLJRGoo3Vo0WKfmxzoa43CShC42a/v5+A2vyMSr
         bqIg==
X-Forwarded-Encrypted: i=1; AHgh+RrRv5S7M+Fa5LpuIRbwXW0OmZMedSm4uBucbkjTXJWn1kGI009dMxkFhD/I+cCTcnlEh386QdV5Eaw=@vger.kernel.org
X-Gm-Message-State: AFuF++mp77jQutAF5UJfDE7KCjVWw0bmUK2YIAywqoRpP696SMsxSGfD
	blJgMHGlalUHqIhyqsVMHVmmeAWwJiCSiDI22fXfxF+r+o+tqaVg8KXStpdpyRYspyioYMNzduD
	+gR8O28eytU73J/66IY7+2CPO7/6SUPZ+eXNAELFOv3zcrDpt+az2VlPTuWkuchs=
X-Gm-Gg: AR+sD11yslzR+SsiOzmco0jKeV/rNpbcdbWjAdOi9rCBwpyOrw+lJIw6V321x6UPIBd
	4NGk9OvIVogUaVgSi1L2SzHtRfrl1gISTC1Sub09YZ4DdmKMGaiOYMyApWia2QD5LnzuETvnY4H
	CxkIj7l4kCpFXtoKoeeupaIfJ7Eez41U1CfoYzR7eko2O4re2ObE8SMoHh+U+nVCAZzn+gy4o8J
	7Rx+kn8mg63heUomjTX2I4MgZcmxAhAmCxHcaSYHzrf481y5T21lA9HSNU4j/NHSAsc5aOxmCBb
	Pu5oJ0WPOQh0SEpJyUHa6RTFYiGn2vCnzgwdYVABlI7mk4Pc/fsqvrzfSHouL1oS9/zEb2Jn3Q3
	VtWNZrC5uezGdPekzn/V3yrRdLGBxKicR
X-Received: by 2002:a17:90b:4c09:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3966d3dcdb1mr15426102a91.9.1787757467957;
        Wed, 26 Aug 2026 08:17:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4c09:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3966d3dcdb1mr15425980a91.9.1787757467399;
        Wed, 26 Aug 2026 08:17:47 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.111.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39646138f87sm8381159a91.3.2026.08.26.08.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 08:17:47 -0700 (PDT)
Message-ID: <75e6979b-84ed-49ee-83f8-bdceef2cb464@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 20:47:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
 <d81d61fd-79d1-4bea-b93c-0afe44f9aab4@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <d81d61fd-79d1-4bea-b93c-0afe44f9aab4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8f039c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=MMW3c9rFXQuugNOjlkEUow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=rko7XVifj6BEHbDbj-IA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: a-lt0dH412oCzdjxU2aM6Xr33HAgsWju
X-Proofpoint-ORIG-GUID: a-lt0dH412oCzdjxU2aM6Xr33HAgsWju
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNyBTYWx0ZWRfX+F55Crnr1Eor
 anxwRJdWesl6DNq+OED0TxXymc0AuCnj49RKdXp9rmOnVtLk0CfSKExoDHDYsW4Qg7nwjnVnHWt
 UBFq7XNpteT0rn2BHoy383JXW8TEBMT53GNZTKjQRLP7sFa2VVS60veWntx45RSQuDaU7V05spR
 iOWZKtNg7xZsx/22SkXprJDy/jwu2rhJWJBpN6AKc9WFDqNytloIjx08ZeAArTUhLsPDK3a9b0o
 LFNANU2/ztSDuBtrtjeR7hnxCElmk2mxhNSk1ZXmN31irg0h/M+FFX7W7naRo2jZ6Opki13hTeA
 A86gDFtb2QxDCB0jgiOWiG5L+QzqvcU3jiKO5nkWEVDoE5njzxfp9n17R4cNDww1StQLX4/4fuO
 HSRnq0973mhhevc193+se2NhTRl7oRhT6FTrabPBJMudIH7KXiaK6TXXYsDG9N3fMc/p+oRbnJo
 ef/NYe3948qqXuyxWqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNyBTYWx0ZWRfX9VaRc7wpfNjQ
 +9PN80HfqraaJCDcKOe4vxAZj17wPd5/3otue6qvHJlhMYRMtPjxIKNn3tZCHsZtGFZtfQ0l3hc
 FnUlFkNRP3alPDIYqtDlbGAcmQBjImM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260127

HI Konrad,

On 24-08-2026 20:26, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> Currently, on the SA8255P platform, protocol drivers attached via
>> geni_se_domain_attach() treat each OPP on the perf domain as directly
>> corresponding to a protocol value such as a baudrate or requested
>> frequency, and simply request that OPP via
> [...]
>
>> @@ -1175,6 +1181,29 @@ int geni_se_domain_attach(struct geni_se *se)
>>   	else if (ret < 0)
>>   		return ret;
>>   
>> +	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
>> +
>> +	num_opps = dev_pm_opp_get_opp_count(perf_dev);
>> +	if (num_opps <= 0)
>> +		return num_opps < 0 ? num_opps : -ENODEV;
> if (num_opps < 0)
> 	return num_opps;
> if (num_opps == 0)
> 	return -ENODEV;
>
>> +
>> +	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
>> +					sizeof(*se->clk_perf_tbl),
>> +					GFP_KERNEL);
>> +	if (!se->clk_perf_tbl)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0, level = 0; i < num_opps; i++, level++) {
> One iterator is sufficient here

level is not acting as a loop iterator here. It represents the OPP 
performance level

returned by dev_pm_opp_find_level_ceil(), which may advance to a value 
greater

than level + 1 depending on the available OPP table entries. The array 
index, however,

must advance sequentially for each populated entry. Therefore, separate 
variables are needed.


Thanks,

Praveen Talari

>
> Konrad
