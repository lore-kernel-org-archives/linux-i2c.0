Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A826334C27
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329365; cv=none; b=dNv7nYc6ftYRchQ2DtNd3zqK2seHm/sK8/xy9tTPNji8dXtsNfCePPfJ9pNhV/pO0mUZmTW66oaLsoPzVTKF4m4pAGqH/om26BeVxQ18C9I83+vnCeYLryN1RN8NQhq4A9aOLifaWA884m6is2gPjwR/qKNj7KAsJpzP4Jq8U3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329365; c=relaxed/simple;
	bh=IHpTnHZt7SzXUK/S7kX+tVLZoFmFUaqjAJBhLbkKzBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXbNtZ0gAarC+EnVaPlL9wHDCmYHS+k1xNQVV/mJQ9mdVEG8OPKacgjW2jDMjwYPdo/IVN6PnlrLnJ8Ys7esxwZGFhY/8gVA9oMqj+AlZxZJBKpXJeTU1Gou9ZVSBTdvMQrMud/HNrErOFWWroIB5n2WRR38I6Eo5m+owMqJvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrCXI1oP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vtqkiw/u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrCXI1oP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vtqkiw/u"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBXuqt1787522
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ci8ERzFPh/SxO4CXB6i8rjaINK9R5am3AqF7jJdUFgU=; b=IrCXI1oPXv0C4YD/
	fGzBQe8+C4rOxiuk3phBVlrbX2VpvjvKDwAMO3QHJbo/1ORm7CYJ8Z36LcDfah1f
	RaPk4dVYPvQynlvLuhv3N5bXyfeVJcCfin63kzGra9m09/lF/K3LwGXbl/zIXKTR
	yJD1m1B6Z0dYfH0csXLxIqBmodn1+hNmLvG21TigcwOM3470ks0IB8z7jkiJwO6L
	jaxPNp7/nBCmVTn9BiWv7vkUej+yB68dtnkhCGpQQNyEDNdV37qDdhG5SXf04mIJ
	XJzjgF/+pIi5KZNVgS1XLKbmP+F04k9te7h1RX00Stj/Ym0fCB6hCUED/GYnzzAb
	m4PoOg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc7ap23f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 11:56:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89547ddf32bso31161546d6.2
        for <linux-i2c@vger.kernel.org>; Tue, 17 Feb 2026 03:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771329363; x=1771934163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ci8ERzFPh/SxO4CXB6i8rjaINK9R5am3AqF7jJdUFgU=;
        b=Vtqkiw/uSuD2dPaOepS5CNZmX30OlTV9znA0yWd1N3t6BbCRSoo3PYOuLEtcVhgZpU
         5xIc1R99fUs0pQBkCdfAVB+v4EBFnLvgf3ptnzZSe/q4onHL4tvYhwJZcZ2kYPyXg1O8
         aT5wBKdsL8y1L//mZVH9Un7jQzwlYRWKXbegiuX13QD9yk4bUsWR9ZKoLTvSbX2g/K9Q
         E1QulsBbBLNjDBeecZYScwfzS/smPAYEVe5UjWPVNc2S3e8J1YrF+aKCJ2pkgbWiaLq4
         Y1mxAbhU4Z3Q1szmSjxX9MhiXTj0cZrKuTh5v3+npsNAaLUBRiDh9JfeNqhDaIYCuC2y
         4LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771329363; x=1771934163;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ci8ERzFPh/SxO4CXB6i8rjaINK9R5am3AqF7jJdUFgU=;
        b=ja4MipoQ1RpDXW+ibSQrNFM11oyLPvaPQBv8gKepUamsVl9S04L0pDJ8tpnIEEFUEL
         xhamI5uehPA19ynt4lND8a6ic0T0US/+gwp/8K/GtobkB3Sj8B309tEhW/2e+8LbJUIA
         AQfBtREAuLmMrjLJ9oJbmTTb+mPNBC/bLmLPBuDgrpJqMG2y/Lm8WbNYTJYzM2SG7+qW
         mJlX4U8nsgmO/6rCRKAJKaXdQu/s4wkdWOpCbipZ1lQA0KAUatJodGD7nJSTXQW7PQ0Y
         IqvlUf3koGeC9YaalaZNYlQ+Owtekcw0rkqDxcGGHNseLLx4Rx83auT9s145hpVifp5r
         WmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBPAmwXk4jgHt+wao4DkYx37diT6YlmXaQSwBjyoKUuymHvZqUEBYN7TqxWglu7M6V2ABV7hR64n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGNLHdKRAF18BOjMBY06kwTKyy44gz0HCTKybdt3hPqL4ofeRu
	pyyMdDnpbQcuiuSVpatFygOWuhOLHdAM/9pJLcdfMk4X8pMjyTHZx3lps/jG39bwrKfJJG2aOi5
	XJeaZ1dSHoZ2nEMdmFPWajRI64/+C39OSRRB/tmLoRTOActcRFjGKxllHrvbMnEM=
