Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF4D90C1
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648502; cv=pass; b=TNVH+w9usEHzDfOEhoW/nlqtN63aafrZspHsxg0TTlGkUAH8qtFQtpxcNnLQ5dYmEDyV9XzQmQBWCJkO02Aw882J3u53cyokLpv2tHok7diCYfgNAX8wCII6r4BQlK4EY9M37OTcl9JBtiNLQsRe9B6aOijHwU7rlGPGCYrjZOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648502; c=relaxed/simple;
	bh=hv/1/jgmosWZG5CXBogS3OC1HHR2eX8+DUld7zfdxto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvp4DzR6US7BTcOS+kia4cYnnveJI8hFO/Mpklj1nrZqsn8FWXEHzwvMzYFBjYtrbOU/mRZl3pQES/iZMyibr8Lr9R53v+f9kRq0aArvSdcLgXrtaBtuySgAnlze4pePC4f9b5ME9uvc06n+J9hPuI01h3BWXIg2N/M6yiJCYvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=As1+TWHH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZU/OWDPx; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="As1+TWHH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZU/OWDPx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg0AH2962649
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sbQkCvHWiH+eSaZ7UFMbyQp97oOU9T6RmNcXd0SaV3s=; b=As1+TWHHRKvwyldx
	M1qiXni7Oo15ZrN6OYnQMaoTXu4vI6bnum1fFiftxK8NVHVWPiuDtvRn/hd55h6G
	JGjascXut5zwgTocYWdA0JoD0xTXDQF5vGCDmrFZiQe3ao4+KbcZiY/k3Tncmlsl
	1nqIuD44i5c6RS4BX8C9pDAbmOxa//GboFuDJM6T+xQxXav/cdoVa36njJZHFykc
	RsPwoJC/1d2UKvCNsHVqqZ7ZASwZjAcLo6cKi7+hdVQdHG0f34wK+0VH0Gbw3rkc
	RvXqOqNZLCCpLmYJvb43lWnukTi+EwaWna7Rw1BgSYUPjNk7TdePowRrmJcWQ5In
	J7Fo1Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nsskv5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 15:41:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e695a3b28so1079504585a.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 08:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784648499; cv=none;
        d=google.com; s=arc-20260327;
        b=g+wcDX9CgeGunWbOsNmnpXLdoFB2R1ET5Bw+QyAe3RIQ1Oao0pqbRdzeV2AWTORFU7
         I6qHv7iGzH0AG3G+zb2jBZMzudbEyLV0EZOR6Iseq/KbJRIgRRDzisAWnCTs5ip1Iuv4
         eQEhvsgI325JO9APhaXPyt+TKQu8gBLTmHk+bi8Aevom7GHhohveWzqUpPT97C95sYFg
         C0jxZEbjSJCZdkhiupOe8Eru9IhkRVuJZ3JB05nFHS3oKZS0KTyP7j93H0LuMbSmgBrj
         vadb1O88KNPF5U094xjRR9ljRSvNZLbuibz6ePnI4hutmzI9+9qnr3bJtsggy2c7Kwyv
         xruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sbQkCvHWiH+eSaZ7UFMbyQp97oOU9T6RmNcXd0SaV3s=;
        fh=8nEQzUYuFES6keQGqHy8y6fV6rXCQSA1J0eDoTsbXO4=;
        b=J7pqJSY4iDxA50MK9SI1L0dYHSUYHKEiznMIqHK79Zd5/ClxyGzy5bopjVd1eSwtfe
         IIaZVCWfhj7iEkjbiJmvHMAd4aB2rWV4WfjLV9/83VxncJcPN1G+3J4TrRUGg4pVDFGI
         NBIKElq7b/IpraJ0No8840SVsp89cUhF9SoAMwJHJFZBBzFpLDHmjHDoowoPUMP7ZM2w
         aVqfzQGq2axM3wufL+xyGKf9l+VMlrIhLXp/1NGs8tbEKR7W2X3gxzGrxABob4bwcg+g
         IzvK2nmx6TeLv406KtLZ58rDDOPT/sGJZhAifGxBIvtE9h3uJPjCzlTONQUQbu0RkV3o
         nG8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784648499; x=1785253299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sbQkCvHWiH+eSaZ7UFMbyQp97oOU9T6RmNcXd0SaV3s=;
        b=ZU/OWDPxVchFolWlmrIjDdqPFYDOvERAgs+15TRD7RxWSgRVgRoNrgC7sb9AJItjwe
         9ec48Imt3r/AFehg5AOXwxQktVsyawcpQ7vjeowiJf/NS51Dwo1e/rCuTM2U3Bg8Aweu
         tYYAxMy2Yvvy5SF2xfne4j1DDOorvEHAT80MugPZal59r3QTUArh0YHnb/YPeU53N3au
         FfgTKkXwH8P7itpDnpP/MVBm3W2VgwyDs2DJ1s9mrukZIjcJ5Bru3HLLX33mo3zuVHhx
         gDxBkEaQ9a9dA3B7jnsolvCwuTAZLFDG0UIasiDYtnVIjxfwLqvJiYoeuJzU3TwOqpB4
         O9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648499; x=1785253299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sbQkCvHWiH+eSaZ7UFMbyQp97oOU9T6RmNcXd0SaV3s=;
        b=MqpA3+LwNCuSn32BysUiDrxnLJuJf8K+Hp40+B+cuqbIbDNQ9s+Qce3Jz56f/IbtjX
         Q0ABZElqahgIOHV+fhZRqYF98Ri5E24wi7E1hzrLqKaeVkfWaW8e8av+YwouTs6LLgf7
         t1t8kozCJUwUVQLiu/MNRHNlKUrDkBM56QNhgJUmf2zWPLOIgOmn7N8BvrXJR1d3XS5y
         lVVK4bV/Gu7tZtgPzW5uHj0xdUssjgf+zrqxP+GnzQ74mj6Oay//F2nbUPjBj6g0la2z
         FDlGs6FRheNfqoT0haWQ0ORU/yBFINKk35ChxYxtqJOJEoqC281AroZvoS7Nc+552nxf
         Wz0A==
