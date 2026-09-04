Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0323BF694
	for <linux-i2c@vger.kernel.org>; Fri,  4 Sep 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512477; cv=none; b=U7wRx4MAE4+jTF4oPpIn/59ltuw1nAq/3WLhBmh6vWole1jiadmhlevSOD8z1lBwLWTKRvaUHjwq36CpELkVxQ/O6KD6qMbkjhCDrDRVgKJDnEcQjRQTx+HpWiHVK/9FufaSR4MVn3CNP1hRajgT0QGRs7a5QWrYw5KLzNSHsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512477; c=relaxed/simple;
	bh=z8mUeY8jdDe+OPla++cCBqYJoVtldQxpArBHUi5E2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe/NbT2US7GurdJADT+ieFQ+05IB5o0FHPCJ8EBMFTfLCpIeEJk+8uVdbAJ/rhJu3E6S6n+ANpJPN/IxPY1dHIauIg0+U3hav9Pim/vKezyt0Hd6h5fddML7IbWz7g/o0mYdh8q7a6OarLRTVe49AX1k0Fnauo5muy+YEpFh/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdPDAK05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QwS/LRWe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdPDAK05";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QwS/LRWe"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847n5HX2839766
	for <linux-i2c@vger.kernel.org>; Fri, 4 Sep 2026 09:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=; b=jdPDAK053fGQzOXD
	4cj+xPyScRRHFDeNL8zcHzs4mOeJur0khdg/RqOwN2LWNkaAIBRuQ66CDy9SNfUz
	cdjxEZOdcuoo5xTcBheqPhDXrE3G5fga5X8nlO191lDpsOMTqPXi6oWY2jljfKQV
	59dl4zlsOQKAGJaFwidGakLayrYMXJrPbLTGEjifEYBP7lgmaCOAlYeIx9GCaBDf
	M2HQZMn55+SmjevbfDJp9azLFpkl/eyqSfKf8dsWQyuZeGef6wUQhnewV2I6jRla
	FTBgBvCfz4S00/OEhRxPpzd4j/JAyFQY6vx5JFZwoS0qJnO2TdcU0HCQ3mRYVUjR
	lvuEAg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqtrpcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 09:01:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ffd22d2b1so1994821cf.2
        for <linux-i2c@vger.kernel.org>; Fri, 04 Sep 2026 02:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512474; x=1789117274; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=QwS/LRWeEVIhjKgkJCqHF99IJ+vtzoMWQL8MzRkkZe92HrORwTi3paXWXqzLOMQQ4F
         7nw0p7zKMz8WCmKjkESHp1RYXFAZExzWqRs86+4U/FE6N79NJAVYO/bVb0NHbrOR4ly9
         MgChSKoITkdd/Q/wZ+GZLU3u987ShDMut1Z/h7nHeK/ej8mPb6xTdgjZJxXaDd8YDaWK
         iV9JojoH6K1Wta1/MkZlC0IZxjPzwReCpuZoFa8Swbc7gxjGIZNzhPQ/J9TstR5fGTV3
         SqsLxfn8wigxWqYYaA/aefTkc55Kaoh51cyM1k+b42OAj5Psq8nf0MGp3CHvaYK0CBqq
         yRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512474; x=1789117274;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=GwVoTQH9pgd3QG/FS1ulZKzKZqj3dMPBpy2xhBkxHJBziaOnTcyj3gB/YWSe0Zatfs
         gQPhpxZoBvjzAPXoV9arza5lnKy7fl6Y1VqSRcbPb5O0iV+aIr61KHLsR2g7AjMrnjYA
         k7SL4GZ+aU89V5E+lRQqbWQwa7UBm8zDYBvJRD9lxDBG1lywqTQPI/6dkOpYdpoGP3aU
         +jiP93rId4GpI6AE+FCyb01C7pG/1gLAHreAsF8ZGdnQRCSAp2tdxqQZTkqIbNEWdVrT
         DvbeYSruwd6QP5Q63eAwu9ZamGxHxsH+SLprMp51HtHx1HqF/z46ySCjaOHqmdn17wi0
         j0Bg==
