Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388B43C7C5
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542665; cv=pass; b=MYcCkP7ns4TWa9OofPEQHXBwLjrb2U1Hc5nrskSWrQBgQwczwaKfsbug8JNG70fhG2+09puHTbuXHRWJddbSHcp+/nhPdA1yZV2aosyk0xrBefn/u6S322o9rayNm3NBLB21Hsgzp2TdTDRn+amMEfWnqbz6v4NCG2RrMasTqXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542665; c=relaxed/simple;
	bh=hOWhDc6Fqp7yVb+hb/ELo5AQ6mHpP50RQtdPn6I3HFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkXFw7siy6YLNsEkmmj6n/1ihaQm0dwe1YxZwSigkSBbhMF2bvRBtTZs/9pXmwQKKVaIK4DZ5a8CBvLGOmyeT4tu/AVuB8sNNtlFqueDKkH6KEoc+AuKLpKBznYod0aD2drM721uIBJMslS1jb1WFfXagkV95ILBRlj4cyrn+VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmvzAV/z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zoyn60cu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmvzAV/z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zoyn60cu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbYMw3597619
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 13:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=; b=VmvzAV/zdNb39Nu4
	ACKmZ7WgdeZxyr7zKWUr39PM7rY1CHc778fkmaJFbleyaQW/549Kurtkky+8i2oi
	irHpy9zLbPRjp4xGAo0O3BeJPaDzxpqRFVfCpJglrLUKHTDgRPMCZdtm0qKwu8P0
	DgKxdIMy6gWlUPt8IQ/JwRMJDWYtNDmR6Pggjd9Wp0XFPDzF5cshLolsoJSdoQCb
	QmLs2nzpMXrnRHJfvC7pey6WGHSgb8KSmfpY4PEr7HdAcb1o1wN8w5f+RY4NsuF3
	P85nCVXlYUjbx4sw4b6I84chDfkFkSuJhioqfX9DjUV/PCTfH4MKaylc5JffV+GX
	+VLxBQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrm4jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 13:51:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec3146553so178394685a.1
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 06:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786542662; cv=none;
        d=google.com; s=arc-20260327;
        b=AmUXeedv53P9f34FB7/DHzm1qCfPu1Ww2X6GfKdTbOsKGPezXp23QIk/blGIyq+5tC
         Z+J0WVetjQwRAmt5bmw7aOfwgQHe4KZjB2/hmIRAm3ZroTb1+EnSNe9F2Oo9rUCfmMnm
         LmMN59W5/Vw4XLtsl1ykCQk/bED2456y4lr+5NmKWqLdNQoOf+UbbvN43sMZCIChAbHC
         3uEpIm7fOX+si3qfcy+wzfRPLgMzuYQTiNOxXVIhrRgtn4Qw/InUoPgshieiUqLuynWD
         UlP5SYI1j0e/K5QuqPrWsXC7g6S0w6AFup0mAfGo/yqp/Y3FYFX+6lpWLYPrUfIOVpn0
         xLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        fh=NQ/a85QP+ZYTmjtwzQl7zPGD10yPxOIJCyjqTBJ7Z9U=;
        b=Eisz6UgSwjrsKLJYVlZMOuZY0oCJl+igCMP/qzEq8HqUDx7SShZwPTiHRRcIHL44Hj
         8DcdxP/ZX707VPz5wxAtlkPKMLmceFjCqtZv/1AWhsGSC/pDlT6banjxzaMNJqkA4XYo
         p+tHVOB2nOGsj62Ja2rxqHb3XnY346tjVOgRmCAN/aEhBh1Rl5Ua2O4a1o9OQNIoGf8m
         dPM9A/OATqESEfKfXTT9kaGR8NCbPiTh+illfGo1G+/qv8S8/Ev3JTycLodgsbpYP4l0
         C3gTKrNfEVaWAr4N1FZFlTeSz1SyYjsRZ430xpvr5k/JElHeKr7eY4jyxXc8SBLQV1sd
         k07Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786542662; x=1787147462; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        b=Zoyn60cuxd3Y+S2glqlcx0ebPmiTYKyY30X3gXeBM2KjGoZ/Et3dzYIKQLuRvrw5Hl
         MfxxApDEf64FmWE0hNFWm/oL6bb9CtJkkezmqW7SB885TsblXKfgqTUyAGZVWkJgP8vV
         r9mfEXF8rkKQ4r8iI7D7IJXHEv1tN9ZUxlBcet4u3fnV1kDlIqca2gNBniLAOSnljwSW
         hCT1HH+5PClnw1b/jgEUVP2lx6F8dLTzMVJNdq7Lxipk84VLu3KeTuhSuzeYeD0FmBqX
         Bxo1l3hi/bPBt9fT/UyGC85t5PB7NaNyut6/scxrVQtxh1kSbZtnpewaY1cHBIciX1Cv
         hdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786542662; x=1787147462;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdaZ6sdPXiAoVOIokOjzAD5jN5cH1HtUETlaWKI67X0=;
        b=QFJbWfVVbVyYw2K0O9WNLgVyezPP2UvSK2dgnortpkpT4jEWHOmvr0G7ovyQnkCmK+
         P5xEBk9MCrBJYBaOx4vgJLTb/qG2+U0Dbm2ZVE2c1GlHzVsbIJkE3xXNIdTKtfsBn7E3
         E5TGtEmJ7bxzhMRhld3NnWE3GV58+l5t9A4CXSQjVeq6sVQG9KARFaIvO5NZGL+U2WH0
         HInk3V4CWV7yQKja3U28fSCWBHpGhGpvuXgm1e/HC6GsVS7kw+XC7cypX6IuYmzUSrU4
         7gUQqVkjkxaQD+Ff725Ie76UYKQ8RmEudct6Zaook++iT+qnkOvHbZsUOqaBoZ7SJlci
         Vdpg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1b0UqaZLTSDzhsu8dC8eCuNmAqvUZDb+pdeh0Phjm9AOxa4NeRgty9CXKWr2VQ63fu+mEDoKL+3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi/yZ1qTMpZ6zVVR64H1I/rIb5s130ztEnexFVMGempYiaT6f7
	n2rnulQjpGfy0xRxXORmuG4LdzHScESLEHiKdv0h2nkSfJvkKLrdoOSsrIefho2+w+38dlZ9hGr
	FaT5tvHI3Vsh4dB1YS5BSc+mcw89vIGf1UAkqUQqMUkAsIS+uwEcmlZ5IhKIdWevMnY1Zr2/TQi
	oOvHVzrrdgOvAglHIrj+lL/0lbmPAOIW1h6k/ShQ==
