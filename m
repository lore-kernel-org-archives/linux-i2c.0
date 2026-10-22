Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792675622;
	b=QcJVzizEI6J/Yb5jNAuEryvPjxDfs6JO+CWXzbYO+Aq/IUGiqNQ5yoNtbN0Ply6AGHdn
	 kMUAwJ9YRFvcnYcNB7q0BHfqc8urMQTpQ0umzryYxerz328iXc/1qHn9ePRwds6w/5yiD
	 1+RIFC8qDIilEVkIVI7ydU+L3l8V6Hw3XIQzEwK+4jSWuTMYVfaPcys67wZ2DEgx2TUsz
	 2bwK6QRfZq976ZMxBbTZjHMBUUPjkznfa1ONXnKDXnX3qZO0L/1fGw1hPwnPwwcPTJSTA
	 wZu+tqLblr2W2NXltgPBixuwblfgaKHJTSjZtmnILUQON68siVh5ma0Rar23mF1+mVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675622;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jkdBGMrXl2ogSNgP+aCYhlNxyIfloe8YrYNUTMrUXHk=;
	b=XZN6q2t7Lz28kIXdUfEVmljwzPk4ALikR5P5iA8eKmBewOvok9bEvVaYmTXPEHSRVCgl
	 NE4pCsfSNFqG1u0U60BhSZ7KbZ86d10qTISIrCcTF3rkBZBd2HYQvj59LjvVp5oQzgtvz
	 iUvQbZm6kimYknDKW+5N4+ZX5Px+r8SUPtbY3y4t7uBQgJU6hViaq8o6Ji0Yf1EL0jfoY
	 BdLRUazYc5n4pbHC6mxpHn/RcMhIPVfxjjaiMoNr7QT4vOOomdb5nm3TGXgmwv6051oIh
	 Gw8nQWPozAEt/WYoufyXjuSXJ/rnKTbv4FALC9Yvc1APtK/vL75QtlaKHzUm9oTB2/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e0XK+CzR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cd8Bs7kp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B8606A31D
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 13:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D26B8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e0XK+CzR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cd8Bs7kp
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA06e83479982
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 13:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jkdBGMrXl2ogSNgP+aCYhlNxyIfloe8YrYNUTMrUXHk=; b=e0XK+CzR+w5dGiD+
	JLK5GhSH9gEEMnUrcdYTBve4Su/QQG6SCAN8Jug2OIxpNqE3iRM6fH0RDnlM+ZRt
	Oggc1GiRGXO/lxF4SDGO7WTxKcAmqxwEBgKJKD7drycDGuvjqeBnjUF4nq4vfbae
	LnDMUqX0Nuw2BnoXaB4p5tbP385AYmPmiXDFTssc/OnJO4iMLsQtue+W1SQoPTSP
	W03UBc1G62vkqlb0RjlmZ6UISZNXKwlTyzo0rJ2a8MfXhtT/7ZJMYWHgClwY8WnJ
	MAeMd1og4dJYQJ6GLwmzQ04BDpRA6AkLCtCcay740UFOClG3kI+BfbADg/BbjetC
	wSnyRQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a3qce-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 13:27:01 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e4dso2649421b6e.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 06:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792675620; cv=none;
        d=google.com; s=arc-20260327;
        b=mad0RgmhOvF97VCa5YF89Ez2fHK33IDdIwKV8cEoPljPyefq9TlQQgny3NF3/vVHue
         PyvXZUX3+l+PdFipX3o6kyzi8CwYF4A0tBMumqKeLlv0x4ayBKjLBb9DM1o7EKFrba9C
         PFN4TNcQl1lOqgNYjdzLbgLmGrt8iDkvfLfaHeksic7MJDjsvetQJd6veV3z3KNOr7yh
         jaRLWDND5rU9/0C8nbs1xbP+s9GDiJMOKrN71T/t6B403DP1U/+VQgudhMeC2zByl0gX
         93kZq8ZP7nKiAOxmuCxxfezVjmh+eqyYsVQQB3s/ovfH0zw+4tvMrI3yKZ8hSrWxBimV
         jLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jkdBGMrXl2ogSNgP+aCYhlNxyIfloe8YrYNUTMrUXHk=;
        fh=TlMPn/CiCgRg8EHSmNT4Vm8cIWdovPoFu8xC/hOozmI=;
        b=IYIdMoWr8io1VdciPABUYRkd+2LlzTC+QgTJ1p6esQ2wPRzJ/3SUaVX2rWPi4Y4CTz
         wG9p0UBnLlm0EfNC5O8Yhd5j4jxSIGogy8SVXX8z8GRaT0YsxK7fpEmvTCisQFo9F0fE
         jwTBBejkCu2vHNyjDReoq1eBF3CQCiJLJ8fIVvMOM3P0CJOa3+ZwasL/vfawhoZ78cQg
         5w3DNu6T4BCiOAOxiwBDcwm8RaSAOuIAb/e4qZYfpanvXyDSfts/0oqhSJ7SeI0R+sdX
         WnA0UG8kuoWN7MJXhA/8EnXcNmE/jzn12BLOpgzdfYWMjR1SG7/zLeVcinI8sFMB3XaX
         /EyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792675620; x=1793280420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jkdBGMrXl2ogSNgP+aCYhlNxyIfloe8YrYNUTMrUXHk=;
        b=cd8Bs7kptfEBPAeSdhJnCBWKk+TgqNJP0L+9BZojSBPsREJKht+YOFgpo6bWDtCH0K
         46GakeEAeeieY8GHoMH9E/ms32opi2OOl7bJkAyIMwxHpGVKeHqnxie2pT5yoR+itXQn
         xwxchSqJ4H5kjq0Tr/8MNIbZndqNlJBIyPTqKxU1okQlJY9PXvvwJVS1dUg3DRc1vzLS
         9qR2zwordUjpan4aQJ37KJ7ingMY/xW6odj8at2zbnFhxDRuJIoXPGKcNHL8cr613uWa
         4Azhtzka+6IwFuKB5sAcFtihTzZIoeLM9jYb+R8WE2+pugfm/Tpyp4p4YYeoqbc0/NdH
         ZU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675620; x=1793280420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jkdBGMrXl2ogSNgP+aCYhlNxyIfloe8YrYNUTMrUXHk=;
        b=Hf73atpiDXRCEgBTRgy84G9Sd+VxB5bWd7PcO3Z0B/0c7Djt5r40Llfwn5myk28BH0
         hMPhLIvNE/eJB0DH7TC4hadVLcedG00FVu5o6w26gOOXl/kwLUFB6j7nz/f1sWKRQj1j
         X2fOLZay8Z9L6bgUCzieLqymkb2v3WBQ5ksNQtF/edc3yMXQJjBiJYC8xY4x5kFf5Own
         3ZLXVHgXypT3W3KFo7r23tooBac/swm+lTRtR8Q08tH1+gaf8dDw8o6hMN2QYhG7BVJf
         JFARCzKMe2MSkKb6q+5kCKHh2Gli4VsTG4+ahki53leP7s9Y4K4JU1CUDW3B/l31Ra4w
         j6iw==
