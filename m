Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DF3DA7DC
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041242; cv=none; b=AroItOIzstdwZ57Oj3SNC2Dkdf5oo38yCKJrwQ9jRsktfBtGhqLg8Nlb3kTvWGzo1pdN2mFvPJvNpCHLU3fSvDFN5Z+TB6PtZ7Kpab1TPA0mZh22I5tpovddDDRGG8Nskumen8nPUJPA6yPevNuHznrUjJkfKaW3shdtjIL4R9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041242; c=relaxed/simple;
	bh=1Q3nKA6KNvqRtkmwyNL/Y6jz0H/eCXypkz9DjWJc6Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPRI5v/EBrcQTpCrf6ema3vRb/8EsE3yycgzfOEm/ba338o/Jf/KsiN8KHX1UqcXMSRw/kLfkvrfgVc3uaxS37MA15pOXjIEfU7g7W/lkXKgh5npSCAG8rsWiAHZVjXcR2vjyVJ9qLDC/STRL0fmiWLmMfgFRzQsSVs2xEMRrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ieuOe3H4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OTkzn7kM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieuOe3H4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OTkzn7kM"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F09GUg1672554
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rcqLN3W0mBzYaprM7xFw8O08UixThBS1YjcY7/7xA3o=; b=ieuOe3H44msy/Bs1
	oOmfp5ipRKg8d1FKAnX1CyjOCaOJxhVqSnC7p2iDR/IHpMg+FSLfeGrhBL0LVGJK
	CGPxxWrd3dAWSd7d/l0qG6XvNWGjvCE82Fr8hxAuG7YoUqWI1VhCPx7CTVy8h0li
	ttaxt3ZqpgolJI6D1a8jT5GKSU6+wDmplSAm8iuWi75m6iy+kob4vjZCO04yvFsH
	Pex0/sz3UYcy7xKGdizYa4bTi9RmN0svWEt/PV2DRkMiLZwVSuE8pHk/EjEXNJLY
	HLmewteVIE0a1mex3L7r67sjq+w8xBoJmwnqt4V0jtQ8mJiyRqj7JzSpIU15CBDX
	1IhEbA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrhakuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 05:13:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3515266f6eeso3145393eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 22:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792041239; x=1792646039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcqLN3W0mBzYaprM7xFw8O08UixThBS1YjcY7/7xA3o=;
        b=OTkzn7kMjN8pZyvwcbd5VdZQB3jeswSgVUqkeHmRbcf3Y/Z1hYA0RPpFyvbKtD3gNw
         3Dc1VtQd5LOLgZR6gpqSBnkzRgmd5ZH+7MCd8aRheB933jrS2n22Q/EPtDVsGaYIGvzz
         67dYPz6WXSPhaRxBFpsQCMhXMDxzGx6eyVYu9jS1PKL5uKx3NoLju5fq+1VNvsqJUHNK
         f5bJc42DURPJ3+OQfhd9hUcsosbbxJwjhevZMAvDLbYGSaKJdotU13Ggh/1p7BNiSQ37
         lgVYxguosI4nNRsttwZe7Q5pad7tRcFiN5ac/Duwbz5d58Be79ReMxny5q97KZQx5BFz
         01kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041239; x=1792646039;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rcqLN3W0mBzYaprM7xFw8O08UixThBS1YjcY7/7xA3o=;
        b=uwqEM98GwaJFJRtHJuRIuG4gh3GdonpR3sUP4hMDhd/0Q0YsCvPuNc0BYAXCz1NfFP
         td2JP3tjEUyN1Aa2f+qRMUpfhEiEJuu6rbwiXkWfbICPL1fZ9VKEGOqw2ho1ZyXFYMB/
         1Td3h/oGHKibucXvR1Xbtazx5b/dBiNHVnPWw4eHDuAlQBuYnt4UeDMaE5ZgQdR6McUN
         N8KSr9o50SJsCJDR9d9kede1ZNe3mbn+47P1p5whgwKElFTdLO4DiUip+CubX5TdRsTc
         qkA4tiOIcnpl4rYz4ABhYg3rTSlTnKcJ0vHb7yGheN9SIfgQCh0uQcOaOBfla/evf/HN
         7fwQ==
