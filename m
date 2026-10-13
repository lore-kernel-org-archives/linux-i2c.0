Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF33AFB1C
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879687; cv=pass; b=PTlUQhTKPLJl8+JEIpp6Z5XD5XpBidY5CPtM8ifGblAU3MwwJqOEOxDvNNHFT/4paeW8TTd5o5vHUbjVEE4hzJjlz9J6mN6nSg7ty4GId6XmL5Zc9IJdWv9AbJYV+SGbikODlM8EKPGMm0nPGaOdOCO8TdhFeuCWmRwuspSUYEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879687; c=relaxed/simple;
	bh=Nx1SjMixwkrle4y3U7Ab2IqOkuOdHGj1UhkIxBeqQFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRaW7p387ba+QYZSg47qqzvGBz8nhWkTDwduvOoLa76UFjPbvxtfxTPPgLQg8+tgGLg+1CoMBV1esr+Rb4hcsiLu7qZU232iTsadnQKDOeFJtX2bAnt6IjhLbalxPUQulPsgeKM6fOH8r4MZU07nLpprVulG+ZY129wdb5ZUQK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJqhhety; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZ48H5fD; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJqhhety";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZ48H5fD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21Jcd4072150
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 08:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1PNbxNjxl3yMAPLNBXy8s1I6w1mnoqka0xQAK1gKCs=; b=gJqhhety9WqLgbhm
	DPZ5pkN9ePz0IasGDvLN7xivT0wGbJVPY+JcPy2W+WhjY6zWN1Y82ADafcAjCuY2
	uy+EmvSLU8BAXl80MLS6loNmUnCXQKBlwf5rmZqMLRY671j5TEst+YtQP1qwS5i8
	qMyWyGBSQYjbNAXm/3oiCiwy1de+ZlqjGl94XHIsP+D6vRQ2zx7x4xK6AcUUMwDe
	I7Vq0MP1HwbxcvmHy3j+s0yLAH22SXe/i83KaozBfk4zRsayTDgqveZZaHDoT5JS
	r2WD8zvrfv40NUSUjhYOvDRuRfIb1ilb0eUgJzF2z4vWXg3zOgkxViHFc3YewnLa
	+2l1FQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h92jjugjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 08:21:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc359d9easo458108685a.3
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 01:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791879684; cv=none;
        d=google.com; s=arc-20260327;
        b=OCgU2BXKoSiUO1MK7jI6vbfm/yrwy7/yyd9Pp/JCLLpHqkHN2QZOpouT9IN0EHUJcI
         A/mcaJNfj9xvclcECCrIdqJpJhu+4cGZDaLD9WUqAOX6/yzk3t2CXi0eBellYvg0TEpe
         rB3B8aKOzeJrLl8YqsR+cLC9xvCY9+IUdax2bu77BFyaHFFnszhUIEjBX2S5U/VSVsEc
         BUyIN1C9+yF1kLzg3tO6dKyoh/ZQttoUmIyJeQ6w9NbJeJAGRYtKA20KGxmR4ZdkmCw6
         +iYGU4hv1ko931HD55GhEEBgvzInp4eWxjByvS/XtxkX3f9MGeCFI/P41FAfrMJmFMbd
         pSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1PNbxNjxl3yMAPLNBXy8s1I6w1mnoqka0xQAK1gKCs=;
        fh=csoiWi4S4bDfA9awKCmOZjhADpyh+OHYBB5y7pHQ2F0=;
        b=CSK5xBZ67XRh6VABOPDpez8+bw+l7kVW9o8D0lyeTnuK5A9f2cvFP/YBHqYlcLJqT4
         RLFPTbwP/7H1hXWlxTc4rQfHpNlSkywDtnIOK4Xe+5e+qwR+4hCyg6eP3B0Zrs6Fok8M
         jDtv+Gw8tNBPEph/+Qo74f9kZcpNfsAKUGWBZAbZmSoKSfSm0XXaBPuD2A21pycEAHar
         LXdf1TaLEthuxKkNn3PymAv/Ks9B5L00+Xjk7iDVTHnSbkKOHPYC+cNexNd2DpGRjWzG
         sqXVlhXUiBcq+cbYEs0divHQ3z+HmGoV6XohmoMFoPITu8Q3MKYbBlnH4zIsAOsRPVKX
         iURA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791879684; x=1792484484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c1PNbxNjxl3yMAPLNBXy8s1I6w1mnoqka0xQAK1gKCs=;
        b=bZ48H5fDI47HDB+y20Ii8fQPRhGgFG4TI0iL29aTqO6FxMJAy/1FaN93pNU1QJ6Wqq
         dm+PrO9H1EEhVkT4ujhteu30aa8zUW3KCv6RFGGmngcypmkcndGmnR8WEGDI5mMVK01v
         eB9VfA0pCDK0tnJIKWnUVtOrNTXv7eZzNsxYv2HuQ1P12MRRdBDS/VAIO+KU/QJ6JZRM
         qMcq1ZBTCDv3edfyhDhkQH5L2mSm4F099btVu7DpOBptAvNtIAhJxVXGkhv3GODhpPe+
         B5WH3hkcAztf8LYfESA6LCecjI3S8zxu/22fYBm7tm4AKKK0K1nOvRZuNsmdAihloyQA
         iaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879684; x=1792484484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c1PNbxNjxl3yMAPLNBXy8s1I6w1mnoqka0xQAK1gKCs=;
        b=Lr33hwiqNMdnP6NX+Ro/hqncNEkC+nnrKBzXRp5j+HEy8Kl1WSC++gVe2JuQORUpDz
         egXOpkoKSzWMzzJX4HSHMQ338r40sR7jxtjt+fe7FF/2+iFuOYGKIoOunEwu6I2qGpPk
         AOuze/mQwVskWGjTg3hczz9zlmnZQP/51qNAjUGC6AoTsm7hAmbiWtjHG3jroA+kNbfX
         5Cr50mkExcc4TNoFb9Zj3WeDIQKOo20WNpAG3NvpjaHwQ9JfkGiivBqYTJKGcq8qsRhC
         DH33jmhELPXmF+XxSlQwi3Zq+xskWxM6tr9b78iG9daG9mMbNjNsaOOz4Cstot/LcmQk
         LlYw==
