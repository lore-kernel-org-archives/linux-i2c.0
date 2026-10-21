Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568694;
	b=owWY7z7kulEPRjjJcUhxDQyVqQrTMQQAJm732HBmf4fhqxGjN0pxYQZpMx6uHxMeuuqx
	 VFqQ1R2YDEJbh+6HY0F6tfLiW6fQ0vHfh2QV+vMMs6t+vnYw0zZLC2md09ll22EIVzbxl
	 DUR65ph9rwpqtN2MDmurSr7+/DwYq4aKoAdbKOTMSKY6yqIepkyrb+gF2lNMDDI8XhTDc
	 i6P7KTM36SVlxdAvcgJUInD7vg0n3gJBZGt3tECKQzmE6E2WwmP0IFRnq8vuBZxz0wWLI
	 BPWA/GSItFgs4bSLbxiSHGbel0pTajAYDU86TBE9OkV1rpSswmTsO90dvdCOVxlCcSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rUepUBVvZqTH1fHQ+aT3wHsXwm6+pjQiNT04ccwpTr0=;
	b=jFSxaUz6vl/BVEOfEIIX0R2FLp7lVEZNTa+A3XLGqT4dtWwf0wP49tIkPKFh7nooP9Xo
	 dTXQsJUtORjYxxvUzTZ8sITnYsB1p55sSKTb2STlXUOFGapJKrhsJCDeTHyBCQ/SNPwm6
	 xPC8cJUwkY7s85epruSF0qsi7JXDMmTK4zFt8SsURGYvw4ayESpSa4q3OCCXRA7MXEMKb
	 tdSvHc9RRlW/0e2Y3z2dS6uiisF8/4fzJ7cB3oCtsUFUFDLVxiWY1ln390tepawFTcayC
	 6rH7iafHucTv4jI43dH/xGIkkBoZsnjKX6NYW0afnpwQn4e2NWdHk+JvfgZ2gvhsffQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jdxo1FD5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmwWMyb0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EA5606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96EA5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jdxo1FD5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JmwWMyb0
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5jNaO3359107
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rUepUBVvZqTH1fHQ+aT3wHsXwm6+pjQiNT04ccwpTr0=; b=jdxo1FD5E9Y1CbK8
	wJBF3T7px8WGG3gXrO963dXhMxvwAJS8yx9tXnrCwq/OaFfc+2aqeJ9re5lH8yJm
	2FAjfPD+Oc0TY8kifDBMwzPhN2/r9RrGOqTwwsdu8SLmqBtjrkqTs82W34gjXcb/
	rdEUsc6ANKPtkjcaJs6I0opoOzqyRxj7eZzlVr9skQYeQ0XTnzAJHnrVwUguJOxs
	Wb1rKqEqJSUe04ovRZfTWcfKeDBK6PIv44wnmTv6uFeaxa9PQnzFg7tduJfzp+fo
	U8i3HX93Sl6MoK/lLpZrEszvHUEaa0BMpcoZZv3IVeTXK73B3GZDQSsK3AxVnwt/
	5Z3C4Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0jm14-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:44:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so147686985a.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 00:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792568692; cv=none;
        d=google.com; s=arc-20260327;
        b=mIA5+iAsdDzMUxcGcqN67a1A386OaIWmTRVQSWEZTaAuxi4px/d0ADLb3Q1laJ+Cpw
         65MdCx8vTFpaMt58nyTWTfRF2WCH0mSz53DDiHxRwMPuAhLZ6hFagYz6fpFY4L2jI1y0
         TAsckdAt1mBFpFvPCRm8ZRT871GccsONrZtgSWJ9bNgVuwqx4giyeC/rTpEwpVCq7AmL
         hkaYQTxNoPk2Ydb2unhKt6IR/xsKZ0wwPvDVUxR2TXuXT3axQ7iB1sNnTdJNTEdbPU7+
         MSBcGO1whBaA+ObH+mt9MOeX6BupBE9WXrpP3lmAAAQ3XW9FJKzJiz2OT0GJZiteZvdH
         bcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rUepUBVvZqTH1fHQ+aT3wHsXwm6+pjQiNT04ccwpTr0=;
        fh=EAj61t2cH1yytUERIxGt5zayUwVsT+/BMu6uPRyVp9M=;
        b=b5X2WlWZ5Yx5Bsw+6VZXmOgd4adH9EwkHV2rNcukvb5gkwuj4CE30/A6vK8dkNPAT6
         5osupJdlWr9rKNy/XFU52wUxWnsg50BJO+8dAtVcrlkoMe+85R64ffArqXA7PpUX4xQG
         Wh3r0vqNUVHf38jzAA7KmR6MFQtLFkXJLB0K+Ps0fAyf4lK/LkluQ9kodUyPCtIAglmc
         u6teWVGWfQLaV0X7MJtA0UDGZekqdIo2W47wccR3B73kYFniWOebKRVsOWOlVVOOMERy
         G8IOyY1IEdzEC3C/f/V/iT38H3TtixiCQUytatQCDiThT396HR6L/cAHd5glkWRbNLDp
         oPmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792568692; x=1793173492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rUepUBVvZqTH1fHQ+aT3wHsXwm6+pjQiNT04ccwpTr0=;
        b=JmwWMyb022VDqs2dVvgQPo2irMuTnmV6fLk8pAuN/vZGs4lhWpsd3UaPdet2pXrCOI
         s1NpjLlLr5CWAczCdVhggYP2P3vVB/aJGm3h9qjQ4dkiMeC8alqwLvlWWFVO/zCuncZ8
         I/noH2qpVA8I6zYbJGykmUBtJ787jgrQgT6OQTXt6+SiJp6mn7vUYaA/4iZjAVuy0YPd
         aU0B+2cNPk7dCHc4jxT1BPVVJsaU2tqAhYeC2dc63h1lzTg1p9Usgue5YzYI46XhkfWz
         /x7LUuS8mm02/djjUANHaXBjaKZ3jG2eunC/0lfe+Vy8L7BMv1T7/kyRhJbQ9Zv5wmzd
         THGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792568692; x=1793173492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rUepUBVvZqTH1fHQ+aT3wHsXwm6+pjQiNT04ccwpTr0=;
        b=DoE1bMwCo6VDMF3VkskAfwihfC0Huy5wJwNhamkFYqr5iWYAU/cRzLJlMPs3GMBAAt
         1FcOi+GPgpn0++SHrFr/GyYypY7LXqLCzOjuNHrGYMhgjDyzxVi/ENAqcAhsZpHc4TF3
         EzTetdQWL/HLoY+YSYfPBUVjb7rSaxxgDZjc1Vb4iQkbaiylfmbOdO/JeMqg3hhmAj/5
         pIQmDgiTZfeNAiZ7ueyUTF/BtuSibLtBS0AyuzEsgKBbl/a98/q8nCCZgWuU8/nHFvnF
         8iU3R0aeNS6z4qDGtP1akhgp3u7HZC65XYBwM86OQRhiyGAuFBkNZmLY8STfeyJFXnwm
         ZHdQ==
