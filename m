Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B448463B73
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766272; cv=none; b=LSjMTR1HQzYL3QnPieIXci18GkQgmviWO2P1C5SA3h7qciyRmijFUnYvYmWt7d8EinQInmRc9vVuNvocs5Va4FjvNLUR66m5zv3kDoYqWYsNb74jOUTPmM4rIN1mKAdfNnE3sF8c3S3Oc0HKX6UFY2dXcd5XSZLdGqCDbbrFw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766272; c=relaxed/simple;
	bh=WHjYXjStzMmqMyYH9wOSdVai7dC1PDsS7igyYe9Q38A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NzKG3Ted3ZYe7O6WlsZ8OpjrwJsZZG5+rQj5mVdT6pjQGIz6a0TzWIJHdjw31p2YmaVg5xrbicJVRs3EC9/3UhnIMWZKUiYydSf1Pll+Z3nCVNsTnW43aDumffnLTc6eCd+aziChk4h+PyOgIpSAJESVA0OLs/wZbjoFTpau4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGXBYoyu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H4Ii6t0Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGXBYoyu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H4Ii6t0Y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U7dYif1556226
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3MB1YFkf6eCm9O8OWocrq35QgOGGFbKE3tag7uTxWMg=; b=LGXBYoyu6Eos3XqK
	peeGPyxpgcYpLPn7o+NSKH9XIlreVoO821DyZ7Xfp3HKQ5iVEiIONUSsAngQkUdH
	Stn2JSJ+AYa4DYGR089XZ+Z29mlGjSAcd1AFiqJhmCylEl5jZIMm+n4UsXAf8Y20
	76ek2ZmdRjkELmmsRoZAe3zuTXM4XXT3E4AOQwp/AYFXt0u+2InxLR8hmhaRA6mW
	/Qwm2DPBE2ZQ57yOXUjPslYkEKMxi26DCSmr2vxQRIjyy7J8KFEpcUp+R+rhjayE
	ZlE224avAWU2KObjtOlQ5Rb55+sPV/JJhneRx83qko0qwoE54+MgEK/Sri2vO+U8
	H/O4PQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x1c0x8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:04:22 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7ba36cae7f6so20129137.3
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790766261; x=1791371061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MB1YFkf6eCm9O8OWocrq35QgOGGFbKE3tag7uTxWMg=;
        b=H4Ii6t0Y/Li6DsNKakhlH6rFgZ4nU6jRILuwfZzUp7hc2vp+HVC4ppdOC7LAQltp/B
         kGw1H4yHoXWJhWigsDibupippM1JkXf3jaq4k6yiQZ/ZnE7bylSAwUshZwzWtOZZdpSJ
         jJoDsKzikNNSzP7neVXuHFhnXDyhPv4btmiVbRaqco8TH8wn/3OA2RGI/Oe3iyRcAWUj
         FcLqU+8cJp+Ur/7SUMJBod0D1BC1SuilBRVBdxGCysqFKtZK+A/YVXZEgH6aRH4+hAuG
         fGdivoctpxZCDq8BmBFaNSnF58EivUatQQLWOs2WTLb97d/zOuqFWGhcF8DjQqF3vs6J
         m7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766261; x=1791371061;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MB1YFkf6eCm9O8OWocrq35QgOGGFbKE3tag7uTxWMg=;
        b=GLZIaVlYzAjc5k05h5+iJacjjWsNkxNXXJfSnK/b0GtDiWiEPThF2KYJAGqGITMHAr
         HI2lPIXXN5lLFFGCI/ryijy7Z9cvtqwZrWya0cbiE9RfQOFuJyBvRdfPjnB+X/lKW0Lk
         BJ4BpAYkGo3QaPYcRNOy00brdWg6X80BnDPTf1zioorD+JrDlbdm5GkBixOnKLjPolf3
         Nmn1OpEe1gUnM6hroECVK5ajFbJTdbCfZY5TrR+/l6w/JSGJAY0BkB0HXWV0aLnsdma1
         VojME/mEs/a4PfbdgKK69/QZWyVZbc38O3z6abfZIYOKModRDbfKwI08vJ6Wtq60u0b1
         LMng==
