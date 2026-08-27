Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62240B6F9
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823082; cv=pass; b=G/4GE6WpEpGqe83pd9PleVF9juI8z/Gs4QCiCSZiSp+Xp33gO8LRKW2vuvU8xJbIkgrEDAFIgoMw95GpLSnjcUAqRiIEaBAML5D+42Q6WSy1Hq1yW98JkSr+QRiRR2NENG57z/6ijOwoQlRrwBOFMTgOKWFkKdzok9a8iH1cQWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823082; c=relaxed/simple;
	bh=+OFocx1aEP+9vQ3gcP1bnLrVbBnXFhujaRLhWeC6sfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atzcITdgRCfq0odzxiiWVF9g1G+gBxiTmEBnbqlfpmoi4UbeZKU2B+N5Litaoq8rqmdbifzI9ybJ9wuEaNfD5/JwUXSF1YXQf+piekXz9cdQBYgxVg9RpfZ21SZN8ovLKWmUrb00IaExKiEHLPFOlBCP17HvUokKZdFNnzj1nao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puXp5hrK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ezf6T6+/; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puXp5hrK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ezf6T6+/"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9GpZo470861
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e0bRS/1/Y3fWl7X8ODZrF2DAl/+US1luAoJB+jji9gM=; b=puXp5hrKOrTO+euL
	jJObPvmyUHIUELmdbOpdfaZoie+lfFKTkRGROkQehzHwRcHIQelKzdMUX2Sj3Jm6
	pwlEVqgh+pqwNIuIvtDTddujHwVDYSS0cljIaWfKN8Xr9tlIE1ivtn+oFGb6fc+B
	HF7kS7f6U7n9xfeyDyNRuwsMH4Kt1BMDvBYDo9HRoNuXath02FhlepGDhX9oPWTb
	9Hue1xQeRCOHHbGun6a6U5jviRtcLlZpwIY8fD3sb1WdvK2SGpQEztzHdGO5lwZJ
	0z/iYjkkOE3flq1vK12OoiDSrJGsWGG5B0W4yZm0gBWXFQhm/DC7Pi+w/6TMeGEe
	GOiacA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5j2ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 09:31:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0ed4fe79aso34335966d6.0
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 02:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787823079; cv=none;
        d=google.com; s=arc-20260327;
        b=U9tAiWoWbhdKDm+ZtUq20PDhSx5JWcg/LWZBWbWvOsGRu2dlKjufw+4LW/DiKEWpF6
         qtWIQ7a5mTNB50H6vgtjdjdOzOa/NxhJmGKUuETigbLiSBsNtBjRdretFpNrqpI3al01
         0gJ6dOoFtk72/81A3DMgPM0AY0qY5eC2jggjPkzolzKEndkXKSdHS3hW1WPrCsM6hyBz
         PfFgOSvUrOqX9QqnnxqXYjB8YK14z1Kzp8wJ1q/my9m+wEl/lNw7GzjnkDipJgNE0dey
         WNnozptamu2Mh1J2ARbuB9cSOZmzo2In5kvOHUcYZzbxbslvpwq/1a5lqxH0zXLdct22
         rDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e0bRS/1/Y3fWl7X8ODZrF2DAl/+US1luAoJB+jji9gM=;
        fh=Gxj3Id8BzyubzxNqtBdbWfqyocytSq5PBDlDxqjfip8=;
        b=X3Adv6GgZ971Yv2XaxaMDoqRibx8utMm9hjckZPD/IWW9QlXjvGqU9h8Dxyb7puknk
         ZMgmqAlGVQf63qOEi52d1QH8LB4gGnWc9br9dawzMy/qIEq/SNHc2lC/RgWrSnPpyuOM
         y/RHpuIouelooZIbqRimicdN7dUgKlKX2KjLIR2mBMu4NiSlkOtPKQatqI2UBsy8SiZl
         fc6Z+IVQ/DxE/Z3do0ASa61RgzGSfxzbXXZnzphzfcYyxHGrLsPvnSpnK1Wuf+cZccGe
         HKSGLKQ1yqESw3l6IJI+cFGpjlh5Uvv6idMPJLfEB2YgIJgviwqO3J91F2SxIjjg4njA
         FM7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787823079; x=1788427879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e0bRS/1/Y3fWl7X8ODZrF2DAl/+US1luAoJB+jji9gM=;
        b=Ezf6T6+/SaUKZrLnJqz9O5dEAZirnj2OOrzxGxhPLEyi2A1v+ldJQvNfoL7+PRRPBx
         7qujxU1Mx4zdOAN2GL6yHNdaGyz+FC+m04Pc8jlbav6CeukhRm/F5AsdUbtMB3w4hoiy
         knI0ZKLSDtE6zZSKAPwS86GsT8pyBkmjLWmItgXsBvtlssPcPz0voqV4ob/MwzXzhaxp
         fJHP+RKnpOrpXBFshICUrQTiuoiirSER4BjwNYbuNRitE+tm8I/DjrMPSp/5JWZ3TXOn
         4mb7KumT4K6QHy3cILdAt5GV3ya9OSluzDyYeQJ4frNKv/ZDxx5SZe7AQFm+hOHDmBm7
         BQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787823079; x=1788427879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0bRS/1/Y3fWl7X8ODZrF2DAl/+US1luAoJB+jji9gM=;
        b=o41lcp3UkXKaqOxeseBckcOQt39cceHTaxBxnMViQTerlEwktiCa+6tjvGCwcDzFCR
         my4pB6Ww+zZtKO3YzjJRw46WPOd9E0EmUVbWt3EdzdC1fl/7Z7UdkM/4T5gwEXQ1AE0G
         jRD8qmP2pqgLiBdjcWs2gCkDdbus0iDjQS+w+EF/YbkVwJBO+4DEr1Ih/+Uy+NWQO380
         /kH1lK52mZ7UvQNeeZtC6s+7Om3IH9juUr40wwI53JLQdYJSLf9VcQwosF/BkWWBfuB9
         e/M5qiEZ/uCmuM6TxGHlNa5qtfz4nEM45yut37NVLawG+V8GqDmdrt5sTpevF8XeSl1O
         8kDw==
