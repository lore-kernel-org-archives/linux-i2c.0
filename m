Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792760033;
	b=gPmAkDkH3RpHaAhpdbHPu4y1SZ0XWHd9r2Vn3I7GTsvnuA++bi+jra34MkPRE/8UAdQp
	 JNM5mpgsqMEiB1AgK41XmrJX0+zBw2U8uHQ7uF9/9mIRcF4+V0muf+kPeueMCN6O/Ww3T
	 toDZDR6KpnPLE4a9LGozMbrxESwlDWfFObPOuScvQtWBPFmNgaJuiRwyHCIqme/YdHhK6
	 GgJQBSw4uk+RfUuLYAItkX7BGJyA9zzqdlOxSyOeIno7PeZoWHGqaJF5BTGS7DUMA37y0
	 uHOposGs0lJAQj+JmM11rDMGUPm2wE3ybbT99ssQAVDHnIXG9GB1OIJC+QxDZ8lgXzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760033;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZL5atUgQF9xYrzrdZd3zMmp+VtVfbiUmv/5LK8lZfT4=;
	b=hLcAuXakuGb0IsDmrPPFdEA/w3iWyLJMQ6R7oTPQKBY2jDdbdCnG9g6dPlGN+I2OXryZ
	 Yts2fiN9vWUMnlpOPGYzzwGVXjqfrJ7GOiEbsv+PtafeC1EWg99aO+RJn0rWExViyQpa5
	 50LtWCM9XK3u/inutWytPEHC/Oat5i41ytvLqHmjD4Ei73/qvMdx/qNptfk7UfkxJR0Mg
	 2CDUP5mcnwhzAk+do3DwM+IMmQuIDfHOSEiPqR8VirBQARvuP6B/qQjIvGIsSz0C8eU97
	 kFE4e8W6dgfsJtvH9WGK0JdkgRbf53sXX3ZzvRM255kNOHaAvkC8L1qSE7GhOlmmJqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k84ztsh+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gXls9Rvn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB25606A31F
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 12:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BB25606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k84ztsh+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gXls9Rvn
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NCAl7Q3822721
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 12:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZL5atUgQF9xYrzrdZd3zMmp+VtVfbiUmv/5LK8lZfT4=; b=k84ztsh+ot53pSBG
	jiTg1dSaK+oMQc9D7xA+HgHuOZWpuLp3Bvqo13JWoqTssTxPnu3DiCT7aw0xyXnE
	RT6y4OMl2AuO6bb97phV2Q2m27M9GBi+txFNJy1PnbrbtbWgGuBBy1jGT2o2Glyj
	VtnyZKcroVaq5xaitlEzPXctl1jOXjsw6ATbcxQefKFGiZrgJnoA/18skPLXlTuh
	i4HYKYHjOLvMbY5rmQLJ8C4xlHxY5RgSJoXH9e8lf1AONUjVv0nvRMQ6P1Yh8p4g
	c5EmDXZp6s25pmBjf/L5xFz5xkwVWZ+6gPkBsrb/Ycyhvxa0apN/1TYNBwIMdN95
	ff14Kg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw04fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 12:53:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso136964885a.0
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 05:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792760031; cv=none;
        d=google.com; s=arc-20260327;
        b=baD/mjC/0hOnKdxd4qkoykPGVLRDQzpWlrTWnljJe3vQYxb0eXmkBdt1RCmR5A6+gk
         gbZ1w4lvUiKY6UWHvxISQCu0B3nABfLDUgA9J3i9EkE+uSFXUFZ0bXAbqqB/s/4xv/cG
         YEwLNUB5cp3WzxxLlg1lL6qqborBARURSPXY46Bf5buuacoURmSercbHSklGq0kMtTgc
         LQxw6QR5cG5ngCEfJuU3usfBMSDnf7Jc0jP1euMUOi9oO5jRVaZMaWQsTCYZWvE8FSES
         NWE6/hO4QdqQDItCwLXIKzDnsJ+bnXerBK6b3xkb/YcBK3IySrWLlcahzC/8koRJCc21
         4uVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZL5atUgQF9xYrzrdZd3zMmp+VtVfbiUmv/5LK8lZfT4=;
        fh=zQ75j2yDwUprPGOph+/d0Huk0P1S5q3E6GhkB5lCX7A=;
        b=Gk/mj94t10h048ew7b+eSuT8if90EqpHnVEcrqvexkUgGhCKRws9jmJTPnzTbsN9y8
         0OxzJ2LPQGxh7ebYJZIpYaI9p/D/U7us6qOehqgOmbcxxP/TnDaN8zOL9On1jSlNX+0M
         bvWAAKFpuBnUfbx1hKS1eT6W9LgeupNaxvJemw3yZyKi3+KW5b7yJgY6nReE/hlc6Jb6
         6ZVJQdxQdnvBgkam4n2GMthdrwn/aDZGd3tr9Xf7Z1PVp6VcCHAocc5Hwg7r4vSlo3Mv
         7uXMVk4TNX/C/pKI15MvTUHTg5HeHORt98vqhqJTBU65w1PB5Q0HahkPlamIK+JoXNms
         i5hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792760031; x=1793364831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZL5atUgQF9xYrzrdZd3zMmp+VtVfbiUmv/5LK8lZfT4=;
        b=gXls9RvnIYR2YK5cmUlO7e3CR8/MOnt1zZSp4Py9+smXc6q/yEf+3cA7UNdcAvtl1z
         4mTmhog5wJzLRPuL6fL79LbvMHtJxMq5jKJDzFHPN30fmTlGssKoMYe8iaSV0pqELicK
         zjiQfjKajbOkIlNR/miwiSjSr57KDQzYhYC8qEw4oiaLO4Ni7CEOJkTMrvhm8zh2FMr4
         h8u/pD7gZMQFDHJuLfRBQhQ5n++Ru+3dUKVwyjW7epYIEkUR1ZqenmYtx+bXJyLw3ytT
         zC/UbzFFWX+BFsZXhIzh73yMbKpXQnQCb9NsfYF9RK7pKqXsn+Zie9geyE0xn6Jvr5Kz
         zB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760031; x=1793364831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZL5atUgQF9xYrzrdZd3zMmp+VtVfbiUmv/5LK8lZfT4=;
        b=gZVyZkJ5E5DkGiVoWUBOuxBQnEJLj6tmLWqRXZ7kQvqvskuvekUw0KG1JTYEeYiTLr
         IbHZwOv3IzqrkYTLfU9Vvfqcoj1MZ9FDoYMC/3KwQzAI37MCnHTI5obWFYaJRN47CVqt
         JruJ5Wx9f1KdNUe7/xqC6IXc0AtRE2VqcUPOD2RzpygmX78yb5qFpeGycni+o6Log52t
         wTcwrY1B+cdVjdog0AyZvVTFB/LOjavz74sucU+4KLpql03mdeMAqKB1vo9tVVx0Fm09
         ZTTBrph4Ybalv7v3NFxwCDIiMMSDIfq8m1K69VpY4JTfZ95aqLBoKD6p546thI+bLdAu
         lzSA==
