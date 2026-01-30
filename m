Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C824A36C58C
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774733; cv=none; b=DKAUqYW+WiFamE48B2H1OSzqDO9aztBU+4y5udxP0V0yoyTtwGSeebfABsEopi/rIA1omGNHt0dRI4jjPke+qyr1m/aBec8bes9tbilABs2Sw6LXRlZBEFFdQsIN+hw4CmScIHLOxRqmfl6bivbEpp//Hsbb1q8h3+wu5fcH4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774733; c=relaxed/simple;
	bh=aFC0zeyoW5t5zvTuMz9rGwaCcw9cyjn7qR7jI7+2euc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX0IT30/siK+mQHeeO44jWCtpBhzqoQG6mvVUUPuNYEkridI2oJbg7/ObH+HbjnULikvKe0IQ2phRlW+9jWYkDZzb7X8UhmbFoJj8hV0lHryhlZny05bvJ8UwKLKesckOod5Hy8Cw+nlXmoWsFlRcWzvYcLm1X7FpWInhSgQMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Im70CB4y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UbTVwpHS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Im70CB4y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UbTVwpHS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBra0g2294942
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZJZ5UjJQNNupcjkDwCIMciIXXm9F7RB7VuIIvWO2KnU=; b=Im70CB4yRaEL9v9N
	FGrL6W7SgVEDc4q52HBfrqTR75hqdrlKzXlFDjICf+Bk2quEvgABuiiSsG058Aam
	1RubjQ8pK8Es+V2/SeQjH7W/lnHc6AzOJCSWJyt9B5hSSd5j8pYw1Oil9ErNshVJ
	XuLaFXcSnZx7exXoAtdE4VQyNUhFPdL7ZqdkO6J1K2DbxXEemWd0xA3xZe7N3Ai3
	jgaEIf1PiKY5uJD+Sas82yIX42x6cfOVd82sDXbYJKoC5diMf/cqMNai3qzIYhm8
	JKYSCUZgww6YUYyyMfqFi/lzRYn7UDvqggdtjnwNmtlD/GdzRKCwlJz1Ky7xCXjY
	KztCtg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p1x96f8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:05:30 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70cb31bcdso49558085a.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769774730; x=1770379530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJZ5UjJQNNupcjkDwCIMciIXXm9F7RB7VuIIvWO2KnU=;
        b=UbTVwpHS8uue+Qmx56ANI0z2wy9JT8WmrJ4iWCqayNMzmev6uCwpNB2xX5dBI20qhm
         g4Kdl7unUC0dojev277MIoiqr8j2ycqRAYoX5IJKithsf5XBzvfe3gALZBwiqkmyhhyo
         n6p7ZW8NizRpTWRs6YoJPhSseG/eTt7FUwHZcQjGur4cU+LEVl5jujoewoOtBSxK8+KY
         G+OodNUY/VHgr1gZqYRf6U/SuupvXbcJdpMJ3fSpa57+DuXoaG45ij7iOB8ng4PPoRf8
         Mml3mRh4rXdcW4PV8aVJ8luQS0D8w4uDBvKdzJ7Py83riJe1HPfDDz+Cd4pxKsqVYxO9
         PMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774730; x=1770379530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJZ5UjJQNNupcjkDwCIMciIXXm9F7RB7VuIIvWO2KnU=;
        b=nM4CD/MDEqWPpBAvl/OdacDG3fhEMnPj1JIqe+FYchQn9s6SVD8HTtzrhJ7FzU2dfE
         j06rSCewv2oVFMoT0UM7NBIaJwant3+knBJ2W66Qys9BbHUt/nRxB4avFdU7EcerEVJt
         xYAeog0IEEEfOsdQHRto5V6NrKyLgXAnDTAJ+r1dpnkGt6rX6Ss8hpr3YXrnToBbVvd9
         jy7qC4iEgVLGNf0cWTKSai8UNoVqSwgLTuIKeH9QdJfdsabpV7wZPiUnNSUVdy/YS3BE
         U0lurEH9dz4FpH6R7eHCkIgaQCzCKPDZxBUgEbunXWFoJtQ9jWaAdTpX0wgHJvNHLy1p
         te1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9PUsyZDWpYbYQaHluFiHJm2jQazPh7PYR9QdWCKCC+e3znApt9Fge8mF14eNlcX7AbswFpx05b3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8SrmWhipqF7AGijcva75wHf9TkWsq1g1TOTySpFVn0GmPbhX
	S6+Vaq0zrW3Ny9pB2o1b50VZ+53pgCZqJAmVVdT8/Pp6X/Uy7/ZHaUozWBWr6hQAv9nSKVO7zu7
	3zfeWU6EkFRVSBBB4ULNpxOSBFsuHhsnPwUl8xmDEXJjfbdK4CwNUM9ecSJy0dQg=
