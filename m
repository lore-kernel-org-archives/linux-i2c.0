Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB14DD6EE
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194815; cv=pass; b=PhwDiusWbB2f5Ud4fV+xZKkHQjrK24aw5WoUXXr/aT+h1pByop8fnE2xGF75SPhtIWM6scwpywnVWfloMpyUs0rl1tkxnCu+Re7kpPD4xI8J8R33H4G4uQsggISgsMRzoHCtiK10AaaKGzNVY8zhO5Q4kEAAdO8tDYGXluXt8+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194815; c=relaxed/simple;
	bh=JSREQUsahyPYMllTrvhG5r6EDbyyMPW6V7ai0thfVvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTuYvFCF4P2Bod1HtCnxsW6YyUJBlZ9gWjIdKKRJc4/Pea/OJT61OMGOUvxLQXJkj2WJoN2lr3UP7xvfizWg0TQjn50U+zytdRudTX2qjDbVXjPdkoaA7QrnGgTR52TM7gAsBpAj7EEDGWZPDRnLYjAP42Sr75vWjdTJ0OVxqA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaWcXxlw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqP4v06w; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaWcXxlw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqP4v06w"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9kuxs1257026
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2SnX1+k0dWpdDwjifpKgD22GoiWb6N1UdGpYIICyh80=; b=PaWcXxlwopLvKhSR
	jQYczDrm4ICaIpCzS6MWpUTYK0k5+43s3znzCWptl9t221LaEDu8QybTUE12xYv8
	hps9HyUDkaDhd6LKeGSPURanbafrtZLJ8l/WMHJD06PkMtmaTpPiuar4r00I8FIs
	YHohdXYy60O6bvL6degAwNTpShBXyVZ6Jy1rQ7K8IsBSBweSBvD/4vXejRlMTR2r
	4ptO3b664hsOn7PH7SV57a/5UFA73ktmg5MvRAfAvtL0MLIY4MUvD5V5hXLlHnpL
	WpAJ036Ew/9dmFgbyQThGO6w0KLkh1YTHNuwmsJgjkNKWLtw+SuungJEcEyvgzDt
	XzFwig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8nhj8n99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 12:46:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d5d1c2289so108882411cf.2
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 05:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194812; cv=none;
        d=google.com; s=arc-20240605;
        b=crvpFoM9+NygPr373mqnNiK9NjePYguineMz31T7mIFGM1QeOhooSnxs5WwytgIKZc
         05TmAMR684SVCe9Co0AP8Ds6fUNiawTPPdKdUyzSINR47oKo/m7CkL7cFCDWZJ/kGjLz
         cXC3xqQh8CnfhC4jXwELUYrwE+Bj8H2gqKWexGlNsARWkjNnCmLpbmMnx3hSIsr12dZL
         ys46jVDB8K28rkHfirR4LqL8EkgDSkXg2EdqUy16dfAy76RcMkbSe3WfXhdHctuJxUt2
         +BiTly/y2I1HxT8xbtoj3nl4mTwH+Ggehi4nQ61YMJ0rSYDQAcxl9Zwjk5xW8ojvyEq0
         KNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2SnX1+k0dWpdDwjifpKgD22GoiWb6N1UdGpYIICyh80=;
        fh=3aeNIAN2W9FO0wxk5AR8mRqyLWaYczaOJ5VBwP3jRy0=;
        b=Zby7EMhFl1ZhztvmlF0nbit0MZhacfQulyAzlY/Ou7yV8/sbMO0tejaKTuXuGxVNaZ
         nokf0ncdEx67I3r/IWjRVmDsfCxcIzhSYU7ocHsCeewb8xZ01oxK1zJQH1hW4FH8q3Js
         jMiCwXB2kfakt5EUfr3BW8g3ySTbYEeW8FyCipvHGX9DjpFvw01uHHmQTgn4y46h2cjO
         e0mIFkJ/3obYucyst/NB3+K/7VanOtXn9+zPNDw0CykTxPCQQ6EyvlvQCIcTGANAcPXx
         /g6FU0K7HzQbc7j0RJK/nF+GQstHirbtlFKHjYKBtk2/5MYT7tTmhL9aS6VgACAjHSRK
         R2xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779194812; x=1779799612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SnX1+k0dWpdDwjifpKgD22GoiWb6N1UdGpYIICyh80=;
        b=cqP4v06wVMuNVb4fnfzWcVvmYcravwI0fa+wAluj/iJM0iSd/cZOGYzf4skF95gWPb
         GGnNWMWzk/qVTsQ0XHDFcRY1GkizRzVkOfP/wJ+J646vKOaQmKCv9BikSl1io8BjSabj
         GPdknJ7mEnIxtZpz7JuMqh9VmKIIB7YZiXK1AbYqHb5Ek1+WGDidBORBdGgc2NXl6QKw
         TvD+6xW+tqWMOlNrCuowkvoP4sq0WRTAptxvEkAQgKi4RtsTs7RLsAXCRzez/v/kg5G7
         6jT1J7IpsytysIuBqPBJcApo4PEbWd2BizQ40NYC8P9XXTHNabICbrRcF8POmfWQenm9
         cnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194812; x=1779799612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2SnX1+k0dWpdDwjifpKgD22GoiWb6N1UdGpYIICyh80=;
        b=M45G1VyXXF5tIHqE0f9tVQljdqx/yVbgaGpso2mN1V9jcnEL9a5vlctXU8KfGxmFck
         NjZEhJTsnlpTcLUBQuccfqgoCkbTYmqthaYcBvuQrNrTHbT8s1ojoRS7iqAyS1zhklnt
         UZvvlPc++qEQbijWlT4gBU7nO9M+JtgNKP/BY1NcrrMmi3QpfsSt8F5F8wmLz9yxwtyk
         RkTt8sWq5KOuKyhf7vFRrjoPZCWNi3QsLASQGV22/71+lAiTFMFyFJdVFb+n2MJi0lsC
         gXCjT4OmqmA8B+SsUT5y4/8fQFQJsVyH+pROQ7jH2pN8i7vxLizyWxlZrwYTtHxkvtzm
         XD3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8hM9Omlmpwxz3fRoO1ZWl8yvJ20CGihfEfSz0s9uK00bPdxkxJQbH5Q96z8rYZmj08NobIa6lJ75c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrXtagJAkGM7kydCEWC329OJa9KXD4u0IhFP12cxY5f0XJ3v4
	eMNxbRgwocMt1e/rAR9C64lCZVrq2Ax1od24HCRsKYgvvjel5pIQsJpeVmdxPq2aWPZ+7W9w49p
	YQbDlxSrDj4OyvZfE1vBCT8mS2tdKFnG95SrS+K3FlONT37/qahE8qNlhth71uUoIuelq24Enqz
	S/mz5XhtXZaobYHeBWEkZD3SjLJl4M2KX7rDsF0A==
