Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0C352010
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520208; cv=none; b=QF7pTNuJDUHQSHFFY4Z/fPn0pnmJDtHM45/JWa6eLeR/jh0NctN/srd6wJbtmLQ4IaV5phab7SCb+AU22A/tIbBYSN8WjVAQTPhIG3uLPM9K0ONoyuRFYM74jYMJuuQzcaztTqO91bWEcKHkPWjdPmTn5s5drXW1tv666InWaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520208; c=relaxed/simple;
	bh=Hn67GR+gO5Esig7XtQGNEiHvrdUGoUdeHXneZMlfYRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv/L82rHYpKZOSrvI4OzOdVGdozHShs4fa2K0S+HcYbbWon2R/cAZCJ5Y2v4j3kUHQhZBg2TRco8vj1grnP9bug9X5Uvo2BFvbh4JK4yqhqOERgm+BpUd7j3exsRpru3BWkTwLNAq8GalvVtF4gHHeFtdJWcY2Z17244qNtb05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUT6U5LF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5aj7xxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUT6U5LF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5aj7xxI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62ThC2641648
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=; b=DUT6U5LF+ORWHPgL
	7A5td5L/EjOH8p5NfbokYu8RsMKY33NfTAxUJ2dQtUiQS2PYGYMFtcwLFGQ0RhAW
	2s/AE0vc+NDkEPsKAfG7qWeyazG9/FoFvPWQJVznO85jF2K1nQQ7AS3XMz77sghP
	YKKRZVoh+BdtBdGfTfBp0MDAlueYM59rI2IKupHHwqrZBh5w0y+TillzsXrqa5l1
	9kh8YY5CZ/3sqcHD7KDtcCXuj1zL3AFBVkwpo/HkctruQhvQFfgTKR8TicTp1sWL
	FzZ9vua5JnOpHLzgo/7Dc/ms+JMC3+77Uml+D3cFHfrbfgk6FltE5+RT/HeoWhwQ
	JDJXbg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mm234-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 07:36:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so475759a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786520205; x=1787125005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=V5aj7xxIGb24dsIzjhBnFqzUfp2Kb9WEFqp7aaZfnDP2SyrIHFxtY8+50hqg7QrwkA
         jEaMQXBq+j0YaY1m/0XpsQCyKhvMxKJyHvpr5mg1P09N2Tmok70RKtqbQu7ltlo6D9ib
         TQZjFt4p5cJTzpG21K2FztoYyHeAG+ld1ejuc/l2ZbDIOmKEmDv4E4ra0eFoIjfzLHqK
         POJOkJQ16lfdVnYdVd1GOPX3fy9GtXjuI2xOUHTohUSb/ethHCPrAOfw5tloMVGsWZRx
         jHxOQzknr0B5TemGz+2og8cE5F9dpDXX9aoJE28dXYLl5lxfA9w91RYwx8DlirS/kiOi
         A4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520205; x=1787125005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=TyTrtdS88nVl6tsDhZ05eThl42OT76tZEW6VSwQRJKqKufllpPHx037Xb6c6W5b4PS
         rlPGyWocWgZg7tM468KG8lfUcL5QM66eSwBAB0MJVV9yPked5QkchFrVQFhbgjSvo7A9
         0uevq74VSF85NGJNxoNyN4ddjCZ50me+MZ408ziBuEzzHoPtAcJ3MwRU6T+qxVjjFVJL
         0Vk59njahoD62xR+ZShUgcoLNHGsSLuSajLiZ8Dl5b/ZeJrx7UYZeXOYwiY/GJZqHAcd
         JPllnYI4KhGRMV63lEcRZN7hI4iC3ltDa7JijSm4ePm5HaADWwVhIfpZc42mGDwx7h0e
         Plxw==
X-Forwarded-Encrypted: i=1; AHgh+RqmhciXFCNxtG0PPA8ikqtepPOfKSoWXwjM8xzgaGg/SRUEjYcGTV0SpNySLwc7Hozv15rE2LL+00k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYt2Cbpe3WCbSP+iHOHoU0CTQNeuz9mWdES0QdNqmqAJAQCqA
	cCcZKmT3g9suKd0XOx9Tn5eNeEvjeXrVo1JCtGptGgWAvVzz1EGrl3MmfQKBUhBEfGWMsWxaDRC
	1Lv49gjYWGEsFRghewguMsdfIB/8tY07F8ZR/2WhVHVuWfEmotS/7Fnor+6+Ur9g=