X-Forwarded-Encrypted: i=1; AHgh+RrdoK5qF2fLJd4WsqJJ/NVi374ltz/tI2MXus/UlWW/lsl4DeFRDFwPN0Ma9S6HOmtG2fTL7bxCDGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTcuQiqsSW24i7sQ3koABqnfqnz/ATjaEzza4+TGTSdLKi8o2P
	q81Ex4f5jWd79cXKqBx01SOL9/ND53z1+FUMzx9L7UToTGcyPc89S82p/WIhRYkjl1cEqJKr2pu
	MEUrGhUGX7cQnavTVBsRJZUuFQ95PCdZAC0NOZhxLAmPS5nY05pSa4sZLJIyjYjBGB8FaJoS43S
	ktf1TUugOXQl5jeDEN8mqR7GJUdQ+iTiqCw5VA+w==
X-Gm-Gg: AfdE7cmN1EpN375rvYLcFj4MKwdj7wTP25AbOs0HiM8oivcVb6HA0RiYyyuXJSSUiM6
	Rd0G6irGygZxY7Bo41ErewMi4egwX1CuX5KHrNYgd9Nw8E0WXv2/SEBOtYEbmbagroclMmkyo0G
	3rKSnU2m0E0K0zoB4ZDm3GTSnWmjqgN17aqnqBZeXvix2r9io1TGtb705/5bEcn5hMa9ctGr/Ub
	tHjIGBsqNwcPFv8Aw3H7MAcnE6eGC+g9Yquy83C3U783ftMu7m3pEQ4fYIhWOSz+VRLXmyfGwQ=
X-Received: by 2002:a05:620a:1a17:b0:929:f78f:6bf9 with SMTP id af79cd13be357-930f2d6a162mr21888185a.16.1784648499417;
        Tue, 21 Jul 2026 08:41:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1a17:b0:929:f78f:6bf9 with SMTP id
 af79cd13be357-930f2d6a162mr21881485a.16.1784648498688; Tue, 21 Jul 2026
 08:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-3-5eae78700da8@oss.qualcomm.com> <7fa30af8-884f-4302-ba88-92720bc741eb@oss.qualcomm.com>
