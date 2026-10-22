Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671746;
	b=bk8dZvWBLHlXJcC307d1TUNTO0Mk0bIWm/foCUtn9ObL562H0rB5yc8buoPZ/H6MrXvj
	 xYwrsN1JWK5+aJ4Cb05cEmk7Z2fWVEmeO0u+aFiinODXgJiOIHzQnImC/VYERUIuhKbDT
	 71vXeB/Jw3rmZ60IJeMmzknaHQmh3V2CmkCoAdG6cy8w0A3cQjMv0X+x0NJGvegyhyYXB
	 6T2ZTdvy2isCu9+bcwn6+HRRLBwm63anCQRbJOG2vVxI6KZyIR/fLHQdCqcFO+FPxR5W8
	 AdP6jS0wKs6k6ydSQRoAseL3NPqCLtwzNb38ObWSXkPXc9U0AYtl9MXUcKFX4Wc2osg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
	b=Bv27TUc4BtUy4/zHNUVfEnmm1jGWvl8l1VslSQeFkPT3An9WXc5Jm4YXtPsXVUNhVBgd
	 hjy+4p18MgTR9L6zFzVazZXGb4Vqd/4IacZJ9kMOl3UIqQjJAII8HPF41oy+qLYIOfmhU
	 y+VjtzFJ64d5yfoed1+pF3OO0MWaWAW8tSxp6jbkDK/ppqCdEdasv9usq96Mv6cQPWz2+
	 tUqThBBtwn48PKdDSpEw15EYKTKZv2v0JEjJwAyrny3FFI3fRUlWNMpC7sWJS3vkGhpof
	 hc6HkwH9U3909HeKbULijs9RTJVhvGZRacXFmOo0AFXjxqlh9+qv15ycsVy70tNsS8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94453606A31B
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94453606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xpuF3478820
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=; b=b7FjuHriWyJcQF6b
	oVxgz8d4XnoXFI7faQANh+GAqlf1hwx2KqrTuYLjyW5FpjEwS2L/kimmAc3pa4AB
	CT4m7ayULxWWZG3q3wZbrPIeLAHicmVkjguUeG7SFxAspd6FWvaKxbVB3HurC8OK
	fcUz/yF/RvrJD4lPFSo6JhfOzG2b4VNvQPZIQxfZkBQgvZJephazPUFFGQ73TqiJ
	R5iVVRCTGKIlJJQdCgbkZ6MEHpNZ0Go3fRbWPJuCci5ZvlhXGO52remI9hyptRID
	m9aiYahu2KCq3Fmjs91IJukRzfggloF1DzztroxWsu6nIhC08nEbKX1fDlEAVsCH
	olWzmg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a3762-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:22:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9d52f684fso17402575ad.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792671744; x=1793276544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=C6zvZYVDvsQzlkSCBnbfBSEinTQ5aqEOrZNT674hCUTK3Z05R+AH6DP0WTc4lrKLzq
         +pHyQwZQfA89UHm81BY5XebO+yKhsStKDNo/bb/r5ijlIw08rB48z7jdfSphizItJbq6
         f+H3UlJilQPQOOB4erv+ZTLSQCR5y3vZw7ipABz59FsDCLTHvPj8c+5v8jl/hTBVBbow
         Yy724azzBS6hhZ09zZa6IW0tE2c72VLgTx89YOy4SEyBu4Faoz692cMJMWFMC08uJdZt
         TP9FEUjo7ZFUeowAtZmVF3OFihn7b+/hpHpgojpxauF2sHALP64B2pKOLNPSZe+NLo7e
         +n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671744; x=1793276544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=1N0WATF8d3uOOB1O47W2sd0v9NEw798HVZWphoO5drcN5QXRMWqqxK/nNMoNn+xLHC
         x4HecttrsiOs/ZFxF84lMhuMBAYYMLlWyu2ZxtueUartIlSzS8H8UWZvm/49SiIAajnt
         VBq2LoXCbLbVWyO5QAWge2Xua4IUQUYIwFP37yWOQGWudKC6+HxZmYWydhKncFurzRif
         UAWcwTLpLfZpH89OsznZPkvrChhXj8PW21/75QYZJufN5GHIfOp18WL3tp5GcC7WpEed
         zn+Xcz1yxrbQxRYnkfKdZXlFuoAzN8Jx5iUmNz52WvQqg6gPH4tJkQPbwlLfBKS5FJpU
         q+vA==
