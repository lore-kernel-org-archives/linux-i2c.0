Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC4346C823
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054101; cv=none; b=OOx2yFMPjM+i5quMborBRyEpUT9wz2iiWs54niOSV7BE3X0AmkPgnw8srjVg5Zl0nm9uwuC/uBvkJChPdzzvtl1RbClUgr1CL4CRRjgeSXvvcZ50fvTOxsUx6IKjApo34ZwMxjdhcjUrgX5PEa6uoSzpBnLUGbr1gSqHFgKnWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054101; c=relaxed/simple;
	bh=Qyu8uROoGehInGoTWn0gxRaoMfy73Q1a2d/cCRHT+h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYJkLUisOWo6057iFek7aTneZFw3tPnoZNb7Z5W9T2mA1GS8zGc8I61xITmhzPLAo3DdxKYKJC9+Yi1iHtDyWFvQrPsDg/NpzLImldILT/BVWeyqrh87Cj6HmR7styj0a4RMGTJW+Q595huWQKlC1IrLUntKIBHq987Iqv4QjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FioKDXvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFTlGPmt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FioKDXvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFTlGPmt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABUfH1544787
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRjbqmmRQUe1N/DZdTdTZi2027UboDzcR/T/Xh8ciXI=; b=FioKDXvWzj4lsM4G
	sH/P291sXadFUJGudcQiWcK0Uuodg8yGOKo3w38VmQRcVPDLBJGxV/rIgy+7ETLA
	pIVsy1NXDDqpqxr+mvdX3zLlGc01PcWMO+tGr2WfUyo/bkxsaE4FY1PartKibBPD
	wYmEexAaxQ9EL1xn+soIoPy1N0e6jeVBC/JxZE+JsBO6IeKxLAkKha/FWu/ZDPLI
	zn9KSyMD/uA/OkG3aDCZPWz5Z+KD09EFCPGHAT3Rg1Q9F9XuMTOgOJhuZ6P55CRZ
	Vsvhgq7qfV+VEtz/cyOhArJEg9MGa7G94c61qO/7PTgX7X3h8b1/Zs1lWqmXuomJ
	rhPdUA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn2fy4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 11:54:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93495488976so119720085a.3
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787054098; x=1787658898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRjbqmmRQUe1N/DZdTdTZi2027UboDzcR/T/Xh8ciXI=;
        b=DFTlGPmtyUtlKPESblfjMkgxn3Kn1Pw5tCrKtz+5p7sdGZAcCUM5/81urBr6c8opSz
         GgMwmhXrSlCGGg1D2k5FWmWrSd2CorrNd0t3PuSwSKwSgKZ/hwfPjZLZ+L+iPnJpp0vK
         qUerTOmxWkVvTo8IkyyZ6ampH05R1Ha/8FqQZdjfa1okNSR2Gd4P0JguBZTRJDrSOwKe
         xMMVQmsuV+o1nDlc6pgrHJD0OR0xfqG520fdXoxWB19foLOW1QH4bGsRhPROvF9lQ8Wf
         15H27a5+8JeSVvRWqEINauctFuHnqI+N5ZFtDUveIn6bnH2mb7hxtHSckXMvhRLjY4dF
         xoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054098; x=1787658898;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRjbqmmRQUe1N/DZdTdTZi2027UboDzcR/T/Xh8ciXI=;
        b=sPqrnnALCXeVjm+8vMLLbUP6q3nIeLOL4donY6iJSwOx0NhBKuLk5prPvM5MBma4NI
         aJVkacIZC7SZF+ivM6yvcST+cQKN/XTT/PUbFmqUEMjJQPgpwJzL2YgSySBFqinuRIHn
         e6Vs62BiWhKFqNuHWt0dADEDQf2Ca/LTB/HoEt2MPdndigPYk74bSsh3S0cP1alvI8mX
         S3N/jH/n3yFkOfZ8Ma6cB5uGB0nPlCWwLABEj3VRwE1tzDWgU/prhJY6JyFriGk6ltgq
         z4ANbvCN4Rwjg4eW2Yqakme7PvvAHSAMcfwO6thg5Uh3K02JA4xJ0YeDw4gZEPpiALzU
         r+tQ==
X-Gm-Message-State: AOJu0YwdQdPIav+yKZE1VW1n7PHWuaOJ0uuiFvgdfNWq/JSs94R9Kdc1
	kcA3oWRjA6wSKxruKhOyrIb2D2tche76zIKSRQjK/pmZ0gzlLgkwolDWSOQP94T1a5x+J1imAB0
	L6dbTYiWZJOLzh66NXgeRRgWszMBf0nylGQnIuKmBtX0nN6Z1LmwvK4WXFCqztagJbVo/H7A=
