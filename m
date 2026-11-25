Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603988;
	b=NVFQ+IGfRlEv5zzWuBjwF79fxtd78s8mv6cDcU2JJqSexsLawbdnHFy6mvyY9ByuU+7F
	 0i43I6zoylpitWYnAD8cFdf25VoOwoYCpS5ojNAvbbLhDUCtxtVRc4ABxx18SaOGGbzdJ
	 z44Rnpn9NBxUJbzQiy8F7p3jMHPGKkXEzm9Co2iesoptLbB/wT3a1cAQjm82CGJ3Icnpm
	 /WwVhF46yttKuDKfL5/iwJk8tq2dvFIFd8f+RKLm27O+R5XdiZ/MsFE5nblpeK5aYgV4t
	 +N+R3RjPb9pLet1IAVvRfQmBy3tSNoIqHXnKa2CRzi6eGr9HhM/ob/muUEmIsxDAzvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603988;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FebbI9F5mjaTpQVwpaWCeaxrYNjsbfM5/tqyvZhTU4w=;
	b=Dld8aVq6BN2qLWADn5aVkFrVXO6MGAXQBWSzEaKetRLHo1UAocq82nrIa3xURXz+hNEc
	 1ofuZX8OUdwFstG4qxsF9TySmgwBuj6MjZveGbV4L4EPaYVUkQH/iQZ+JYPdnSGeYB6y8
	 RsgfD9yPJLDJnoOojsAP6aGOfuvykFjklfVusIwMCchn0hc2JI7fGn/bV+nlYwZzjmbUS
	 cUgGiO3Qk4ijP3nlUgaSzKzqSH4f8LJeU1KJrlUrq1hVFTTzRcip238cB63KW8SQjTcVd
	 fLX86xax9GUNrQx5Df/UpsoplFl4YcrO7eFwUYWnMWk3y2cCFHAmT7fRrAqD2Pr6d6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lBEkQFga;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=diRJ9wgf;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41D606A33B
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B41D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lBEkQFga;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=diRJ9wgf
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mFL63126473
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FebbI9F5mjaTpQVwpaWCeaxrYNjsbfM5/tqyvZhTU4w=; b=lBEkQFgas7Td87xj
	PgUMKCXYiObvlo2EfLiAxp8KoE/szjO0b6T8LjOQSnkFKFOE3hAxgjDE65uVONjb
	vftvXpejW2kREFvhQ591qFGCLo1Rnwvsm+xnPcDldNA6IxQSg7fImdyXSo0q2f4Y
	pyB+LAo0dUSj2Qx+ZYtLCWJDDd9OAaVCLfiwEeoHtqmYb6Dmafm6vQ0x9ASB6umD
	8+V+wqp3fpMH0V3RvExvJoX2obuj+19E6GkPz+dR3YeHSDOKvODytk4MSQ97wliU
	azcMMIGs52cFiInelru1HseH9/VI3JzU8CsMnrgdyjFgtBr9TCdCYJ96JVoekx3B
	ahD1Yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydbsks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:53:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9460411fce4so32663885a.2
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795603987; x=1796208787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FebbI9F5mjaTpQVwpaWCeaxrYNjsbfM5/tqyvZhTU4w=;
        b=diRJ9wgfKoyZyMWoiRTYjExM2T9r4lZPufOT1pIHPrPvDoIAuAmbKuv/UwUFsFx5xd
         AAEupvnulxS3C94P4fwUHty7ROfty99Xx1w7XAD2MPZenugMuWiGbYwqZ9HBSD0Num7r
         5TK8YC05oAPyI4ssuj4nG30W53EI4vUUNVCN4WgE9bDENvx3LNKrF1Stre4qoVZwyRS3
         YKONrQSzu7H/4bPdh19kfFDqzbPtqubIh5vUWIjl70VnKn/uVpGeSk4RycmnhQ+q44bo
         At2daaxMRYGuhS81MzqUxINutxFUFSKgpGxO3uOYDAoZa7kchvHFoJ2QvBROU/Ql8VYi
         JZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795603987; x=1796208787;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FebbI9F5mjaTpQVwpaWCeaxrYNjsbfM5/tqyvZhTU4w=;
        b=WdA4wYDvAYU41o4dLF7xqen7pu8xObGD29DxL0f0d2Xhh+IZW8OOzWBawfGKROQvgP
         TX75IVH6s8qwc9+PvXm1lY4CAaIFiF4SlUOe/ws587BYuVRwy/0hOwm4RbDUgpAhSLSE
         1FeLLYI0SE1SlKtrcWazw4tR+CWLDFhkFvvoTUSA/zNMafqUIhSkntYnKZeNUHPb/jOi
         sxAXUGfI3eBub8z40eHClU+AiBPDixQXUp/HXAGQrJQwdnq7zqgUoSIBlkSyHmm4naCQ
         feOOPWJy7XU1vEe5niqY5/xtmkozbG7OFwEgYMoKiuUEzkzZ2+UTo5XGxOobkX9DBX2W
         9JAg==
X-Forwarded-Encrypted: i=1; AL+hErHeR7dGdSNJh2gHs6QsfuvaW1YxIyM1ZGvBI5ymeQIQ655EUCuVWan9KGyJ22wF40V9MC3S7QWL400=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pemh0jgSLfucR9J8GIlfgBwSNNaEptK34KgyQEhJICcBZ6uBR
	zB5Nl+cLZqhy+atjyGKwJopIsPE77A6aaWxua1uRTlgd/jgT8k5m2FX8M7siR66nBpPJJ1uafK2
	nCcnhc63bqV6IXktjoHeZE+W7Tw248wbNmmwNIlRdWrRYOijhae5nG8kJK0V2Zpc=
