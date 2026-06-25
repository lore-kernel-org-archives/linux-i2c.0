Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFE3C09EE
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381099; cv=pass; b=Gt5sbpUkCmP06mB3No7Bl0rZrZLj5PuWKuS2WVo3YXxHAwolQziRzsYOVmw3I4Vwm4Z4EKceMDywOs7YWaeLLuO1U51G9hIwVkiKAszQ0TsnKKsKLneVNtlNA1GHLCFGFCrN6+4U+4PseuLpoAdvc7EaSMo69iwI8IT/R8Qlb+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381099; c=relaxed/simple;
	bh=NXKI/X2JdsZ4JImi2yN22pzvK3RGm6LVHH3NHot9Mzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8WEmanaVM+hTsxZmOc/Codx8XR+qR9EUKZ3QPi3ixe9VZszpvq6JD/ZERGDNrDnKsqSn3yiEBNwvL+Uuu0asvNK8N6f3kepO7wHO5AzNSp8c80HOseVkOflk2M9Z7jiQyMRRlAwcPlPqnNVC9DuqC22vxb+mU/ygxjWIVYM7hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=neHH2+Gq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0pGKOf6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="neHH2+Gq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0pGKOf6"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9js6i2009328
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=; b=neHH2+GqkXm4jA5o
	Hz+Z6gpE0mpPMnGoD1cRYZEBD0zDDrM78UsGS5zMUmjxdSfDa/om//rGGk2AVF00
	KU3lOskymWkC09tz0aJzoH+PM1Mql/CGYpyqFH+Q+87js/mRzQk8mvqdgqLoEp3n
	MD3zB1/mJs4HJXdZNDi/MFnQ4EOffoOnsyDxQZ9EL5DuIRijokgAqVUoPAgdBvza
	9R7ikt4oUbrn9/901ZM6n028Prc+F66flYShREXRYk/BgBdW0ZWJlwIWjoxAw8TP
	NB01WgjrLDRTRMVYPwT1ZOdBIFBCvs4P6Xz1hGYZMv4TX75tQshiz/w7pDV4YZ/7
	/Im4Vg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmhkkm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:51:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92045e86763so160909685a.1
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 02:51:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782381096; cv=none;
        d=google.com; s=arc-20260327;
        b=CX+vPbWETBYc7iaLisPYTq0IjIYZ5SjmpziD9DzKBHmqPska4qHeS6H+Ftd01miO5q
         IDU41gU73QNPsCPpYhmBGEwNQ8zTFPYwrNTYIuSkYeYA9FxcYfuLhApcjQWUShsL/8Br
         Iy5v4J0R7UBL2oi0gQIeHAH2nWDzRXV+Khk/AJl8ksT+LkbhcjsY6eLxBttD4qEFz7iZ
         Ap9QXuFHMOJ/tacDwMN9JCxhigz/uqrfUm/jWQ+cs9PrSTZkeQ1IPEESE2XESpODGULV
         DTflghDkqeDX1tvnb4UcXBrziWR7eKsRqihBlwE+hPSV4M+h9hcDuMH8hsUG1YQ8pqqz
         tTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        fh=9Y6CfCxqoiO9hodqbFsI0UL/Dnzsmgk0hR0BvDVNjMI=;
        b=KL9jp8yOKZONbgOOVK1iKUrgdjNuc0CNxfjptX7e1xmITbc97UjQV6Kxz7y0LhYWc1
         k8xFAFcJdMdzZ6lPiyUHWM4A/jIqjrKGaPJR4jvJL+2MJCscq5OOOIzb37T1U02Rt06G
         WisGCMHfizqdWh0UWV1+lxj0MD1cNyK7UYnaNL+2ckqHm8ms6wHhiMJjimlb/xexC2Ci
         TjsbqOO0RLABZcEErDrfqCpi1oB3pxAyXvFNA9B5w9vLpXByu2TPLBXEqIJO6Hf9yxi0
         YpSBMCtMvO0RePtmQUDctwsUeUJcgKSu1a5A/WxfPEDNrdCPMfbLYZO7d6fi9l4PeF+W
         VEEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782381096; x=1782985896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        b=K0pGKOf6Nj1hOVU7/vPFIagniMTTMIq0LZm6+/1WyaN26YL9c7BXnJoH+EB89i86yB
         oBy2Xg3cPwG/VWkMkFZsYBjGMVkBHlDrotZOG2BHEs39DWhzShKB5YA+Bvt1bxy7dFqu
         W5IJG+8gIQQBQxI4dfQv9dVDOsLhNK//S/UXTV9Kwh58EkmFWbdpNcVKzC3YiBQLb/Kn
         NzoOCabnMpESVBy9rc/0+4NT6W6fXR4xsGzE5E8aCA1pTLdSx3L1u/U3zSpak9rfXG16
         QlbnK3lmMmH2faJimZC4+dXx/EmidBKgkpiM+sNV8X4Sx3cRopYrTmpfWsXrY1+qE6jP
         iUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381096; x=1782985896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60fAk3AGCUEygd+ffK7iRw0f1YhHwOSSOFfmJ0pJwAg=;
        b=gSeyuL08ovc779f6GoAbeR/LlKylxArO2yjk4pL7DsJnbv78HzAMv1ck4bLTLYs+7S
         fCWNLoYOO+O5jgiRbeMRVSWMy8gzIlBe7golaBMcsCzIG0Fk+ciqMjW0GwOksTO8Yz9A
         sIJfgGE3HtgDPJ+oQTSWpB2vo8Q2ev+tzuXj5mEBeM5yf3+14Z1YdHChve90zP7S89QL
         fttU/DFDon20vhJXI+xuyeX1tL2EaKCklwZuuAHFGMHAvcXUZR9gl+3tV7mLfBbKy44s
         9a/kBJKhyUHoGQEpTBClCVSBuU5r4qH0TqM6c/3LXwE4ZZDaeO+pB3anKjOwi/ooTM5v
         z3vg==
