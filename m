Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2590A3EB7FF
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066360; cv=none; b=NnUETRHV3tvmNyLMK/NTwwZ3EfeFVm8Cus/A9ziGgUFgAvlOGzw3DfNe1MHoAomGOJlSHV1TthwloBq2uah+H6hLuPSg3CfBUGIwzgmuJa7qGbDmToMyNKwzVKJCv8eanJcjA7Qr1p0pV6EN5Ha34faDxFiBRmdYmH7aerJ5mnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066360; c=relaxed/simple;
	bh=MGHfaR8jlzUkkXidIGH4kSnaaY60wAaRTetyKjPVzYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6nepgumJhXJ1BvKEYUIQX2myM2oUiCFNdzfNcj17SWu+qQ9e15xrjrIo0a8aTY219R5+g+VfHy//MX2lK/6FYd1ynlfOm7GFkjKj4USaYMz0JZvAinkCTNegoBe0/HAG84JoFPT+2D9kVlG9OK4KoBLHocVZtrVmd21nVPK3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WsnegsD/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j0qyfvJw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WsnegsD/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0qyfvJw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKXqr4119185
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7fDi3qZvLhAdC7/0jy+gsVwkzd9Lct8DJ2M+A7e3DX0=; b=WsnegsD/WRgT7zBp
	KZBLOe3RIyTM21H3gknjzlTo+0dXRAyfiCQQTVtGDsznzUIm6YH5vqc4ByboIQmp
	eMmW18qt9ncuqZ+mPB9WBd0MLqIkVfvWtaQRM8RJciofK8pHhC/ecd6O4NXuEarE
	YCJiL823SF8/MsQIuuzHJGpaERcYn6mDnlZWfQ00wNkyT7IF30sqJemQv2r4j4JA
	WuWWtvHZNOuEh8j5uCSTHmDMMrvF6UxOdtJbYHwPO/eXakd3YZUsU3U4n67m4K8k
	9RCjb6XhNP7JA9zBEKKNBGJ9qQMh+JJGbQVNtkhpnIstTuLfKltjCEsovzMocvtg
	d5yOTA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rch3mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:52:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-365fd467cf6so11606461a91.0
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780066355; x=1780671155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fDi3qZvLhAdC7/0jy+gsVwkzd9Lct8DJ2M+A7e3DX0=;
        b=j0qyfvJwv/MwEWNQFyeVED+kb4rQPzwJvf5HifFprzBQuZ8Ou8j8oXbU7ngnUt+pHh
         urZpvVfzmK5ihcc1ugWJbzOk5/Czurf4GZB0RLFc15cFQ2fGrSwN04PE0tEiyOvwSrn6
         RyhT5vg8MmMGkL/Xtbv5PJqMaAMSWGUMtniOfSVJ4CAEhabHrJhL0FNvBtrBURlmcTox
         /ehu3Snt93M/eJPSopsvMZ2p3DG0aU2imAkkUZgL5T7Y/lmFzrILV9g/NEKRX6AGklNP
         aYBFc98dGbnJJffoyvRV8YqijKUgX82b0nhg3edQ/zLs277MBPp1V1EYgezGcYCE5qz6
         FVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066355; x=1780671155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fDi3qZvLhAdC7/0jy+gsVwkzd9Lct8DJ2M+A7e3DX0=;
        b=aDTtSQLj09hgeWfBUeF6JmFCm8vj6jM/nvbvwylaJzpvp4dm4ZbMOukewsVGQr6jwZ
         pDXvZeTZfYpSpnX9yIj1ZxAKtmWkBz5P9LwRhjltgnwgtGS4LNrH9VeZzZmj4vPrxoom
         DL2PiFXsDw3uw+DSyqylQDOLFjkcy0SE8dMj168wSjrmufO7evcFKHaR6EVY2JBjY2j1
         X/CMz7Vhn5Yk94Huye3uUgwLQQ7S1nKDDR7mvcgIeCMzP+dEFOAx6lUFNWgVZX6peA8x
         uW/ey736b3xwBFnV9Tq2olser7SYlrrBxA0F2GrWrcqluFB9sUkwN6gCX6JXgioek5HZ
         vr7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+wNTmri6eA3L570nwu0s61KNXiNASGfGfI7DpMLV5Qkx/rE9oitcZovfw0KHqn8VIs4FohSappw/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNPzn+VMUFoI3JTi86GnQtXti2slfIsx7oqrohwh5wYu+yaSl
	uD9e2FA7IG8KNcn6Lzgrja92RTJQ4aBdjK4CSUWX6M+FaIB/tUMIb9Senw5IxIaEzDvH7aRtdoP
	LhTGMIxwpeWUx1CeuvEnjtQCTgnEdrIZJoCLCr7WZUmaPrbh7qQNvrd7EZRoq7b4=