X-Gm-Gg: AR+sD11HNktz/z31sRf7eA9LFLPwK6YCDMeANMR4mgwxpzhcKPGlrrhwCbCuHP10ZoQ
	x3ihvMIj5Y3MUGN0X3M98pYoHXLYKINfmY2vMdcHRqHGazAiFEc7GWsW7P+07shzegArxmd3ETn
	KnrVRRy9EJppYBcX/JAJvSrKrNqu8owCM2Ve7wkR1osA3TZtSGeFNv9/82G+n4yJLYeQDVgFF87
	VAsjZ1Yxr8tTOkgZNgsPaGvL3EdTgyYiflTqyRDRlPj+Kl0Bd5dJsMrhyiEa3vEGBFm62P8AXQo
X-Received: by 2002:a05:620a:648b:b0:923:8612:f15 with SMTP id af79cd13be357-936b3ad916cmr450086485a.18.1786542662271;
        Wed, 12 Aug 2026 06:51:02 -0700 (PDT)
X-Received: by 2002:a05:620a:648b:b0:923:8612:f15 with SMTP id
 af79cd13be357-936b3ad916cmr450082885a.18.1786542661921; Wed, 12 Aug 2026
 06:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812094425.3515179-1-lgs201920130244@gmail.com>
In-Reply-To: <20260812094425.3515179-1-lgs201920130244@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 15:50:50 +0200
X-Gm-Features: AUfX_mx6BU4whCh4J6zK1bhvqjl7XdzdnNX_zuruD8pdUd_6rsfBiSjTp64h08o
Message-ID: <CAFEp6-177whXgFj1uViqg1Gv=68GkqzG_gYqEbV1kX-9UXkSHw@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Wolfram Sang <wsa@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WQ_Db1lZ59GMuApjRGrUD2D0RMTpKpSF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfX+rA+h3yRwLkM
 FhSYhdvAf20RYdOdYazbEMdGcH3ocrKn4/rWym2oHhIh17Vhlf/k6xkOrjVmBZKNSnlqroRGT0h
 Heu/TZnrfruh71++5CT2KDTYp3qk3rw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMiBTYWx0ZWRfX6VpFK6lfMCe/
 RSfG2G2eezDjaSGBCXCl2IR/9aUlBkiGy/sBqZuOTVTp3QkumE5PCASGNVgPQuQgBg6ROWNkMQ1
 pJD1dh86o7o4iujIRm+Cc6w9H5SPsTNbDl0VGWkigmYD/scxm4F4Bw+4BEHHW+pch9GJK6ZMQCY
 wxR/ZQLv8EyLKCE7cR3UA2+U9HV8uLIW8EyhiA0QVPXFrehypLYAEb7TPQHtpn2nri9TYOs+WhJ
 bef+LPpbR/gTyR+u6wLlyd5fJ3JdDBjC6sYdn7lyksIHwsjvsIxZsuSt5nUUSbBMaiJBKNDlWEG
 OPS1d4O5u9xq2P9eeeX8Hwxup0mMX2FVVhU47rKSTFCHwOg2QmNcIK3WmB2ttK4iQsmCMZc3r31
 daleb3+/XQ631HmYFCoTaP1c7QUHQ2756EVdbfMo7YR1w9Yb7VK/Jx9KqQNgAbT7N9ktSHdU5jq
 VlohmKyNoKK4sIvV1zw==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c7a47 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=XDTyClmYPJ3ucqjADi8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: WQ_Db1lZ59GMuApjRGrUD2D0RMTpKpSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120112

