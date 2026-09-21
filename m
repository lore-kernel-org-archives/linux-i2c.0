Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9F493D4F
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992220; cv=none; b=iKPQnq3qlyOxs4hy5rfxqNZq3oaXXktmW8k60LV7vypE1lc7qrfzPnIlbQlUuFwf/17qS8R5M6VcY5EfCY8J70hQHJ5xBu7wDH94IMFqS7eZaap5fcbYvBydm3kTVgKBRE6wndRobEW9zqeI57k9A3wYMGt/YZQZwjNoqZkAHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992220; c=relaxed/simple;
	bh=wrCw6QYtbAtAjoXr8u5vWlaJ122mrqoxMHssYpqC5PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLOz0cLT8D5buuCFOdsoMKhAMzRfAynGqFoKu7WaAgCN5Oq1fDwOgFMueaNtDE9WBNyWXKizyuPU8WkT15ntaXujh+KdKpKbDdDqfN+VXthFmyGBHNlmz+MowR5UmPZp1EY+ZNL/l00D4a+RFhH74pdImR3OP6pZDsq+qy0b86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/E5fXIW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b0ujr1K1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/E5fXIW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b0ujr1K1"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdusW1926524
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 12:03:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VArKn6HRSgJ5ORsNQ2h5LlmQglM2MWTODNVNkO1AMKc=; b=l/E5fXIWIUi2ga5n
	68l3PKkeuQfCkRrACbkitObZjQCPKRtbyOD/KVroG3bZtibwqwww6LbPTn2ttor4
	lgqVBMf3qsm+TJbmcKpDvM9u5l665qzWJ7GU75JmbEti1rQVC+0TTcbICTy10Ajp
	QlglCmjAV5fo8FBrX+lTao4ufrFUXt8Ek8YUzgNZovGeZ8B4KXA/1a/bJ0XIB3dS
	teqOHW0wy3z9bElB8Uj13suxH+M6cSkpLy7Pqs9lpYxYAmyNmj6ahLI+s9sTCF1r
	1VucRkKLKNEXfkEgJQ1lMuBQ138/nYR+G8VIACt4RpCIqvJQ7rwrEyybQw/ol1Uq
	gT3AEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3va8um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 12:03:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so7367444a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789992216; x=1790597016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VArKn6HRSgJ5ORsNQ2h5LlmQglM2MWTODNVNkO1AMKc=;
        b=b0ujr1K1pXF5eo6SM9RAoKkP0chCPvXyyZ90YoyqteyDc2erTyR+b2xEER3QtvTywv
         8p5MxxU82kEPmEEJm0YluZNjddlbbwdR/kgVCri0sWli7VmrNvGIRajAaDYePUFE5f9o
         R4lH1foKu2HhXYXifAC8aM0L5d+XWOIs/gSdJLFnPH1bOQNPHsufdyjXeRYsQkElJcpw
         ivYySlYyYhHxJhyKVYd6JbNwxyTmbEVm7b//HqPBPyz8uCPpvaH3yzFaZx09ObcSOYuy
         p5wBwia9pYCtRDU3NtdwBKlBrO8m4oXBf6tnGEXSA/mFbcHhsI5vdK4KVz+/hKyg2ymi
         Q7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992216; x=1790597016;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VArKn6HRSgJ5ORsNQ2h5LlmQglM2MWTODNVNkO1AMKc=;
        b=k5XwDn+a0mNfNfeh9sxRrvmFPWyaoiwN0LMXXgo8KiaigHs119ADlvqHyr8QQe8GHH
         2iXtj51zTuxIB0th9/ZlaY/YA5qqS7IaLxopjWzGIIe8LgEuKpwTIFv7ZEurZd9E2SDD
         bzo4wyZlay63S6wvhdqxNWm/ZwTwSLrB6XgT6XA6HtwtCwSHibIyLnjl3f1FljkkTJNc
         jtKylZgVwugvz5EtP/zgCW1heaVkXSR1a82ElxYvVhv3nWf2tZhqNs128lz2G1g0yiWB
         On5cxntkMXJ+JrPLK33DmQi4Nd1xzDDk0BGp0SNJqZ4atUnLohA5e2kfkrUZ05m5w98s
         ryGg==
X-Forwarded-Encrypted: i=1; AKwUvBzMzkETU8/ann35sc3q9O3WtC2wCEeVWu9wcgwjL8o/c2IxLqVvBDQ0sW+5u/yR1QEkiHR/UCL0IcE=@vger.kernel.org
X-Gm-Message-State: AFuF++l4ffYMLe7o9QF5+eYPxmt7dGTVZ2JM8Bi+Gxujd2i+bBtEmFPs
	SGJoabiLA/txzFYE9QDi/Xbj+ac26ddaQdT9XCnuwBfupbfzOrx5CUmWbmfWJ7a11mfOtWGkfiP
	xoeDvmtshnRYbfA4YfWIs0/CFJ0nJIYykFIsQC2msveqAiDRP0pd2AfYnwQObnrw=