X-Forwarded-Encrypted: i=1; AKwUvBw4LbTacgcNCTnxaTCn9Yk/izZqWuRNhCFtkn9s+OptGtwbCz59q36k4doMhzIo/xNqpUPNgyLNLz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/EMoyDAYQn3hqXGkiwZPjLoj9SXanW5llLW6bT6Hj3zcsbLdd
	BpMZ89RjrtrIHAYR6UvLI4DfmPtzubKjv8SYMuxgCDgvQuIrEznGuPsKSqfdvpU6fb2eLQK1au6
	rharKSbrYY+SLFDBa+bfD4ko7RgEsNjVrthPYxe+E1uCSUmkVjl3f/0HrB6mi1EsxcelXi9mffo
	oRm/PZoDheENevGC4MAAipGLfzgf4voaGRt4mS5Q==
X-Gm-Gg: AYBFou3vLA+zKCKm/2BvydE8XFUNNcK7UKPmSbHhFp6/NPdvJpRt8ohm9+hDRZV/0T+
	szY51LKG3HkVsGTjD6Yxaks8hDcHLd8CqLv3/iePbdD38I7n/LKevWkry7LDPwepmOWv7rfcWgR
	J0TPlaUGFL1yjk2aiYlk9Npn40qL9zgW0NLon2GRdaZ4POvybsTB9hxyeIrAS99aj04zz10s2/9
	9LEgTWQHBwBVZo6nCsXQGwDdIyTcVmcZBgMDV5udmZG7neuF0SoQzpR5c+b1efp1k390pZ/mFo=
X-Received: by 2002:a05:6808:508b:b0:53e:42e4:47c with SMTP id 5614622812f47-5535a28a8ebmr3850178b6e.34.1792675620242;
        Thu, 22 Oct 2026 06:27:00 -0700 (PDT)
X-Received: by 2002:a05:6808:508b:b0:53e:42e4:47c with SMTP id
 5614622812f47-5535a28a8ebmr3850158b6e.34.1792675619795; Thu, 22 Oct 2026
 06:26:59 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022071418.26895-1-bjsaikiran@gmail.com> <20261022071418.26895-2-bjsaikiran@gmail.com>
