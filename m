Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559938947F
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313053; cv=none; b=b85mxoy+uX/nAwI2cKHog/HTWUfXupJi1PmwKeXuiwXDxcam54qqJ53AfYhVEllGXzV1JZV9q3FhAE2Vvi5FS+ViVA3F7JW7IJJcO2E6x+KCoaiDWfa9KS2VRphem0WwvuKadln0/UZ3tlyhXFU13bBv/sAdUaJZyY+AukoFv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313053; c=relaxed/simple;
	bh=qF0Ufo/CjIRzKBzBQQtd19XCtcP1aSRWrtVrk1k3Gg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z78p+IR5DjonW8RP4PF3G673bXgCUMS10hHb5V8RmotROEn2anwkxbh2Nhdz9PIF5MDP0Vne1ZjJ8TpGvNoBYg9qvkmSr7KMtk14DmbcQQalDriIM5XoNirDKs/voevWG1jJB/KE4gOeVpGYJR16o2R0BzLGwjMpnxpaYLTFawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGfffAwe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UuM9Nhmj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGfffAwe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UuM9Nhmj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651BM1ia621997
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 11:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ArCUJSu0p5Rr7kXoBPCR6AQJ
	dxQ3plRaRNA21LoO2vQ=; b=kGfffAweEuFI61ksMVOgeMQXVInhen1UNYG1849B
	gwrE6W77PzXJ55F0VIo/G6QE4UFr4VkNBqcNCgraI/1O9owetKwsDe+zvxq7xoQR
	JYDcjuMt1IauhlADNOZsoSQaXTCXxeXtFXSOXr4Yig5qYSbSkYDYlSiSl+IYoTrg
	jMrVGCQesGyfSSSgReb1/L0IAgdQvm2ohB2TTzFN5ulheYqsCVycPI5x19OlXZUJ
	5dN3mHud3khZdJe/Co/J2rlGF+fRWBWFwcVan5WhgZDEXoXgvhzRgN+zGj3ljH6k
	x9rhNv4aGp3tYB5iT8vrovY39fBM4dC0tMc5/RiBrRS8bQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh954g08t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 11:24:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6751c50552dso3570972137.2
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780313050; x=1780917850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ArCUJSu0p5Rr7kXoBPCR6AQJdxQ3plRaRNA21LoO2vQ=;
        b=UuM9NhmjQwFH0QXyrNFau22D62X8VV6XPvsz0TbQXI444ON8Yb+JXzSemBat1rTFwV
         k3nDhRL0+dfSVirRraP8G4nh5o0z9VlGA2BhMSXGLatpkbFMR2XGoFIoFnr1EvOMdP/l
         +Jt+ZZSnWo1MsqL7uhFWByNFQGLfh+TC2jBLIq2c6hPELkItmYxN2/dDs83YTts1htQl
         /ZwwmekKx26Qv0ZkRK2HMVG/WXmYodAb7jZb37MBRJNiK979I+nOtr3kQPHMzf99EEyt
         JhxT8WSVpX0NdUtPW4PneWZP1jBrAoPRdd96+u8aGaHQoLpbuH3gbg2yXG8ug76aYcmt
         QJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313050; x=1780917850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArCUJSu0p5Rr7kXoBPCR6AQJdxQ3plRaRNA21LoO2vQ=;
        b=TL3V9g6hxK3kBWZ+iE3PM10VoADEqn+VIDOEJbc6mB7P6d62kWPXtnhzb0+C3Dn4xk
         c2PSb22B5xYqZy68G/y+DvYQSovr9BNm2fOWRp/vlwoUytF0bybT9GDOnscxZbE7eMX7
         dz5dCi74Na8IpZMzHtUcGUsa0vZcjzpxKQmXM5q2FEKOpiEswwTKh87m6z29wfeptKAf
         R7NNvWO1VY3aPHdlR91Ebi+n7PsohW7DL+Pu2kBCrzyGnTmmuOv8CJHTDPW7zymZPu5j
         CtH0VDvem1SXX9PDjPUqodJ29jlfyKFx+wa46yw2MDok+/7vqpfVvAB3iFOxgBl+EOKK
         XzXw==
X-Forwarded-Encrypted: i=1; AFNElJ8BE8JIOYeUJfjV1rZpbDki7z+Ezp4Z+pbTCacpSscorMGBnU47I9qabPoujO3gl0MDxtyc3nLsJq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5rCAIW4DU6PNtUl1WYxVs3fvkkDdxOl8WfTAQ/1vYetvXO6k
	oIOHIXT379Ryk4CT3TzSgfX8DN+XTzs8grr/fkKQg9ydCAFseV1rFbCeP2irddoBvKVlosv9NE8
	5WwMTcD6hWyyEOBIPoB/x39F96cSbUC+vOnqhv/WnET0qBXgp+JMRkHBlb8CEUZo=
