Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2A46AA61
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766684; cv=none; b=hRKIeC6RjhG2pod0GtCkyWvBJnDdtbqlor3Nx/tZ/3kr/HOml6Z0kYJ/0DGYgaYc0MBFOMRYiJ6tRg/Nc74pe5FXXy4KmTuw/UxT8RBZGCqv/14M+ezdo1K36aRkOjJIvjmszv+AuCt9v6fWo3VntmIxmzKitFLv59E+o46w0KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766684; c=relaxed/simple;
	bh=i7/Ddmlv/nASy9qZy1FJthLav9YvKAiAioDkGWvdURs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJcmcDjyFci7Pds7YH4qrPDbw7OT9fscyUiCYzhGjXx5KojESXlBM6c194qGcTjz9UPd1DMnbqxoElEPwbj1MXITxmG8gPfjgbfUs3oq6Ng5IbKbwA2zhBokHdHOvVFzJPP6tgNHPtm8INcfNVM8LPR930TBxqNXcNvcsUW+PVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDIEd0ga; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JpAV5wiw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDIEd0ga";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JpAV5wiw"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7JF23554799
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dLSP6RP/ktPW0pVnkumOxr/DfzMe7aMYty59LE3rHJ8=; b=FDIEd0gaYezmy4ft
	kxcmynOkHQKgYz97TpHAfasoAOpmCtvyUyKIoOGiRCb9LB5zrYPrAT6LhgqfiFYF
	4U8HzrQOsnoxZt2D5D9xrSBGxh8o4X4IgIt9Nee4NzBAZUW0fR+2oue3cPSKR3fr
	snsXCuPYV3XmfzMcIMBLPgybjLU9a0vBgek+XPDQfE2wfuAHr3X9KBjjUyNPLSFI
	raikEBg5ZDcrI8gy73Bb4gGRDsNzUFevNH4cHxxEt9x1E4WMTx7L37HR4ZD5DJsl
	v29O19qW6f1fWpDoUeieuRrbU1bn1zVHKYbLgsCEOeO3nrxT0/Xbl0kaJAkfn+rE
	DKvIcA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h10bk89f9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 11:11:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5333cac460fso9377131cf.2
        for <linux-i2c@vger.kernel.org>; Wed, 30 Sep 2026 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790766681; x=1791371481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dLSP6RP/ktPW0pVnkumOxr/DfzMe7aMYty59LE3rHJ8=;
        b=JpAV5wiwPPBUwRJEpoxkO8Ydv/1xn4RDxVeidcY9VeoDLlq4aewml1OU9SzqfZil90
         jS0qOZLyDw5MRVkXgkMiyyANxoLKpxYZTsD225bpL1D7sOSGCRUHTSui0K8dJxyJHNBr
         5QKnexUUBwFFPzVJfKESkN3o61+dl9KBFoEbPiAF8DrCAs5pzsiGxpw79UVoR4qD5Qpv
         OQM0v3TduNrnIBYT7DW3f2DnIMRhv6+bGfMFs3wdOj7IAuAdxANhbpBnsSwz8XXV+qK0
         l23AlGyFoAVejkenHgRP9WsW5cN7Q/3V6BJiEjG0gazoeOojOaZ7GND8h95rtcFRrZC3
         e05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790766681; x=1791371481;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dLSP6RP/ktPW0pVnkumOxr/DfzMe7aMYty59LE3rHJ8=;
        b=QB91HoY6D7jR8QAVdLcEgtzg45HojMkhhXjNUc23CAtBTLT4ObhY+zi77OC2Yqw5bH
         1CdJBe33X31qinL+T50N8JH66v4wrbvP0gsHU0pL5NQ/rW+gLskV/8rlGRekQIjnyY5d
         6ruAQyTsLy+AqmPgJP9HweTWK6PBAAR2NOzKLZPWe8fgndQ9bRnMqGX0AQZS20cXVmW4
         MtyrsNYA1kqPiXlFOq0rMQqmjFPxUE5TiApPzyybUW6KcdwAtAT77TsODIejQjf/1DTZ
         xk279EbE79qdAzoA3XRG+32lY8ao0nMigT5QuSXsla43Lep9GYc9RNldMLmtjQjmcksl
         kJkg==
