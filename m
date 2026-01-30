Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8B30FF3A
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769775099; cv=none; b=oMOOkwkb38s4V0v0+P+5u70zDgXpRSFIdQB6JwKdBg/nCE1dWjx9L+2Qn2e1cyk7oWQtpl5sPgyHXTVuIU+/jyH6TCxY9OHyMyTDWKpi5QnWIopLNhl0CnlFrIPrZpM/CWKCZZIXZMBKMKBnx+zn92ByY2MJGW0mVCLr03GBqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769775099; c=relaxed/simple;
	bh=3GSdMKdwN+itJrF8aikP9IngQ/p6kcunKAal99y/xbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZD4YlmVT22T9D01QnaUta2iRvLT52OaJVaJDsDSW0At6cy3OyOOVwEH3tFkNjhf2+tqcYYuTxpTjqUG3X/z6YTjaPQw9QusM/T32jjonSP0z1tSVUh2eoFvpgAVopmUPOvvB/A68ZLubAoL2MdR4ejUHIwOCQNXd7SMV/VkWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=osY1sV75; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OXb60wLt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="osY1sV75";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OXb60wLt"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBdAAh2993795
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QML/ROFYsRa3wCAhgii1SBThLnaFW/W37txI0arbOqk=; b=osY1sV75QR7fChrV
	TH8jz7Dy7Gd2IniTB6Y1nuebWirl6RZZ1//eWy9troxKu2tQlsLPedyCxGixSd9W
	+HHKK9IAalpzmkf80s9OT8pJHDrshDXCDM5g1RRZydXO/L4Ik1dPMw3fNhSWdzXd
	sA3ZL10x4i0f/SXfJL+AFfpSGz28BAHqpG1gKtI9K9qb0GrCnw6zGhW0VHiW1O5T
	6pguIRaGB9SgWXxzWXWq5obcalM9NiPJlngeHtWDhnWC1Ifm4OK/7jG7TBN0IQ1B
	EhSo2VG/XJSGgMiPBSw3QzsRfqo/SrEnHuUmIyVBIrWvSJGnDneYHhEk0lZf/y4g
	Eu3D4A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0db1jqst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 12:11:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c536c9d2f7so17106785a.1
        for <linux-i2c@vger.kernel.org>; Fri, 30 Jan 2026 04:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769775096; x=1770379896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QML/ROFYsRa3wCAhgii1SBThLnaFW/W37txI0arbOqk=;
        b=OXb60wLtZI+ZY1iHme9ktWazfZXKkA3fQnRCde8NogaSvKlrjxJzxny0dufv0bJWyM
         wVfIfkYhCeJgDe2u0vBUL9J1bzDDlxXkxzIN2i1oSOH03f8DRHUWSbPFzItMt8RnvSgP
         QxXcKMkHb3ofxcwGn6X4kNxRgElvMNbh3BclUW3cDyuE/OCRGeFsSf0s8sJ+LCIXY3rr
         8xX5bL11VVmuBPCJ7hk6d/7Ll2k0cdBTM4OphuNaBuXMZZFIrR34wJhAqLpXz16HU+Fd
         0eFaMFVrvZA2pUVa8I/nCDoUJvtSrZfIHUzGRzLlUkcuZv+kkC7JRmfWE45/rMGrPe8B
         700g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769775096; x=1770379896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QML/ROFYsRa3wCAhgii1SBThLnaFW/W37txI0arbOqk=;
        b=SwB4QHpxjR1wlNlXdD95+G9MC9Y5fIaLgh9cYWxB6Le0T+CVhaejoGK5t/2wWgOtGG
         J33pClbuQHXH2vZoS1GooEoQI2vMMrsjQChSsKK6Bv1h8z+PCG5zIsappHKXHgzYlwWX
         o+naIDW8Ws0GDLDTO/CW9acfVqaiNMoKI2WDdoQ/hWHKFaPWHF/O+V2N9Ha0qr7JKJ6W
         W6+6Vdx/C1jq3qj66tVIyiZymUihes1817s2mG0oXWcOLPg3gt3WVINVT0/M9cJ6ZD3v
         RcJRhZaUx/RemQh9sTrxxBangC1s+S05RbypTA83r1TYuRLHbNcOEX0vMxyMpZrkwspc
         rqFg==