X-Gm-Gg: Acq92OHUVOZTyRnuBL/DTRumq21ygaAcB5rG3ciZEPte9d4WTS82JZqfa3PePWVBcwy
	9ecDqICYbmiVia98t1nfxVcgyhFMUd6aGqTOuvzbzkiiWlDXxaK6/GSpdBwHHFJ80kzhpq/jzJ3
	UhTZ7apgJRdjGyiP4vlWvqobJzhbCVWdgc8Wa4O3fvKVcuoMl3bzAldAwBy4d6FItOu4dVmkvfv
	PvQZw0WDKObcGZG/YAigDhIu4ZuXA2NkQKAHbWP9i2CSZald7qckYYhvo6PRTKghxUf0NfRhzQV
	QGF2g24SqC9eEezTO8T93lztbWSdjP6q6guxgYSIX1sd4CkX5WsU7jiLkA7jeU72i2GUHnZleqv
	abJ0XyPmPg8/RTj4cuLGIwO69418MlgH434agmgffEjDsKmB8pQY1wA2ikWAPY7o=
X-Received: by 2002:a17:90a:d40d:b0:35f:b572:ece9 with SMTP id 98e67ed59e1d1-36bbcad48acmr3569133a91.5.1780066355531;
        Fri, 29 May 2026 07:52:35 -0700 (PDT)
X-Received: by 2002:a17:90a:d40d:b0:35f:b572:ece9 with SMTP id 98e67ed59e1d1-36bbcad48acmr3569081a91.5.1780066354875;
        Fri, 29 May 2026 07:52:34 -0700 (PDT)
Received: from [10.204.67.150] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc9bff159sm845633a91.0.2026.05.29.07.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 07:52:34 -0700 (PDT)
Message-ID: <df00e8d8-21ab-415f-815e-608eb7ab0967@oss.qualcomm.com>
Date: Fri, 29 May 2026 20:22:25 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] arm64: dts: qcom: shikra: Add CAMSS node
To: bod@kernel.org, Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
 <20260526-shikra-camss-review-v1-4-645d2c8c75a7@qti.qualcomm.com>
 <178000689150.4557.11759359941436928903.b4-reply@b4>
Content-Language: en-US
From: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
In-Reply-To: <178000689150.4557.11759359941436928903.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: HpKjaUoFX9MBXsXX6rAKbCCFEETQPhE7
X-Proofpoint-ORIG-GUID: HpKjaUoFX9MBXsXX6rAKbCCFEETQPhE7
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a19a834 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=i0fgkIc6DCDsPB5MfecA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0OSBTYWx0ZWRfX/Q4Z+mWwe9HO
 /oIFJqsFYuR87Ra7iwWWgCNcSBiiQG5inmrjZihfWcY+pxF4pwjlce5KIFATZk8+c2SaeIHx7eO
 hAGpYgb+xoZuW41OqIwgl7cR9tnKDRt+K7E6OTEWNfYj2iiGlPJu9Wn21laBI05SBIDBhLeVcQX
 IvgQ6hOT38GJxC8670/PbWKnJziCs8fjtJlXcelhr09I4zugyZojvG/D0xeYjM0H4coAIMXvxGK
 zKM3cunkqXI30Ntqv1PiQML+1b5bpMEGCMY82lk6H43QbRvXc9KOoWTA8kxc4RD43ks9VFFWtTU
 bhXu/SUJn8HAnlAXGpb0Uy6yOP9mw1RP2C6NL6Y1pv5CH82V6r65aHIaMCC4OgWhfZtvq8T10np
 9xExQcIAEPvLOk3Lk+TBoMwDP96Qb5lbT42nWcG1b301X7FCF1cCP6MgnZx2ByqFMx4mrNWeQrV
 Qvl6R+lIZNVL2lLP1DQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290149


On 5/29/2026 3:51 AM, bod@kernel.org wrote:
>> +			iommus = <&apps_smmu 0x400 0x0>;
> So I'm suspicious of this IOMMU.
>
> We should list the full range of IFE SIDs here not a subset. Since we are
> register compatible with Agatti that implies to me we should also be IOMMU
> compatible.

Shikra and Agatti are not iommu compatible in terms of Stream ID. Only VFE SID is same
for both. Agatti is documenting iommu for VFE, CDM and OPE. OPE is not yet enabled for
Shikra and in my opinion it should be added as a separate yaml similar to Agatti.
"https://lore.kernel.org/all/20260508-camss-isp-ope-v3-9-bb1055274603@oss.qualcomm.com/"

Regarding cdm iommu we have excluded it as we do not use it to program registers as of now.

Loic/Bryan, Please share your thoughts on this?

> Please list in your next submission commit log the IOMMU SIDs - comment in
> the DTS is fine too.

Sure.

> Ideally list the IOMMus for Agatti/2290 and then explain why the singleton
> you have enumerated here is the only required one.
>
> Right now my suspicion radar is high that either the Agatti binding is
> wrong or the Shikra binding is.
>
> Possibly both.

Regards,

Vikram

