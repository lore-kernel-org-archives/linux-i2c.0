Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D93358B7
	for <linux-i2c@vger.kernel.org>; Tue,  3 Feb 2026 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121439; cv=none; b=CFuVAdFvf6fgGeHoE5HYuJAuxxLLiCy30fb1D9mHmWJBFot3hU79+1kx0HkvgzZyVs1T9G6E0eLTRa9NAxgx8yA0XWqctr6UYRTC1tBzwJPqbZDU1A84yp7sLhb+j3A9wPSzVIkKmhfQTqhBYq0OU6Y3k4cnaP0l1Ubz3W17NrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121439; c=relaxed/simple;
	bh=1beno9bJ66kwAx9wlruDfw1G3tmXkab6b6hnYrIXZ0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djdSzzXhtotYm6lJRQbCvDGNaHmQRvFdRHx4PYZqMBufkax6KnQ9LFvcICXdQ1Ssu3/kQmR53k1qO9+4V5qI+1GXXxJnWlBqU5mnKi93xbqVH0kBnoh6EXOMHd0c4utMlOPoJ2i5bXzetAi7ayfDH6rRz2/ZvU0gDXjQc1sJCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEXxhyiR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CMZ3oVZf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEXxhyiR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CMZ3oVZf"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138nxov848943
	for <linux-i2c@vger.kernel.org>; Tue, 3 Feb 2026 12:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYO3cR/k1KFc/9QYbB0PIjXcwT9hHSS+VNzE2GCCgfc=; b=EEXxhyiRJfZFSbZB
	ajzLxTCZss5ndJE2qW6VtPKK8g+B44amSCDEsbDTaikwDjlUsvnLQ6Zwq8fitPvO
	DZZPGjXUvxZpj4st/oQOfIp32RVOTXYrgJ/qb54ytx8ZPDfRC2ZqJdo2ta7n7TLn
	Jw5boOaealA3fgOPaNQdNbGTm9K2FkiOkwa9yCTGIXgHc5hbUCwQOSx5oVsGIK4B
	ckwnFuT4V/XElfYaHcT0z3TznEnciJQCsHn3PyOi4H0ds8oLx4IxmcCIF17wO4IL
	5V+hIZiSlNaWOLVbzgst7lYFDXkUekyp37hoRxSGwZW7uWjqSxS1eUphEx2QEJzX
	A55x/g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3dutgn77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 12:23:56 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894662cba4fso13960556d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 03 Feb 2026 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770121435; x=1770726235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYO3cR/k1KFc/9QYbB0PIjXcwT9hHSS+VNzE2GCCgfc=;
        b=CMZ3oVZfH5p4OTvp+N8orfIiyxcv30PJN7APWCIz+bbMRlsDVNvaT51MGPT4Ql5CFm
         k5K3mJUqxdVinvbNCkvcrn+90uI5YyP7AqySi3S+zkchHSYBKDA36QYEvWoO7hqW1mXP
         M3/hUrrP7KzkDTQCQmP2HB407yj1hablwwcVel7sVzpFU7GEfklnnSdo3y4MVYn1ARXi
         4CZjcbna135j48xM9eGIMsXSPzySAEH8/Jy63OnpSf+zIdHqW96dHwywHTyPE/5MFxhE
         0FsadUU5wYtbBSox38G3q9vYXZNvIGZ7CwEcOEledjAKzegwxID3+nEj6AfeiQa3Ovb9
         ZAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121435; x=1770726235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYO3cR/k1KFc/9QYbB0PIjXcwT9hHSS+VNzE2GCCgfc=;
        b=NSUyC/wNQ8Qmj4RQP02TLp2IhVpQmjTi9ArvMXzY2MgaZKXA5IS3PKTzU9cf5pk9F0
         r4392y7xxrCB7oTT1y6j/6ZEQKFa3sLin0OCteNbk6l9qZ5mjIkhJp5Kf1oIgmGbLNum
         +Sd19JurY5Kp1c0lLHyVblX7z7QLcm/dzNp7p6tNayGNPOuUbDklP7RMcY0WnpCr2VQS
         dKLMhph/9+GE3VFogddTnQoHhlWYdhpSlfO73hBCjxRaFYxeTdEITrlnrjdkrHcrTHsD
         0OqueFdDUUGCUylY8VRDsFo2WzVfVSN0aPSaV8WMy3JFGIlUap4LOxyvHEY7NtzLdA1p
         Yg+w==
X-Forwarded-Encrypted: i=1; AJvYcCU68hShZtEFl524SFsNL746ziaxm+JV3wHOJzzqiBupKMQNs6vAEipqbNUL9K9rV4KKQwUSM8bCixQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyef8GjrQKdUEHipDBogxyXoKNiH4JIjKYfUo02aa5I89B4VeuZ
	2G6y11JesP/48XHnbKn/DkVajGQxPAzIi3y6CdR15oF8p5Is80tIMLxO8FNfPQNI1KsD5eMVBTN
	6/Xwmz80F1gd7/6XjaC+1vIAw7tN8zBIROLMKbwKPaHIOru3QkuvAAPLYNLbJnvQ=
