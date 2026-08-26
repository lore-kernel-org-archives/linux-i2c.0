Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE441DEE7
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748782; cv=none; b=pknOtuj5XvDFMAQ3UKrOJbsB9K90bVhpDdNQdFfi2JcIhpuiS3yTXwqPePerlEs2Pl/gQAtC5ftNOWDM2On+vnOWj90hhnj+cmVrrRSnwJ2aJIao2euDqTqVvJPCiAA+oj9z8Al15SEh4HnxjpmQ79pAoUZhUg83UC7DCkYzljg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748782; c=relaxed/simple;
	bh=WKvODjXitmfFPfAG/gy9D4hMRVexb8bj4k8N5J0scWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB4hbtkcr2Vzn4EXBKAQOiKW8zw51WBCuKViLKjaIJDEvNnZN0g7yodZ1B29ie6ffF1+3YbHUiHbgsz4hnoMkd/+q8qaUo1f/CgKdD8281mubi0xupSXHGKl4jCvV2IfL8RknmqDicW77aEow61ofpWnFLlsLy4SPnNnN1HjTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MDUIZzOL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AQ/3cOCM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MDUIZzOL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQ/3cOCM"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCBr8e3898951
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 12:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNQy4Y4QWEwkxWzbv8l3UovuMLGmgUb0gTLe2xWCdfs=; b=MDUIZzOLG/xaNMuS
	Qs3/6xV2NLRxJQYybM8+X8E8uG+xngf36QVohX5IIJAfC2+MVRzUSOa1AqKX5TqW
	p3G3jqPK6t3wutGJZEN7M07qqnQ2U9+yxRRLiQfCu+YCu/fgDfPTTOivfMC/BVK8
	2M9vobhrBPLluIFI09N77/dzT07uENqfbQ6DOSuhi1K+Gqv8XKf3R6Grt1Hxi75Y
	HxVBGy5pa/AAPZI2um+/zXpCdGkGsy9oSZBAmXkzpDRr5LjPYDwaZN1uFX6NHQVZ
	ATESggMM0bo30mrsylr4BGxT/llqUl/KJrtRm/eLA6iC4HrSx3tUM8x4LW4lP+Xa
	OcnG+w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uths6pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 12:52:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1422511a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787748779; x=1788353579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNQy4Y4QWEwkxWzbv8l3UovuMLGmgUb0gTLe2xWCdfs=;
        b=AQ/3cOCMS6huLonu+BgV4+iayDWe/NUPxFMuJE6qNjEtEaQxsIXFk3YCUYe/08Ho/H
         2ngyBNLk62I/VvLS9kaorzARicRgmrMit0rC1XzNqy8bNm/SVw4fX8A09n0fBC84Klbt
         jDWpOE8TSYHtB76XgKiKFlpjM3H9llyTGhk5CepcRWdlC0mpL8HWnTlI1ZNH7SHjqklQ
         b6yLHBeU5/t6dGWvzQ6k8wUcI7zUAyPkpRKNDn6Bra7lijYm47rraVsb4fFB6s9xK1vB
         BS9QWG5V+HAN+l23wSkvTgot+4GTn6lRIh8MPzipFtX89Pnv0VVk8NmlhDMSKD2FIuox
         jmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787748779; x=1788353579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNQy4Y4QWEwkxWzbv8l3UovuMLGmgUb0gTLe2xWCdfs=;
        b=R0VFJIFe80vvmIgpWZJZX0BI/Sv98yst+h9ugEDNJZTokhS31wiDgRK49J+n/zpRw4
         gT2OPrhvIbiWNKO24eEoAXPd4QE1IA2c10PIWe7g83P+qEKB7Vq050dRRjPEkPcoLDot
         D1OCW9ewdibZfcM8SagINSKPBvnqSfMq1TJHRoq4R1ly12BNM9/qsRTv3QHUMJBGfeb2
         yvYzVyEi9Np1V/r3HQ1hBot1cRw2rla1/y4nSuuM4ZXoKpsd1Ks9voFZVcrBXvgZomYx
         sCakiPA32/HfZYw5GUNQhjjHw3KNudv9NjF/6W+NOC7H0fHFDTnpWDQ2prstUTAxgPFt
         /29g==
X-Forwarded-Encrypted: i=1; AHgh+RpQczLp0xqPEZctWtK+K1RqS+FqDMtV2Ar5hiJyY8yrodpUomI5sQTiU5G44Wzit+RgTxXwKOrtWbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nF3W8Iav795PoaEVgNiuh7p4ee+WKU2O50TzAet3Yq3pJVJzi5
	tJ7hBEqhqrakIf+E3boXoTJwIfkTwa8XtGYSqOBIGfygJm1CvFyC2B0z+D/iLCdzRBWnCQivK+c
	OrI/SrfY+ZbZVvpOgwX9ROK0r2cscRVunPY1u7LzYtd5x4VE9sUljWPYeandw1Ig=
