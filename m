Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25F4A7C9E
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766295; cv=none; b=lkhk43QGiGAdlAeJNfCZrpa/+SgH3+TeKU2+I6zXsPLsJMVIKd/oIZEdB0hpp5olb/pRA8VtxxsB8lR7s7rzEY6SFLxatxB6xqtynhIB9P6thq2eWI0ia9Pr2JDMkdZ1XfdWMxB0Ewl3SVWqkAsN94pwgOwv8ADx09SQvd82PdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766295; c=relaxed/simple;
	bh=n/22CJIRs3FbTQ/EXxPb6QwR4RlL3xGqhin4YyXX/X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjD9VihykQE+MBSzScZbFUwQztvCPlHfsaBY6qukutXJLggbITZEPYPm/hZdd9MoC29gGL4IE86UgF/LRAGc0I2155C7ZrysOn2tdYt31p+Bl4x3k7SbQtDP1AQYUmSHcnCHsEsy3u0rNUkz1YsuA6OMyKTgVh+YGqVz9B+i3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=my/5kK0N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XmynXiKG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="my/5kK0N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmynXiKG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dTBp2819942
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUpd9+a72DFNRMumj2W0ENVQopg4yo6onCsGEdVnGag=; b=my/5kK0NPcYGPUMl
	GwPINqpVbrConduOJeWQdn91NGpRbCdMDaiI0IDliWmraW876kpruCsjk3/EdsTG
	b81M1/JGMwU6QZL8lTEtRZFZiS0LM7B4ccPkcIduhuGIC44XQJtsmdGV0YKvjEUe
	BXkqrA+hzOdFFFBIw16F3aS4mb67zhgQy9Ilt1ZRcL1TrbD66PxGC2UijdwhwGOk
	7nxafei1MSj5rJ4iQGceK/uW6NabTx63WXdlACOYfZSVR3MGY83zhrQ/dk73Z+sm
	B6bmHL5/rJ/S41V4xC+p84Mn0NEekeTT28yUwlP6TUqQ7DCqfoopW517Faf4pDq8
	FWLeJg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2tec7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9179ef12a03so1283566d6.1
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790766282; x=1791371082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUpd9+a72DFNRMumj2W0ENVQopg4yo6onCsGEdVnGag=;
        b=XmynXiKGoOC3mwn54Gm7mkIDfPzsDmR1et9fPdNy3Dy7yqqdjk5HlgLmrx2ZWIHcDc
         ynAjdb7kzlLS/ksQuVyeYhBMMR/mgEBbteybIw8CQc5cnpQEv5BgwEAUv9HDD/SuJtd9
         3t0CEEZ3Pkz5i2gZ8ayYjZjo62OAcRc0rf3F6W3hhWXVcEOAaq/8gbMQXDbCGHdotw8Q
         FOiel8Eiq4CG7zZ8WohM/FiBQJAZfJaeuBUM6nELhyxt8H6l47Etf53bsCOpwWVyzj9+
         AZdLGBrG9P2zOoI9ML/mfDAARdgKVNzUcmi2KU1rFQtHUwDnoWH60/upRm7YwTevPgse
         dsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766282; x=1791371082;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUpd9+a72DFNRMumj2W0ENVQopg4yo6onCsGEdVnGag=;
        b=SoxESVBbKgLV3gWaOoOfoR3+nTsGwmYLdipYoEapUe0M/eipxeq1iJsYYkqABiccWl
         hiH0rGsFNYw/8bIDFtGhH7648/ofX+eGcQHRcSO9zKvNe5ai0D3wqyGUqwxeLzqz8vIk
         CtE64cydkKxDKOjo7aySKibsONzBs898euNbJ8OI71c+N3rxCT4AC0QQVFqUHQadCikx
         sFwwPxTY4SOfqSD/S+FZFUWIDAgXVWBe3HrvVAJDQ7zhyCexUzLrOR3+lkcWeqVCIhHc
         R9PJ0fDnfLk67hQub5ApKVyaEx3/gpsUwb5zRw+bgmeo/nxmxpApebEgPNvuKjIlYQhT
         eybg==
