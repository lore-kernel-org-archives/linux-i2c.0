Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA9155757
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784984804; cv=pass; b=Wlgc4MLE44upt/cmLTwqHZrVjSk8xT4TcM4SYMEp0apn1akj3UOnDKbjskpY82qJhSYWsu7F+x99usRwDi1YVH8jyQs0bwhiy84oKsWcPBf3cLyt6fiuBEdGoQlGwdi2VM87aeqKUmfK6RgaB/+oM62Y/y2AomHPFtTTiW0dBTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784984804; c=relaxed/simple;
	bh=2Uh9eT5tK8Vo6mo+sKW6kVlIwzKg56YPQeznGWsFhOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBA0E63NdONgbGwFrp3NSahXegfmAoK9lJ4kcS5c4N2mC1g7+7Aoneq5jF75M3XoX4jqomoQJRiLrzd2NV2VguBaiwerVRRblXAD0M+X9KSbqJ+6IDX5VLo65j5QijFDDG4q5n0NxJCUV29pGRX0o7or2rWfciwlTjfgW6mkt0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BugCbEsu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BkCrxuxg; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BugCbEsu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BkCrxuxg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P9BbjS1661160
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 13:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USdCGOXvhOSXrJtdi7etv1/dOPdyWHrZPu0jrOTEMuE=; b=BugCbEsu+a/LmeVr
	C4J7OmznDDC4jOhjg1zfq2EOMxHu8yQMNfqPMtJ8ihMtU8eHOVWeZqARl0ImbUCz
	GA4kej0I5fNfP4Y207KjzSNgcR0JlKQ7jCVeATmYF/zyhKdFPJtep6Q8V4UEl+MI
	FKIZTgSW2uxXraygkpoL5zcNvTVchFr619V695N0ZTK0l9Vk0Eke7/kZdw6N/Ab4
	a9KKNH5rodrHNTVrUHZ3/D6K6vI958FCWZeVpasJKLI0jHYSSZx+sZYGM6ytnWmT
	lA3rdNvpCuKNVHqTjpsfa+wIRn5KRhtnd84YkYuCRXUJV0TWqwrAhKCkWKA6iPfn
	tR1+fQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmnc3gwjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 13:06:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930b571432fso152597585a.0
        for <linux-i2c@vger.kernel.org>; Sat, 25 Jul 2026 06:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784984800; cv=none;
        d=google.com; s=arc-20260327;
        b=nuEty9rRfoDw1ackCdotLosJAJ7YZjCgMrwx/YuF+FlqCY1z6Ws7bwH/dZ7igLCacW
         e92jhaKvif7zGnnUqKVKrEA5pf1th+rf73OOrM/wHXw5YVIfR/lQrU1oLcdotdo033ip
         4VdVvG2yeeVKLy7PvTYJ8IPJNuCJj0FdkHSyOJqgqPWV7A7W/wk13oDW7LhX3aNDqOT0
         0l33nIerLWgLGqxyTZvAhvrCSkNawoBUuERtjAC19WuebAjSQ0nxzUXDHE+u3oQZuWLR
         R5XTW/5umLvmfZLkmTTvKLGS0WdO3j3rlJ9GqLD5m1p8d3N3KiE9HDwhrnxsBNUa5+EY
         cpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USdCGOXvhOSXrJtdi7etv1/dOPdyWHrZPu0jrOTEMuE=;
        fh=kbrAb4qJzFpoDpXHEh2Hp0q6VIHIGiqP1+BOxYjBeRQ=;
        b=IftI29vS/Jj7WBmVnwk2EYHHHXt6CMzHWSel9uocoQ+F4/wDr8Z+Mf6HWGnIu+dKul
         cwNAOo3nBZk/TZULJZF/50mnGTs4Ld+6/a3Fyo0xMY0BM+NRYyre6Dp3ASt6eFyT6q/y
         EE8+GqganJtxZb1un2i0HWobaJgyK/v5e7mtTp2gibJtzBmcv1SHaYcQX/pLzhKJikfx
         +b7nJD0ok9BxcCrluqtwcM1jNVQwxoWwTHx8SEP0MAaoKSo6SdYjHR9xVauX6zI/RBVv
         4j0nXkCAHW70KYXB3D/rjPiL2y4T9EeVKNX08REUT9VPY4DgH359In4ahjcc6hi2q1OX
         Oatw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784984800; x=1785589600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USdCGOXvhOSXrJtdi7etv1/dOPdyWHrZPu0jrOTEMuE=;
        b=BkCrxuxgMrcmfSw0kdCsXAfmlvKL9vQwDlrsZVH16ZBSWzSwCk1cAxDPcEf+Cf4e7j
         s0eF3e8qfsQITi7M3nAxg99zmaWkIaCzS/VrThiq3IchqKisUnxcr6rNpHd27Fsg6LDI
         YD26evVx+apwWkPGEOnglnfkG9sKcEuHlEJ4+wAd7SRCh+8fMWAdmgTZYyizW5WziXFD
         kguQmPfC8W9adWHHnwg0w2c1Tsy8U5M8qhoNsuhfsI3VWm2/+EPsFYcb3mkcBX5UabC9
         GVKaIRzAQNtCqOHEIdJTxLtHnXlHiSmRx9n7jf5StHANCFb5+o6EDXJjOf2fxigoBSqh
         QZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784984800; x=1785589600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USdCGOXvhOSXrJtdi7etv1/dOPdyWHrZPu0jrOTEMuE=;
        b=gOXfNs3LgHCK4IG9RWwK6AX+FBvszPfh4kqHtVxYVH1oc3SgdZNXAkCCPhFoSY70C0
         U7Ai7R25J/GCvEblGdLWuGy40T0O3w39D604U25eSFNEj5QedJwi7uN/XT7JumNfGB48
         f1Mgz2lLCF3UntUIDSLrr2CQJd+r20X9/8m0aAudRvUOgeZrHNm1DFd7//tlFHd5Rh34
         PFWsyiOv24sNLSc5FJPRWcTF7Cseo7m0qQZsy2BXzVVB18BhPo1birSsBb7kqN5zbw+J
         ZD6kqD3ZcrHrdyw/dlyOz8LBfF4bUScPeclerm8xdZBucIR+MtuK/m0YM8W/Yr1wfRal
         8gxw==