X-Gm-Gg: AR+sD13xAOaG3PxkDdQAIjVlFBW97X3yIEvlcBv/xUjbp/7oabyzxO9mBRvckNNaxiv
	JQsrlbJMFLdwsXF59/QS7z5vN6zQEf3IMpHPpvKJws+YjH4QZAvcfDFVOywDqPWXbbiAlXgG5H3
	DvzAJwpCWwYZhtlvIdlZst2CEw2yd+2gE78V4pqARSZbJTE0OglTyvMpsBDmYhqsMne/KjDZBhn
	ZwpxCRJ1gPG10Xe1jrjS/aAHy3JG6dZuRuaJSNwNQxFwpUxGIVT3/vfpluQCi5X/x7FJA0DhF1C
	bDmTYHiHHAUKkWHXnpSY1+OQAZEcnTLy6GBx2IgNeW1O5HQ3X+czaZUE47tUWPFnaLamQPkD74V
	84zd3ZIXIuCyG8/LuwR/2Vz+n
X-Received: by 2002:a05:622a:15c5:b0:51b:ff78:f229 with SMTP id d75a77b69052e-52d8551fa90mr238610251cf.5.1787054098368;
        Tue, 18 Aug 2026 04:54:58 -0700 (PDT)
X-Received: by 2002:a05:622a:15c5:b0:51b:ff78:f229 with SMTP id d75a77b69052e-52d8551fa90mr238609961cf.5.1787054097927;
        Tue, 18 Aug 2026 04:54:57 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d85173dcsm1917509a12.3.2026.08.18.04.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:54:56 -0700 (PDT)
Message-ID: <19e93687-eccf-4aed-8d84-20c2389696ef@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:54:53 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-1-e1d80da54e01@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-1-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LSrtVECB1PLD4ZAC412HOVyvsurmZyhE
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a844813 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=oFlMz6Kjfd5ZYSfE-JoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: LSrtVECB1PLD4ZAC412HOVyvsurmZyhE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX/ehGBfh0nad4
 SV2ESzDyCxCfb3TDtsAJ55jngWqVZvxnAKvUNOvszO3bk0Ke+Cd6NtaYk88o8LoXnhC5uzm3SCw
 q+XhEJ6RLoavA2r+wQ9g1Xm10Nw9iCYSmlcCRv/xvgUaUZW/0M5kbIryQk0Z/s8HQFiQIVnFlSX
 cAukft/9rcDbydf/IbfTR+s4+4wuGjxQJmYoM63IvOBaOCUhWGlVk2Shc7veBb1UYsV5d/VWzGb
 Pf5EjYTOtSvHfureyPKhkrlKaQU5vldcmYKTwOmQ3zhASe+IqZI+A+FVZT0V8AcBXGQ7v3/DU+m
 AMGOYCoOkO6FB5X7xZ9W1ZyvE1+X0Gpdes7w72htcoGKfpAOBV2MRLzkpjFZjmxrM0cGJtwdVK/
 vyHcJ3icJxIQOkLgOCRAJuN0jG/OoSRAmYesg4/NTjuhdPbRVKiucHijDdUGg6r2PpjRU6rfKgS
 oIqSCz5ljctucCX8nSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NyBTYWx0ZWRfX7b3OeXs5DNNb
 n8hqf/y4bRzcQaav6H6SL/PTCB1VDgx2b68T9U3OUQfY4SVcoyicp6pkpg0wK5gUtxD/E2gIzBH
 OV2YPEcOsmhHPoL5UGADP6o+0NlM4QY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180087

On 8/1/26 10:10 PM, Loic Poulain wrote:
> The msm8953 CCI timing table is internally inconsistent. Its Standard
> and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
> clock, but its Fast+ timings are essentially the v2 values, which are
> calibrated for 37.5 MHz. Since all masters share a single CCI clock,
> no single rate can satisfy all three modes with the current table, and
> the DT assigns 19.2 MHz, so Fast+ timings are wrong.
> 
> The msm8953 CCI is the same hardware version as msm8996/sdm630, which
> already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
> the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
> the redundant, inconsistent standalone table. This makes all three I2C
> modes self-consistent under a single clock rate.
> 
> Note this requires the CCI clock to run at 37.5 MHz, the driver selects
> and enforces the proper rate in following patches.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