X-Gm-Gg: AZuq6aKkR75ADdkJpgXIDW7cXrdRfpC9Ikat4fTF2rK0+vTxxlaOP2dMwIC2c/zE4wU
	q6Cz8w8asr1wUKcazFU/hKLuEiOgoysJrK48zE9sAII3IpcXtHMY7gtV0N28r+CNJmXy2OiAXJJ
	mBoGnHE/1vDYoH1iJrkVvC34J7pfkvEdk+WFOCr5qrtPn0tc0ySVzC9GUpB53Ue0MzS7DNBi0UU
	rE1gtOQrgd9GQxg5kQmaMNOOdeRjoAOuBYSI9gGAkcn3Dz2kFs4/adjJS/F5HhYzU4dbrODthmL
	gxJE5vpBGYB/M4jFwESwGDJ4se3CtYnb9LdMPVHNYP1dVGbtkeaWBNfNy3NHZGjs/xuD9We4FMz
	W0kmyc5JoAtojZGyfRYfGKeVkZtFCJCcIv0XsTAyoWbAe2LiYDpiZwaJ0SQmODox7uZY=
X-Received: by 2002:a05:6214:4d03:b0:894:6c97:691b with SMTP id 6a1803df08f44-894ea075718mr154409156d6.6.1770121435513;
        Tue, 03 Feb 2026 04:23:55 -0800 (PST)
X-Received: by 2002:a05:6214:4d03:b0:894:6c97:691b with SMTP id 6a1803df08f44-894ea075718mr154408786d6.6.1770121435029;
        Tue, 03 Feb 2026 04:23:55 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691e53sm9060151a12.21.2026.02.03.04.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:23:53 -0800 (PST)
Message-ID: <2d2bc77b-715d-4484-86c4-4389ebb63856@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 13:23:50 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] soc: qcom: geni-se: Introduce helper API for
 attaching power domains
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
 <20260202180922.1692428-7-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260202180922.1692428-7-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5OCBTYWx0ZWRfX0vjKHUhTSo+H
 z5eRMr/+r8Di5YVAexewOQNqNlPDmlL15yCOizI/oNX3xP+HIFGAkUW7CG6ND2T8ySqckNbPTL7
 E5HnyFoP3oQ3usG4YlFsPluFxde3FHdHRIeNGw2LPZf2lSaJtf3Xqk19xgX5pa9jSIsTrtA0XL6
 M3H764HjAfc7tY4e45apKfn/7K9PgzGTF08E3KD3pB9LSyPdKBAeHVn9SLOHVWrOedPJuIHqbp9
 jz4uUKvKQh8yDNPHxqGr14vECm9SwkKmBj/oTlD4cG3HSG+R9TfF5JIepfMiR0Lz0U8/PXCytB8
 hiplw7MVudGCQju742T6wTQdFOB1qQ/3g2PIQlVxL/DpIllHqXa3jPs+HtkFVktme+hicJbbUIu
 UXT+ezcJ78qGAEhZeUdPs0JlHmRlNy8EcRuLdErA79qBnyYK4SI+Hh3Uw9K78mZ7NhvU09/XDEr
 5CPiR2A9C2glZlnvDOg==
X-Authority-Analysis: v=2.4 cv=FrgIPmrq c=1 sm=1 tr=0 ts=6981e8dc cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9pTQncvtRyGiLAFmc8cA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: KO4n7kQ5TM35c6aoGkPApWeINqD7I6rU
X-Proofpoint-GUID: KO4n7kQ5TM35c6aoGkPApWeINqD7I6rU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030098

On 2/2/26 7:09 PM, Praveen Talari wrote:
> The GENI Serial Engine drivers (I2C, SPI, and SERIAL) currently handle
> the attachment of power domains. This often leads to duplicated code
> logic across different driver probe functions.
> 
> Introduce a new helper API, geni_se_domain_attach(), to centralize
> the logic for attaching "power" and "perf" domains to the GENI SE
> device.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

[...]

> +int geni_se_domain_attach(struct geni_se *se)
> +{
> +	struct dev_pm_domain_attach_data pd_data = {
> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
> +		.pd_names = (const char*[]) { "power", "perf" },
> +		.num_pd_names = 2,
> +	};
> +	int ret;
> +
> +	ret = dev_pm_domain_attach_list(se->dev,
> +					&pd_data, &se->pd_list);

Let's use devm_pm_domain_attach_list() (notice the 'm'), as the list
is never detached from at the moment

otherwise lgtm

Konrad
