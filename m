Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CA27A91D
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583380; cv=none; b=EbXO76RmTW6G0KT5TdDbi6InulNwMOUMIzZHuwATVVsqTKdLiNaRefuchT6RFvlHXBYWL31eyBfM2G+ilYBYNFDpC6W4DbZy1Tl/NZRICU3IhDtxI29j/F4R/hs2vAHw35BZ1Y4IUGcyQteuiwHcSIBCsI13ZSSBJOfgLchgrGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583380; c=relaxed/simple;
	bh=Jqxu5MXRSdDX81MRmy98Q+z8Tv/DZxOeZCNhHFG86kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3tAKdKwUM/UhYOe+ZbaNcHdacJmsdkaHm2ZismDpKY+uQaMhrxusys6qI4nZPCwXIkQ9PNust7vY6zjnU0t3MpBeKsTdTBjl4Z3TChi4ASU6/nDrzyn7Q89+WFpCDVX3Dvyy0U3IoqYwYfK8szFSrDhXbq8hOzNnTyA0Q7Hip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dnCitTg/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iihb390B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dnCitTg/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iihb390B"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv5AR2006638
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zB8sPRDGnPoHZz7yCyo7IhuzIfOUg/WXFNjdVypaMnM=; b=dnCitTg/XZbxEIip
	uHNJVoY8tzwTRbq7219tT5RUx/ZSWmZ7aQulFVNSjhhZDgpIBNRQh7fOuUq6O6Sm
	DfJxIj2yMsPe4xN+JkWsc1SrFkHQ0EGrizm8Q6G5XMgfdOPh6sFH1OZkZ3RQx/1Q
	On+NSPuTyYAp4cSmsMN5rpEgy/pv6dwXleV3usQ1H3xKystIJ54Q45sgib2zJ1S9
	rnnsggjnQlDwd2OI8U+kD2fqpUyEB3c1uFvr1i1h1vo2tEJuIy2au2Cideq5LMvV
	Zr42Sa8TigKvdMmOoaKHD3JrrXKi8LGaAloBzX1n93/X/r5/1OU8tlAB023FZXO/
	kDskzA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kv7987n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 14:56:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d35a38fafso6970531cf.3
        for <linux-i2c@vger.kernel.org>; Mon, 24 Aug 2026 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787583378; x=1788188178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zB8sPRDGnPoHZz7yCyo7IhuzIfOUg/WXFNjdVypaMnM=;
        b=iihb390B09M5YipGxq3HexCq6CLKKIk9VzPvI5Pck14v8NgEvL2Rs+aSaPuiSCeUPf
         xwshTpX1chGAUgDtCgr9KD51ZBv1weJB+fd+BPXlSiyXYF9zVr9cBT1T5V6mzf+lqTU7
         GiaGq7/a4ZUMxD8LukqRksUX1WjX9oaLzWvvqyBtJHe81094N/zXkSgRjOlvt5EsHYD3
         bh+r2dfMsBtZHeahEN8g0aU3448zANY3jFxoOIwz2Hbn966T5ci93Zv07QiOWu9wIn52
         sIft0E1cVI292P52ui7m2PRt6MqIw3bafcz1S5bXIva8PBsbwGVX6/mRJSm8+NLn+Nt7
         OHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583378; x=1788188178;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zB8sPRDGnPoHZz7yCyo7IhuzIfOUg/WXFNjdVypaMnM=;
        b=HANXGCOMmGO69GyPT0Bp6/beEV94U7+SPZ7A4dZanjtUiRM3gaKMOW0q/WmzCycB61
         TmZm8QojDPG9mF3jDnEosusltw9/D8ExS+s1Iz7dunBPeqLJncAWCiCRQmlMaJA9SAgo
         ly2J3u8UlgLySsCZiRH9Cj2pz6CfJaxcGMGW50KPVfhRYGFKCDVMJdX9nBzkjyglQS4B
         nQ42HppCYdOhM5/KPerGRY/KDkPwp+WxnvnB0MDX+xQGqmwlbmYAc24Szslh67a20ZZt
         1sJGXQYNzCKd9h5F+peWOcahhngjwtZPDGyszc1yPubVsLQ/zz3fvCzAuUniqo/oSZax
         5bHw==
X-Forwarded-Encrypted: i=1; AHgh+RqS5ACIiSlGToKF3v/2coCyjyRE6dWwjiuDubu5LsjxvVk6UIulR06kP45spY/st37qq1YSM1bbPNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kfwtrka3K2hzK1v9wql16oO9DZoXhJtDuWuHhkVbRNAARGZbuW
	8FvChSM7fSQjCXBPQ8fi0qEZCJ4q0u4xdZkV1Qd0pV1iu993yd5Bg8IPMygeloXY4oYXQh9w1mp
	HRpPqMJSDFm2RXOU6BzCXN2L9Q1NzHhGQhsrEMw4KHHrMNCxg9+zNibrFlGK3pDg=