X-Forwarded-Encrypted: i=1; AKwUvBz63aAvIgIPSnqy03P47EqHT8CqVZsr9YqqQJwjmNfonn96OQLwPSXoft9zgIlFDEUK2uzCZWpiMY4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJllI77JfeC7oNx8pGe6MkwPiNHLDZtbHuGfEhW4s3SU5rekCGZ
	8d8ZDoWEp/bhUZiuDU6WzVPjbWeI5lZX9MGRyeECj8kITY7TyT4/ZnsksP8tdwMugL4ufS2YacS
	d2vcw5HDbVf5pAVhr3fuYSgTvTovzvzBsbvA2UMnylc6oDQQE6j6o/+FpCiwueEGrQ7wms/sIxr
	d6R+jWJ5IWMty73WUOiYG8GioChtVWAdeql15hmQ==
X-Gm-Gg: AYBFou1FaklvR5qF+NXx7UQwgyzg5ZrzUEa74YFjwStcYvlwFuaJ1TmADuabbW7/gs0
	Ca3gXFIRbTaucdurFmF8R9WQBTTIaUqIUvkI0yjoKgaivNab/pMtC44o93jO4hkHVmP0Ry3icxN
	xNTsNjnROu1TLc3IqLIvFc11lscvfOz/truTvG/HvSeMOsROLZNqDZEHpxUDc8sKqqKfZ06ohfq
	ZHYeH8WJ51VTcS0p5IVppKKe1UTviVo6PddmeBUgTZrREbxUJdIE2hqw7S2x7T8SyRhbOlANWs=
X-Received: by 2002:a05:620a:2608:b0:93e:7ec0:7c63 with SMTP id af79cd13be357-93f6f9b51femr330275185a.57.1792760031121;
        Fri, 23 Oct 2026 05:53:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2608:b0:93e:7ec0:7c63 with SMTP id
 af79cd13be357-93f6f9b51femr330270785a.57.1792760030624; Fri, 23 Oct 2026
 05:53:50 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022071418.26895-1-bjsaikiran@gmail.com> <20261022071418.26895-3-bjsaikiran@gmail.com>