X-Gm-Gg: AR+sD10rBSOwYtahMYIddU/voeboI8icLteC+jCEtSf+m1YP37uLEyU+6msuwTsYZya
	xusD5iHKlAEyzODVOQs2/oDEiaL1eyn9tJhr5NUn3RopNkMsVKXX/yHMuSSvQYCKPV4EyKxnqKM
	xMCLGcGyD8TqS6dl5PY/dFVaQUnetdgbQ0G01ItVGcdsm+4QGxnhjW6ivVziCBczpjkolwBBmE6
	KtI/VSVw5uMwCBD9YpQvjzlN7YKphuEtS5Yk5BRikHE9jtci1zueQHPPuZbHeLmZq19BTPn0g9i
	yblI0rE8tJ5FHxBu0V3CTSiXrvnP8OFs5TkI4+XcTGN8+koyRyThSMhRA0T3FkXPZcbI+rt84g+
	ALHKL5m0p+ICvAo7uGibq2c4uafzSiX/j
X-Received: by 2002:a17:90b:3f46:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3966d3d8a07mr14427502a91.10.1787748778818;
        Wed, 26 Aug 2026 05:52:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3f46:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3966d3d8a07mr14427403a91.10.1787748778378;
        Wed, 26 Aug 2026 05:52:58 -0700 (PDT)
Received: from [10.218.4.101] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3966875e5c3sm4076282a91.7.2026.08.26.05.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 05:52:54 -0700 (PDT)
Message-ID: <41af9695-44f2-48cb-b5f2-8e779f7366cc@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 18:22:43 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
 <9c8e4e57-135b-4f24-97b5-dde9c0418efd@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <9c8e4e57-135b-4f24-97b5-dde9c0418efd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8ee1ab cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=jJ7N_Ga9sRvXCTnihBAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ytrBeEGN4WLn3z562OT0JE400pWYCLff
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX0DIPpsx+HGq9
 FzVEUV2KAJKjAdiSIMZ3PQAqmGf7qRqAoQZP6HYyXkPQD17H3OWAb239RqQb9jN3Lr83kGtNAi8
 v7tQX6s5SCLZQFeWEWmVPc94+FQ6eAGVqXPlvYi9dX4k4B+YHRNS1Ls77qELQyQ1kEM6nAXmw2W
 sU3KpzRi8gFtDQpMJa7fXO16IW7QG5eRVQ7/86u6av3WpLr2HqeUlZzTbYzHBrKk3jdYj1l/Tdt
 5wPw+uTPcJlBu5vzwFQiUt9sHYlYXYQGa/mVzzvdRCzJ2sffkuJcwAe4EOixxw/Mtd6L2XeK1Qn
 aYhPLnSyq6Gedtmt9TpY9oEYT3vvwUDqwPxEC85i+3Dgo3aacZS88rnxwyCsbCtmq6mijPnlrie
 KTBFpXJJxhVSUMCYl11Qyy3i25cVETULrhRNyNCArFgTiU6LNbGLGguUuuDlxTxXW5lfNNddSz4
 5OCa6g0f32XFzmlfS0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX/fsS/ymG/QiG
 yGs7szTeapjkep8kSBY/fLCkg8fyfAqtU8hTcp7kxTX5iGv4LdY3Wbv0IusdP62hXNa36Fefdju
 EDOmJysy5AUgB+UcXJ1+KBxHI3KkXGI=
X-Proofpoint-GUID: ytrBeEGN4WLn3z562OT0JE400pWYCLff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260106



On 8/25/2026 3:11 PM, Konrad Dybcio wrote:
> On 8/13/26 5:52 PM, Viken Dadhaniya wrote:
>> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
>> controller that operates exclusively in target mode. The existing
>> Qualcomm I2C controller drivers (GENI, QUP) are master-only and cannot
>> serve systems where the SoC must respond as an I2C target on the bus.
> 
> [...]
> 
>> +	ret = clk_prepare_enable(target->xo_clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to enable XO clock\n");
>> +
>> +	ret = clk_prepare_enable(target->ahb_clk);
>> +	if (ret) {
>> +		clk_disable_unprepare(target->xo_clk);
>> +		return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
>> +	}
> 
> Does this need an OPP table? Presumably we need a power vote for each bus
> frequency

The xo and ahb are simple gate clocks with no rate states —
xo runs at a fixed 19.2 MHz and the ahb rate is fabric-managed.
Since this is a target-only controller the master drives bus speed,
so there is nothing for us to scale. OPP is not needed here

> 
> Konrad