X-Forwarded-Encrypted: i=1; AKwUvBz/sauQF71yzMGg6PSnKqFiaBnddxV9IhpwD7PrqutL90CzuiGyP/eR4rcNXcE0kWbrdx7SVDnShuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbr6MpYTIS1jS69v6/LFmjWYpX1yfQ9aXDPnCYK+IFp4dZrhIj
	wzGwNOTBPPMh3rqOiNUXVejbfKqC5utxsxf3uc2vy0l64tM3TebNGiULz0eh49CwlRqZNcmytAt
	aE4ZGhvsqFjyBMBVCDxdFwy9TIoVBWhVw2CSUwrqcxZJc/yupyE0p1+IM86acaf+9Ub3GooYGwb
	4VG9f1FPH3QUfjZU5B+0gW9Q6Gxh5Ywhb2kbSb5Q==
X-Gm-Gg: AYBFou1I2FLCSWgVRdQBFbZ86rI2wmkxX5zA0XZ/d5o4gFB8KbBvQcF+8nF/ORgsdga
	sE7gFMCzfhCS3ovOdyT9C2PD3KpD4qAFdycZ4bNV4HvvQRPu70nZOSWWV1rd/1cdo5Yd1tScy4m
	mSlNr7DaF09hiJ8b+x5JBUDo78bBh3G7mYHmzYkJEa/zRHB8wanp5O4UKaJDsrvrNiHi3qReTnO
	YzGwzkKUXajHXhMnYzRdrtQFN8mHydTeOykpsZjo8MjGL3AGnwwS8N0IUnvJVnrGnhJMTZZD3WE
	sLX1Bw5o+pYNwf3lIomHZxAviLCX
X-Received: by 2002:a05:620a:6e87:20b0:93e:c5eb:2230 with SMTP id af79cd13be357-93ec5eb2796mr1173390785a.33.1791879684371;
        Tue, 13 Oct 2026 01:21:24 -0700 (PDT)
X-Received: by 2002:a05:620a:6e87:20b0:93e:c5eb:2230 with SMTP id
 af79cd13be357-93ec5eb2796mr1173389185a.33.1791879683843; Tue, 13 Oct 2026
 01:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-3-227d12cb4829@oss.qualcomm.com> <717d9cb2-d7e5-423b-9d0e-fad307385474@oss.qualcomm.com>