X-Forwarded-Encrypted: i=1; AKwUvByQBL3i4lkaGRG8/JIVPyo3T4ZJOzkh0eBdANcdvz7BFTZsy++sujtALwM3g32e4iUby1ZJDisXjD8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDsdBZ2FvA3xMDGmxCAVcWIOr4PeMHSOERftSAqZDq4MWGyAgA
	qAsE6ELq4VaaxQ5GJnNBHwwFtUlbI2tgY0lUEigN55cHZFSJ8jev0cZ0hh2+Azcz+Ir6KAf33cF
	QtVzx1491Ih3zY6AtoXC6aw+ynmQMJF5h5ZxmeNMtDBodLu191znbcLXUWmhEwNWGwo5qFrjIh4
	RnFQYUBEkuZRfP05bhPPD5nwwigZevjevoP+vWFQ==
X-Gm-Gg: AYBFou339qMvvQh2y1ecGc27xuBhO9tXW7xKixMXcl0rzm299hG2kXlgiEiJhNZk0iT
	POzSGTPJjdaJ7fCeIbwH4o+6Dgml78L0JQDG0Y8Bcwljbf82SppQAf9T294RWQDlcovAhWUuCiq
	teTgGhIKv8NUBO3aFJfiP26fs2VEUmSpA1XY1xnMe1vGEg2MEvsKOUaEo+A4SB40fLMTLaxnhGX
	WPw/+IGiM/1rd1fL3dopuy0C14x0lx6pp3E+MPm00dH+uuiUnB5REzKBkfYmm1XEnJCLjPwG+w=
X-Received: by 2002:a05:620a:4452:b0:939:de48:e41f with SMTP id af79cd13be357-93f57f4a770mr277892485a.31.1792568691718;
        Wed, 21 Oct 2026 00:44:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4452:b0:939:de48:e41f with SMTP id
 af79cd13be357-93f57f4a770mr277889085a.31.1792568691247; Wed, 21 Oct 2026
 00:44:51 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020193946.51478-1-birk.skyum@pm.me> <20261020193946.51478-3-birk.skyum@pm.me>