In-Reply-To: <20261022071418.26895-3-bjsaikiran@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:53:39 +0200
X-Gm-Features: AclHuK-A5Hp4e6c3qITTZozdBZs-UH-SXsDSTVo8_muXWDLKvdme3VTjvVNKGIQ
Message-ID: <CAFEp6-0cFMSRcTsgOSvep3unzb+vwFGTRaQCyt8eYrw=Os2L=A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] media: ov02c10: Fix sensor power sequencing
To: Saikiran <bjsaikiran@gmail.com>
Cc: rfoss@kernel.org, andi.shyti@kernel.org, sakari.ailus@linux.intel.com,
        hansg@kernel.org, bod@kernel.org, mchehab@kernel.org,
        vladimir.zapolskiy@linaro.org, jishnu.prakash@oss.qualcomm.com,
        birk.skyum@pm.me, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0TiCy2KYvUDi7QQwMocwiMbgOEoaB5Z_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MCBTYWx0ZWRfX7NRIsGj71Xpf
 caJwZZW5TqrOofuXb/y/cpo5agMgFuXt6rXPUwVmwznZ4GrEngBfIBm26Lji3Zuw8FIqKrzX3fV
 sgNGoP1TUaLpeIFNJYzyoxdv+D+76X4=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb58e0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=WXF1KB85Zuouuk2w01YA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 0TiCy2KYvUDi7QQwMocwiMbgOEoaB5Z_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MCBTYWx0ZWRfX/WlyyPWmCSO2
 CB6cUSLdSGRf2ZBVtkxyf+T1Y8u0eWJcKAEb73qT1NZd75hjCarXFRKt9JMjPjdjgqVZPOuieiY
 4dVzA47MC9hz2VPKgn5lJxa1Ba+bt3aG/2AJzTJy/OACdstCzCvSIHQ8f2HiaMi0LDybg0beoZQ
 LfW2smSYC2ZyyT5OzpjF8f0CjYorCUqEeU1rzyMaztEJmJVsQU1zFqklA5CjSYep3UFjAO4wVqT
 uREwILxxNdrv/jiU9If3meYEXz83N3KDt+BH7/5mRAT/Jf3U5ZWICSdrjIxya3FVTAH1ZIxq8K0
 rP3zlLyPXPQGNwfGQqBII6qYFAyOxFgi2Z9XJG2FwmsgmgsVSMTWDvdDcBWJej11egHmt2T1dHk
 KrABpiBkP5QoxrAqJHmhtlcb9VK8/BUDt8XOiMVfa3fo4NSZqG1grcrf1pqx9kpENX/rl3N+DQt
 7OmOB1+qpW27TL6CENQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230050

On Thu, Oct 22, 2026 at 9:14=E2=80=AFAM Saikiran <bjsaikiran@gmail.com> wro=
te:
>
> The OV02C10 driver enables MCLK before the sensor supplies and disables i=
t
> after the supplies. This can back-power the sensor through MCLK while its
> supplies are off and contributes to camera brownouts on the Lenovo Yoga
> Slim 7x.
>
> Follow the power sequence used by the firmware on this platform: enable t=
he
> supplies before MCLK and disable MCLK before the supplies. Hold reset for
> at least 1 ms before disabling MCLK on power-off, and wait at least 10 ms
> after releasing reset on power-on to allow the sensor to start up.
>
> Update the power-on error path to disable the supplies if enabling MCLK
> fails.
>
> Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>

Should it come with a Fixes tag?

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/media/i2c/ov02c10.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> index 221cb93126ec..42aa43ea0a22 100644
> --- a/drivers/media/i2c/ov02c10.c
> +++ b/drivers/media/i2c/ov02c10.c
> @@ -661,12 +661,13 @@ static int ov02c10_power_off(struct device *dev)
>         struct ov02c10 *ov02c10 =3D to_ov02c10(sd);
>
>         gpiod_set_value_cansleep(ov02c10->reset, 1);
> +       usleep_range(1000, 1100);
> +
> +       clk_disable_unprepare(ov02c10->img_clk);
>
>         regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
>                                ov02c10->supplies);
>
> -       clk_disable_unprepare(ov02c10->img_clk);
> -
>         return 0;
>  }
>
> @@ -682,23 +683,24 @@ static int ov02c10_power_on(struct device *dev)
>                 usleep_range(5000, 6000);
>         }
>
> -       ret =3D clk_prepare_enable(ov02c10->img_clk);
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
> +                                   ov02c10->supplies);
>         if (ret < 0) {
> -               dev_err(dev, "failed to enable imaging clock: %d", ret);
> +               dev_err(dev, "failed to enable regulators: %d", ret);
>                 return ret;
>         }
>
> -       ret =3D regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
> -                                   ov02c10->supplies);
> +       ret =3D clk_prepare_enable(ov02c10->img_clk);
>         if (ret < 0) {
> -               dev_err(dev, "failed to enable regulators: %d", ret);
> -               clk_disable_unprepare(ov02c10->img_clk);
> +               dev_err(dev, "failed to enable imaging clock: %d", ret);
> +               regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> +                                      ov02c10->supplies);
>                 return ret;
>         }
>
>         if (ov02c10->reset) {
>                 gpiod_set_value_cansleep(ov02c10->reset, 0);
> -               usleep_range(5000, 5500);
> +               usleep_range(10000, 11000);
>         }
>
>         return 0;
> --
> 2.56.0
>