X-Gm-Gg: AZFdTZd6L5HIUq4UykE1W9V9le5LXwkJXSIKS3R/zPip+HjuCnasTo6aPLsISqALwxF
	NHStz3wH9dDOwFgBC6C3IVY37ssRGvo+IOLmTKR3G1uknq6vLUL7ZEkhwgQb9WHt/cgyqkC2CIf
	9JFUf0GMF4wkCkkz0jQaD6kqrG8+vQBNHvUZvYnabgttSTp0OjLLvPdwzVtA1Gkr7mKRTb/MCfR
	CjxgWZSBfcw2AcaL7GymjX2IyNvLBz+rO5UKJc6NcK8IL1ynNx5prApZa4gvAwUWyzJcYCOUHQa
	oR5Ip0WID3KDrFnSPq7nWHD9demUWL1ZApz9ViBRv5W0LxXevm0tsLAVC/8uYEgKCqgORFDoNg7
	am9qfBiF1B8B0ckMAd+Y5AQQ0czwxLx0cReSV61X4zAzXoqsk6ja0o4O0LFizIZewdChhIAo=
X-Received: by 2002:a05:620a:a786:20b0:949:6e6a:e85c with SMTP id af79cd13be357-949ba997457mr3195148085a.4.1795603986675;
        Wed, 25 Nov 2026 02:53:06 -0800 (PST)
X-Received: by 2002:a05:620a:a786:20b0:949:6e6a:e85c with SMTP id af79cd13be357-949ba997457mr3195141985a.4.1795603986021;
        Wed, 25 Nov 2026 02:53:06 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85ecsm617587866b.70.2026.11.25.02.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:53:05 -0800 (PST)
Message-ID: <15cde6af-0b9f-4a0f-9d21-4e5ca9107a67@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:53:02 +0100
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
Subject: Re: [PATCH v5 3/3] phy: qcom-mipi-csi2: Add Hawi support
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
References: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
 <20261125-hawi-maili-camss-v5-3-1483b7f68dce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-hawi-maili-camss-v5-3-1483b7f68dce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfXyKAoBdg/x6eE
 oPXBRcRapyqtxsurrnppmvjtF+FDNhEnHHF6yLNgHJ2s2xRN2C2LDKL0ioOeqGnn15hj5oRVV27
 Craw3QB+9tU+YMjT2lt4b9x6XHPOD+0=
X-Proofpoint-ORIG-GUID: I2Zy4RDDd9hgbw4llalMEe-MthCvecuS
X-Proofpoint-GUID: I2Zy4RDDd9hgbw4llalMEe-MthCvecuS
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b06be13 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Olo7VrpVOdv4N-DtMm0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfX4fKKE5XV0OFN
 7kif90VTS1dlX8sfYUYlKuQ3odiNgzo2GpG0MBNZ9TerrdSERenJ6GwHVoPK3FbM3gnhKK+DtmQ
 6cMA7Ww/fpLlgBWMav9lDDURBUd/4n/E2tbfUQU7TBlxtcR4u/tFHQQg/jKu/T0rDTEXwBayNUI
 lTYBdhAtZLxOrKBTOUuzPElWF3tE62ym/1whaZFyT183deN2FM9IcW5UkC+u0RvliX6Dxv+juLu
 QqoVRf1DNCFJ2SqEUjlGzrCFFWYzJtXiTGGcuRquH3XoKQ4YZoq9wXWPameFkUdd43vHqPTRmfg
 9su9889uRo1kI6TNHoxijog8opkv1eg8ie0Q3IyX2FqIh7MRJafo5Qzb4cYwNpVFSsEUwudXdJQ
 R0qIIjcbKw2QCtKK0poVxi+nZ/hTFnIymM2bgDybyAq3khYhP8mv9nW62Rp3y6YEPR6MfghklRH
 h1UbS/Qx3p7h3Gtxkvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250043

On 11/25/26 7:25 AM, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Add support for the Hawi 2nm CSI-2 D-PHY.
> 
> Reuse the Kaanapali lane table and adjust the data-lane CTRL0 value
> from 0x8e to 0x8c for Hawi-specific tuning. This prevents potential
> stream stalls and SMMU faults.
> 
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c | 136 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     |   1 +
>  drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          |   1 +
>  3 files changed, 138 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
> index ed40934d67eaeba0c6ac7ac75324ac6292fe7d9e..5d91303e0df2e8c5bca3ea8fa2bb831429a8f1ff 100644
> --- a/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
> +++ b/drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c
> @@ -162,6 +162,126 @@ mipi_csi2phy_lane_regs lane_regs_x1e80100[] = {
>  	{.reg_addr = 0x0c64, .reg_data = 0x7f, .param_type = CSIPHY_SKEW_CAL},
>  };
>  
> +/* 2nm 2PH 2p5Gbps 4 lane DPHY mode, Kaanapali table with data-lane CTRL0 0x8c */

nit: 2ph and DPHY are synonymous, if you rename the struct to something
like lane_regs_hawi_dphy, we no longer need this comment.

As for the override, if its meaning is well-known (the difference is bit1
being set or not), we can add some sort of a booelan override instead of
duplicating the table, maybe

Konrad