X-Forwarded-Encrypted: i=1; AFNElJ9LOs4uDAEccZEhQxytA255MenaxQZ0M/qFyvUOc/DM0RzB7d4tsaMuaBMJ3MC9bjQmaI57rti+EXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYxX8bCGEFgOFWdHyCD7CBKcp7tn7SVrOMtY4+dYwoWa8rlUR
	HnpLHyeSdF/nb+WKWnlNyLjINCIaHMz50XFc4BX87iG6OF+/lKL5/jbHhHW05IEi5lbEU1u8uX+
	1X4rveXMZV5VH7ZgPHahpRTJHQMfHDRfOSKCiGRmmcyWnHPZ173eKkLs9NzIltbvC+VDt4+qWWD
	gel5xTcvIad+C2akWC97/nwD2LBzTA7p5THQX3fQ==
X-Gm-Gg: AfdE7cldxRmsF5fp4N8OLIC4I0YTeh6cYtvkw28PoAiDZu7s23ue4NReM9ZctmBrbfS
	O2JYybWeigFxGB5kxv/MEbg/sactCSa4g69pmRVC4wJV2fnCvGkwUZfuS3u3LqvA0gKxaHda1lq
	8M0/PKtkSHpVGDXDYFlXJXr8EKw5VrBhdbj3ei/4Lk8CpfUtpGO9efhYBV8Efu6Z+gWNLfBNrSd
	Kjf9uhFo7DbLNtdiwTzEj865WIwb1lf+LFGiV0fgxQ2FN0QgxKm+iuS8VMWS2ASnRajOAEg/MZy
	zLPRt0lQPq8=
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id af79cd13be357-926039b4cc5mr908910585a.43.1782381096069;
        Thu, 25 Jun 2026 02:51:36 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:915:ab5d:6763 with SMTP id
 af79cd13be357-926039b4cc5mr908908085a.43.1782381095620; Thu, 25 Jun 2026
 02:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