On Wed, Aug 12, 2026 at 11:46=E2=80=AFAM Guangshuo Li <lgs201920130244@gmai=
l.com> wrote:
>
> cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> does not call the matching pm_runtime_dont_use_autosuspend() before
> disabling runtime PM.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
>
> Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> state. Its managed cleanup disables autosuspend and runtime PM and
> restores the suspended state on probe failure and driver removal.
> Remove the now redundant manual runtime PM cleanup.
>
> This issue was found by manual code inspection.
>
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index bdeda3979c48..25b6e4e9e3fa 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -595,9 +595,11 @@ static int cci_probe(struct platform_device *pdev)
>                 goto disable_clocks;
>
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +       ret =3D devm_pm_runtime_set_active_enabled(dev);
> +       if (ret)
> +               goto disable_clocks;
> +
>         pm_runtime_use_autosuspend(dev);
> -       pm_runtime_set_active(dev);
> -       pm_runtime_enable(dev);
>
>         for (i =3D 0; i < cci->data->num_masters; i++) {
>                 if (!cci->master[i].cci)
> @@ -613,8 +615,6 @@ static int cci_probe(struct platform_device *pdev)
>         return 0;
>
>  error_i2c:
> -       pm_runtime_disable(dev);
> -       pm_runtime_dont_use_autosuspend(dev);
>
>         for (--i ; i >=3D 0; i--) {
>                 if (cci->master[i].cci) {
> @@ -640,9 +640,6 @@ static void cci_remove(struct platform_device *pdev)
>                         cci_halt(cci, i);
>                 }
>         }
> -
> -       pm_runtime_disable(&pdev->dev);
> -       pm_runtime_set_suspended(&pdev->dev);
>  }
>
>  static const struct cci_data cci_v1_data =3D {
> --
> 2.43.0
>
