Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE338CFED
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568479; cv=pass; b=MRDykyrOakC9bBKhiZzWd0ke+1OccTu8ESjDCXYfsJD0XhaRJU2RiCidQ2CIEekrl6eGB7hHuf6x2qbAWnFMY3uaMn9K1Uwwkf5hxY+rufCGAWHgbsQlBww4+5LPdq+xO+7dhdn/Xh/pKVrBOPglo3QLK6ooc17XZ0vN7t5OcRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568479; c=relaxed/simple;
	bh=FoLnMNkzqeKpMuu+hR8xzZnVrJXqZEd8JbxRn61bVqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lsg5/zKQ5nZ83ZmqzPuLk5p4BsxFfb2J9yQTf+mgOModMqQl6AGJAYOdu93yzKXlUrhBTzf3lP9ml+gqdeVD7Q6tk04EevEQNWi5sq80ncuXc+F0G2TMhSUDtmxZSXIuFTnMMDy1ZBJWPN+oy19f4DCfibpMSnZQO5fgjm8jY30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfrLuIye; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8mOnCB7; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfrLuIye";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8mOnCB7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6713DVBF2065322
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 07:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCXBcH2ut5gRN32kpD6L5RV/tPGzXmadbsvQBUEN3Po=; b=ZfrLuIye48OTH9t3
	JbymXtlSu1ZjOXHJwQebgIL4sm1U4EhVhQsLkxMd2TwVyx6renYV/5Yd8I/N9Ef/
	5Cg3RvLnWAM0JeqhPVglJFJNuDlNp04Zz2MOGmF0AFz/HeiSJZIvE//3UIw7EQjF
	SBb1kNECZeOoijJKlzxWYHcBwOlahfuD0LcZfihsr+r0cCk4jv5Ix4w5EP9IaW6C
	LQJtHBDA0gbZBobunZm91EseQGseJRF4KS/CDQsMjN/NR09MunfV7ODzCtgVsl1O
	uXKDOlbj2CosJN6id4Sgl3RpOsRk1HUoS5vHyyl9jGWr3s8IyV9sQmbtVsQJkgQH
	ljGjqQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8q50em5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 07:14:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930edb4362dso138596285a.3
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 00:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785568476; cv=none;
        d=google.com; s=arc-20260327;
        b=R2oUU1V8rKREkvAEQ/ZIO9MczLTYvVSZwejgqhl/kb7t8QdiEafBNs3EHH2ZiS1UuL
         p9uYcww5yUnlKzRdH1VMtuTMy/+FJjYAPZH12UmTg37rz9Y/r4nAb6s6mLc8iChGUuWO
         VHWx5/Smeyxdcs4IhLsdUUQs79AuydruiUkdNBt+TEbXSYnbEcnRFkuRwAR7oLW2UJ06
         ZWconPandTMiD1OKRh8DEqA+FN1/cC1YKKDdbyPPtxaLgPRY6kveQOnqXfDLU4L+V31v
         lf4KS+QYIZJVUTCDXmymGxJK/M1JRWj/kR8lWWv+T3cDTFqORmaTcF0vEWcPwcxMJTD4
         DQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jCXBcH2ut5gRN32kpD6L5RV/tPGzXmadbsvQBUEN3Po=;
        fh=rCfZMSKOkHJnWVcykFK6kcFLhS89GhaVoYs9Oqfb/Iw=;
        b=ZUuWY5qtlFdev9a5M0t/9g0a/Xn/CrWeOUftwDgBusYPDR2Mfn7pyktc8+d4hOJO5+
         dLswJ+GOiYUWIJzKrn2mm5SBcGZIE0oifaQJG9qzUKXwrWdxfk9M42SDTT5beWcxAc6l
         giTeXoAMdLzjjUsoDEnsgTDbDYsKTtZiqeLXWEHOcIzAofYbiwDl+mcF/rcEghPWyrbY
         KxxOa/Gc78QGz4lBAVpiktxzPE/igKrgazBQYpgnA3Nu+8tv+KyI/FS4OifpgHZIs5sR
         LARFpPIqfWo2V0e+j2J4hRdwvtzOqrZP17OjOyp6wFZpwiEeX/9j6SBHJdxFOQ7eOlX+
         Nmvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785568476; x=1786173276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jCXBcH2ut5gRN32kpD6L5RV/tPGzXmadbsvQBUEN3Po=;
        b=W8mOnCB7FE7p1RxNsZq+ovfEHI1lJkwR6Lfn6M6jKdr6qAavJ26hvpDg/NThVZG9Uc
         Vs4VyRc5+1RU9OwgZ/1g1Cuuj1VHXZsE0S9G5W0xeP6lNYmjsehBEDU/+6BywOr7QuFx
         EyXXxwVpMZf8GpA0fmdPfHY2zYHxc51JmI/iYN1IQA1Ic70/WkbvEJjwL5L60V/VCaCh
         RmGObZGYBcxYOPnJBGjeSXPW3fATeqt23J9oqi7kMcpkIH68txKfk0EpWwF2XDx/uVKF
         MtJEDdW3D3B/XuvQBZsF9ACBag0TEveearcoil5TlBr7wkbNGaSpnTmSrZxAjnn6zi3f
         5c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785568476; x=1786173276;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCXBcH2ut5gRN32kpD6L5RV/tPGzXmadbsvQBUEN3Po=;
        b=h2aI5W0BI4Q9mZPZB4WOmMlauuvnInB3gnHWdv9hILrbc0IMBXSj58IDbzLE/XjmHv
         WhvDxELO3vuECVsNuA1WnOYCZmaNTYK8jLpF7F277mzstpmu60903GF51zkk0jLtl2F4
         u0X+pWd78hTnGgBPR3YYI/2Xg6ktal1pU3+Z0gRwlKAuBu5KDu2dOvRNL8eTgSSi0uxq
         +2GBwGUzFgUD5GUtSrrCNzen75Y5rUWE3fRNqgSxEhxEiiYmSXU52UrUDrcHJ9U7AxLs
         IcEknI83L7RaOcN/3zlxyPSoDe5hPo4CuAzFgbZJv/poKmIakkAwV8nZwP1CFZ2akY26
         w7gQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro07Yy0nDGtsIlhwkCykF6N55J07sZkr/el2JC6noS+P8jFhXgr3WduOgWBvtFwYhForyKVRJ/qs6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxItWN3SzvMp0/P1PbQEOxk30aea4zIiF9CPtCO2iaElzrGdJr
	WOQn4cBy1CsqPODAvJhx+zRprWN95O4Ny6r/7unqhzSlGPCQJVuhHAHsTGxPiPMqJC96wjltzYh
	Q/EKqgJicXhJnhPVFYYx4djXJBG1AF0q5hASuEl8fa3EwFVxh6hD2NDJO01bCAHSJOxlibISnTp
	M3l5sVMYgqvboA873b0oJCCc4Q9nAyBWp8drW97A==
