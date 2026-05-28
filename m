Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02313ECBE9
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971121; cv=pass; b=C0l62oG0ZT57/3+Y52vu1H/pWMwKXqOcqThyvWjrQSdrod+B7ZyvyTtzbuUSHuGQ+twedw5nMMofj/cdV3DgtrpVQhYiNxNYVl82RQdpXoLKd2K7z+85k7vPnzd20mjaEAWkxibMrLCsRayA+nfJxfjwqA+LUypBN7940qexxCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971121; c=relaxed/simple;
	bh=rjGKcaiPzzE9XfowjPUEZRn6zT+jUKQFamebPp3qZ4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTodzpdi7/0aeHSx3RKknmS0qFCWi8l+hB5MOyroe06pj4dz/ShMkV+QbR6+SGxLCNdsdRBFvtarEduF4sKqQeTNvOwNQsFFx6JBNdL3vzP5sWBs3+5p59aN6q7K7XBXqICS6D8AuA0pwK00aUpfaBRt5B16qTx+wdOolH7BWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prEfC2i4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZMuzG8B; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prEfC2i4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZMuzG8B"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vSBf4184451
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 12:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d3417W+FQetIJ6t9E35gaP1Wyhl0UtZ7U9jN1sdRzUY=; b=prEfC2i4IyXES7BC
	cmHulPI14uPbrVtMetN2T5yu4ICQO00WgaK+A6eXmgJI1v7hE9fii++rwodl+CgJ
	mST0ZvEIHGyhietuMO6fYzSAJNAzRD8ppMDX5EdMynHhNRkTmvNeu5bXYvzPcKdB
	rA6oIBqgnEmljP1Z0rxr7yVDRlNHKXT0pivyyFO5kR7FlVfxbwaHpqz5Ta0WTbp9
	6BnOI1vOHCLXZDz//RqETpdeYe9/zaf6TLaJHqlz7Bdkrx1h3kD3pMG95XEDk2MC
	DvpNyX4lbx3Im5Mx5bc6unNLyEB6lrMTHPd+XBXSQFjT+C1Wg9a7joPe0d9r3EBz
	WzGJmQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf2prr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 12:25:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914f037b7dfso599718185a.3
        for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 05:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779971117; cv=none;
        d=google.com; s=arc-20240605;
        b=T2qKyY3XSFFbUMoTRPuuw80ulX42CEuT348MY5xs4x+HJ3l26nKTNvxGCb3q9eoQbS
         zzhjvnLFC+w3AWSjpv6Aosvo7dRnTA/9EYyS/UJ8PU4b5X6aRx7Z5wwsU47leeRDYNua
         7+9XbWj/Qn43Jur9aUPYcY1UEy4a5RgH5RqaQtMj450fDXoOa9q9c/Tu9V/Vjt6HhQ/B
         z7scNVwgCv+ExfwubynWWs5KQ4JRKQI7PN3b0x/ZPcvGFYuKxdijlivz/GsFlSboDLB5
         a8gp9z6ihfCaTMCltDZBByQaoBX2UBoFlyw7MLNADqCUxxhQMpFGl8KRYusfZVZ0hRzj
         isdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d3417W+FQetIJ6t9E35gaP1Wyhl0UtZ7U9jN1sdRzUY=;
        fh=BZvQrmQj6sP8OPeTuLsweZWeOilSR4K52ZhRKMOAmTo=;
        b=NmiKU6ljW8oxs7UW7jx/Dz0o1vBN8Q9Or385NoejL4cLL2IwRsLoS3TwUaMVdIJHlI
         dOMw0FV0WK+vUGdvpMAa4/r6AJk9cu7qebkcYB+j64ZNf/VMJdQllftNIGF5RJtccr3P
         +yoVGeBUC80HJuuFYq6E+Le/ZsdwxcpDaTYdDPqRVXHsOmbtYOw3M/wtOHoyXMh40vjk
         zw+eIlrHXf/utzXL6ptIprNyMzwyvGcofZz9nPlv8vI4SYFr49PGO2SPI39UxM4p5j/l
         GoUxnzB1RqrfTdyDctE7Uk0REjyIXfXXktJIuQML1tzo9wCu/n6BCE99iPsC8TAsD2v+
         5vlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779971117; x=1780575917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3417W+FQetIJ6t9E35gaP1Wyhl0UtZ7U9jN1sdRzUY=;
        b=QZMuzG8BzyeJWyVaeoG1d3GykAoRlxajPSwjX1kPY3Q94GZF0NUbZhCiZhhQg07QcO
         AOtQ0IraRos0+dASszySCYdA2jDXAURWgr91VRnbBrOYxS4iKPppD9E3ykQR0vUZeG43
         L1a58Gnd+Xs4j6B4A3mIjiyttHz97UJi7Ammp/9y1lTP94gd0x3q1zq1dHjTkf46U2Zn
         DtAe6PgsygUCYa/7ByQvom2IZ/lyRM+SrADua4O9b7tMP3iJVnZw0TD59eda9SpB/1tK
         m/y6y1tAPlfvFLUsfyFMb/UuYy3ijLxNIDFGUKoB/1nTuy9dDPnkfoECypOZLkMPJoC/
         mU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971117; x=1780575917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3417W+FQetIJ6t9E35gaP1Wyhl0UtZ7U9jN1sdRzUY=;
        b=LJXTMO/50v/afL9oXHjDTMmdXpxQ9Vz0D9yvZVuHY48enFQJ6Cz3XTuIATeVGBZrOr
         ppcmwlRfMFLTju7wnvVaH5cvUUIlDYn5GuyUuP/8JfLig2zSb9gh+0eEMTwBUamCTWIz
         lvRJ/jKmcDfgLpAbVeZFyPkkoko8t1CAF1hYYkD/gC24sAGnmKQFEDXI66aEMiI6B1J+
         XlE28aGls2xZO3C2di7YeOcg4OCPYTiA3NVLP22ZP+mE/LfLT7+Rm2cf/qWQTmNAWGpy
         KjddhWMb2mZnCl1MGF4Ikidv8tJMSktB3victR64YyKfd0QywyCun4hMbS48Q8q8tVb5
         vJ3A==
