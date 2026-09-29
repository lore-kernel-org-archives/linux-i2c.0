Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1B3A7189
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669515; cv=pass; b=il1K6TmPm/PKrJ2v7gkAI8Kf3T8scuACCbOdJGCcu6MRIBRw1r+YS171Bsgiww+6WcGMnnhObY77RheMS0sX9wptNnTPlJTDzcNKJZ+7uZ7yXiypAAOajwr8bKeQmxVB09PoU1byWCgucnWfXZtiryv16eg2221KApi4PCEo0Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669515; c=relaxed/simple;
	bh=HoGjfIBERBjuLlbfWX6YofwkC+7tgErkdW19lovibhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb69OnrMubXJ89ANl0vhIWMsbYErfbJ/a0olnoYM21zrut7hmKgYmLUkSvhibiYoCc+mVs2mazaT7R8U5BDLVrGTpBGiIS9UirWwsiz6LvmJqSAtpfpOOVyzshOUVovW51K180SV52n3RfW/YFVBCbjOvgtF3THjDa6tOn19xC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvTAuSg5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJ6TTw1v; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvTAuSg5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJ6TTw1v"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T7ThHI761151
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 08:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8n8olIhU2MMWC1LHor4cPhfWXcE121qFu8pwc/M0v7o=; b=CvTAuSg50oMo9/0m
	xDDnOPZtJSEth9eBTCxnaJUwER+mJqKf5oQYYR/cDGCX8LR9CZUvS+Puwkd5S+v9
	6COfMrg8zEspOP6N20tApNPlGc9pJyb+OXj48kgMeA/rPErxFsP1m6cAbGlybrNT
	ZpYY6fd9BkAXlj0doSXoS2uMaQWFN0KKrXgUKys1DMU3pYv6idIu3CSTxnwe0AiB
	mZNQlcFd3wy4AOygJYyru59JYssZM6jug95kHc8ZXEJt+Ibz3MiJMbeH9zzVJ6+D
	F3+LkeygJ+5CQn7tbO6QwOjmcwg0oWDlYw2xD/Njz+qO7qguy9oTscF+QZQNIxha
	sOiyyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03jxqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 08:11:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93bfb2da664so1128480585a.1
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 01:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790669512; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIL5roj5JuClgNybaXtoVHqbWxgOagRRPPO5wxfWCu5C79xFoawlUTi2BxUlUupY+w
         uk/x2GLYlsQsXsgZsf6diNuFyGt5MqRYcMkmXHz2Kb87vAhdrKxmrNNmNd3CwHoRLcQ0
         ebVlnLe/fQ6B22DzKNJ+ddzjiUQVUBypwj1O2AlfDqgNq6RLTEXbgXm0xDoAbaxcl3X8
         +Gmh9FIhPcIdd8g1pqL/hIQaSGKZsV2wQ68JEeC7guyfWsr8883WptdhNeOyCWO2kQUz
         xygsY5E89ISKmXb6xT2plNXq5wPgfzOOz1iFZk1kBx9BozlJP7T1vojPQGM3bp7gOzfk
         DSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8n8olIhU2MMWC1LHor4cPhfWXcE121qFu8pwc/M0v7o=;
        fh=T7McYz1wN4Re5yGvyJv5fsJtMVYmkAjoMaKgjYvCRJo=;
        b=pA2B/tR1kDgpVbhxiEnevjw3CrKOnAH3dKoU9fnXUJrWm8/1pe9nISJtYy2mTAzdwT
         u/VFdrhUh6usQFuFbpacoabR2nlELKnNvkg1ocybFdCnzHmuXWJYx0urw5P0c7Z7Q1ys
         hvYcVB9wIq9MuSce7qyWIozhA2mbHHcz2eFkA+JMQgosMYuEFrRuM0gkaEWVGcJy3nbb
         vVRTXNEnmrK6C/PA+p24W/XDgpNso7EOH0mCqVKTznEevDKaPn8BXmp3NlYFOFoclAx8
         dMBElyymfefFewUPaIYy/CZIMNAdxm6F05xJqYoR4kOWHzSz2efssYJFdW8PZL+0fLxM
         6ORA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790669512; x=1791274312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8n8olIhU2MMWC1LHor4cPhfWXcE121qFu8pwc/M0v7o=;
        b=aJ6TTw1vnPSVbdRGOkG1NAObhkulrbj2nSWly4KBmLYCIxzOF5ZuJOfkS87HKaue0x
         YnkCHnaiF8T2+Bs06prU7fxvYnkrtbQpzw00feHjAm/U5shw3drnYTEmWm0q6Xdqc17z
         +QLGQwwscemg9IKsO3vIRFb5THsAm7dwulUVHIFAuf0K5k5euUTQJUprGbmNRWgDd92n
         xMbsrhfzsSW6t6SE5/D2kwIW0t10vK3Da1Xv9rKgk/WU7KdO458sc38m4aqbESFJJ6P/
         YdmMVa/qVQK9KpHXH+y1+NsaPQz0yBWYhTTDJxMzu1r2KJLgxiaixtXx6jpFfp5Xbq+c
         BQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669512; x=1791274312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8n8olIhU2MMWC1LHor4cPhfWXcE121qFu8pwc/M0v7o=;
        b=EgDM9AnrsU84bjlsqO+tQJlpGf943aNpzmqrw3ZKin2IUcEZQyGUdG/sIXeLn5BM1z
         sk9UZd2K1JEcRskUfp9sVXvvIQaJExAYq+n1bzIKUXED/DhiVTt0z+pUAHKRhXpt9rki
         1ie2orcm9EFNXk/5rGlfboIJ+33GVmMxjoqkTDgYmiNKUT41pwRzeSJIKaz+2ejzpv+2
         aQR23UQO4X5HbBw9g9pUtWA7oaLoD7xCKyXedna7ML+sCCQr/NnDQOv/n+3cmlLv2FG1
         M4w3jOIpjhxLtF6FbrC5YoV/ButQbty7/ZZWboF4D3NJMab5MhvDI8QTlxXbXZ0isCMB
         8c9w==
