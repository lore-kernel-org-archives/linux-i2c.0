Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B314B7A4E
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659022; cv=none; b=jKZnRTU4irdTIKFIaGjyLhgSSs9xxpLZYBBrJFiPJdZGqfMZdQ3EymwTALxxXcu/hdMh5HHjctQzYWQTMosX2JtIJm3bYNpqrOQBb83uOr9Kl+LkuQbdvbZl+0WJgXDyYldDwU7PMrzOEfOf7T7e0RcsGJlIEueOy1268DfCO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659022; c=relaxed/simple;
	bh=EWDDxvLh/ajUORqgSDl2rZ8ViAb2Wg2kGEU9j2QUOOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B65AD5QRVAauWHjlRoR8TMIP1AHNLURzPm9SJizeIwDyEJwCdHK8pINMnshqUK8FH1+L4y9SiOdkYGIId0VMTyK3JN58fHPEiPZ5Ji90RWaBzJOdkXTSBv8OOlB7JUSPq2h/8T4pgXWdCu4LAAF7drgzZMZBiAuxdYrCECo+pEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDsyaP0e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQMYTvPL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDsyaP0e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQMYTvPL"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDjdhe1307355
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ri1E8u+BKFp8OWjyXvh+uMJ4
	co8edga6jii1ZtQDCCU=; b=PDsyaP0eFQq0gY9bRGD1dBPRKI+Mti6Fa6Mjx9P4
	/khZUBYJ0eBzHeRoEwoD2BIAv1R1UYKV0L0YH6aTLI9OE8jA57mYaHLv3jelQ66Q
	2vN1baVoBfaUxZfXQRxJ/MWfg9+zKIqYi32F18ewUXW3XhPsDW8hgyuXpm/npdUE
	eh0kwUF0zhAS1AO10UaJngpkjcqIA6sQmOMEqu1EZHf5tTw+UyGNX1M69T6FYH3D
	uwGIaJSJ0XTUBI2Zmu0T4rdQOuc6mYtXsJoD+KwwihlcaBfW0YWoUGIcpm7N5LLS
	pvypELLWoJjYJxxdP5Alw0GmTnYKP+QNFEMG4ZsO5NFlPg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grcra9w68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 15:30:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ae8e7e546so182774485a.1
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789659007; x=1790263807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ri1E8u+BKFp8OWjyXvh+uMJ4co8edga6jii1ZtQDCCU=;
        b=GQMYTvPLu1a4ZBbD7WwWpX/WSxaTjHibIB/F3M+xX412BoDUspXI60DoS0vfAFphk2
         tqdQG5gQyQOk/XmDBeyiJ0xNP2bUgtA53iYb9Mckodn8ly184M02OLcLsIz+TMYP8p/2
         DoZpDeSgllJhlACJ1dcQdul79F/Tmxrma63ld8omWj8wyImMw5eYKi7hoAQEPFtC5ijG
         3oD2TDV6AQjh9QcOgzMxIK92DMR/ZqmJQSTb8l4u+c4eR8kE8t0VzqkLGswXVnpY5Z98
         RNKaHO8bO34W7EIxll3NnqCAeXWOBkK6vc5Jx87pWltlQZiiJqVzXkgDnswrpYURrxaj
         H2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659007; x=1790263807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ri1E8u+BKFp8OWjyXvh+uMJ4co8edga6jii1ZtQDCCU=;
        b=UkzI00f3lQTiYh3DuyHl92YsUAchu7BgZcFjoy2r4+aPHmDqH4Hh3/mHubiOCd4PgJ
         6HJ+8LvKv6s2MmNjPHJOrqL1twIFWbMcExC/kqEj1MD95YygWsvAIj7JyCwXo3Mc8MiP
         WsrQ/Gj2HrgXm24zSI+eVkC7D0GTqtPJB9QhYbRBUzbnkEUPeUFAU+wMgR0adOld3KbR
         qB34RzCoHuvuAvLUT5Qh4zmxUrkjElxwMZxlM0k5EJZAB1G1oj7+5tBQoDwa21caDCq1
         Ds2/kqERy4uL1d+T7E14F2LZByKhsDBSbYOqKd3lM1xsmdz1v8qTq76O7v6483ZsqMaO
         CBkw==