X-Forwarded-Encrypted: i=1; AKwUvBwmhcUcjpSlNytyQdUJGuOIi4iqaJQWVm/I/446b+tioDfjZxBId3/D1EqsyuA8nMllfmreDJmaH0E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxsDSwn8bv6LoW2ZEFvEb3n6his2fmZurb6uaYLeIM8RW70m9b
	UAH8xDMp36EM1Sdtvf9rfae1gDQIt7W9S7XfHwyel/sCmwGc0ZYQTp6tCmw2toa+PCeVwiZe4HS
	GCBa5jV27ee57GFUaUpioCZfdS/qCwHqYttOh7VvPM0O+Zqsa7Wt29pjJ42AsElw=
X-Gm-Gg: AYBFou3PIMiMJVmElO0XS7hZYYrRiHpOg/rhFHzShD3l7PrjiZKGqi/9k+vdIRNwdy5
	DKUUeP6Uf8Vje65EKoYMDszL82yByAXookZ8KfLut3zh/fMg6U/vK3SqDT/qSrfntpe+SoY42Qq
	4JRfjiTvhOkNs/76MsYTNjo9cNs2LtDLs8x6cTkvIaNLUPEml0tzsOwZ1CY5HREsiYYN77b6Glj
	PAijAqW/o2Ai85wo7GU+on2KMazPEyWMpCEeDBDomQvoU6pMIWFeNO6cPM76cSfK/3XW7VxfDBw
	knq7lOraBC/Q/efnDlwrryBIknEA7cVzVbhCxrUFZjm/eAr2Bnrtz7cjlHeJh9WdMSVWa0uloOC
	tlzrJQwki4yJCbYRTdsU3p+n5X6R9p6pnCQ==
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591705ad.48.1792671743992;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591515ad.48.1792671743527;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b412756sm23642595ad.24.2026.10.22.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:22:22 -0700 (PDT)
Message-ID: <5dfd7245-c2c0-4468-95ed-6bb8a385da98@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:52:15 +0530
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with SE
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
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX2ekm+MkTR7tb
 q+QZi2FSgWe5DfWjcOzPElGw7YJNJN8VnfIRidwBN3aPD7c15FChqZD6JKrU0Ae/8CGfMOmvkX/
 se5iApb8qnOX2wm5c5J0/Y/Y1ikXpjuMx1WWfxt2qg1XSN+bViYR4TQRdkqHpYRWWu9nsddEwlk
 fhB2MtBLUAhMf24TIWRfe+RHj8prZmhea+G7p6I4ot0KQ8slMNJ3aupX18WPptD71la8A8mFUTV
 pJnBDFcg6vWoXD65qMQ9OzmzETz8MULfIYzsFYQXSJ8+7o2ke9SED2YM4wIfLtTcwJLZ4E8Qdpd
 k82CdzxAzuxRR7sZ+NozQtJ1mkKantIhFFMGk1y1zWqVs5mVjI5uuM8CoYjPLvfnmfuLmxccP+B
 NekAxLYJTOhXK/PTDxV27qRwuQrTxQJGEuYdHSBhPl+GHsbkK8vThQIpMe+9PnnhqwisQJzaXiD
 cShPf7qaeo/+LzXwNsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX+Lt2YY/QJvhb
 SZBEEDe6UYdLKwTdwuOR744ZVows1GosDqYgrIqmtfMGN0JiOiPOFWJV+NjIr5Nurs5iCD1kqgF
 W3ub1psgdH7QMJWbeBiEZd88dWdnUJs=
X-Proofpoint-GUID: 1dFaz0eBqRk0TyNz7r_12sioVry4cO1W
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada0000 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 1dFaz0eBqRk0TyNz7r_12sioVry4cO1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
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

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