X-Forwarded-Encrypted: i=1; AHgh+RqHthTghVLhtHkk2ak6tTL4VdEN4c7FpHfL58L04LfAL+dM36/qevzuZ8MKqZ20BqWJK98IKisIDNM=@vger.kernel.org
X-Gm-Message-State: AFuF++lrK9+XSiQ5qHOVP6I/2u2k8q004YZhg9A6YqKAs37ondRIgCzb
	oQKYh97IlQAvhRboikE4e3bvyxB+JjkWhznK7djGldXh4C34/CnKMBHSHxKITuM9Ht4HXFhDWrc
	jvrxajTp4tdcm7MHCXMM0M7yfWGrApTMSPUJwzGq8motjFePBMJwEa5rqo/L88WB1C6cL5rt8ay
	HU+Xws1t0m9bOv9GdQVrbCaVIGvLWeOPbkUrMGBw==
X-Gm-Gg: AR+sD11E+CRVeNz9r9n6qyGyU5a5qB3phL7woLRjkxxCHJHdzaUYwtAt1dXOLZo82s7
	QMUYD/7IqdcqRFhxfY5QRS6ykTCvEIjBv6YZq/Vu/dTVXUtCQjZsrv35lS6JpyzgsKBcviK11y6
	XjezUqGHUse67CxntZZMXJ13/9uk88MT2K9ygPdZJD0vKyTICy9hZ5zsAaorLI7ICPMd8K9a+4D
	KypEo+B/y4CeZQNgLTtjoUfs45uPOA4WILrY4ipN8c1d4KufwWxLvBBht92ejcPi5av4jHqSU4=