X-Gm-Gg: AYBFou24iCkDGxtA9x+OnLv89uw/NHtiylsuWV2oAxxo463lA4zsF6+az/RczpeqVw2
	UMB33o8HpwHcPXxMG7/n+XZ/HujkIllEO4PnJ2wPAaS6dXPJkVRECcuxMGj9Xh0PtEFCuOITXXT
	YaoZd4ybnkAP3Scg708OktqNaqJwzCFNoFKj9wAZ5g9N5N40s+LEIdzGMz1O3FKHe8oqKwtFuX6
	i5PNJuehzXvmfguQlDonQ2FQn3v47WyevKP19GUQ/ShZDDX5rXAH0A/5MoEmFf8b57S4KJ232VW
	1ohtnOwYPO4BXJCHWjFb9tXXIERLAZ7TF1dgPWde4iz5XVGUC2kEkLfblpzmQliyREgudY7OHyr
	BhDHZ1t1F3ud7pzorKJPJep6Ng8zOv1w=
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:656d with SMTP id 98e67ed59e1d1-39e6c6a6757mr9411741a91.48.1789992215618;
        Mon, 21 Sep 2026 05:03:35 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:656d with SMTP id 98e67ed59e1d1-39e6c6a6757mr9411692a91.48.1789992214968;
        Mon, 21 Sep 2026 05:03:34 -0700 (PDT)
Received: from [10.218.4.101] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb427casm14277769a91.17.2026.09.21.05.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 05:03:34 -0700 (PDT)
Message-ID: <5fc58faf-dd51-4b7b-a2ce-5acb0ac6bbd6@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:33:29 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ytia1IYX c=1 sm=1 tr=0 ts=6ab11d18 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=787kBdZmKeldAlDLGqgA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: ivz502S5AYTd4B1_vBSSbuaBnXYi5bm-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX7Fwz1st4InF0
 I4nxn1ZkJs362S0grnm38tngdorz6jeiy9hMeqaGNEzKx8dHYm6Nh6bmgR4u0fm4Nq5THT1XPcx
 2Mg6TFJPGJd+vHX/g1seieBZC+aMjy4=
X-Proofpoint-GUID: ivz502S5AYTd4B1_vBSSbuaBnXYi5bm-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NCBTYWx0ZWRfX+a9gM5laAhHy
 bXa7d047mIQYpDnxi80WyfuWGJUE4yCsM23vFm601IQCGipVgsUIwriNx6Jwmh9tPKJWWfxsCPi
 zz3o67Z6aCGfYKGPCXwjmWY8GwMPU3VUoJVcByU94YCwqB0pHVzM6IL0x0WMLKLELvhHKBA+xBR
 uEJ0iCUmMO6NOVJBJ+gFvF98NU/3TJ0zoMOi+khgpXwnfALzXtVF11GzE93pY77fnA3byAum76E
 iFxjoLljn7NqVqSmq7GqcidZX1sNfZ5Cc5q5G8bZgjdBcNlYI2/YbBrX2lF8zwstOcpzmPiVX5/
 Dm6oc7rz2uSkuYsqI+3sH7tpLO0IFGcgMIG+PQUboeIirtaqZ+XRGtB4TCnwtEW3q4TPNByalT2
 qq3Y24DZcnJl07qEW0PHrGJhaFEsb9gYjlrbyX6DI+NnNz7/Vf/UNJ43wIe7Vcy/+9CuCcdzeRd
 brSkVx4z2bP0Sl+nt4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210174



On 9/21/2026 5:17 PM, Viken Dadhaniya wrote:
> qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
> selects an index from the hardware clock performance table. This always
> picks the first table entry regardless of the actual source clock
> configuration. On platforms where the matching entry is not at index 0,
> the wrong source clock divider is active and the I2C bus runs at an
> incorrect frequency.
> 
> Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
> performance table index for the source clock (32 MHz or 19.2 MHz). Store
> the resolved index in a new clk_idx field in geni_i2c_dev and write it
> to SE_GENI_CLK_SEL instead of the hardcoded 0.
> 
> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
> Changes in v2:
> - Update the comment describing the source-clock frequency requirement
>   and the rejection of higher-frequency multiples.
> - Add a blank line before the final return statement, as suggested.
> - Link to v1: https://patch.msgid.link/20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com
> 
> --- b4-submit-tracking ---
> {
>   "series": {
>     "revision": 2,
>     "change-id": "20260807-i2c-fix-se-clk-conf-89f6f92d373a",
>     "prefixes": [],
>     "presubject": "",
>     "history": {
>       "v1": [
>         "20260828-i2c-fix-se-clk-conf-v1-1-9adc72308f2d@oss.qualcomm.com"
>       ]
>     }
>   }
> }

Please ignore the --- b4-submit-tracking --- block; it is internal b4
metadata accidentally included during the rebase.
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
[...]