X-Gm-Gg: AR+sD13QNtRKGtYKOYWnu71fK/rHkJIETIAKjLVXn3N5JM6qBPwOovkDeex3+nQAVkI
	wDXvpDsZ6x/OLpLqZ/gt19QLmuQZBpWidxVHcCy+0f0BmIw+m3eMogx2yE3pSVH2VPO//n6YgL2
	1A8h1YdqMl+S/zW55PF8U4Ni9iznRnJqTznpJCDKabOOZu08ifK5V/9ot5RtU78w+wEEKtNA1wr
	8afu0B5UhXqPtFLYgH8jbf7D0R7z480w5FRbic0rOopfKf+2lSC7FIxhqUMIutSEVKCXPFmSuU=
X-Received: by 2002:a05:620a:3183:b0:92e:e632:1471 with SMTP id af79cd13be357-934a0acf023mr475635285a.44.1785568476073;
        Sat, 01 Aug 2026 00:14:36 -0700 (PDT)
X-Received: by 2002:a05:620a:3183:b0:92e:e632:1471 with SMTP id
 af79cd13be357-934a0acf023mr475633185a.44.1785568475607; Sat, 01 Aug 2026
 00:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
 <20260729-cci-clk-fix-v3-5-f3c731d1596e@oss.qualcomm.com> <am0Li7jT2BQAI54k@zenone.zhora.eu>