X-Gm-Gg: AR+sD105dVpl0XhIeL4KqHbu6DFtqWZmwhkpexfbvLPHnJ7uH0qW3R9rSALpO+khK2+
	O4ZyRW3L6XK5uMuAyVIKM1MgKIe10NUSwlpOQfND3MOieJfwhPrqRhyCgW05GSYJY9uVRAscy1h
	wNWjDN4xA1lhZXmM3HXAcAtMDyx/sKOqqi6UcY+21UkNyU4sycO0J2+xfw8O45jlG24DjUY3JFq
	UjZNXopxMshRfYdZvN4Gj0N7xNgv20rIjrhYBXHcj6Ufr0GBlRgtNfFnFbk1sMvAWx+o5gs7ndI
	TNnbtaq6MPbKZquCqk5D6BSZJDu1GguOtOYPFcFhxz+IgtWXWTFg7durZOcIoBQkDJMugUv0u/0
	e0zgHarQQmf2DI7ji1YkR0PiuiGh+AzBa/g==
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3195038a91.10.1786520204575;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3194989a91.10.1786520204012;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f9675e32sm829428a91.0.2026.08.12.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:36:43 -0700 (PDT)
Message-ID: <2c036793-23b3-48d4-834f-9daf8000b2d5@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 13:06:36 +0530
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FlrG-uit-qly2eC6B9VLOkts-87LpilI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX3gNXOOqTIsOu
 dxitGUIoC18RqePXKtAYHV6udlcgYDKCZr/U4T3hv8zqARnWO2YIud0Dmeo2dUFX7BbJH0SABhd
 tFgUYkjzdW1C5/w9g4JzIJDiOUW5Cfzv4k7FLKtVfIY4ayxB2Sjs0ELibvCI/hlMvCENTaM1aIf
 W2sW8X8vZsall/kKZmGB0bqwgum5/Hg/1TsXwdJsHYAn9spUcRxja3dzwdQEjGdEfkmGl7mGUE3
 SnnXWCERnCNHVPGYA5Cuo1C2HAzcl8XUgg4iFUFjZxmLIbQHae5e+E26T+6Ku1Wz5viUMmO/lpv
 oSECRYqIqDW8WZl7TKJ2JN1AtPKN7h27Iy3mqUqb90lJLB23GZt0c6aOYvKmHiMmCyLIhOct3gL
 vLcgRh0mcyg7dvUh8u7yxqKLElXJCW0Igw0U80aFT6hPLBpy4QCBu6dRcofaybOkw/MxG8aYueF
 0U/b66ChlhmU6oYRF3w==
X-Proofpoint-ORIG-GUID: FlrG-uit-qly2eC6B9VLOkts-87LpilI
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7c228d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX69a+3cukyaYv
 nSNNWv4ZUK5FRzdm0f0n9M6fPH+xClqYZAcOQutVaM5h8Uq7B2Nu7w/l3MB0yOkk8QvsCgWibN/
 yawrh1PAN1hMXfrPoHZ+wEwaE2AO8GE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120060



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via
> geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
> computing a source clock and divider combination for a protocol
> requested frequency, unlike the Linux clock managed path which derives
> this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
> applies the matched source clock frequency with dev_pm_opp_set_rate().
> 
> Change this by treating the OPP table exposed on the perf domain
> device as representing the actual SE HW supported source clock
> frequencies, the same role clk_perf_tbl plays for the Linux clock
> managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
> iterating over this OPP table in geni_se_domain_attach(), so that
> protocol drivers on the firmware managed (SA8255P) path can also use
> geni_se_clk_freq_match() to pick the closest supported source clock
> frequency and calculate the required divider, and apply it with
> dev_pm_opp_set_rate() the same way as it is done for the Linux clock
> managed path, instead of relying on a direct frequency/baudrate-to-
> perf-level mapping.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