X-Forwarded-Encrypted: i=1; AFNElJ/lpmwCUwwcEDcXRxsxZ0n2OI7rTZ6cnp6YgnofqZYAhYn+7g0FkqmtCSPpOl2GCf+irQu/APqPu2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXaENiLdu3juiWmOUSXEiXYwitSMNsOzTw4mJW9koBUlO1O9Hw
	Y6ZSmpN3nfMR0xQeFc5hYqDLEoe7SQQfynR1xV46ssHbDVzjPoCki5dpYbZbXQ1QYz6B3FM8JRR
	a5QXRtrh9VDHAxA7pNSWVxavd4jUAl8iDQpDQnVsUXutHGsaUy8UjpUw7d9vVTaRVXmSXD0peez
	35Ynqlerv2u1FZvMM9+P/lcipI0VbII684Rcfofw==
X-Gm-Gg: Acq92OEKXMv4+yoJQfncx+MMkNFwhk0J/KXkXgvHt2HKlUYO7FfoAm8fvtAEFMiTe9z
	HqnysHadGaBbZB2UMxuyIABDVDBELVpezUkXtPbHHQNT8KTunKQZuRfq7a0xJCgueRaY52hICfq
	QdOlTYJjr9bycDTRa3qQKOfKwO/nlG675j/2WNvQjuLMnqWGOLVuQsRue2jfGuEjPhz8vFcd2Em
	vXQSIx08CB1Xf6abvdzukwng19nYr0/HDQNR5iPIZd1O7Je
X-Received: by 2002:a05:620a:84c4:b0:914:c0bc:a7cd with SMTP id af79cd13be357-914c0bcaf11mr3886831885a.48.1779971117117;
        Thu, 28 May 2026 05:25:17 -0700 (PDT)
X-Received: by 2002:a05:620a:84c4:b0:914:c0bc:a7cd with SMTP id
 af79cd13be357-914c0bcaf11mr3886823885a.48.1779971116654; Thu, 28 May 2026
 05:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com> <20260526-shikra-camss-review-v1-3-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-3-645d2c8c75a7@qti.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 28 May 2026 14:25:04 +0200
X-Gm-Features: AVHnY4JO8P8GLceB0VuUyA9tvcNmn11LuhgjLHguxnzI4BEUk6ZkF0V4tx2XITE
Message-ID: <CAFEp6-1VAW-S2d3q3uN2n1weMOoSPXtX_k_6msQ-K_5A5mZVLQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] media: qcom: camss: add support for QCM2390 camss
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: "Bryan O'Donoghue" <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: RKysLNdHsP4SCvBXZ2XoLEaBWNluGpbS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEyNSBTYWx0ZWRfXzcCAAaDxIeHt
 4qBpiWbsyKDvw1PV7V7O1kWWvi+YFM4FmKmNT8IrFm9FpR/Zn+spSvTaG9YlYvoC6vGjp0/h1nB
 oC33L2lgLKBJXtu0PTJr4eEWQKO2psjriCEypCnDewL01VLm0XC/bunZ18zi57iRt44SJZ/J29u
 SO4Di1DZr1i9d/H4qBG0O7s7MVfqLkrzh4DwCZ6P87Eh/8xow9wlfHw9c9/sHMXK8mGU/WyChdA
 wQ66SRXZ2+if2PJxpQ2nHkFJz8mMcMtxMXQLPFPlEHZlpl0wA5JV5LzD/RJfdShwAsJnb04+30z
 ijtcRYuJraL3zVNtlGR2Y+A11lvmtWyChnqdTpZeNzCW5CrcwwA0gPkaR8vsJ1t9j4mJR+Y3F5M
 cxCGYFgRRzYB4n/6NgBELbkBxjpVSPn7yL86CgqkyVgQhCG5V7/lIANXeqPAi8JFHX3CbAmarXc
 LYFFk7jSdgXQ+MOfeaQ==
X-Proofpoint-ORIG-GUID: RKysLNdHsP4SCvBXZ2XoLEaBWNluGpbS
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a18342d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=8qkcLw8Gk86Nxc3JiHYA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280125