X-Received: by 2002:a05:620a:4414:b0:939:682:684f with SMTP id af79cd13be357-93906826933mr234772985a.17.1787823079203;
        Thu, 27 Aug 2026 02:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4414:b0:939:682:684f with SMTP id
 af79cd13be357-93906826933mr234766785a.17.1787823078637; Thu, 27 Aug 2026
 02:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
 <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com> <8af313a1-5f7f-431f-91f6-9e22119d456b@linaro.org>
In-Reply-To: <8af313a1-5f7f-431f-91f6-9e22119d456b@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:31:06 +0200
X-Gm-Features: AcwNN1UvaL1W-zyD8Eglxdfy81HKEI8nddcPmZVpUkhnUF7SybxDrqSKZKvr1qg
Message-ID: <CAFEp6-10Dz8EJjMNrM0FPHwmaMr2ownKLBh2=F70PmkFn9Ke2Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] i2c: qcom-cci: Share the timing table across CCI revisions
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: OZh193lXl1lwzhQc0h1l2UBtfJNWAdDv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3OCBTYWx0ZWRfX9uHrf6a8M26q
 UV34X5v2WCputJErKildvMfZDqHE5d7PNJV7SyL5WkWlK0jegjFFc2AlSXFWTCFeIEbQtnyNixZ
 NXleNT4XDdViLfJRBSABVVnhCt5xqzo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3OCBTYWx0ZWRfXyv2y0oM3tpAG
 dtBMbbujER0OBr0V887lDJ851pL5zT2Oef/hl+79US5sC9Liewwpbgg65NhJqAQP7gJfSxTUfqV
 dvB6D9yv0Ddvlu/sFIut5cD2RuYpIkIWMdwRxfxRyrQXb/ETgWksT8qH+xRGPeoCY+noBtdqQJs
 yk97ZoY9sJo8pid5/s98Y99349/vuyZiZk2fZEPgOtkpmOm3QWWnDFgI51Ew/ko/Du62SE6khej
 8VSH6gXojc8fuRUWaTAhmAZoKnNQEdv5v3KyFeAiXD0IMmxDUN1ZisDp8z3YwBkylnKCHozPcf+
 4IzKn8LFNMiIYHSXTthG0pTa7EaB8aCTAJBmPKlbp6i0rUp7y1EUil43hkFNHOV0zvfb1rvEWeq
 gg3YEYq1oED/umQXfl996EgF4VcxOUVtoYo69Ue2fr0WPop8cUdrNxK4MvO3HGQzHWrPVa/X/kT
 DM51Ad5fPo9nd+7OC/Q==
X-Proofpoint-GUID: OZh193lXl1lwzhQc0h1l2UBtfJNWAdDv
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a9003e8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=8nvrDW3bclPgcZMhjs4A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270078

Hi Vlad,