In-Reply-To: <20260625-cci-v1-1-a100cda673ce@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 11:51:24 +0200
X-Gm-Features: AVVi8CfDXACT0qSqvnYo9b7ZgxqbZ1d4WZWiyuwC73lAhja8c1-UXvbxtlfkIMw
Message-ID: <CAFEp6-3AY535E4LzCpH9-8ksiec=qsk+Ayzfti-kAk7p_FxstA@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: drop custom suspend/resume and rely on
 runtime PM helpers
To: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3cfa28 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=lGg1ZlD2jTvwlhVTGJMA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA4MyBTYWx0ZWRfX8K6AmjmjxzUb
 OQg4hgZmEBSLkUhv+mJrmLi5/x9cjn4vGM6TH9Yfaba6Mp0H43OniPilOWvNelSlXHeNCbmUBQ0
 3L/DqChAvNbdnOLEWji+coXoCPRQM4Q2l1ZwdWkJvJII4CX+dE3rCHyjNPxIlYgJHJMZP8T9y4b
 fbKG+qmw6FYR+CmuFDJ2FLZYSv+Mtgxa9aMfj0HJQ+BWDcJJW3Ux4YNz9TmSqB3tz1EfGR4vl3l
 O9Z7XpeQGYNjoCThZshDKRxLcu+0XGYIRCuX1eSrDsMenrmbjC10uoXeGBt/SuEqQ/1o7vrCHNU
 o2LiWEr3eP96LdoBdRWU2a8A7no4scA8llUgq2SynEAVJtG1KE5TPXTJlMH6zasISxhJwjYAsvN
 B5yQySf4FMeRCm+/lMShmMoX+RcOqMR9Ve2w3O8+WH/o1nWtz7/QnItd+BZCTcv7BArGNA2x9wE
 ULeYSQOrGSyexAQPwYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA4MyBTYWx0ZWRfXw2WHhMrASBuC
 m5LmfaAUC2n9dpi/7uuHL4ZY4FPf3TNTynW3jiWYIJFMgZrsNkKyWea+miasVHwQo6Dkq+2nuUg
 2OYe/Lu+8ZXdnASlK9DErSDXAo6xeWk=
X-Proofpoint-GUID: MBuLRns-XEkZqViZ2T1IqsS83FADAIAD
X-Proofpoint-ORIG-GUID: MBuLRns-XEkZqViZ2T1IqsS83FADAIAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250083

On Thu, Jun 25, 2026 at 11:42=E2=80=AFAM Wenmeng Liu
<wenmeng.liu@oss.qualcomm.com> wrote:
>
> cci_resume() unconditionally calls cci_resume_runtime() regardless of
> the runtime PM state.
>
> If the device is already runtime-suspended before system suspend,
> the clock is re-enabled while runtime_status remains RPM_SUSPENDED.
> As a result, pm_request_autosuspend() does not arm the timer,
> leaving the clock permanently enabled.
>
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..bdeda3979c4814b5cdb463734=
b8361da7fffa879 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -492,24 +492,8 @@ static int __maybe_unused cci_resume_runtime(struct =
device *dev)
>         return 0;
>  }
>
> -static int __maybe_unused cci_suspend(struct device *dev)
> -{
> -       if (!pm_runtime_suspended(dev))
> -               return cci_suspend_runtime(dev);
> -
> -       return 0;
> -}
> -
> -static int __maybe_unused cci_resume(struct device *dev)
> -{
> -       cci_resume_runtime(dev);
> -       pm_request_autosuspend(dev);
> -
> -       return 0;
> -}
> -
>  static const struct dev_pm_ops qcom_cci_pm =3D {
> -       SET_SYSTEM_SLEEP_PM_OPS(cci_suspend, cci_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_forc=
e_resume)
>         SET_RUNTIME_PM_OPS(cci_suspend_runtime, cci_resume_runtime, NULL)
>  };
>
>
> ---
> base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> change-id: 20260625-cci-3eedf766d43b
>
> Best regards,
> --
> Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
>
