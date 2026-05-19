Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA32628D
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194897; cv=pass; b=mGyNWsbMXbX3FaMybmVE4+kl6raLcyfE9f4HxQRG9cKHdx8ELSl93hdrBq2kMZuZOhOBoo7qyYnXo6aJ9DFSHUFHWxb892KXdOzlKCXNd1kqcU7WxUENj9HXAYyEciYEM9Y2QlYQabmmduxoTgFIn1cYAMJUAXBt1e975B2gQ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194897; c=relaxed/simple;
	bh=tsgnV2aO8dyapXDpjYvvBCE8bTReMUKPZ4SILq8b81g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmqTALjV4m8pRwA96+eR+oO9mWylidI6M7ijcyrZzJH6QiGbID7lTjl8zcBxWNCgAbEzPGg5Xo2oqlF3mOfOPpbUrnYRsLjoLOQ04lIFl7Jv8O0K4AoTOenfmNOd4G2AtSfANsEG3aAh6VfEao2rWJd3bfWbYifuiMwACberIPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHudPXWN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SahnvIig; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHudPXWN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SahnvIig"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JA8JFB4130457
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FVUH6wBFgYiTBEVe2zhpxVry+VzFY3pfxbuijh3eje0=; b=HHudPXWNccwdsBlr
	+Nzk2I/MBcSFdaT5jB8yEKJWx0EEvc/EB2e0QlNn5wNOFyw6ndLehasBUTPpLrBc
	5yNzXDVyPu2npU5bSMbBf98jJcU6K1FoePh/APdWWJyOHW7o6QaCK/6FCLRy9Zwj
	7GuQXmxrEbda/7mgAXW7a0KDh282mMMWATCw6Y09t0YkryOv/DeOQaZNKyeLqNhJ
	eLS6ccYdBCQyJnHwDeXEBY7X+JDW4m1HDARU5ioxePwPI+ADl/vXQ8Mafjq4HXDe
	hXsSs0S4wHhVRDavfQHylXxiuFRS53CRYFIZ36n3Q1dDTZDaliqc+FJRVaTdBMxK
	mgwxEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ht1hs08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:48:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9112b2756fbso864892785a.0
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 05:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194893; cv=none;
        d=google.com; s=arc-20240605;
        b=LFmxos6rTFMNFYSK71xrZdUJ/vnvrBey5vHw4PLll0wlHWYxCwoA7zxtQjluzfdzk6
         dkcka+A5SHoRLIeNf2nCq3yNd0RnddTFtfBiaJg8pphlYTpo7padsNaAXu29n/Fdr4Lj
         O3t5T4NDXpMNOfPtMlSp7MG/hRjnffD+GR3QVU1E64X+0e80E7cEFmpbyVq2BfLXFVXG
         hf0fTDz3HbTDmg5k4lwXulz/FH/MvG1ODmAstIXlg2m1fiLXRY5hGxjq/VRsM5PPMNDy
         3r56TVjlgYrMR6bW3g4wefXvSzvh/3usJXEvNbOa2MvEyVevYtgfYNXmUIo5htw8CFuy
         WPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVUH6wBFgYiTBEVe2zhpxVry+VzFY3pfxbuijh3eje0=;
        fh=MP5r4YOGY67/g2qHmbFvaYYe931x7ZoLil808rBwECc=;
        b=Hyg+WZomFMN7+MeiZtJeNPcT9On8xk5lq+cG9YPNDJ7JGYY4PfaIUo5BQGf3e2AC9m
         vnTMysh13Vhsp1q2+VvB3YAm9HKLMAoHm69bUKINAb9DZyqgZ6Ezdrp9XAZ2hsxyFjiF
         YLS3PAouqJe/huodwCZmup509B7m536xqj9e2vcX57pP3kgyVY+1oDYZtVJ4oFxhOQ0o
         QlABqzDMBtuwVeRQ4z3SwDC5HFGWoQFKaHm7s8QfwOYMYhWU4wpGe+C5RC9XqnppRTrc
         7sEqwKE2vyutdamKV3v8l9WnkwtX/HMHnHbo8H4lJYsmXHFHkfCNgGrh8nToyrCFK7jI
         V3aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779194893; x=1779799693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVUH6wBFgYiTBEVe2zhpxVry+VzFY3pfxbuijh3eje0=;
        b=SahnvIigoqN2WG4c8plmzs/t0mjhnykmomDfyWvLQpXzO5UlsJFj9GpcX5ntOptYJ0
         EGampXl9ZDuk9w0Ff0DyecqHtMo/ke7kpTTEqgD5jHZAhJzmhmlWbdkacfjkETAtQj+U
         2++NCGKvm/bZcvjSdUoyl1yyNcpgbourtF9l9mV0pZ09fOzHOGa4jFA3U1Gg0JXPiaD4
         VYo1HFIKU7KQNCXI1ehsVDkfkn8qUUKf2SjOVWqw/kpfAfUXVvRzSjrccSIZEC+DuuAX
         a53e+eadpQ9po/bbv6uUH2F5p9VZW/FWK8rZCorPlYKwyExbcBhro32jl5mnueFvnW29
         XaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194893; x=1779799693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVUH6wBFgYiTBEVe2zhpxVry+VzFY3pfxbuijh3eje0=;
        b=WLaWFgdQMziwdSAX/Y0ydC4aJzrBB7+GNdagwiVEZt9FdWcO+1hLm+8c9Q/829l9XD
         TsjhdclklPq/irwI2w8KFofeZX5Un5kqHtxGIbgg2x4LUUkF3723iT1VfNZ3xzqKOPy3
         V2ar3wTB5Nj9OYwjMePB7KnDNpmqnnJ5r68dqKXtdFObhwPVmbR5wEwed1X5XAxn26Aq
         VnashObp48q6kpSHu39GHsp/gfaIQfj2T5GaPJCQflRc/ngXIIlAq4Uu1XnDgg143r0y
         DH2YoiEai84+kZawhD45KZc2ewTKlMYsZTp53DkRzqaZQAEmyKvccijlmTf2Zlya/hCn
         27IA==