In-Reply-To: <20261020193946.51478-3-birk.skyum@pm.me>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:44:39 +0200
X-Gm-Features: AclHuK-A2tHFi1BbsII8WbD0jiKjbsnoXE2GHZ86KIPcCe_VjivQo4KKDrbb9oI
Message-ID: <CAFEp6-0wmUYhcF+_nv8U3WovxyHVJJFs1FWfN8xb9ogMOxpBRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: qcom-cci: Suspend the controller 50 ms after the
 last transfer
To: Birk Skyum <birk.skyum@pm.me>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Saikiran <bjsaikiran@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfXzFaNzubamrMO
 5iz5pLbP2EHeaI+clj33pRAn7HH22FZcE7n96V1uDDni+g0IbG1NoMzgwE0FoN1rh9c/f6FWwGw
 A5IasmodBZSrrAVg89LcZTQq7LFZdp0zYkwd7iPoG1XZqiA7QXhnH94biytCy3hEP17RiaiTxkn
 XUhEipNIJvhCQHgGa5RyVBNvhPDZ4s0PpEhQPZUabJm8UdhtSlvXigZY1ZSo6qW60LweZL12mW8
 riKSAtLUG5Ha6iArd2u+XRFqyCnui3GnaN2udEWmGUEu25SW80I2wF8e1GZZ9srhscplUM/JV6G
 2efYt4n7Be15HXC1XJLaQw0Njhk/qoAj5fSp6eR4LrTtwFQwCI8bIFRClNzcLqXrijQVhBnjOkt
 DEqSDRi+2sb3MAbL1WI6NQFlS1f9M6hQeoam/Uc62gDPju/DYIP15IBy2cEGweOwgULbtLz8XVa
 sotrKz72fVw9l+dwKww==
X-Proofpoint-ORIG-GUID: As5Se26_7HYKH5vdcff2vDLAHhPFn9SW
X-Proofpoint-GUID: As5Se26_7HYKH5vdcff2vDLAHhPFn9SW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzMCBTYWx0ZWRfX2uBF1q8bOjtn
 Z1gGANvict3v9d7kO/LWSedRp8gLhOyWFLcwrsj++FS0l5xA1amk8javdq5C5csMyey3kGNgfWq
 ovOC1V3S/x2XLhU2lkS0aLOEq8tZY3Y=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad86d74 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=ZovgdgjKAAAA:8
 a=Bu-N7aw3tzf4DBNc8b0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=VOxKbm1zgHvARWIDjr3b:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210030

Hi Birk,

On Tue, Oct 20, 2026 at 9:40=E2=80=AFPM Birk Skyum <birk.skyum@pm.me> wrote=
:
>
> With a 1 s autosuspend delay the controller stays clocked across any
> power cycle of a target that is shorter than a second, so the reset on
> resume never runs in between and the first transfer after the target
> comes back stalls until the 100 ms timeout. Camera sensors are powered
> down when they stop streaming and up again when they start, so closing
> and reopening a camera quickly hits this.
>
> On the Lenovo Yoga Slim 7x (X1E80100), restarting the OV02C10 with
> v4l2-ctl after pauses of 0.05, 0.1, 0.2 and 0.5 s failed in 19 of 20
> cycles each, and in 16 of 20 after 1 s pauses. With this change and the
> reset on resume, all 100 cycles started, and so did 150 of 150
> libcamera starts back to back.
>
> Transfers come in bursts (a sensor mode alone is a few hundred register
> writes), so suspending 50 ms after the last one costs one reset per
> burst.

So, no, we should not rely on runtime suspend/resume timing as a
workaround for this. That approach is inherently bad and fragile.

Have you been able to probe the CCI I2C bus during resume? It would be
useful to see whether there is any activity on SCL/SDA and, in
particular, whether either line is being held low.

I wonder if enabling SCL stretching support could help here. One
possibility is that the sensor (or another I2C slave) is not yet ready
when the transfer is initiated and therefore holds SCL low. If that's
the case, have you tried the change below?
https://lore.kernel.org/all/20261007050147.274096-1-hitesh@ebytelogic.com/#=
t

Regards,
Loic

>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 51ce174..62b0fcb 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -794,7 +794,7 @@ static int cci_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto disable_clocks;
>
> -       pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +       pm_runtime_set_autosuspend_delay(dev, 50);
>         ret =3D devm_pm_runtime_set_active_enabled(dev);
>         if (ret)
>                 goto disable_clocks;
> --
> 2.53.0
>
>