X-Forwarded-Encrypted: i=1; AJvYcCWmaauMKUj+kW49RFvyfe2WylTcPnqXhbJkzxJLABh5bNE6XwvtFhmELwxF8mVVE1fkRFuT2BMiaTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVySl/o1sLfvU+i7OyCs/idf9fqqt34EhyNrvB7aW3B8jFtEWM
	7SpaDgQMDWmPqrLzByJfHA0n2mNl3mW9XDu8UnCiurFBgMxcp2JFAAJiGVvJVeS3HmOzgoH1mUD
	d0hn1BH8Ju+MWIQNgGfmubo6TraUktR5olBXnIPJJ4JahC5KO5fG7p4Kp8UpoxCc=
X-Gm-Gg: AZuq6aIiENatDoWfks1u9BtQQkweK/3UCnUM8fW2+RSO6BatmIrjl6g/RrZPAKnR/pS
	Bcd9hNa3HhlglOaHktbUp3WdvqLFia9pGxK2V/768skMyQKR2h+WPnVvlPTtwHfY+oygoZh0gx9
	2+t+ILsVfJn7uokgJnFhDO/vQB2R9GD9jYCydFRmdtsAm20nl12W06o7tCyr/xc0KLPzc0Fx8rC
	ib6DTD+OPmI89B4U+AnhdfCtp7iohvlYbge72rpsOusWY8SiQqKwskwP+yLfxw9WOqvEoraLEmh
	4jtNZxVKdawliVUYwWp26C3I9b7vbj4P7y9mgvucv/b9VhW0yab+nh/0N69hSHiLdGJwD8AMZFE
	zc2wUnQh2lv/JUFv2hCKHL1rj4+Qqqz6s4lSHKuyqcGKac/Y5fyYVeJ6jTmRU1obZxKE=
X-Received: by 2002:a05:620a:bd6:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c9eb34ff20mr277197785a.11.1769775095670;
        Fri, 30 Jan 2026 04:11:35 -0800 (PST)
X-Received: by 2002:a05:620a:bd6:b0:8c0:cec5:148c with SMTP id af79cd13be357-8c9eb34ff20mr277193885a.11.1769775095204;
        Fri, 30 Jan 2026 04:11:35 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4256a35sm4087136a12.1.2026.01.30.04.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 04:11:34 -0800 (PST)
Message-ID: <ae4eeac9-701e-4697-9d76-931a6659e7d5@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 13:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] soc: qcom: geni-se: Add resources
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
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        dmitry.baryshkov@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260112104722.591521-1-praveen.talari@oss.qualcomm.com>
 <20260112104722.591521-5-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260112104722.591521-5-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: N7-7FQxWY3rWyvejxqtp90OE9bNmPxD3
X-Proofpoint-GUID: N7-7FQxWY3rWyvejxqtp90OE9bNmPxD3
X-Authority-Analysis: v=2.4 cv=VMTQXtPX c=1 sm=1 tr=0 ts=697c9ff8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fehRvCu74lOKQ2FmR6kA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5OSBTYWx0ZWRfX/GTxMstEEVBn
 2IfotFdLD7TWtT37u4XKZnZoVL6zZOkxqSkNKzCFjsiPKt6FxlMOXbee8pv3S7Y8G7At2w4Kbhb
 0Vmy0A7rH+pw7jzCGdAjnGSzDQdpDaM2i/7dn6kXHLeo1iNfdI9J4vRyMPBLf/tfrN1G/+bdR+4
 ucFuK1wufDEJMB7bHfYxwVJFPKQSCqfTHA5EnxxUIWknmK5bpylH9pNFuX30XDpB0a+uqhdye04
 3TYlYVoZ5kM8LMjcTG/f+02hzXH9bCxy+crJ3lOVe9/nq9xIdbecyqDqUO2Llpk/g8NyuZaGM1F
 5YKCJwe/oIM3DnepJxbW9Pmv0uu2oTrqEXx0B276/+Vli9NNAkcEAf4H8bcR39JyrmX3e0hGiTw
 4Tw4ivoGBtcQn16MeSmAhrCxJUtGcbBhgzAIPHNm1dGADJye8rMnJhhGDlEHRMLP0hzY509dhWy
 MIZzDtsgr71Nf3lQLcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300099

On 1/12/26 11:47 AM, Praveen Talari wrote:
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
> +
> +	ret = pinctrl_pm_select_sleep_state(se->dev);
> +	if (ret)
> +		return ret;
> +
> +	geni_se_clks_off(se);
> +
> +	if (se->core_clk)
> +		clk_disable_unprepare(se->core_clk);

All clk APIs already perform a null-check internally, perhaps this call
could be merged into geni_se_clks_off()?

Konrad