X-Forwarded-Encrypted: i=1; AHgh+Rod/wOYdKv8YOM1NbJ8CDyF+J14nX5L3sXImKgW4j79kO0capYcgI5JMdTLJM6sJku5LLn0KG+MBRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+g1igCXRlmbfvxxsl/zC/XVx/3xdYFgfOZwFDjC+TVRj4MN/
	+U3a4k8czNoh+6nikAkOMB1uAlTxry/docH0KFC5dZCEVOJUILQKmgIxQSsA87A96iMD/XCvr1y
	gd2LVt3ykPcWyTVMLLQPRVaizSzps5aDvXuJpNyH3nCo2vXV0AyFvfg9XnqF8UOoQ9mhj6cGbKT
	uV87TCm4JqfzYqDNgzpH4lE41X6ZgfMcqied7WQQ==
X-Gm-Gg: AR+sD128ZtwbeZ8TJdhQpXZ9abvCbvry6NuxpenlKRyEgwOExW95PuhfxLi19EbUDiV
	bvc1Bj/LuS1UaMY9zNpcoydA+GilypKCNrRFGn1HkyQUo2K5tA+jdOaehH9DDJmJYQhqytfPwrZ
	mgUGgGPgTeQJOuJErGt1fCEbLhIf78RGsPPDT68ZVgomx9E7cYWXqymrnbVq/kWvbsi8uXNugfa
	WpO4PsM0h/ns7VLuN7TZWhlQ53AC/TOZT2YyYHDNF9ylt1KYJr+94SkCO+v1oPT4BxW0AO8Tp2Q
	uDzyWeYE59cmmCl3jbHY9iPQ8A==
X-Received: by 2002:a05:620a:7081:b0:915:29cd:306c with SMTP id af79cd13be357-93283072ba2mr474269285a.9.1784984800352;
        Sat, 25 Jul 2026 06:06:40 -0700 (PDT)
X-Received: by 2002:a05:620a:7081:b0:915:29cd:306c with SMTP id
 af79cd13be357-93283072ba2mr474265385a.9.1784984799917; Sat, 25 Jul 2026
 06:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com> <8d20f3ab-696e-40a4-a05a-688779299071@linaro.org>
In-Reply-To: <8d20f3ab-696e-40a4-a05a-688779299071@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 15:06:29 +0200
X-Gm-Features: AUfX_mxBZYabrUQfsrUEOG-i_LCjFJ1GwsQYG5u6cV8cytNozvrdZqMLkqF8--0
Message-ID: <CAFEp6-3OKp0XhpNmp-yYwf4r16A=CD5eA-Ts1kk+mFjdCA38RQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] i2c: qcom-cci: Add missing cci_clk_rate for msm8953
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDEyMyBTYWx0ZWRfX0mgc7deSTjBz
 gOartKv3CshpVZxSq+qAifoA1GlgTif3ofZledMI9zD8HzxP3APUqAoIp8FaMuukKAG/VToa6C7
 kclgKXtt/CXD9kLxVfxQO4MHf12WjFFxfXurzUEacKmshhSr+2ItSGDkXjRbIyzBOFd2OChcEO0
 isAl1TsL3It0DEHlRnuNTpxVLRr0iRC1PyXrh7PjqHM0X+KCkGmUp/Z/rD9XQMketX9bGYpLOA0
 P/j4ZA+BgtXfv9078bLONzCrLwpbT/KSkJ4YimuqKVB/TeuyUQRI59edt6XUZDrO4RZPG8oiTFT
 sgqGA5lfksNd6yEUigAWtBliWWhvettqwT0tB//lFMFZfaepQLC/MKFx0HGwTrSL+n9Tczu1H9s
 WRsrR2uKl5VNcpcZ942hpSJMoBsWoKo1UXrENa94Q3+LscOtY+i1z4u5HWgmrbs6ITei9K1R7og
 /obqu5AUOuyLV+4V6HA==