On Tue, May 26, 2026 at 7:13=E2=80=AFPM Nihal Kumar Gupta
<nihal.gupta@oss.qualcomm.com> wrote:
>
> From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
>
> Add CAMSS driver support for Shikra SoC. Add high level
> resource definitions for 2 CSIPHY, 2 CSID and 2 VFE instances along
> with the interconnect bandwidth votes for AHB, HF and SF MNOC paths.
>
> Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c |  2 ++
>  drivers/media/platform/qcom/camss/camss-vfe.c            |  1 +
>  drivers/media/platform/qcom/camss/camss.c                | 13 ++++++++++=
+++
>  drivers/media/platform/qcom/camss/camss.h                |  1 +
>  4 files changed, 17 insertions(+)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/d=
rivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> index dac8d2ecf79957dc05c5524dc439791ce097c785..62208f5c4f17bd6c9a8fe5613=
649920e6ee1a1f2 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
> @@ -1130,6 +1130,7 @@ static bool csiphy_is_gen2(u32 version)
>
>         switch (version) {
>         case CAMSS_2290:
> +       case CAMSS_2390:
>         case CAMSS_6150:
>         case CAMSS_6350:
>         case CAMSS_7280:
> @@ -1222,6 +1223,7 @@ static int csiphy_init(struct csiphy_device *csiphy=
)
>                 regs->lane_array_size =3D ARRAY_SIZE(lane_regs_sdm845);
>                 break;
>         case CAMSS_2290:
> +       case CAMSS_2390:
>         case CAMSS_6150:
>                 regs->lane_regs =3D &lane_regs_qcm2290[0];
>                 regs->lane_array_size =3D ARRAY_SIZE(lane_regs_qcm2290);
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/medi=
a/platform/qcom/camss/camss-vfe.c
> index 319d191589884777bced456867e5a2a4211a2770..b152f8d48e003d8eeb0cf19ad=
57419b25cdec087 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -342,6 +342,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u3=
2 sink_code,
>                 break;
>         case CAMSS_660:
>         case CAMSS_2290:
> +       case CAMSS_2390:
>         case CAMSS_6150:
>         case CAMSS_6350:
>         case CAMSS_7280:
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/pl=
atform/qcom/camss/camss.c
> index 2123f6388e3d7eafe669efd6b033e22d8eb5cf79..f67ecff53f15bd213dc7736d4=
e5fe880007d1ee7 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -5565,6 +5565,18 @@ static const struct camss_resources qcm2290_resour=
ces =3D {
>         .vfe_num =3D ARRAY_SIZE(vfe_res_2290),
>  };
>
> +static const struct camss_resources qcm2390_resources =3D {
> +       .version =3D CAMSS_2390,
> +       .csiphy_res =3D csiphy_res_2290,
> +       .csid_res =3D csid_res_2290,
> +       .vfe_res =3D vfe_res_2290,
> +       .icc_res =3D icc_res_2290,
> +       .icc_path_num =3D ARRAY_SIZE(icc_res_2290),
> +       .csiphy_num =3D ARRAY_SIZE(csiphy_res_2290),
> +       .csid_num =3D ARRAY_SIZE(csid_res_2290),
> +       .vfe_num =3D ARRAY_SIZE(vfe_res_2290),

So isn't it exactly the same as 2290? wouldn't it be easier to have
the shikra simply fallback to qcm220 (via compatible string)?


> +};
> +
>  static const struct camss_resources qcs8300_resources =3D {
>         .version =3D CAMSS_8300,
>         .pd_name =3D "top",
> @@ -5752,6 +5764,7 @@ static const struct of_device_id camss_dt_match[] =
=3D {
>         { .compatible =3D "qcom,sdm660-camss", .data =3D &sdm660_resource=
s },
>         { .compatible =3D "qcom,sdm670-camss", .data =3D &sdm670_resource=
s },
>         { .compatible =3D "qcom,sdm845-camss", .data =3D &sdm845_resource=
s },
> +       { .compatible =3D "qcom,shikra-camss", .data =3D &qcm2390_resourc=
es },
>         { .compatible =3D "qcom,sm6150-camss", .data =3D &sm6150_resource=
s },
>         { .compatible =3D "qcom,sm6350-camss", .data =3D &sm6350_resource=
s },
>         { .compatible =3D "qcom,sm8250-camss", .data =3D &sm8250_resource=
s },
> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/pl=
atform/qcom/camss/camss.h
> index 93d691c8ac63b2a47dbb234856b627d8911a1851..8ba8a38113dfc15849fa333d0=
5b2c3853f3a7714 100644
> --- a/drivers/media/platform/qcom/camss/camss.h
> +++ b/drivers/media/platform/qcom/camss/camss.h
> @@ -82,6 +82,7 @@ enum pm_domain {
>  enum camss_version {
>         CAMSS_660,
>         CAMSS_2290,
> +       CAMSS_2390,
>         CAMSS_6150,
>         CAMSS_6350,
>         CAMSS_7280,
>
> --
> 2.34.1
>