X-Gm-Gg: AZuq6aLgRE9k/QQUI3+I63LJG7Qvq+vcx1UWZ4/68YTTDGi4mid1qd+G3P6EFAkEW+J
	R+3T52/kxr0zRkClMx5kmvoAjlQksxjwP4U6VdvpdRntyMt0NEXfl1PWoHuRXdcMZ7JxLqywGEz
	a8w5nrHuI/7AKHkwyKdsSSW6jS6uJhUcPgK1HNHX9G8NGEE2g8cUvdpmPn+IhDhEn2x05Ok57ih
	78AtQoFauNCE5POUw/N97Jm3Mjqc+ToYlPJK5vro9vmHZGvYUoF8+6J7PxsGWCqgddnBIxob7+D
	kfrF7nwYlJhatveIt/ImO9bkalPCPg+hKPMkL+RedUlY4ee0BH0DKo1grMw5sIRUHODEtBiEki6
	HHyPo6EwDPOdbKoINnjtzfZYIsU60m7UUcHWER6sthg8msnbqi0tk++/J9k7lisuaDXM=
X-Received: by 2002:a05:620a:1a18:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8c9eb29d0b9mr291471485a.5.1769774728835;
        Fri, 30 Jan 2026 04:05:28 -0800 (PST)
X-Received: by 2002:a05:620a:1a18:b0:8c6:f7ad:49b with SMTP id af79cd13be357-8c9eb29d0b9mr291467585a.5.1769774728347;
        Fri, 30 Jan 2026 04:05:28 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fbff42sm15630051fa.45.2026.01.30.04.05.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:05:27 -0800 (PST)
Message-ID: <ce78b376-b581-4053-aa23-4f41ea0d140a@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:05:21 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] i2c: qcom-geni: Use resources helper APIs in
 runtime PM functions
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
 <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-11-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vb9jrbHVXXzLD_sKVYVdtT7DArjc-MYB
X-Proofpoint-ORIG-GUID: vb9jrbHVXXzLD_sKVYVdtT7DArjc-MYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5OCBTYWx0ZWRfX8NAtWZaA3fKA
 eHOgkhKn8Db07KqrQkmwG2a9c3o/MfN6IKzV7VDyTSbT8fhIMm9SKxyHPiJVYQyzJvi4pUfyBKT
 6qfjXNuH+S+hKAeg8hxX45jSTPRPMBbWx0jLUVTnFOwKrPfHAPUP3tITkpqeKGQgLOtm3k1YrZ/
 AkwVD9DzE4LLdB5i8U0+SEYwhcRy46vv5BGkG9FCbAe2eJTWHWmT/BhN/o1egDunVGzBkNtepfw
 ZR8k9cZ7yUBcPwMZSgXi36I7q9w7Q9AIhUzIXFEyOFDEdNUlc6xRPxYLu3y1HKFcJGuXSp619kM
 aWhNcJi/mHmazA6Jy7peBY5ZpFHeyAMgm8ksjX3E6NNxpKf3uOWVFzISeJru1JNBeXMsO2VHUCI
 wdXDlDidaX8fMzkBFR31khsXTmDwbFqPd11K56pyrNGKaUA9+WVjVhHEhy0X03QQx0psEfOZm4H
 fJQPliLRr/Ib9TOjoQw==
X-Authority-Analysis: v=2.4 cv=G5cR0tk5 c=1 sm=1 tr=0 ts=697c9e8a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gzD-2WDeCj_JQFVUwcoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300098

On 1/12/26 11:47 AM, Praveen Talari wrote:
> To manage GENI serial engine resources during runtime power management,
> drivers currently need to call functions for ICC, clock, and
> SE resource operations in both suspend and resume paths, resulting in
> code duplication across drivers.
> 
> The new geni_se_resources_activate() and geni_se_resources_deactivate()
> helper APIs addresses this issue by providing a streamlined method to
> enable or disable all resources based, thereby eliminating redundancy
> across drivers.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v1->v2:
> Bjorn:
> - Remove geni_se_resources_state() API.
> - Used geni_se_resources_activate() and geni_se_resources_deactivate()
>   to enable/disable resources.
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a4b13022e508..b0a18e3d57d9 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
>  	disable_irq(gi2c->irq);
> -	ret = geni_se_resources_off(&gi2c->se);
> +
> +	ret = geni_se_resources_deactivate(&gi2c->se);

This calls dev_pm_opp_set_rate(se->dev, 0), dropping the performance state
vote, but the other function doesn't have a counterpart to bring it back

Konrad