X-Gm-Gg: AZuq6aKieJHjpNDVvQkPoIrKDDdVGAKrps3SWbHoieV6BWvXpdgtnGTBVWGI6Ct93SP
	MuofZrKrPzaPBt87mkNNnr30n8NqFZwApSoL6HdgFUVn0VZ3P7xU8DsHzxfUOEos+5gUgkNwBHE
	gKZSL0044+cfDv1VjWymyy9UZbBbM7eDUgMPV2LiWuYpuihUvVEURwoPx/uDzJj75PnH+13hD13
	wpvcEHuY27d/o9i4U0RIm6yizbsRe1nRgPJPEeA0iYKS3zu8MT6jSjdscb+YQQwDe5LNbFBjdV3
	P8vPQTtsdxssqkZ96glRnbvsAv9zbrNK1S7EdWfzoOtZY72+xYvN35vCetCV9RbOYFzlT4K+Wim
	Bnav9huk9+3BWyVoJfFk2quTq1nkFt91TIpj35wsWmb3i0PRPupppJLcvqunZBjlED8Q+VGSuuI
	aK5sM=
X-Received: by 2002:ac8:5890:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-506a67af949mr130225771cf.4.1771329362569;
        Tue, 17 Feb 2026 03:56:02 -0800 (PST)
X-Received: by 2002:ac8:5890:0:b0:4e6:eaff:3a4b with SMTP id d75a77b69052e-506a67af949mr130225521cf.4.1771329362067;
        Tue, 17 Feb 2026 03:56:02 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e39ebsm2333308a12.18.2026.02.17.03.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:56:01 -0800 (PST)
Message-ID: <8f52d9de-2639-4bbd-9ae1-4d55ba13422c@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 12:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] i2c: qcom-geni: Use resources helper APIs in
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
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260206174112.4149893-1-praveen.talari@oss.qualcomm.com>
 <20260206174112.4149893-12-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260206174112.4149893-12-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5OSBTYWx0ZWRfXwDKasRb1IjHa
 xQno1sbInjEfcaKVRYBywGk6SJ7YKriTBs20zHcnG73hR7C20JeF6HTYHofzjElpSxpaFT4R2r1
 rgcW7Td9uU2U8doKPTnRCijacLa8uUezhaJ036MZDkgMBgrQzgJ63LT2HD9u/JXOGhgMaqCQpj2
 91JsNpVEIR4sQJCZNT/nEduhXPJAtCPmXPmLTZHXAAfUhbOe9sPFmqOHPnnhUDg0RJpdDtzaokQ
 x2IKOfXXZpDqFPQlF0OtswRTJpqQF1F+gDDbTlGn5Svm0hvGtWJKcEVUItXgZVMucX86rDfM5an
 MCNEZnZmLMQzr2DRSZmBtxscTwFr+Yr2yPsuU03XACtSB9/FTVL+xMWxFSp4eMCq8VW/0qY+LOM
 THfdpSdR6h4B2KEMWfCP6auNGSr66k6u3HJfzrFW+/jLeXqGpJjx52cVRXHy2CKkaX++cjHQvBD
 X+Q0X856T+TwxX7Iy7g==
X-Proofpoint-ORIG-GUID: x6nyoG7I3S388O8y5OcJgsBr7APyIsxb
X-Proofpoint-GUID: x6nyoG7I3S388O8y5OcJgsBr7APyIsxb
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=69945753 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=gzD-2WDeCj_JQFVUwcoA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170099

On 2/6/26 6:41 PM, Praveen Talari wrote:
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
> Acked-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v3->v4:
> - Added Acked-by tag.
> 
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
> index 05f5705b0319..0ddfeef6d1b2 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -1160,18 +1160,15 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>  	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
>  
>  	disable_irq(gi2c->irq);
> -	ret = geni_se_resources_off(&gi2c->se);
> +
> +	ret = geni_se_resources_deactivate(&gi2c->se);
>  	if (ret) {
>  		enable_irq(gi2c->irq);
>  		return ret;
> -
> -	} else {
> -		gi2c->suspended = 1;
>  	}
>  
> -	clk_disable_unprepare(gi2c->se.core_clk);
> -
> -	return geni_icc_disable(&gi2c->se);
> +	gi2c->suspended = 1;
> +	return ret;

Both of these functions can now only return 0 in the last 'return'

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