In-Reply-To: <am0Li7jT2BQAI54k@zenone.zhora.eu>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 1 Aug 2026 09:14:23 +0200
X-Gm-Features: AUfX_mxGbl0pCWu0ANaqcPtaK03nU8RQ-p3Hmw3seBTi2N1Vo3Ep2CGZoMCqQ0w
Message-ID: <CAFEp6-3d6POaAnAb6kPxenKxb-68AnGNr7oWz0MU==hppMeUcA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, konradybcio@kernel.org,
        stephan.gerhold@linaro.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MCBTYWx0ZWRfX3trLDaU/MZsl
 2DYU+REBp23NUVkJtxjrSLqf4WFy/jgHqgn1rU7MGmfpYDSM6mutex4yvR8q7Z3hBxzbpzHxuvu
 slGO/1FhypWcRvxs1VjGqYBBuvr/0S0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MCBTYWx0ZWRfX/hfOftxq26Cl
 AO9SJ6It2UDT1X44n2Czot441jhV5glCDvM5wwNuuQah4RO/dw1otXEOY2SWxt2Ei86iPSD7uOP
 nJDfmPfPTQm1lIe/0hZXwar7SIHjUUKCmMeVYWXHMK+V6M07AGRz/AnKgyWuKjRccBFJI+BRiIf
 HaZzrdPTZttGn5FC+ZJGeHFW84zep24kNsiItapt8dsjAQ/sBEwor4rVjhHT/akRfFYxwXPyE+f
 Y6r2JF2MgYudCJLkQ0W+LBlfeOHsxIZkZYsv1bWF3WCYoCdfaUT+jabz7dAoXuk3zzvr56gQy6P
 2Z6sPSp1/7aHajBIiRE/uhp/vFAJWIbIRaXfTS2SWoSBqelcPvs/94aFV8XHbx+zZdu3nroLw10
 t82CFyz25zn35OiQT3DR49/k/kuE0SgF91solA1IQ74eXtjTVLoSTMBHzCLovrgEjBXZ0JXK//l
 4KYVw1TKy1wUDGk3sDg==
X-Proofpoint-GUID: xs4hiMu1panVJlTs2WljufRoNaYI1sXy
X-Authority-Analysis: v=2.4 cv=IYC3n2qa c=1 sm=1 tr=0 ts=6a6d9cdc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=g9bKSjx6ID7T_xEQ07YA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: xs4hiMu1panVJlTs2WljufRoNaYI1sXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010050

On Fri, Jul 31, 2026 at 10:55=E2=80=AFPM Andi Shyti <andi.shyti@kernel.org>=
 wrote:
>
> Hi Loic,
>
> ...
>
> > @@ -588,6 +646,10 @@ static int __maybe_unused cci_resume_runtime(struc=
t device *dev)
> >       struct cci *cci =3D dev_get_drvdata(dev);
> >       int ret;
> >
> > +     ret =3D cci_set_core_rate(cci, cci_get_required_rate(cci));
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D cci_enable_clocks(cci);
> >       if (ret)
> >               return ret;
> > @@ -694,6 +756,19 @@ static int cci_probe(struct platform_device *pdev)
> >               return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
> >                                    "failed to get CCI clock\n");
> >
> > +     ret =3D devm_pm_opp_set_clkname(dev, "cci");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set CCI OPP clk=
\n");
>
> what if CONFIG_PM_OPP is not configured in?

In that case we will 'gracefully' fail the probe as the operation will
return -EOPNOTSUPP. Actually, this mirrors spi-qup and spi-qcom-qspi.
On a qcom arm64 build, several always-present symbols pull it in.
That said, it could be better to make the dependency explicit rather
than rely on transitive selects and add select PM_OPP to the qcom-cci
Kconfig entry?



>
> Thanks,
> Andi
>
> > +
> > +     /* OPP table is optional */
> > +     ret =3D devm_pm_opp_of_add_table(dev);
> > +     if (ret && ret !=3D -ENODEV)
> > +             return dev_err_probe(dev, ret, "failed to add OPP table\n=
");