In-Reply-To: <717d9cb2-d7e5-423b-9d0e-fad307385474@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:21:12 +0200
X-Gm-Features: AclHuK8BcryeFwF7_mfVGnZ02cWvL43_LCZ_Rm7JvQqSScTUu5Q5fBxBQFd8Gt0
Message-ID: <CAFEp6-20=Hkb9ZsubULMg9YYVzEc11Y37g90Gu1mxpvOwqJB9g@mail.gmail.com>
Subject: Re: [PATCH 3/5] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: rhfvy_2orUPZgzUYbIyNE3CayS11_lm9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfX8n2QDaYNkftm
 4rGzF0Y1XyAdZSC+BbEeBs25wXM+SFY7W1EmXVZzulDnSPC93AfY9UKdT45NcFZS2IvXMFWLOSL
 aL0ELw8inrRfUsV3RDQD0lf0TqKJPOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfXyQyueyor0hrH
 Jyva/QacjqS/aQXLhEJS0MvDoakvRVq41C1g4aoCBwGAxcQB5iwCBfoRe8hksKgEmrKxo7rC8XO
 X0BHkSsMBeQ7iqJ2Wz0GoB26k8HXRmcBEUcyZdqW+y9cOZA/eSQYVB6ZY2jtRSY5nLqeGTHEXCf
 90Ql905ommFpalvC+dakuSAwCl5CRS3KXaMg1kY7fAny20HX0a2Qgou2Ux3KKoy3PQeaNL95yEr
 gRq2ykZWPjRIvHdSZysRdd8NPEL8fChi685jn5OBki1DyUhVvgCDrhHu7PSrZrfboK3jLYLXQ9L
 2RpO63NW1TTBN9/j342KPkkeaymhrOriLHZAbHVr8epNZCu3qQiw30neGnGwHRc1Z/+AfFVUN0M
 ob7SqBHSlsS3QhEiYUqVE2MukYUeCBEU9H09SsyzgpI2KQBJXM0X1hc4mojqUcs2ddzSOZX3UDs
 4KluoOtIao8wEDaKxBg==
X-Authority-Analysis: v=2.4 cv=GfKCDgXL c=1 sm=1 tr=0 ts=6acdea05 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=GZDsnYW4LkaCH1OrQOQA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: rhfvy_2orUPZgzUYbIyNE3CayS11_lm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130033

On Mon, Oct 12, 2026 at 3:58=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/4/26 9:09 PM, Loic Poulain wrote:
> > In theory, every SoC integrating a CCI revision that differs from
> > an existing one should introduce a dedicated compatible string.
>
> [...]
>
> > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c=
-qcom-cci.c
> > index 099da0069251681cc52e351fb656bd73e78a96c9..c0b39d419e296454a083d38=
ce302940875b8ad2b 100644
> > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > @@ -14,6 +14,10 @@
> >  #include <linux/pm_opp.h>
> >
> >  #define CCI_HW_VERSION                               0x0
> > +#define CCI_HW_VERSION_MAJOR(val)            (((val) >> 28) & 0xf)
> > +#define CCI_HW_VERSION_MINOR(val)            (((val) >> 16) & 0xfff)
> > +#define CCI_HW_VERSION_STEP(val)             ((val) & 0xffff)
>
> GENMASK/FIELD_GET(), please
>
> [...]
>
> >  static const struct of_device_id cci_dt_match[] =3D {
> > -     { .compatible =3D "qcom,msm8226-cci", .data =3D &cci_v1_data},
> > -     { .compatible =3D "qcom,msm8953-cci", .data =3D &cci_v2_data},
> > -     { .compatible =3D "qcom,msm8974-cci", .data =3D &cci_v1_5_data},
> > -     { .compatible =3D "qcom,msm8996-cci", .data =3D &cci_v2_data},
> > +     { .compatible =3D "qcom,msm8226-cci", .data =3D (void *)1 },
> > +     { .compatible =3D "qcom,msm8953-cci", .data =3D (void *)NUM_MASTE=
RS },
> > +     { .compatible =3D "qcom,msm8974-cci", .data =3D (void *)NUM_MASTE=
RS },
> > +     { .compatible =3D "qcom,msm8996-cci", .data =3D (void *)NUM_MASTE=
RS },
> >
> >
> >       /*
> >        * Legacy compatibles kept for backwards compatibility.
> >        * Do not add any new ones unless they introduce a new config
> >        */
> > -     { .compatible =3D "qcom,msm8916-cci", .data =3D &cci_v1_data},
> > -     { .compatible =3D "qcom,sdm845-cci", .data =3D &cci_v2_data},
> > -     { .compatible =3D "qcom,sm8250-cci", .data =3D &cci_v2_data},
> > -     { .compatible =3D "qcom,sm8450-cci", .data =3D &cci_v2_data},
> > +     { .compatible =3D "qcom,msm8916-cci", .data =3D (void *)1 },
> > +     { .compatible =3D "qcom,sdm845-cci", .data =3D (void *)NUM_MASTER=
S },
> > +     { .compatible =3D "qcom,sm8250-cci", .data =3D (void *)NUM_MASTER=
S },
> > +     { .compatible =3D "qcom,sm8450-cci", .data =3D (void *)NUM_MASTER=
S },
>
> This looks a little sloppy - can we infer the number of masters at
> runtime somehow?

Yes, we can either add a small msm8916-specific condition in the probe
path, or derive the number of masters dynamically from the number of
master subnodes present in the Device Tree.

Regards,
Loic