X-Forwarded-Encrypted: i=1; AFNElJ9gpz2x/fSSV78Lr2zZRfglGClokR++J/XsPrXc+e8trWRizxIR/j+DDZfO5pBiAo/Smt5HlzWVa4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKGkp3Z6R22HPeyU5gANpLhu1MyRQRtG70k/xmPVLhJP5FGy4
	exDcvCylBm5ozsZd+RKWe1928LbTc3us4P0UEiJtfR9akeaIDQX5+STC82HhNSKcQDYEBX3/XIM
	CPe0ENSggF7nuNOO78gPPxMAsnaJPaWaf1OUZ3viGQvsML4wLLd8m5I7pUAbn5FvmPLqvGkr2oA
	O5jye+Q11RW+mlLEtqoqmmV3i8zBA7zU80e03P1Q==
X-Gm-Gg: Acq92OFst7sT9+J/UMDdlhIdxaSwF14Blc4ksd2iYJq/q0WWbOm79WOJm1xttYzT0cn
	wPkj8DkcuKZP8tR4hAi61qLzMqP0KCNa1qIwBr0vj0siKQZICbDqJ1KVAEwAXlfuYtfj0toFo+F
	mamr3FybYE0eI2WWg57+X/THvgTQpN/j5kBvhWURFPgCn1LmKETzZ4MQ+gEij8h4/Y6/OynjG3i
	jTc3WtU6C/raWyQt38wtqbmisEnu6CpvL7upM8=
X-Received: by 2002:a05:620a:1984:b0:90f:429c:e63e with SMTP id af79cd13be357-911cdc4936emr2936953585a.12.1779194893171;
        Tue, 19 May 2026 05:48:13 -0700 (PDT)
X-Received: by 2002:a05:620a:1984:b0:90f:429c:e63e with SMTP id
 af79cd13be357-911cdc4936emr2936948585a.12.1779194892757; Tue, 19 May 2026
 05:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org> <20260515234121.1607425-4-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260515234121.1607425-4-vladimir.zapolskiy@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:48:01 +0200