On Wed, Aug 19, 2026 at 1:31=E2=80=AFPM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> On 8/1/26 23:10, Loic Poulain wrote:
> > The hw_params timing values only depend on the CCI clock rate and the
> > I2C mode, not on the hardware revision: every per-variant table used
> > identical values for a given [rate][mode]. Only the set of supported
> > modes differs between revisions.
> >
> > Move the timings into a single shared cci_hw_params[rate][mode] table
> > and describe each variant's highest supported mode in cci_data with
> > max_mode instead of duplicating the timing values. This removes the
> > per-variant timing tables without any functional change.
> >
> > Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/i2c/busses/i2c-qcom-cci.c | 181 +++++++++++++++--------------=
---------
> >   1 file changed, 70 insertions(+), 111 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c=
-qcom-cci.c
> > index b6fa37a306758ec33ede6fcc39ce4412b86d9a84..21695c744502f7fb5d333f1=
272f3771e4d9d5508 100644
> > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > @@ -124,7 +124,8 @@ struct cci_data {
> >       unsigned int num_masters;
> >       struct i2c_adapter_quirks quirks;
> >       u16 queue_size[NUM_QUEUES];
> > -     struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
> > +     /* Highest I2C mode supported by this variant. */
> > +     u8 max_mode;
> >   };
> >
> >   struct cci {
> > @@ -249,13 +250,76 @@ static int cci_clk_rate_idx(unsigned long rate)
> >       return -EINVAL;
> >   }
> >
> > +static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C=
_MODES] =3D {
> > +     [CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > +             .thigh =3D 78,
> > +             .tlow =3D 114,
> > +             .tsu_sto =3D 28,
> > +             .tsu_sta =3D 28,
> > +             .thd_dat =3D 10,
> > +             .thd_sta =3D 77,
> > +             .tbuf =3D 118,
> > +             .scl_stretch_en =3D 0,
> > +             .trdhld =3D 6,
> > +             .tsp =3D 1
> > +     },
> > +     [CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > +             .thigh =3D 20,
> > +             .tlow =3D 28,
> > +             .tsu_sto =3D 21,
> > +             .tsu_sta =3D 21,
> > +             .thd_dat =3D 13,
> > +             .thd_sta =3D 18,
> > +             .tbuf =3D 32,
> > +             .scl_stretch_en =3D 0,
> > +             .trdhld =3D 6,
> > +             .tsp =3D 3
> > +     },
> > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] =3D {
> > +             .thigh =3D 201,
> > +             .tlow =3D 174,
> > +             .tsu_sto =3D 204,
> > +             .tsu_sta =3D 231,
> > +             .thd_dat =3D 22,
> > +             .thd_sta =3D 162,
> > +             .tbuf =3D 227,
> > +             .scl_stretch_en =3D 0,
> > +             .trdhld =3D 6,
> > +             .tsp =3D 3
> > +     },
> > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] =3D {
> > +             .thigh =3D 38,
> > +             .tlow =3D 56,
> > +             .tsu_sto =3D 40,
> > +             .tsu_sta =3D 40,
> > +             .thd_dat =3D 22,
> > +             .thd_sta =3D 35,
> > +             .tbuf =3D 62,
> > +             .scl_stretch_en =3D 0,
> > +             .trdhld =3D 6,
> > +             .tsp =3D 3
> > +     },
> > +     [CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] =3D {
> > +             .thigh =3D 16,
> > +             .tlow =3D 22,
> > +             .tsu_sto =3D 17,
> > +             .tsu_sta =3D 18,
> > +             .thd_dat =3D 16,
> > +             .thd_sta =3D 15,
> > +             .tbuf =3D 24,
> > +             .scl_stretch_en =3D 0,
> > +             .trdhld =3D 3,
> > +             .tsp =3D 3
> > +     },
> > +};
> > +
> >   static const struct hw_params *cci_get_hw_params(struct cci *cci, int=
 mode)
> >   {
> >       unsigned long rate =3D clk_get_rate(cci->cci_clk);
> >       int ri =3D cci_clk_rate_idx(rate);
> >
> > -     if (ri >=3D 0 && cci->data->params[ri][mode].thigh)
> > -             return &cci->data->params[ri][mode];
> > +     if (ri >=3D 0 && mode <=3D cci->data->max_mode && cci_hw_params[r=
i][mode].thigh)
>
> This earlier introduced sanity check for non-zero 'cci_hw_params[ri][mode=
].thigh'
> is not needed anymore, right?

It's still needed. max_mode captures the platform limitation, the
thigh check captures the clock-rate limitation. E.g. we don't define
Fast+ params for the 19.2 MHz entry, so the two checks aren't
equivalent.