X-Forwarded-Encrypted: i=1; AKwUvByMwId6jALLh9zUaTjKSBvDXxwHcrBNpgNBSVIMrwTXKHskWXAvpMMA1CICTX5v9yWjfY1t4AEBx3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsJJcnK/MJ6hQqhdOmk/Mn6ZhISuJ8euRU2WnIwxSRw3WZeAhN
	RkSIRGmn8HbkJbDwc2bw+wioIwuYIcfJD5FmIW8p+mY6d00qUdICPS3DNRGamgUYHMFMlNcFdyv
	xpOW+7uq+vxOVp2OlGljwlqKIGRlHRgA7ZxRL9+ROZyPwg7ZEoELmpSTJipH6gRk=
X-Gm-Gg: AYBFou27nLuBlfmOprWiKbdFaqIOlTdb5xRUl4dE5rKL2pJuzGVw2FsOnTYMPXPqKYo
	gkD7MKPIdQjvLo+sKGGacQL/2CsjtiZpb+KHqnT7cdq4DaBmkNVSnQxLD0rQwTpqPzMZL/9AnXv
	fIMa8I9U3az2xZmhcbPkU5KmINyE8MfXk48/eMCNATBeIRBLRpvsFKoopww0UeoKLjNZEOTusgd
	WgfCAcRgP9/K4WU1Cqmzhfsg30tDtMhQbL6zu6Fc6xMxGb1UHgvKvXGUYhiHp1OBDRfFMJB9Fnj
	3e1sENIT1LXmg9CLA2pzEdoBaIVnxQ453oGzW/eTjPXsMTglpFXXatolgtfPbCVx+H1pC3t/g8M
	YA21L6q/0bP/vcNC/4HDMC2kKkbD1Hn2o
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-3537e0788bemr33213607eec.14.1792041238959;
        Wed, 14 Oct 2026 22:13:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2289:b0:34b:5ab2:e200 with SMTP id 5a478bee46e88-3537e0788bemr33213570eec.14.1792041238403;
        Wed, 14 Oct 2026 22:13:58 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm62494806eec.21.2026.10.14.22.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 22:13:57 -0700 (PDT)
Message-ID: <d7f782f8-56ed-41ba-8d01-5eb235f873d1@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:43:50 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iALcdKB6Al2DH9hawr4bQ14E88akS8dC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX11AuA0CsJPox
 pZA25wNg1nH5SQbO7W589TX/GhsmK3FETlp/jDI24Sl9m/zML/erTbvJX+uB5SU+F5b0bt+9WCP
 szvb5g/8vCi9lm9EBf8Okb31RL+1GzQ=
X-Proofpoint-GUID: iALcdKB6Al2DH9hawr4bQ14E88akS8dC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyMCBTYWx0ZWRfX53jHt2Ukp9Q1
 pgw/petizOVlHVF5kHH1UoIS6Z/ZNmtozoW1imom6NNx0UOCHk2+Kav87jdbqiJDIxQJTp7bkRU
 evK7pGM4UYyweJO+jai5K1yVcpYwhJMSByKwoTakT7lEfeZxE55MhTWrR0noNJURRBL8OP/YjE1
 xhLBjeQFvvivZTFxCbQjuD5livZBPWTJdUaOM5rh1Jfc+UTv0NpYc4+fWONmLoe5VlrjEFCaxrx
 hlu5VSAcg9KqEonwSW1L8tyNvP9eSzMTEDu2Y62B5tCxfxrmq9bO4HpQaX/HEL+23Uxp0nFqSaJ
 nTuNgDLDfg0lyPmXVFhcU59Mt58XtZr1+Jj1t0wU87R/V2jyMNm9hF3oXFaIM4cSXZMaEAf63rz
 eTrrvNkWKEGTfg16kTBb3xX3QZ7lkUt8Tiq5kQlGSGr0kvtGxjdwfDqwnI3jAl2AI074/vyxDfT
 vYyT5zqSBiesutbaJNQ==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6ad06117 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QlY0LIaGgR1dm1rbm6YA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150020



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to compute the divider needed
> for a requested baud rate. To work around this, firmware instead
> exposes the SE HW supported source clock frequencies as OPPs on the
> perf domain device.
> 
> geni_se_domain_attach() now populates clk_perf_tbl from
> the performance-domain OPP table, allowing firmware-managed
> platforms to use geni_se_clk_freq_match().
> 
> Call geni_serial_set_rate() unconditionally from
> qcom_geni_serial_set_termios(), and use geni_se_set_rate() instead of
> dev_pm_opp_set_rate() so clock programming is handled centrally by
> the GENI core, independent of the underlying clock-control mechanism.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