In-Reply-To: <20261022071418.26895-2-bjsaikiran@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 15:26:46 +0200
X-Gm-Features: AclHuK8flPST7fFs4KH2917QipXg6lzf73ICNib5r7yG-3sF-q7lhsX38NFcO_w
Message-ID: <CAFEp6-3iqL_a1c0u0tXhtZBZ+k__=KjQX7y2-0djf9qbBzS+Mw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] i2c: qcom-cci: Select pinctrl states during
 runtime PM
To: Saikiran <bjsaikiran@gmail.com>
Cc: rfoss@kernel.org, andi.shyti@kernel.org, sakari.ailus@linux.intel.com,
        hansg@kernel.org, bod@kernel.org, mchehab@kernel.org,
        vladimir.zapolskiy@linaro.org, jishnu.prakash@oss.qualcomm.com,
        birk.skyum@pm.me, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX+c9+qH8FsACT
 vCAqAN7dXd9ugXrACDmK6AfL6ZhUUssFXD5FbWIQ2c5vVwMxfLsCgrDhY1cQKCG/grQz0Ttc2xl
 SKC+0Crpl/UsiJerhExflFDx8JjQE/1zbKgVRrCjxC3hMdz4a/C0exVTsVxcrRlr7SpE7op+0Ln
 uVjINRsieC8UJMkoxM5kZSkrzdgVW2TWWXqOeMo4dMED9wWLHVdgHwe1c7NjZ0V1iYeFF9gWhHm
 NCTmAS9gIpIBIuhOJTh7zDDZq3jwjRID6gUy/WPwLiPOck5YMxGaT5FajrM8Z+H9s1/5CllP4cr
 bJ9ZmbJSlT0m6WLnwyBwGLnX6T7YQGTJQr+MrdHGev83qN56Jj9u1u58CWFlCJniRFzZ2Yo/CMM
 o+aPj6Oz4vOuykAH4ZzMcUnCgvYikyvTG7CGy/wlIH497RvrhToz4TcqnKFWVwZrzXyt01gKoF9
 fT7R/Q9xkuNo/3zPpxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MyBTYWx0ZWRfX9+uCg9HvyIYV
 DAoWGV5t1y47sK6fEAZQ4PQNsQEp7PaqfmNlNp6BPAMNWBGxD9jU5tUFnHRrYfDi6nug2/zm2PY
 4neoUN0hHiQauT7S/UufhPTCJNnbgDE=
X-Proofpoint-GUID: IxtowjV-sWmaEHrPz72b1xU349U3JN5W
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ada0f25 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=i_vyvEnQizJGaKJi4PUA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: IxtowjV-sWmaEHrPz72b1xU349U3JN5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220053

On Thu, Oct 22, 2026 at 9:14=E2=80=AFAM Saikiran <bjsaikiran@gmail.com> wro=
te:
>
> The CCI runtime PM callbacks only gate the controller clocks, leaving the
> bus pins in their default state while the controller is suspended. On the
> Lenovo Yoga Slim 7x, this can back-power the camera sensor through SDA an=
d
> SCL after its supplies have been disabled, contributing to brownouts on
> subsequent power cycles.
>
> Select the sleep pinctrl state before disabling the clocks so that the
> configured pull-downs can take effect. Restore the default state before
> enabling the clocks on resume, and return to the sleep state if enabling
> the clocks fails.
>
> Tested-on: Lenovo Yoga Slim 7x (Snapdragon X Elite)
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 873e901a23d7..fba5f664eeaa 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm_runtime.h>
>
>  #define CCI_HW_VERSION                         0x0
> @@ -474,6 +475,11 @@ static void cci_disable_clocks(struct cci *cci)
>  static int __maybe_unused cci_suspend_runtime(struct device *dev)
>  {
>         struct cci *cci =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D pinctrl_pm_select_sleep_state(dev);
> +       if (ret)
> +               return ret;

You should perform the do/undo symmetrically in suspend/resume, so it
would probably be better to move the pinctrl handling to the end of
the suspend function after clock disabling.

>
>         cci_disable_clocks(cci);
>         return 0;
> @@ -484,10 +490,16 @@ static int __maybe_unused cci_resume_runtime(struct=
 device *dev)
>         struct cci *cci =3D dev_get_drvdata(dev);
>         int ret;
>
> -       ret =3D cci_enable_clocks(cci);
> +       ret =3D pinctrl_pm_select_default_state(dev);
>         if (ret)
>                 return ret;
>
> +       ret =3D cci_enable_clocks(cci);
> +       if (ret) {
> +               pinctrl_pm_select_sleep_state(dev);
> +               return ret;
> +       }
> +
>         cci_init(cci);
>         return 0;
>  }
> --
> 2.56.0
>