X-Forwarded-Encrypted: i=1; AKwUvByvCzsE9OqqLVUgFEx19Yw5MJsO9He9IV6vMXzhAW/gmnO9GMJpBObY6RUOXsrmOCuAZHCo1l3yjgY=@vger.kernel.org
X-Gm-Message-State: AFuF++k5y7iOMDdSsURCc5mKoNcpuNSCGIkjnthmfDNpoBxVdDVyutN5
	WVnd1JlszZ3+Y4TzY4fVwhBrR3yTzqKVAFtQtnW0v/xbghTY6Uimlz5XkLdGd5U8pAoO3utsjQD
	6l+VAwP0n013gvPUfSdayhZ3nNnDtxOmB6nHLaEKjEiLeDAnTpjTZADYzAAAqSWX2hQndR40=
X-Gm-Gg: AYBFou2/mTN3JsdxQ3zpbzIVvNQrfpKnP2ppZHJUMxah/JNlk1RmfgGaug2+cCO67P1
	W/4NbqrBULaILrjS2i04IeF6nW8g2ZCZDWbw9AHNFNwpTyP03Q3E4lRCAKj2BDu0ubZB+ZMt/SL
	r3uhld8mTbSdH9zHRp/+arVj6h0NwPuQ0wxwh2DH9cv6DN7XVKLSBqzX8BM69yHJpXC9JPg41Y8
	KWJgu0ygbwsbc9cUHOJg5ffjbXh+2vqDpIytgjLcrw1BILuwnOhfxoMWEZ57FxkE8sseNJeeMg3
	vvVjUQ1dE/AjmCSsgf5qW/qSNNNVVerRaoPzOFg+unM+DZ+Jic/4LVh7ATLMPh73Uy2ovNjvKLR
	FjrJOQiSMJCVxM58JZMtL6Q==
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341377185a.1.1788512469154;
        Fri, 04 Sep 2026 02:01:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341372085a.1.1788512468661;
        Fri, 04 Sep 2026 02:01:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm76155866b.40.2026.09.04.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:01:07 -0700 (PDT)
Message-ID: <b245d6c2-825c-403e-ac73-d569820895e4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:01:05 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a9a88da cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 8alBQsj3H4htk5RuvVoNd8AscYmdM6sK
X-Proofpoint-GUID: 8alBQsj3H4htk5RuvVoNd8AscYmdM6sK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX4i77Byy2oRpg
 v81cWpMEs6fNwNoxpcCNEKY89/ey3NaJprcu/WJ2713QQ4jWC2OK8lqIOMDfwMeoELqKel+GNet
 uxmuT9Eri5VI/C58P2SUVwLaYfb/mKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX81FEhZJvAj78
 eTzGQ4gFF13uZVUW8RQp/QMc0jECWmnjz41oqukScRevTAm3C0rxp099D9G7Z6gtYruzDlwdZDq
 rI0Yovcm/XDFGAlk2BWtkhwO3Jgk9B9E76uAGmsHf4EHs3oi7jLyj7pKezXGlQoan0UM9llxhJG
 NL8WD0bpL/kVY07uEU6z3Nz/zGl0q9e0ac2pNMpzg/6RbDQCeNC2h60XOFpWr+eXkdSlohxcYt1
 RWZ5p1Tlz2YC90Q+E8e6AzdqtWEFAOY8KM1Kg4M+1i+B2FYUgE4QWL0AJxAU/ueA/ktripaoN5d
 LuxFgCSJR3HMjLdDkacLKlQYqB8JRk4FEdtSDLHa20Ry3UixOeOEe0sthMmQWTfK7qz5oq6jlOg
 E1AnUgniqcz078kKL9UGw5z2ylDATtFy53HKt7fG+eTwLQ2cRz5mitqtTXAXCsUXDq2i+tDJVVS
 0x9QmTxYXm6d9PoGzeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040081

On 8/27/26 7:59 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]


> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;

For !se->has_opp, this silently does nothing, which presumably
may have bad consequences if the caller is unaware

Konrad