In-Reply-To: <7fa30af8-884f-4302-ba88-92720bc741eb@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:41:27 +0200
X-Gm-Features: AUfX_mwyy8vbRP2ppfU0TptxSlY_11gMT9nEpxnw4n4-8o8SBZmnuQ4ns9XB6wo
Message-ID: <CAFEp6-3Zd9Rg0h3v5FGT_RoJiXg8qYNbyCmdx-tO16p8nyBuZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: J-a6xW3QOqmlfWBzYd7GLvdTS0IsPpNS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2NiBTYWx0ZWRfXxMrPYAA57Ksf
 CO/kvTwCQd6YX1cHk7FivY0SqWRgSdJV3WeLZ9l/rp4IH6d94pa3Ol5cAFrOYdZgHBUZ1uOo6zy
 Ukcs9N8bjs45U1moY1dkWR6z/YWc+AA=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5f9334 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0suC49so9GQ0SDQiWU8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: J-a6xW3QOqmlfWBzYd7GLvdTS0IsPpNS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2NiBTYWx0ZWRfXyWxIm5ymxYLW
 ZSmADKT6OuaqT4tOlBwDfAj7n4esRoaFqUkH+EALzEJms54CJINYT4DYzcZI0JcXvfQvOYjcNKr
 p1CNz3vi08IdOlYd/IhAaLmmnrifJ7/zTZpt5BYNq6KQ5CuX6mcH4n/m8DBl8bBA7459VWi/9xs
 ZRI2XAppJy2nMQkiUPke92Qp+JiWe+1K4YDuMxyEzBW9NI1sD7sXnGGcg96TLRRw/tovMCLQ35z
 5T7dlZOhcz+nuNVstQWKBlMiwTAgUkIVtaS8aJ3GdjQeOZHiUxsyA72oNQgYrPUmkbbGRDp7Znt
 nz+IV92+6eR9SAN2NfgBPpGuGEZflZdfYxS+FIJ0hes6EkF8caqJofodQ9n2Lvc2VeCFiq2/8aV
 4+AkKozwwAWpu8nwVS1CSii0AvNa2qm7NqApC9tUcoqF5AfATzmsATzPUMTAYjILq9sw0QPPylt
 ULPzxrClAfSI5gD9xYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210166

Hi Konrad,

On Tue, Jul 21, 2026 at 5:07=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/21/26 4:58 PM, Loic Poulain wrote:
> > The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
> > and were calibrated for a specific clock rate per hardware variant. If
> > the clock is running at a different rate the I2C timings will be wrong,
> > potentially violating the I2C specification.
> >
> > Rather than just warning about a mismatch, actively set the clock to th=
e
> > expected rate at probe time. Warn if the rate could not be applied so t=
he
> > user is informed that timings may be incorrect.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/i2c/busses/i2c-qcom-cci.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c=
-qcom-cci.c
> > index 5f74edde8558382e63e2c3d0fbe19489f325e8ce..e001c0d565cebd386fd67b1=
d9d532360b29c67d0 100644
> > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > @@ -519,6 +519,7 @@ static int cci_probe(struct platform_device *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct device_node *child;
> >       struct resource *r;
> > +     struct clk *cci_clk;
> >       struct cci *cci;
> >       int ret, i;
> >       u32 val;
> > @@ -587,6 +588,15 @@ static int cci_probe(struct platform_device *pdev)
> >               return dev_err_probe(dev, -EINVAL, "not enough clocks in =
DT\n");
> >       cci->nclocks =3D ret;
> >
> > +     cci_clk =3D devm_clk_get(dev, "cci");
> > +     if (IS_ERR(cci_clk))
> > +             return dev_err_probe(dev, PTR_ERR(cci_clk), "failed to ge=
t CCI clock\n");
> > +
> > +     clk_set_rate(cci_clk, cci->data->cci_clk_rate);
> > +     if (clk_get_rate(cci_clk) !=3D cci->data->cci_clk_rate)
> > +             dev_warn(dev, "CCI clock is not at expected %lu Hz\n",
> > +                      cci->data->cci_clk_rate);
>
> This needs to go through OPP.
>
> Feel free to take over and refresh:
>
> https://lore.kernel.org/linux-arm-msm/20250904-topic-cci_updates-v1-0-d38=
559692703@oss.qualcomm.com/

Sorry for missing your series earlier. I still think we need this
series to restore the expected clock rate information in the driver
and enforce it at probe time, right now the timing tables are
calibrated for a specific frequency and the driver has no way to
verify or correct what it gets.

Then, I'm not against an OPP-based approach in principle, though I
think it should be built on top of proper foundations, we would need
to rework the driver so that the mode selection (standard/fast/fast+)
drives the clock rate selection, which in turn selects the appropriate
timing table.

Regards,
Loic