X-Forwarded-Encrypted: i=1; AKwUvByp9b82rVHXqLRP+NTl+rqNuRb1k/rUIbn7/KLAybrTE4BWThh1WS3Unlz1pS9AEGjCGGqiuWYhuD4=@vger.kernel.org
X-Gm-Message-State: AFuF++lodnhJSHfo34713AWGoyTUjuROHPOa/0SDOQEMuwDphW6Qh4jl
	dseg9kmhcjim6rcG/hhfnoBoZ4bHSn+ZPPO7vp6s2A1tnky/nSenVH0o/1pyIUQV1SBFb+qcHIh
	SRYYjppktWufPKekhZTFbnacMn89vu9kZa9Yei1cWiBgf4WgdKV0R4ROcJQv01tQ=
X-Gm-Gg: AYBFou028jHkWKFDsAfr9NjnE801O67Gx9UqWY6ME8iRY7XuNx4xCIABpP41T/A6AWS
	1XVdquYgiW1aDDRBS0W0SZ1hdbU7VkqvPtB+hXi90QoQBVnKvUJxDcrAahwmh+GZNw+QtHzXNFp
	sxqeaifL1IsVl9FwlxrWiEFbvuBattKpikYewgmDss/l86fGLM3HO6d9E95uU6E6GA6UTNuy3aC
	oCm32Dd0l2E1qAvSYsPmE6sKJLebrPP4BSfb6CjllIn02kih56P9IXn3US7E5eELOTtd9KcLKAN
	y70bwJ2Tk1AyHWZgwWCfDHX/ccYB9E/23hCICCAbgi7PZoVggIK1cJPqG1S5rLV/+P2HYZTNU1L
	x3hC1fw7SN5RMYMn8JWlr5A==
X-Received: by 2002:a05:620a:28c1:b0:93c:61e0:81ff with SMTP id af79cd13be357-93ca9523518mr139809485a.1.1790766280780;
        Wed, 30 Sep 2026 04:04:40 -0700 (PDT)
X-Received: by 2002:a05:620a:28c1:b0:93c:61e0:81ff with SMTP id af79cd13be357-93ca9523518mr139803285a.1.1790766280181;
        Wed, 30 Sep 2026 04:04:40 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae047e9a39sm708830a12.1.2026.09.30.04.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:04:39 -0700 (PDT)
Message-ID: <2b8045d6-050c-46c5-bbf2-eab7544b7070@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:04:36 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/15] arm64: dts: qcom: hawi: Add camera MCLK pinctrl
 for Hawi
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
 <20260923-hawi-maili-camss-v1-9-cbbb42e534ef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-9-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W4C1wzQQ90_kr8hLfwOSJ2mHmyHa8DlG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MyBTYWx0ZWRfX4h/5LH6yho6W
 I3kNAZumr9YLGwf8v5wPrWQ3s6XoMwEfRCOFLJyD8bekBFGfu4MTTraGJr67scT2SDyJtwkpDad
 9Pas78NxdDgkTdplFzLCleB33CmEVuP0OXOO1ZAB/+2Ju/4oSXXxpeupDsLgEWq4NAeTaF1dPGl
 2CskXywMs8h1HzOAE5gbhu1WLb528DFdO3qF9rGD8GbcAGMYisyp+yt5ToKDxppqMVeRrRtIUeJ
 w6gn3w9wC7rCn5pVO7WJIlYoglLKKoVNv0lDt3WBHsOiW5vqBVbmJhiTiKMeHmsf+q1Z2yZWclr
 Qx9lK9y9ERbl8Xyte1BQgf6lYDt4dO7WmL9LtCTtyle1y651oUTFUNU/WA/uFroJNa3P33xqdvC
 KK/n+wH4cnUw2MHdDxKupWkivtESZyaAzdQ1bDYQHCIAgaemsAg123YX1SHOmKGxgy8gYH7xSeu
 tYmhhaxJu9oZqaMaL1w==
X-Proofpoint-GUID: W4C1wzQQ90_kr8hLfwOSJ2mHmyHa8DlG
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abcecca cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=bWtWBUCbUMvqLY_lKcQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MyBTYWx0ZWRfX64gh/WWmtdIA
 0uIN66WI/l3W+i4pqnzrVpbvVCZSlFIceCeoHorwEZrDUtMVnyL8XED4E8lEGAcwgZl39iTuqsa
 4Wwsz3hPvLeadZJ7zU65l5bpoZDycZY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300043

On 9/23/26 1:02 PM, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Define pinctrl definitions to enable camera master clocks on Hawi.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
