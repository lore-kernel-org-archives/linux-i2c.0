Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC4344031
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054863; cv=none; b=UMptnj7/hdmS3+Qg7mr7kzU12PSUfJxY91sball21udeIUq1FZZ4gK27I5ee9cp3c8hbRULcv44jD5ob2gHCWxrrEzehkO1U9CvIF1c8CjJAH2kBbayrHdOVP8lUL/iLsUix2cuCZw4+OkZfasIYZzlMKDsVRAHBH+pLSoGpL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054863; c=relaxed/simple;
	bh=3r7knVhGZGq+WCrj+RsM6COqa6AyLlTag3U5LHNzNz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UuWcS7JgmoKh/JU0No0HqVqHsaWd6wTTzuwzS9NlN94cXUnkU+8fBWLARNcLEPIQP5Xp4y28p/+EkzSPAu4gRNwY3Lw5W7dWDybnNvMfsvDQhOvuNU2ngvgXvxe+Kc42WybTfQrQGAgau4frkvvsGhH/SMZp9nGXD1l2wlytFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLhnj3He; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LS5fAMST; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLhnj3He";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LS5fAMST"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABU731021536
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kyfh3wdgd9lUoXbO0HmIc2QmpIubp30Zz5X3LdzooKM=; b=bLhnj3HeabgyONhg
	CfDFm/DWs64JGtmP2y9pmUBaNj3ocmMiHzKn+57jTANan3EXr4u3NvlbdUgQadxP
	mANHL4EOgaY0hn2wLFrE3oQGkoSh03nkHEI3MH/qSNQ7xcl1Huwscvf3gcwrjdd/
	1o9AQqZI+WoqQDPnE9vnE8tC/HVqWM8P6id3PBXasJFlIOHfoPGIjewqCTU/uYEY
	Rtx1Ah7JcabgO/Ye0jTmw+diu6JfAbU4NEuDhGxmtNXQOB9/XhrIMqcvnDvb4ebG
	tLqu01K00t05GjyEDlyw0hQ7egXqgsNuNIoxGF5NNG5A6eK0Cdj1LvKfc4FdglXL
	JWD0wA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0uk04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 12:07:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9349ba88188so117384985a.2
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787054858; x=1787659658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kyfh3wdgd9lUoXbO0HmIc2QmpIubp30Zz5X3LdzooKM=;
        b=LS5fAMSTODFNgE4NVM/h3WzX4oDMdyAkaafypLGIo2fy5ik4dwIDgw098C9RozMHoH
         fbptHdTogGwdyrnturwoSuWQgoZEo9JH6vBMUdKZbWtU1ADb5IDepBKZsWbwhmDYKSDq
         ezeykQX1jGtEjLrFdVZes5SRId+7hSUjq3i6l8wjCVhHFl3EaS0GyA1ENH/eRgn3oVcB
         PyqTL126KhQTQ6blCSDLAwDmMbnKa+lDeQyTSXdvja+rK17dgSCs+gyavGHnUi0573TE
         /DeYLCt4fp/uYUtDKMKW/7jAv/6KhWHln2hWjBHicp5JSB7dZgrmn1DEbjrOjLJWUKhW
         xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787054858; x=1787659658;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kyfh3wdgd9lUoXbO0HmIc2QmpIubp30Zz5X3LdzooKM=;
        b=m1mvB23lNHcEuQoZX33MSXK+AiRXw/DDK4NkjMe3+jxEKqK6UkWQmySmv6pCvHoYJ6
         hAjes9jW7qP4EM2LbpsP0TEUsd+fAWxEcs/3s+b7vZrrWwQBNb8hWy9jgL5vE9GIGGff
         RylKttgkIcgrENeoeajUmhwLd3ZtTPcnMe95v2DqTO1hpI1G+I7x0fXbqX/Q+/4jv7d/
         cVZJIFDq6I9m6EwZfZw0MakA81qVSeEcsiY1wEUjkFS8vyAQaE1sm5YRMyZw92rb+T5+
         YfPPMnQkI7zIKDBLZu9gRu9QS8CM3nEh9Zmyy2gNEZfblYdy1at9heaL2hGHO8NEJB/V
         I51g==