X-Gm-Gg: Acq92OHdwJnsnEIZ5rVwc/+YUG+TgiKL+WYyy94h6eYwM5t5rc6r81192+tn9zXnpoN
	vtsgHnv5e0NRHgO2410ftVhQO+e9nBplSVMAII4HUxfegxjxEwm6tOZVJGuiCE7975YYgq7HNEQ
	MNvpupvbATt6QrFjIYYTDcvGcG+KHuYuYMrs1qKfya4UQFW4mA8nNdpJPHbGwZoBannwX23r+Zz
	5vquuqW1aXcUiBzilIbCSJk7t+ueWdbTvZo1f0=
X-Received: by 2002:a05:622a:250e:b0:50d:b0f9:1a66 with SMTP id d75a77b69052e-5165a20c07emr253806171cf.42.1779194812260;
        Tue, 19 May 2026 05:46:52 -0700 (PDT)
X-Received: by 2002:a05:622a:250e:b0:50d:b0f9:1a66 with SMTP id
 d75a77b69052e-5165a20c07emr253805731cf.42.1779194811677; Tue, 19 May 2026
 05:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515234121.1607425-1-vladimir.zapolskiy@linaro.org> <20260515234121.1607425-3-vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260515234121.1607425-3-vladimir.zapolskiy@linaro.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:46:39 +0200
X-Gm-Features: AVHnY4IAFUXjXBxumMI80HUL62s38SMtNjuD9sgUlih-awOYvkH1ZnsJAOq5Fdc
Message-ID: <CAFEp6-06muw35D_oJ7SOrKdYjeB2KcCL-7YQHzwdOyNTsuzv2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] i2c: qcom-cci: Do not check return value of cci_init()
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: W1O06yg61BLAJAjb8oaKkn9qwHB1HYBa
X-Proofpoint-ORIG-GUID: W1O06yg61BLAJAjb8oaKkn9qwHB1HYBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyNiBTYWx0ZWRfXyPuf2xQRQFkd
 pRQbLnhwEcRwelT5swiTEEGN+4zVIQkeZs89aJDa8dTqQ4RurKfYaG5+XPQ7PiRJQk7Hoz0WI/u
 qX3C31omkCLYfh0EWqWjHJhc3ocQQrK8pJ/D3FDn/Pc93nsC7+XnkNvRkX82Sg3O4iQ3lqt4ESG
 gloNJIq0Zx+uHFo88M7QLu/7nsZGBCezUkeaAcdf9bx3OfB/ED60ewCYxRnIOOpBTOGW9m2ejf+
 JxH6RzA0WhvszLBUl143GRZKvCIK3HQYjrXyETgYBZzo4lMOhHE5sbBb0720Uwmy2SdJg2MfDgl
 tIKS01PPt89z8muk7nPWNwwRQNyeV487ogSn2/PT3IjeyjLwGXYqixhoZHLu0vsofpvOPe+Scq2
 +lKLeVEdY5pnvt/zkC5JpavaVS2cJiYdRbzx+JfpVDiH8qFEtLOX1jf7uX9RjcHyWTtW0lUnxr7
 /yNW+6qE8cYVdl80kpQ==
X-Authority-Analysis: v=2.4 cv=ToTWQjXh c=1 sm=1 tr=0 ts=6a0c5bbc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Nkl_wrZ5PYaF25YkcdkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190126

On Sat, May 16, 2026 at 1:41=E2=80=AFAM Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> The cci_init() function is not supposed to fail, and it never returns
> a non-zero, so it'd make sense to convert its signature to void.
>
> Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 01e440b6585d..be41a53e30c6 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -243,7 +243,7 @@ static int cci_reset(struct cci *cci)
>         return 0;
>  }
>
> -static int cci_init(struct cci *cci)
> +static void cci_init(struct cci *cci)
>  {
>         u32 val =3D CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
>                         CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
> @@ -284,8 +284,6 @@ static int cci_init(struct cci *cci)
>                 val =3D hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->t=
sp;
>                 writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
>         }
> -
> -       return 0;
>  }
>
>  static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
> @@ -611,9 +609,7 @@ static int cci_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto error;
>
> -       ret =3D cci_init(cci);
> -       if (ret < 0)
> -               goto error;
> +       cci_init(cci);
>
>         pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
>         pm_runtime_use_autosuspend(dev);
> --
> 2.49.0
>