X-Forwarded-Encrypted: i=1; AKwUvBxqIrl30VPZJQaMyyEF043fYlk+zpMfi6QYxNrLNl3mjl2KYY8gSNauvqx62uxwIroDyRYDKLAMJqc=@vger.kernel.org
X-Gm-Message-State: AFuF++lsxiijcUXwDIvyr0LMKd8qyF4VC3F8gCMof8NkC1sEukUbGeWn
	Sg3tc5h3g6kOxbNFeiAhjF+aWppetYzCQbDvAb2BztxI30zm8Q4GKri+Q85vjyHSnU4rc6ac7Ha
	IoGJHnAdQTAromsg4vIBb6LQ2i3rVfLSHdEGqxxUEQQDEdjpjEe6RBsrt8AsB7d0=
X-Gm-Gg: AYBFou0H7a7Zpy3aRAmt7JXmp8JiZorNagqAibbJI1B0eV4QDDESBpRhJom9VTfQNrg
	n9r8sglUo4koJGouDoiZyIQtM0nuiarKUwO/BB37dWgLxxuYWdVCc50+KOlAQN01pOpEvHbABKv
	LrIfzwkkQLNyMxjFmHAzbvbX5quJ09/Pw4VGhR3nHMn0hbPIaLch/w5Lig1IODEgucImJZYOiwp
	uK/dz3yap8Tl3Wl8a+N6FMp2G/wO6zR8fuhZLDgCvdZcbilC79/LgzUbIdfHL7Nsw6lai2XsytV
	1UUWmmiXuKYGk74eUmcGXVIrTXKLn7qIGsYLVA/LzdRYrykxJTsWLmJLwNeRCtncUw2Du6htUfS
	F5VKTOofcFhCaq7McHzg4tA==
X-Received: by 2002:a05:620a:261c:b0:939:b8da:1242 with SMTP id af79cd13be357-93ca93311ecmr150233385a.0.1790766680574;
        Wed, 30 Sep 2026 04:11:20 -0700 (PDT)
X-Received: by 2002:a05:620a:261c:b0:939:b8da:1242 with SMTP id af79cd13be357-93ca93311ecmr150224085a.0.1790766679866;
        Wed, 30 Sep 2026 04:11:19 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e22f7ea6fsm48243366b.40.2026.09.30.04.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 04:11:19 -0700 (PDT)
Message-ID: <84a3c9e4-4ddd-4ef4-a4ec-d71c30122128@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 13:11:15 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/15] arm64: dts: qcom: maili: Add camera MCLK
 pinctrl for Maili
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
 <20260923-hawi-maili-camss-v1-13-cbbb42e534ef@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-13-cbbb42e534ef@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -c0BO4ETXFsjlIA-LGDQIrpjODW3U2wF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfX4jTKP9wtvG1M
 crGcdVP0aVDI9lsg9GFbun42CzrovwL8geJmdlVk5Up6UP8/aBaUzHIKY9KxlK7zhcZNP10/+sh
 KkuR6OZL0c0tvtPBTk2RAyLJHO5+xCSM1z62FZBQYND7bEI+XpeeqbuvKKSnbHnLquQDGTWDo7j
 6qTuUC1/3CHrCGX9lm4aSQH0fziqg34SCgY2VU1IInknHJUSNU2JAmHd9hzNrm40yHFlr5sbw3z
 X+qhSsgKiDq7FQhkLvmbp193u2+Dbb2Jl4iD6sPZrYasQsaraAulC6Fy5/AgDYJ7SONd0J/Eb0W
 tbbkYvLfizN4Q85h4XkZ3cgPV3lyEhDJ1r4SzdXBbacI2rXvZOADpQ2YxHhY0dor7wxcbeb3azx
 nIW4X4j945z4Sw/7z0OBD9wokErfRBWKlu9cuU6Wlo4AuDSIZ6MJ10BkmP1/NVSnUG4Uy0OP1tb
 A6IG7Lx4+LKJ22uTR9A==
X-Authority-Analysis: v=2.4 cv=MZn5KJ/f c=1 sm=1 tr=0 ts=6abcee59 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2DWhv4IeyTXb80rK1lUA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NCBTYWx0ZWRfX25i1sLO2VFAj
 pUBa+3mmSUu1B56VVFrD/OMR234THeOl0y69IFK5CIhMaTgSHicR8ytTkgWGQs9fESRjRZhVuhG
 htiFcuviu1XO4fTeuahJiAoEi4FoX0U=
X-Proofpoint-ORIG-GUID: -c0BO4ETXFsjlIA-LGDQIrpjODW3U2wF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300044

On 9/23/26 1:02 PM, Nihal Kumar Gupta wrote:
> Define pinctrl definitions to enable camera master clocks on Maili.
> 
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