X-Gm-Message-State: AOJu0Ywfm3WVC9HSsjacu07dumsbPNbz99XiXKbgdaogJuB95abnUT47
	qs8msPA4iMMkdzPrUXrnjVaUq4isulIdjRMzI1Jq6xXCpfrabo/W10j3MCQ8cVkXy1GSViGVYQm
	kxBxeUpZZur2t1V6CvrHa2NcAd5DN3CzFMLRae3R9xWbE9jCNYnZ51V/RqV/JZi8=
X-Gm-Gg: AR+sD11bebNkPmMQthQ0pTgO1DsDOqBo1OkWT7h6txOI+FX+Jqv3P3Y3l3rp8c/gpuO
	6JjbqgMMTA5cg5BGQr6UjLuU0qcYbpVbsx24VVRifhWv0qweI8zfoCKhIJSMLpy16PyEykya3KD
	sixAv7P66EEbpnuuy0D9POf9RKDLaGcZHDumnJI4AX9+z3AaaizEcRFMUDMmvrOn79JfF1UqwvA
	YVABavIx6/Z+30ubuOxwz2Qafc4AC4mdsxYumZr2bdWdJe2flMVKaZGh3UdOG2mh1lOjVAdCqSR
	jpBt6QGiz0hbbH41YcQkMpVLQ0dI3er3eEcIz91ZypVpdxzUO7cZxFqzk8YamhTwHzAWxPJ0PX9
	dCs3KAYcbsQ8/WE6B8m47uxDT
X-Received: by 2002:a05:620a:6846:b0:92e:5272:4e3e with SMTP id af79cd13be357-936d1f0a69cmr2304633085a.0.1787054858437;
        Tue, 18 Aug 2026 05:07:38 -0700 (PDT)
X-Received: by 2002:a05:620a:6846:b0:92e:5272:4e3e with SMTP id af79cd13be357-936d1f0a69cmr2304624885a.0.1787054857750;
        Tue, 18 Aug 2026 05:07:37 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3d8524445sm1699810a12.7.2026.08.18.05.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 05:07:36 -0700 (PDT)
Message-ID: <8eb4ee0d-a505-4b2f-b0ce-ac4f21384ff5@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:07:33 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] i2c: qcom-cci: Share the timing table across CCI
 revisions
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX/DW5h9TUMQR+
 O/wILT83jQQYjJYbqNNY4clCIaU2oVPDkWTLYADWhz90IGacAthP2ESoiAGOM5Ry5obGzGw7L06
 YIqTOzJiLHqEaTw3DRN+1AjFYd5NTuE=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a844b0b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=SwLGY96dXX6l99FlqfMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NqAIizmVT1iF8PcWYiTyLVcSduu_H6wx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4OSBTYWx0ZWRfX8b0fcQg+6OF/
 TpZ21emF/h9AnKDDdDYiZ2so8AgYg/V150UT2kF0dex5x42xSjgBc/DslRYYqqvSllIfAhtoprp
 y6HB5PJqRQ9i31CTKC7RnQfx7hW8N7TogEgmiWvP28B5y2vIk+t5w5UftV4e/Glu0YjhFMWEIDz
 ro4sqposGu0v/JZoCXWTeEUQzgeyeb4//YEyVAFkTH/FGpr4Vvfc0D5msLzXRtI9e2pPflydMbm
 ijeySrRGY/tmZPO4ciKKuPaXC1kKvQLoT5emLLj1HTiMAUbVwxM4aWQPVcxjV2HF9MC88KW+NHZ
 n8s3wTdpEkE0L3zdqMg26xBR6/zqrEBqQijm7rkt+75Oo5HRYGOSLWucdkkXnRJBBVSCCiEIG/c
 wVaETgUgVmC3hku4XsC0baPuSB6h1bjEDhlOjtVzq+xTC0FuRenDZSZWIwy9ERwCYi4T+U5ECLs
 KHFW+2fUaoyx+Sg+39w==
X-Proofpoint-ORIG-GUID: NqAIizmVT1iF8PcWYiTyLVcSduu_H6wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180089

On 8/1/26 10:10 PM, Loic Poulain wrote:
> The hw_params timing values only depend on the CCI clock rate and the
> I2C mode, not on the hardware revision: every per-variant table used
> identical values for a given [rate][mode]. Only the set of supported
> modes differs between revisions.
> 
> Move the timings into a single shared cci_hw_params[rate][mode] table
> and describe each variant's highest supported mode in cci_data with
> max_mode instead of duplicating the timing values. This removes the
> per-variant timing tables without any functional change.
> 
> Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