X-Forwarded-Encrypted: i=1; AKwUvByeuiO6znN7hYuEcgzs7QaUHb6msJg8szvuJerIGj6SMpzmGmAEc/BqewbLJWGPM5TuWMG1fo/rR2g=@vger.kernel.org
X-Gm-Message-State: AFuF++l67VHlo7HnTrdaO5Bf9gZZ+9jbr2JNnANaBxbWGDjdqwdSa6st
	yBLFhZb4fkR4DtReXqwRn6CFV1dHRRqZ83aAsrTpV4tgET9m6IH5t5Mo6n830jvGb/wOWKEXeWM
	f9414u276jUWMpF+X2IrxWaxoVIeH7HPNRGnveQYY5l3Qbjq3o/J9DSv9P2wsh9POxtkO29Q9MG
	QgZvAuHjJtiJQe8iDDKPKrZuO3BUM+w/h+8yWPsbmGzn2B/Na1KA8=
X-Gm-Gg: AYBFou3fKfKHGd1rRJUvahDcOoPEPvI8fI4lUdtY4vng1Gk68guGwHlUTB33i/zSplB
	VOWJa+l9Kv3y5dV77CPhfzfsG6sHdYaK8/1qdMogNNPIlXHdB3ingW4zW9dWsQCJVCNNxUUezeS
	I6laCJJw1kF1gwyBjUJL4ofH8GB+cGyt1ST9mP3t+wc4S45Lmrl13qjNlucYLLOFDhz3gKDdqlP
	3m/pRf1lyNjDrmpRlTLu2FAGzvV4veBvwzCypId0hrly+6/kjemJEMMlNbn4EGV0p9XFiH7HN8=
X-Received: by 2002:a05:620a:2621:b0:93c:75f3:e146 with SMTP id af79cd13be357-93c75f3e31amr1222359085a.33.1790669511506;
        Tue, 29 Sep 2026 01:11:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2621:b0:93c:75f3:e146 with SMTP id
 af79cd13be357-93c75f3e31amr1222357085a.33.1790669511064; Tue, 29 Sep 2026
 01:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
 <20260927-cci-clk-fix-v5-5-4cd498559ae5@oss.qualcomm.com> <arrymkYqBOzLrgnV@zenone.zhora.eu>