X-Gm-Features: AVHnY4KevGWQPierX4-OQr-g_8yECcl0PFq6IHdvowvHo86TBnJAG3UzKxDhnvI
Message-ID: <CAFEp6-06qWkuN+dSg=27jdvH59k9BctnnRcT2LCFYmOzyxTpTA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] i2c: qcom-cci: Move cci_init() under cci_reset() function
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JKULdcKb c=1 sm=1 tr=0 ts=6a0c5c0e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=U8yPnnuYQYX5AjQiYr4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0JWgBYuLxE74C_7GEJRVjbN-YN6nw8ud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyNiBTYWx0ZWRfX4LMjPaNWQD4j
 LlIHJDbEE9Mgu07WS4MPSt6IjUiTuumFvdusUJnuEZ7wS0Je3u+EV1dJoq17U31EKmP/B9lL7fy
 Z7doMevlLl+DL7532fUDPTrdvPKOO0+YjYT8+UAxKACrECCBAuOMaAlCQO9PVlFJ42/ziJOnjpR
 t/L90583xg98VAjPXpf7b4SYrG/XDj5PUJgEEzW8Ry3ZjDtSbGnOpiXX19ho5MGYq5zHJa24hSB
 w2n9sQDpjU5HsYAdRfFEegYH9k5H5jgWGe/BNN8Rd6fQu3NmaOcxnfCYIDPyoGXMNUizM4myc2Q
 LrOwIZr3q0GdD25iOyMnYFzd0qtQm0JihBszRibXPV4pGINDO61rGTlcr6T7aC8fLEJ7L4cWNiw
 TKK2jfBu62fdzcgG2U3kBNj9UVolpIE16bvNoTvao7wQoRVjWIuoIDhECTnGb8hA+e1CSEE1NLz
 co+PqH+KMuwfyur2Z8g==
X-Proofpoint-ORIG-GUID: 0JWgBYuLxE74C_7GEJRVjbN-YN6nw8ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190126

On Sat, May 16, 2026 at 1:41=E2=80=AFAM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> On probe or runtime errors cci_reset() is called and it should be coupled
> with cci_init(), instead of doing this on caller's side, embed cci_init()
> directly into the cci_reset() function.
>
> This is a non-functional change, cci_reset() and cci_init() function
> bodies are reordered.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 41 +++++++++++++++----------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index be41a53e30c6..2d73903f14d3 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -225,24 +225,6 @@ static int cci_halt(struct cci *cci, u8 master_num)
>         return 0;
>  }
>
> -static int cci_reset(struct cci *cci)
> -{
> -       /*
> -        * we reset the whole controller, here and for implicity use
> -        * master[0].xxx for waiting on it.
> -        */
> -       reinit_completion(&cci->master[0].irq_complete);
> -       writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
> -
> -       if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
> -                                        CCI_TIMEOUT)) {
> -               dev_err(cci->dev, "CCI reset timeout\n");
> -               return -ETIMEDOUT;
> -       }
> -
> -       return 0;
> -}
> -
>  static void cci_init(struct cci *cci)
>  {
>         u32 val =3D CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
> @@ -286,6 +268,26 @@ static void cci_init(struct cci *cci)
>         }
>  }
>
> +static int cci_reset(struct cci *cci)
> +{
> +       /*
> +        * we reset the whole controller, here and for implicity use
> +        * master[0].xxx for waiting on it.
> +        */
> +       reinit_completion(&cci->master[0].irq_complete);
> +       writel(CCI_RESET_CMD_MASK, cci->base + CCI_RESET_CMD);
> +
> +       if (!wait_for_completion_timeout(&cci->master[0].irq_complete,
> +                                        CCI_TIMEOUT)) {
> +               dev_err(cci->dev, "CCI reset timeout\n");
> +               return -ETIMEDOUT;
> +       }
> +
> +       cci_init(cci);
> +
> +       return 0;
> +}
> +
>  static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
>  {
>         u32 val;
> @@ -302,7 +304,6 @@ static int cci_run_queue(struct cci *cci, u8 master, =
u8 queue)
>                 dev_err(cci->dev, "master %d queue %d timeout\n",
>                         master, queue);
>                 cci_reset(cci);
> -               cci_init(cci);
>                 return -ETIMEDOUT;
>         }
>
> @@ -609,8 +610,6 @@ static int cci_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto error;
>
> -       cci_init(cci);
> -
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
>         pm_runtime_use_autosuspend(dev);
>         pm_runtime_set_active(dev);
> --
> 2.49.0
>