>
> > +             return &cci_hw_params[ri][mode];
> >
> >       return NULL;
> >   }
> > @@ -696,30 +760,7 @@ static const struct cci_data cci_v1_data =3D {
> >               .max_write_len =3D 10,
> >               .max_read_len =3D 12,
> >       },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > -             .thigh =3D 78,
> > -             .tlow =3D 114,
> > -             .tsu_sto =3D 28,
> > -             .tsu_sta =3D 28,
> > -             .thd_dat =3D 10,
> > -             .thd_sta =3D 77,
> > -             .tbuf =3D 118,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 1
> > -     },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > -             .thigh =3D 20,
> > -             .tlow =3D 28,
> > -             .tsu_sto =3D 21,
> > -             .tsu_sta =3D 21,
> > -             .thd_dat =3D 13,
> > -             .thd_sta =3D 18,
> > -             .tbuf =3D 32,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 3
> > -     },
> > +     .max_mode =3D I2C_MODE_FAST,
> >   };
> >
> >   static const struct cci_data cci_v1_5_data =3D {
> > @@ -729,30 +770,7 @@ static const struct cci_data cci_v1_5_data =3D {
> >               .max_write_len =3D 10,
> >               .max_read_len =3D 12,
> >       },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > -             .thigh =3D 78,
> > -             .tlow =3D 114,
> > -             .tsu_sto =3D 28,
> > -             .tsu_sta =3D 28,
> > -             .thd_dat =3D 10,
> > -             .thd_sta =3D 77,
> > -             .tbuf =3D 118,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 1
> > -     },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > -             .thigh =3D 20,
> > -             .tlow =3D 28,
> > -             .tsu_sto =3D 21,
> > -             .tsu_sta =3D 21,
> > -             .thd_dat =3D 13,
> > -             .thd_sta =3D 18,
> > -             .tbuf =3D 32,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 3
> > -     },
> > +     .max_mode =3D I2C_MODE_FAST,
> >   };
> >
> >   static const struct cci_data cci_v2_data =3D {
> > @@ -762,66 +780,7 @@ static const struct cci_data cci_v2_data =3D {
> >               .max_write_len =3D 11,
> >               .max_read_len =3D 12,
> >       },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] =3D {
> > -             .thigh =3D 78,
> > -             .tlow =3D 114,
> > -             .tsu_sto =3D 28,
> > -             .tsu_sta =3D 28,
> > -             .thd_dat =3D 10,
> > -             .thd_sta =3D 77,
> > -             .tbuf =3D 118,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 1
> > -     },
> > -     .params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] =3D {
> > -             .thigh =3D 20,
> > -             .tlow =3D 28,
> > -             .tsu_sto =3D 21,
> > -             .tsu_sta =3D 21,
> > -             .thd_dat =3D 13,
> > -             .thd_sta =3D 18,
> > -             .tbuf =3D 32,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 3
> > -     },
> > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] =3D {
> > -             .thigh =3D 201,
> > -             .tlow =3D 174,
> > -             .tsu_sto =3D 204,
> > -             .tsu_sta =3D 231,
> > -             .thd_dat =3D 22,
> > -             .thd_sta =3D 162,
> > -             .tbuf =3D 227,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 3
> > -     },
> > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] =3D {
> > -             .thigh =3D 38,
> > -             .tlow =3D 56,
> > -             .tsu_sto =3D 40,
> > -             .tsu_sta =3D 40,
> > -             .thd_dat =3D 22,
> > -             .thd_sta =3D 35,
> > -             .tbuf =3D 62,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 6,
> > -             .tsp =3D 3
> > -     },
> > -     .params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] =3D {
> > -             .thigh =3D 16,
> > -             .tlow =3D 22,
> > -             .tsu_sto =3D 17,
> > -             .tsu_sta =3D 18,
> > -             .thd_dat =3D 16,
> > -             .thd_sta =3D 15,
> > -             .tbuf =3D 24,
> > -             .scl_stretch_en =3D 0,
> > -             .trdhld =3D 3,
> > -             .tsp =3D 3
> > -     },
> > +     .max_mode =3D I2C_MODE_FAST_PLUS,
> >   };
> >
> >   static const struct of_device_id cci_dt_match[] =3D {
> >
>
> --
> Best wishes,
> Vladimir