X-Gm-Gg: Acq92OFtnjbpf/OYCNQ1X5Qya0inL+RwPXVrIcI5b+ux9nc+F5R6SpaBHrdplwX2M1m
	BnaA7P/Q22dtrkf2jUxG7XDmhCTOirmMrqmeSotljfBSPQRVFq45yK+0Nl4rwQvQvYtG1urgL44
	LHsrvB0iTCzh76JXiWA7ChIDCt8CMXtwj9rhnYAw/b12Fg0z7ar5ANYSJZNyaJC7NlLFIMqCX4V
	fRruEe4HUm5CczyjwdwmRti+FqRnj89ZnLgiI37Rp/joCMOhYUqukRY/Hnm3M5yKh3SVRJyLkSc
	6XF3M09cZjuqzYriT8ewjZQs4g7zTklAAuH9H1YnH/gRH+HhQPv2MLfQJxzRzXXSxHk2lMTntkj
	yuvfm3oc1UbaWrDuOM9wCKJ6ViQBIR/OJ64GYV3P4Xovu9trFE4AJdGhNrHHxXtMcGyIhK9sjAy
	fV/V/IyDwapBlQnKbZStmCDnyNB4K+rWThNK5ehVK53JmrbA==
X-Received: by 2002:a05:6102:5049:b0:607:4fde:1921 with SMTP id ada2fe7eead31-6c6976d1327mr2867662137.24.1780313050083;
        Mon, 01 Jun 2026 04:24:10 -0700 (PDT)
X-Received: by 2002:a05:6102:5049:b0:607:4fde:1921 with SMTP id ada2fe7eead31-6c6976d1327mr2867647137.24.1780313049688;
        Mon, 01 Jun 2026 04:24:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa70b75865sm182056e87.18.2026.06.01.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:24:08 -0700 (PDT)
Date: Mon, 1 Jun 2026 14:24:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 1/6] dt-bindings: media: Add bindings for
 qcom,glymur-camss
Message-ID: <5fdcnv3k7w2r5at3oun4eldgbmh2o25rmb234urksy72le7an5@ddl4aapbjexg>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-1-bee535396d22@oss.qualcomm.com>
 <8618255e-ecbf-4f55-877d-09cb2faa6f50@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8618255e-ecbf-4f55-877d-09cb2faa6f50@linaro.org>
X-Proofpoint-ORIG-GUID: ab-wCnFpWo-mLcjJkNqu5Ft4l3LSecVo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDExNCBTYWx0ZWRfX0qfdYXB6pro1
 nl/z91jB/9ROmeIvxv6Sq3IYS9FJz8YE9OZazFTHj8MCL/DgiqDPNlZMN+4wxles9zRCmo2LBAN
 wZ4rq5iF7nadUZYKXleWSFrDaDRqtqSMnsjM/LxJKuaPrterEP3+5rkZ0bnyGlaB8iVurXmE0Ml
 3FxyVB9P9psGVedg/u3HMrgs5ma7kmuwRk8RqLtNVYciD6TvELHVSkU8C1RrVSd1d3FfplDNeU8
 H3OE9f3XKPUGmY8KW02Q7RODn2sYzkyeQ3a/LsyPZP6P/JW9Xy3V3rD6ykDVc8vwA5tDViljmgf
 6aYJQCwjuoRjFonNtNptW1xXQMUwrdlbXCuQSBK9PdIbTG6Xz2/jVG+L5BGHoIzVL8aE0xIxgk8
 1C0RW8BxDHRx7/nLrc/qnLRz8DoN5w8oOtmgVpPN5dKCUftvEohH82MYvLuosUx3mjBeqCqxdEt
 +qkHsDrOSjxqb59JuSQ==
X-Proofpoint-GUID: ab-wCnFpWo-mLcjJkNqu5Ft4l3LSecVo
X-Authority-Analysis: v=2.4 cv=VpcTxe2n c=1 sm=1 tr=0 ts=6a1d6bda cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=YcgPmG4jwsFezTXk2NgA:9
 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010114

On Fri, May 29, 2026 at 04:07:38PM +0100, Bryan O'Donoghue wrote:
> On 29/05/2026 15:37, Vikram Sharma wrote:
> > +
> > +  vdd-csiphy-0p8-supply:
> > +    description:
> > +      Phandle to 0.8V regulator supply to CSI PHYs.
> > +
> > +  vdd-csiphy-1p2-supply:
> > +    description:
> > +      Phandle to a 1.2V regulator supply to CSI PHYs pll block.
> > +
> 
> To be brutally honest, I'd rather see effort and buy-in from qcom engineers
> in converting to CSIPHY as a distinct sub-node.
> 
> Pushing patches to hit your own internal deadlines to the detriment of
> upstream quality is not OK.

Can we please get an update of the the CSI PHY series? I think they were
some time ago, they received some comments and there were no updates on them.

> 
> This binding should be predicated on separate CSIPHY nodes. I've
> published... three perhaps four versions of that patch to radio silence on
> your side.
> 
> ---
> bod

-- 
With best wishes
Dmitry