X-Gm-Gg: AR+sD13WSAVJMZ0ogo4Qg5ckJBSeXwyAeOdDLmro/m6/7W2alG0pDkWkiCuQg5IX2ee
	XXNDylhsJqlnVC7Y97iKJN3UXKKM7mcc9sRLhqdeVCT9qNb+olgWCpIrJd64k5arXOW8jLT0CL7
	I4Q2eK/OLKMdWGIbnPoJ6fsu7MHZ9ebFBubZeKpibGiIbITSfvfDOZZqKAeS5m/+orh9azlJOhB
	adCmM64JmBIid2oZBIyJkeWLOG0qwonFWK4/SgFy2AbgaDMvQCH3EDYwhqoGImfEmmDBq9XojCN
	ODBrSENSJQ1WMDXDyfAgu2qnQ1Hq0Jn7b2oEju26ConT0XmBMZzSsKIhdS9CXvJpCrZ70r+I7Yj
	5VRcF7+/6xIz7o8vbL2kxERCJ
X-Received: by 2002:a05:622a:181e:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52df59cf0abmr198355171cf.3.1787583377795;
        Mon, 24 Aug 2026 07:56:17 -0700 (PDT)
X-Received: by 2002:a05:622a:181e:b0:51c:845b:ac4 with SMTP id d75a77b69052e-52df59cf0abmr198354441cf.3.1787583377271;
        Mon, 24 Aug 2026 07:56:17 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa97sm1147107166b.57.2026.08.24.07.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:56:16 -0700 (PDT)
Message-ID: <d81d61fd-79d1-4bea-b93c-0afe44f9aab4@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Cfg4Irrl c=1 sm=1 tr=0 ts=6a8c5b92 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=U6xjVzI5DKoLzCUfakQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNSBTYWx0ZWRfX7s0QgJB1W0lh
 QqwWvz3KxTLrq8hCpdRGR3j+SWX08toChO4JEX8QGL/8A7Ah+si5sjTf7TwICO8WOVwhmarwFYg
 YjfWCm37OSMgYIpYATL+D3dvwEGV3hk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNSBTYWx0ZWRfXywLIcaboAMoQ
 uBN3TZKN6LlYL/yvDANv8IsYTmravfl4pe7jc9M+2vmI5ECGuKHnapXer/SbzKEiVCcspT98znw
 INuW3U/YDlxexbQB1WTYdMNpyjQxEJH6z+ZXdq6TIv3HeHs9hdaD+yV80YwMXl+2LQgyPnQAzUW
 u5+IMfwGDlWqfiEXbTsDC7HNIJB8V1827X90Zzw5XnuqdIMFI85HQ+DywDi0WqMClTNU6KJxQI0
 zfPz6SKXo0JXSmCho+fDTkxXQQxkHKS2i89DZ53DStuC2hPw8Y/pZE49AlkOn6CiiwMm6XSGkkK
 2affWRmUq3rLGrizPXjGrDR0Ja6gzXv3VzZ91cCZmm2IbEKCc/q/ozB84WpZTf6xbxYta9VDwTs
 SJqjl9PaV4LlkzWKYGe8u0vR/yIkqkwltQaiPgohFMfBw7XArXGoRekRXxG4uuB7QRvuAp7dAR/
 fCQ+h62RR/qQYw5wMJA==
X-Proofpoint-ORIG-GUID: qDQDrmvcU78X_BqEj9aRhjP0WNBbcKzp
X-Proofpoint-GUID: qDQDrmvcU78X_BqEj9aRhjP0WNBbcKzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240125

On 8/4/26 9:57 PM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via

[...]

> @@ -1175,6 +1181,29 @@ int geni_se_domain_attach(struct geni_se *se)
>  	else if (ret < 0)
>  		return ret;
>  
> +	perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	num_opps = dev_pm_opp_get_opp_count(perf_dev);
> +	if (num_opps <= 0)
> +		return num_opps < 0 ? num_opps : -ENODEV;

if (num_opps < 0)
	return num_opps;
if (num_opps == 0)
	return -ENODEV;

> +
> +	se->clk_perf_tbl = devm_kcalloc(se->dev, num_opps,
> +					sizeof(*se->clk_perf_tbl),
> +					GFP_KERNEL);
> +	if (!se->clk_perf_tbl)
> +		return -ENOMEM;
> +
> +	for (i = 0, level = 0; i < num_opps; i++, level++) {

One iterator is sufficient here

Konrad