In-Reply-To: <arrymkYqBOzLrgnV@zenone.zhora.eu>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 10:11:39 +0200
X-Gm-Features: AclHuK9tROaSuZGwrgXYftuCTCCZsm9VQ-ThGHIjlFm3D2BpIHH4ATLe6l7ae24
Message-ID: <CAFEp6-3F94+Ve+7cj8Pgu+HMq6=RfHEFksJ1eG-4rcpG+ODW-A@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] i2c: qcom-cci: Enforce the required CCI clock rate
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Robert Foss <rfoss@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vladimir.zapolskiy@linaro.org, konradybcio@kernel.org,
        stephan.gerhold@linaro.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfX6I6pfTfL7YRP
 3Np+xqBnwKgpRw5/MtJ+HLtT9gH25ucgO9LwZyVGTfKcyrQleTCuWNDK+/0e0cOlKUyy62uG7R8
 Jtz7NZCBLUDTpGN7sW3L72Vwwj6c41A=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abb72c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=eW-YW5vREpMiMjnL-pYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfXxAOhH7MB7D+Y
 QjzNgtfFETQCUCFvpbkKvNnTaeDyhIMFQnfJtf9cIKWer6GxiHNLCZTI1vP1brtolO1YmTYsRhn
 CntRxRoFjC09S//hu5GHPkRLXoNGWOdLbSEBb3G6yxGSeDWph9lO0f7SoSmkorsNUDZzYdxCGVh
 BV/MgriCPreU3ZpvPjAFDxMFf+19iFCupO+5/f7cxkvHrVg6WSwnehBe0GFe5jcwEK3LOES25do
 OOy/YJ7q8y1t+uPh8e6DC9oDN6Q/B7lb6U1TI9ojr6CMRbILV2ZcPKLuPDbEGC3rryGFwhPCXc5
 OvmV5CJK0yvvqzB3XZoNp1LF62kS3QPYWG2WGq1Sd7LuXAZeU8I6qovw7Z28j7vd0kon/MNSgDE
 E2isklpZVRLl/WxNRcgpRxEXxsFqAM/qmFZ1LFvKB+w7gV0XDzE5O4jDdoGdSK6oLvWt5UTBxT3
 KdKapaKV3R2YvT7vv4g==
X-Proofpoint-GUID: dWJfSCIndnfOWy6Hvg8wj-nSQ7iL_aTL
X-Proofpoint-ORIG-GUID: dWJfSCIndnfOWy6Hvg8wj-nSQ7iL_aTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290032

Hi Andi,


On Tue, Sep 29, 2026 at 1:28=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> =
wrote:
>
> Hi Loic,
>
> ...
>
> > @@ -318,7 +319,7 @@ static const struct hw_params *cci_get_hw_params(st=
ruct cci *cci, int mode)
> >       unsigned long rate =3D clk_get_rate(cci->cci_clk);
> >       int ri =3D cci_clk_rate_idx(rate);
> >
> > -     if (ri >=3D 0 && mode <=3D cci->data->max_mode && cci_hw_params[r=
i][mode].thigh)
> > +     if (ri >=3D 0 && mode <=3D cci->data->max_mode)
>
> why are you removing the .thigh check here?

Because it is now redundant, the mode content is already validated
during core clock selection in probe. At this point, we only ensure
that the mode value is a valid index.
This follows Vlad's comment:
https://lore.kernel.org/all/CAFEp6-1GCa2t3wBznoF-HnmtNCUSsshnWnrv8O6R2_06Kq=
gKQA@mail.gmail.com/

>
> >               return &cci_hw_params[ri][mode];
> >
> >       return NULL;
>
> ...
>
> > +static int cci_set_core_rate(struct cci *cci)
> > +{
> > +     struct device *dev =3D cci->dev;
> > +     unsigned long rate;
> > +     int ret;
> > +
> > +     ret =3D cci_get_required_rate(cci, &rate);
> > +     if (ret) {
> > +             dev_err(dev, "no CCI clock rate satisfies all masters\n")=
;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D dev_pm_opp_set_rate(dev, rate);
> > +     if (ret) {
> > +             dev_warn(dev, "CCI clock could not be set to %lu Hz\n", r=
ate);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Sanity: The hw_params timings are only valid at the exact
> > +      * expected rate, verify what landed on the hardware.
> > +      */
> > +     if (clk_get_rate(cci->cci_clk) !=3D rate)
> > +             dev_warn(dev, "CCI clock is not at expected %lu Hz\n", ra=
te);
> > +
> > +     return 0;
> > +}
> > +
> >  static int __maybe_unused cci_suspend_runtime(struct device *dev)
> >  {
> >       struct cci *cci =3D dev_get_drvdata(dev);
> > @@ -678,6 +739,19 @@ static int cci_probe(struct platform_device *pdev)
> >               return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
> >                                    "failed to get CCI clock\n");
> >
> > +     ret =3D devm_pm_opp_set_clkname(dev, "cci");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set CCI OPP clk=
\n");
> > +
> > +     /* OPP table is optional */
> > +     ret =3D devm_pm_opp_of_add_table(dev);
> > +     if (ret && ret !=3D -ENODEV)
> > +             return dev_err_probe(dev, ret, "failed to add OPP table\n=
");
> > +
> > +     ret =3D cci_set_core_rate(cci);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to set CCI clock r=
ate\n");
>
> The error logging is a bit messed up here: you either print here
> or in cci_set_core_rate(). Besides why is a warning there and an
> error here? I would just print error in cci_set_core_rate() and
> return here.

Right, will fix that.

Thanks,
Loic

>
> Andi
>
> > +