X-Forwarded-Encrypted: i=1; AKwUvBxMFHfOEtzDLbY1W/RgN70lyo5y0ftpnT3FtxiAGTD2nmxl2Tu1GGS+QSYrZb0RA4ZWCao1TI3YG98=@vger.kernel.org
X-Gm-Message-State: AFuF++kD7hIR3TAfLAgwGV3t8fXaEesgdJoOu6dO0vergnSDloOaDp7H
	1EhdDxp8yYQdM5MyyTTz0+t6awkkk8nxRF/NDvH3+4IKAnSss+Jsw9kSQ024d+popzF2Jz0TYLH
	uDEQsQo8dyOOiCgJVXNqdE5o5FpzmynGO8i1AU4as2KmVx+BY0AOjV1fJMwUfdtc=
X-Gm-Gg: AYBFou0lI++xA7l8J7x9xH62chxag9/FfjKFulKpKSUTlUMPT2JrxKQLD2Sk0+CBov3
	7ETlDs/WD8wjGYyOLUzUHTrRvK8JljPXaqCQZYkJeqAb7ERsejriwhspHkTcGv4ywxqFDVirIxJ
	DHKke27Sd4tP8RC9Fjs5n7laqGy2vrgkt3BCTnic63Ne80r0Oy/peDJGzs5VLOptUJfgQx298jC
	wiy6mMw490qkXt8tt3DozpzvpbVYUC2DW0oLylitavoFiXMaZ8dveXsOTmcIyvgAc+mZ9Z3Ybpb
	pjIsmakvjO/RRh46zt1g9PfK91R+vWiURUqfHzEo4PfkHhbe+3lQw0r056me41yaGr/eCrunHwz
	Z+f6eDqhbrKr61g==
X-Received: by 2002:a05:620a:172c:b0:939:6de6:9517 with SMTP id af79cd13be357-93bb794e07dmr1288319485a.46.1789659006321;
        Thu, 17 Sep 2026 08:30:06 -0700 (PDT)
X-Received: by 2002:a05:620a:172c:b0:939:6de6:9517 with SMTP id af79cd13be357-93bb794e07dmr1288311585a.46.1789659005708;
        Thu, 17 Sep 2026 08:30:05 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm141129705e9.11.2026.09.17.08.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:30:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 18:30:02 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: Re: [PATCH v8 5/5] arm64: dts: qcom: shikra-iqs-evk-imx577-camera:
 Add DT overlay for Shikra
Message-ID: <ok2efl2jwkpm4etywz2w256gozewohaznorhhb6b3zed5ktr6f@vvqtflnebftn>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
 <20260917-shikra-camss-review-v8-5-9b9596221cfa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-shikra-camss-review-v8-5-9b9596221cfa@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX5efAU4MkhJKy
 JW8GjiSgs04AB/B08VNGHsVAL4AUXnEI1f8pXvpbuK+qsVdbXUsvH5tGa6bAbyqedjM+k6Rm2y+
 j9BlmpUvjxrOtxsyKfItF/zuQWXnEo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIyMCBTYWx0ZWRfX9BGKA6vZqLLw
 P7/vk02Hhg7fBMidgo41LYbaAhb/entovewcRf6KaTANuzigOZt95o4brQiidKQmlGU2xNsYBxk
 ji0pIlECOsnahMJ2Y7UIdjFLtxwoBgQao1EV0RkDhKvYr47Ma9+qhYcRzTTFQ55uLrlfVqGjDWl
 Mtpvv1WYGZ0HD9n7ZFRpa42skL4Sbstd8zSwDoEdciggTBT9miwU3BtXKll2C26ypW6W9WzYu/m
 14TIursePKYHvvw956Usl88Q0a4s953yM2gfFiOYW30J73tQGONTzTf9i9mfkv5xCwvGjf6pIyE
 9CEl1OrIGjlSpI0Ugik2Iv1jzXBAME4ADnNYvcJ220ChKvp1pmuK1oRm23ynAtfJeCU2q/r1zOj
 8KHpl5Q3OUe24oiz0EyJdQecDPNzK19jeE+k4ZD+2PqirExurWY6mAje4uZhUR3l/m5uUJE/G/5
 Q27pxMf/TmBszaPAMbg==
X-Authority-Analysis: v=2.4 cv=WL/qzXsR c=1 sm=1 tr=0 ts=6aac077f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XE-wypd_VeY0GsksmEIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: naVfMdun4wcClBwkDsXgoKPQyrujVaYi
X-Proofpoint-ORIG-GUID: naVfMdun4wcClBwkDsXgoKPQyrujVaYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170220

On 26-09-17 17:11:04, Nihal Kumar Gupta wrote:
> Shikra IQS is an industrial-grade variant using PM8150 PMIC, requiring
> different CSIPHY and sensor supply rails compared to the retail boards
> (CQM and CQS) which use PM4125.
> 
> Add a dedicated overlay for optional IMX577 integration via CSIPHY1.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