X-Forwarded-Encrypted: i=1; AKwUvBwibc8wcntclEwhnnKdk1XpaQJT4kQ48NBur8QqAPAtTdHYmzWayVKiBEMMIXpposqHevvpdCOkkIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIK3q0xdYZbCG8eKuNXD29RzdCd11JTLOwILlomGGXm5jzCG99X
	p3QsHQvLtaUCT1TVKMPkPUrgq1O7mYStFvU4vqP1lkpjod6kNk4ZtTTfTSwXLW8r8/sGNGjJWRv
	JuxR4ZjggjqTtt8/0imgRYNEw+BSmAPlnJ5Itp91ISDI0x1hf6w6553xiKO291EY=
X-Gm-Gg: AYBFou0cWE+6xlv+NmskO4np+MIXnOEE79/L/xDr56oblyC195GH4ciyAWFoM2aJbbV
	xQE+zLu2jReW21RSMa6V73RcLf9HGm235p5/oMCKNtBYZImgpwWt6LozrIrnnDIP0m6dE5qiZGB
	OKsbtWUTZ1mA1WmjdfwjDG6RWfdJKapMp3z+BKX+vRWrRvSzDL6ZwBsH18eufRLdscsinB2H2VH
	VpTLNvK5i8OQeVTQgZY80rdFbAyE/MFJyRlbJGHcaVUYMpNfDuffIAwCauJYEUtmpQ+cod6mfdj
	ukFpakYSk++tMdmAX3r3qIx5hBC2iSLbysyDhQU1n34ew4ph2tW6gXOGclZ9ma3SO//vmgqgAse
	Wk+fPSW+UNr0kTY9pwS2aSA==
X-Received: by 2002:a67:e717:0:b0:7ae:c2ca:8d6 with SMTP id ada2fe7eead31-7be61e8f5a6mr105393137.1.1790766261222;
        Wed, 30 Sep 2026 04:04:21 -0700 (PDT)
X-Received: by 2002:a67:e717:0:b0:7ae:c2ca:8d6 with SMTP id ada2fe7eead31-7be61e8f5a6mr105388137.1.1790766260792;
        Wed, 30 Sep 2026 04:04:20 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7ea6fsm47420566b.40.2026.09.30.04.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:04:20 -0700 (PDT)
Message-ID: <35b1e5d4-8b52-4403-8f16-735caa21d26c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/15] arm64: dts: qcom: hawi: Add CCI definitions for
 Hawi
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
 <20260923-hawi-maili-camss-v1-8-cbbb42e534ef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-8-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0MyBTYWx0ZWRfXzfITdP5YcmY0
 hI0Huw9EJDYG5z7PB88TARUxccUPbbklRA3OG5m8Sm8/PVLyHvp7lXH94LKBjuIbsXIaiOvRpD/
 TyMKdSE+JohiVnyvUpuZ+6LZemcjPds=
X-Proofpoint-ORIG-GUID: zgA10OVBwrEsOb0Q9qxfT5tel5RFIJCw
X-Authority-Analysis: v=2.4 cv=VrC2kO2n c=1 sm=1 tr=0 ts=6abcecb6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=H9GO2F0ABltwggOLjD4A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: zgA10OVBwrEsOb0Q9qxfT5tel5RFIJCw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0MyBTYWx0ZWRfX/SCzOzex7g4h
 Rjl7Fk+CJqmrR1Uj7zezBbbRNzgAIgKpH3mr4V02wASZGbzs1p1A5ssk8T5K+5K5mf7ZFXjPs0K
 3VNoXpyHl0lUkGIzErF7VNiB4t7YfopmR+kwuuMmP9Gtz1vn6B8tOZAgHZyb5EtEDqHhFyZr8x1
 TMPaKPSsIZM9zKdq5ajNaPsD1GFqDi1WxpdKiMj13KbQ8iKejDuOSUaPcZZCG2bQ5EraQnT8+7h
 KxppJ4p9adzHSpijs+jTGpJxn26/rcJRawpnATp+k2iRCQ3xxyiBprw+3FlihVfJnwLjRsKsaWt
 zVu9dWcSw9ParTu9S9wOlVgwxIgWc/THYLh+h5h9YXcgb9gLkF3jz9j54DYRl12d1Vef68tYA9u
 zzLCKJyPbnGLuDci6gQZfLt2tjUae9+PCOvSv+e83hJjlPsEnV9WhKZd+PKv6hQkYjrtnMOAf/U
 a4xljKUSgHhYHgs5x2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300043

On 9/23/26 1:02 PM, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Qualcomm Hawi SoC has three Camera Control Interface (CCI). Each
> controller contains two I2C hosts.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