X-Proofpoint-GUID: ezRaeQ9SuoWR9nDIKPe5gKTreqE_xHqM
X-Authority-Analysis: v=2.4 cv=VcfH+lp9 c=1 sm=1 tr=0 ts=6a64b4e1 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=9uqHTFpEoz8C6ldqAIkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDEyMyBTYWx0ZWRfX+eVIMKAVNSeU
 F2vcvI45JWftbV1S2I6ZuBoE+bEaUaEdbdjT/fPVTH79AkYd8yzZh1+JoKoNFCBCiEioGnefOnL
 wF2IbBw5jE+0eFc+AVw9CO+7MAdyGj0=
X-Proofpoint-ORIG-GUID: ezRaeQ9SuoWR9nDIKPe5gKTreqE_xHqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250123

Hi Vladimir,

On Sat, Jul 25, 2026 at 10:36=E2=80=AFAM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Loic, Luca,
>
> On 7/21/26 17:58, Loic Poulain wrote:
> > The msm8953 CCI data was added after cci_clk_rate was removed from the
> > driver, so it never got a clock rate entry. The DT assigns 19.2 MHz to
> > GCC_CAMSS_CCI_CLK and the hw_params values match those of v1/v1.5 which
> > were also calibrated for 19.2 MHz.
> >
> > Fixes: d202341d9b0c ("i2c: qcom-cci: Add msm8953 compatible")
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/i2c/busses/i2c-qcom-cci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c=
-qcom-cci.c
> > index 19e4719f13b29b2cf60e113565b1b63f19d0e669..5f74edde8558382e63e2c3d=
0fbe19489f325e8ce 100644
> > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > @@ -783,6 +783,7 @@ static const struct cci_data cci_msm8953_data =3D {
> >               .max_write_len =3D 11,
> >               .max_read_len =3D 12,
> >       },
> > +     .cci_clk_rate =3D 19200000,
> >       .params[I2C_MODE_STANDARD] =3D {
> >               .thigh =3D 78,
> >               .tlow =3D 114,
> >
>
> this simple change is wrong, but commit d202341d9b0c ("i2c: qcom-cci: Add
> msm8953 compatible") causes it, but please note that the commit d202341d9=
b0c
> has no explicit issues per se (if proper frequencies are set in dt), but
> this particular commit 2/3 breaks the whole picture.
>
> Let's see, MSM8953 I2C_MODE_STANDARD/I2C_MODE_FAST settings repeat the on=
es
> for v1/v1.5 and 19.2MHz supply clock frequency, but I2C_MODE_FAST_PLUS
> speed setting very close to v2 parameters and assumes 37.MHz supply clock
> frequency.

Good catch, there's a real inconsistency in the table, and it's also
why configuring the clock rate in DT independently of the timing table
is fragile (and not even enforced by the bindings).

> So, at least one clock rate setting for all modes is invalid in this case=
.
> Automatically it means the reverted commit 1/3 in the series does not
> directly lead to the wanted and well-managed data, and the logic in 3/3
> becomes invalid.

Agreed on the analysis. To be precise though, this doesn't make things
worse than they already are upstream, msm8953.dtsi assigns 19.2 MHz,
and the Standard/Fast rows are identical to v1/v1.5 (calibrated for
19.2 MHz), so those two modes are fine today. Only Fast+ is broken
(without a DT change).

> I would suggest to grasp the statement above carefully, design a bit
> better solution, meanwhile postpone applying any commits from the
> series, especially if a breaking change holds a Fixes tag.

So if you agree? my short-term plan is submitting a V2 with a
switching of msm8953 to the CCI v2 params table, so running the CCI
clock at 37.5 MHz, which is what SDM630/MSM8996 already do (same HW
version). Moreover 37.5 MHz is supported by the msm8953 CCI RCG, so
this is a viable single rate that makes all three modes
self-consistent.

Longer term, clock scaling (probably OPP-based) could be an elegant
improvement, but it's a bigger change, also CCI block's masters share
one clock yet can run in different modes, the per-mode timing/rate
can't be chosen independently per master.

Regards,
Loic
