Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567223;
	b=tJOdt84nCqcvbSMB2ncJA+H51y7tGnt7GZz8EXp4CgfIGxaN9v4OfrzmU4TE9O8rMRhF
	 adloGbZGSWc4y6pIyF6WVZjK8WvGTnmlRLqfvBsyJEQNhr/yB19TFACA22Nv7tUDV/+ZH
	 vOYADaj2jezUoVqvbtPMwbGeKqTuj+F/VWitnDhdIsK9RfTandmsYaDREo25+nfEpgO6z
	 wQA130bvgV3/JXSRtY0NilZjEmBjNd64IBavQj5KBpJrXi8MtKmDyeO0nWy8ih20U7S2C
	 8BV1G9WwANi4BBJqHCj80lL7enQ+1p9xaZEsnIzgbeab5k3npF6uZCNH0hMx/66zB/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567223;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Vyw8xlAE2+V3gWsuPQfIkm8MHQNj4BK+dYXwJch3hNE=;
	b=oIoFBPmKNLBFkdxlAM2V1Cssi5yW8mjByyBGN+tpS3m70h59Z4XxiVhuo5ikY/C0xVH7
	 YU2Fu6FZ/e4vYIbngZtQ4U3q5Svv9fS41Me12Typ46CWgWehmg4LC2eJWB7QpKfl3RIBW
	 MlQa1HbtFm3lGKW/p6vSyMjlYB3WwAWtxiWsWqRYsceWq/QG++rmwWvDOR7cPcouM29QN
	 ThKB5n5Gjq7PKJ14ZHooRGCr4QkpXwq/zuR61vDR+qCE1Ix5BKX3ColnPzbx/gRtxmLEj
	 2Ji8U6iOxzW43S4C+XuaUfEflm2DKjNjHxPtp8xRCOJ/FMnMs7JNsAwN7gFrsZ7Df/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hGTqGpQT;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eI6HWg1A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE2606A31D
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFE2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hGTqGpQT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eI6HWg1A
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j1bG3355622
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vyw8xlAE2+V3gWsuPQfIkm8MHQNj4BK+dYXwJch3hNE=; b=hGTqGpQTnyw3Y/zm
	HjoYc5lye/Mu900AVh1RHHDLmp1qkre8mvTF4kXSMbvJRu3/K+FO3PwEeamjsCqL
	hcHK9qyyCJPtnQo1ZHphKccJW+rpkYRztarOXRmsE1NH7v6wJszC+1WzC8QKmrkx
	0KUTGEMiYAWUFDk1QxYmNf8supa3K39VcUZAplUI0IGRgQcyW63/h2sjsjt5Q9ot
	zOZ+DeCrpqbpmnph33ykoRUC0TEKFgOw+CEx6JTpw9zWOwEO7Y2IWHu+K0mwZLWV
	+XtuY9LFnOM8A3qKEumUO76tSg0mPIH9DtSAVGXecsLznVLygzUJjYGRDfnvgIig
	PT9SQw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0jgy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 07:20:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f2373e9b4so48973885a.1
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 00:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792567221; cv=none;
        d=google.com; s=arc-20260327;
        b=JpnnQfSJl5SfdiWXJWgyBjZhG5jC4oaW48AZ4EbKUBm1Vo/4n9YTfp5/ksloivuZNO
         kc3h0V6l06VjaibacoeRDpXa6v7GC2wAI0/JfWNVnJvso0uFVI55O9z8m1Y8rB4zFeTU
         nmWcWK6Aw50bLB8IDDQC2dOHyElGe2YUK0vLZRPTpEjwHRKU9U0yoXc9JHLP0gd/s6a6
         R7bTUS6TEfndLoqzUw43BjXmImDDQTcxbz4WsM+gP5YiNBv/YKntcuIWWz2oKyvgPLDH
         Wsbdt0Wdj0MIM+wilyGZzmQtj4CePip527KzJRPHrBYaBLlHEFO97cZeQ/cfGU6Gv59W
         3B5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vyw8xlAE2+V3gWsuPQfIkm8MHQNj4BK+dYXwJch3hNE=;
        fh=TIplUADUpzl1NXZkJzR1pf1zJZ33RbUh+PKzU8ZB4wg=;
        b=pz9ZKKzUkIVsHDmNsJjGj6/W2cDcLmf/x+WsvHvRyj2Td/A9ACviwNOATyvMps02+3
         qkyCQkX4U1pCTaiz6kav84HDd15t/ph1FX/tVfYVd6TuwFWO4SYzuMT0xAztM6vQ316x
         08LVSQ4pvckRoY3+TypqTgXFHqIMgYpxQIVWaTSZa6cSkD5BWrwdgj+809/OtrmjMU5w
         Qb/0QpkAO32Q6VnsqJVKmVSYH/4qGmcCG5/9BrWQ5sRsHz7Ft0XFgYT1thXFjB1z/3wz
         kJGv50IZdnZ0ZddB28s4k95ZdC50kgXigvh6JuhmLa1gEdhafgSu8D1m3Z0+YpWYfEDR
         Ek3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792567221; x=1793172021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vyw8xlAE2+V3gWsuPQfIkm8MHQNj4BK+dYXwJch3hNE=;
        b=eI6HWg1AmnRQa9/t7EIYa9FGcaUYXuj2QoMymB4mB0PpTRjbOo/PeY1viyijmkcGMQ
         BtADHNWFC8OZyHpubyUlRs0wg0hKv1y8XyDPfMhZ+p8KYg2bS/L5iciYST417kP7xX5f
         rGYcp2ZaVnXnBY0lcjqWEY04e8IVTcTVt/MllZ1LxkiLHwRsX2xuWnsXlMYIjcluJvF9
         LzYElWzOQWEPWB+Ry8CrY5wTMZtuHlUO7IBUcJbJLf2pFqGhUn0aQsV53VLIKQ6LoHnO
         Oqmfjz/i8NsWlUFVPDPpZlrzRvmwVc+s33lEl3V0mi5W2+JAQqz6oB/JLKQL1I0OXvEd
         FYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567221; x=1793172021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vyw8xlAE2+V3gWsuPQfIkm8MHQNj4BK+dYXwJch3hNE=;
        b=RCzNVx0zjpzAJj8AxtI31/QxNXli84aY4gaYoEvcP85LG8yQDsB7KmW4E1RTVdJk/+
         0BZs9upXNjI6n/nmMwMxPHOWNQt9k9gRJ49xP4NHOWC33SuO5HDkLa1HsIKY3zk4xQFh
         k7j4ysOd68NhjM/tjG6MwBNt3pFRVBYoLHwEzapvEOpgTQm31aVArBQnzQxw7S9QOYBH
         Q3eoaHIRP9wbsPbr3zgkpcftw1t7dJ1yhHnyQ7/bzZ+2aqpG7/SW897VGaGJhiCya8EE
         LiN2ahilgIL6LMSdHIzCI1qqtIR9oEyj39Wx4IUUvaNv2X9oTVSBKvDBde/BsQdop5MC
         qD3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy4ZeQ065UzM8rI7rdYhA23zhgMfNQ/hYgbmQSArtCwblkS2DmTng01b/UjeX9g1zzAzimwe3LNVSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFsMJ35oCJy+700vNtR96Vw6PsUsIwwN1GwIKx7bFDbGwIjoN1
	TGFa0qbKm3UxjSfxJ8fcfhGGmAqFDjSLvWjmhP7tSZeMX4h6GsKnYdBVJd2JuBHM0JC3BxLd5xl
	FxDwnvH2njcZnGKRRzx8gN9c091USr73acEsBdXkQs3XvbnOJjxHmagmWdDP1cvN+jnetMbv9IF
	CKV1xHxIxtbidJsre+chf8fxL4V+BO1zvcogmW/w==
X-Gm-Gg: AYBFou17H+yd0ZpDycXoZbS8YaAyRD4V3A0c0p2bZqbNoZ+p19uBf9Rk2CYN1IO1uEo
	9ijhu9pgm2sGTAsqvxD6gQCR3nnqr5l0+iWMKHcbfgLRCCPt66ORiBnRTOTJiCi5M6l2bhMA7kS
	BAuk4rEk8VnRhht5GoKDrC/VlPULRvEiWWAh6RpGsduYz/N1SHm7q0Z2lPPzJhCOEruwAkW7+mU
	g1ml5qK2tgDuQbfptzE+Fy6koffCMKgYtqQm5037C18kVYURMr6kJ2GWK81p/WQaFruspez3Vo=
X-Received: by 2002:a05:620a:4010:b0:93f:3576:d428 with SMTP id af79cd13be357-93f57f65fedmr280276785a.22.1792567221476;
        Wed, 21 Oct 2026 00:20:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4010:b0:93f:3576:d428 with SMTP id
 af79cd13be357-93f57f65fedmr280271585a.22.1792567220118; Wed, 21 Oct 2026
 00:20:20 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020193946.51478-1-birk.skyum@pm.me> <20261020193946.51478-2-birk.skyum@pm.me>
In-Reply-To: <20261020193946.51478-2-birk.skyum@pm.me>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:20:08 +0200
X-Gm-Features: AclHuK9V7aVQiTOHc0vqWeOOfVJ0Ma-H2IE8l1YY-5LJtcIK6v0ZsdlpKcyDMMM
Message-ID: <CAFEp6-3s9ER_V_B89W5f5PVkRnLrgSwnUwE+tmftbUGB-1_BdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] i2c: qcom-cci: Reset the controller when it resumes
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfX6YaLkJhJn7R/
 0u2rLO/24PgMiMFl47ynI2KgI0maJoJk+aKVe87KXOmY/VI1wiegnzy7spBfv01s2iT/nxSmxOh
 rANBJRGVV3wmyCf5ToN33Sp4wy+1SPc0IHw7SzW4dzsa8zhjyKYmQgeEapPUrvXajD9g1h+bVqJ
 J/eYNMpRqkn1PCaDQtzLoKJ08syQNf5INCFymw5T1jJojjL99uBlsWdyQMlS8LzT+HTwYoM7nPM
 0Y79jnO3dXJvUDKXImuYOqS/YK7+OdrYB2mwZ2DCRyecwKqr4WxI8j4ReABAVQTloLmwt9IGf3g
 RoDZzWBLqGTlEBk6QzhpM8DV3L4lBzuCDfZaJIwkvIirsuPHhQBFy2SviweMeFwNjXbRsaFXjFP
 kDUplrR9kFGtKcyldaUyMyMULeFC4AbEkcDwxmQaMwJdWa2jb+Xop+fliWr/YiT0/0awM5GdYua
 mdoVkGg3rkNBgSfUIcQ==
X-Proofpoint-ORIG-GUID: mFXQRnVNncK-CCLO_bUZ8GCYWFw28DgW
X-Proofpoint-GUID: mFXQRnVNncK-CCLO_bUZ8GCYWFw28DgW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfX3cd/CHVHnEt6
 jo6KZwJOdfjG74f+zYJ5IpcSLMphknVGDWBFXUpa8rX42gxYN/xBrCW257WFdIjQo8w1GqHl0iU
 YW3ANUhXUxTMpXI8OLLEyT/PSKPWVz8=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad867b6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=o4kKvnnIlv_pODaOlxoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210029

On Tue, Oct 20, 2026 at 9:40=E2=80=AFPM Birk Skyum <birk.skyum@pm.me> wrote=
:
>
> A CCI master can stop starting transfers after a target on its bus was
> powered down and up again while the controller kept its clocks running.
> The next transfer's queue then stays on its first command, neither
> CCI_IRQ_STATUS_0 nor the queue's report status changes, and
> cci_run_queue() times out after 100 ms ("master 1 queue 0 timeout").
> Only the controller reset in that error path, or the controller's power
> domain collapsing while it is runtime suspended, brings it back.
>
> On the Lenovo Yoga Slim 7x (X1E80100) the OV02C10 front camera is
> powered down whenever it stops streaming, and the unpowered sensor
> holds SCL and SDA low: both read low at the TLMM pins with the internal
> pull-ups enabled. The queue registers at the timeout show the stuck
> first command (CUR_CMD 0x08010339, a write of 03 01 08) with the bus
> timing registers intact and no error or halt interrupt before it.
>
> cci_resume_runtime() only programs the interrupt mask and the bus timing
> again, so a controller that was runtime suspended without its power
> domain collapsing keeps the stuck state. With the camera's TITAN_TOP
> GDSC held on and the controller suspended between camera starts, 3 of
> 40 starts failed this way; with a reset on resume, 0 of 40.
>
> Reset the controller on every runtime resume, as the timeout path does.
>
> Signed-off-by: Birk Skyum <birk.skyum@pm.me>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index 76a5ded..51ce174 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -651,7 +651,20 @@ static int __maybe_unused cci_resume_runtime(struct =
device *dev)
>         if (ret)
>                 return ret;
>
> -       return cci_init(cci);
> +       /*
> +        * A master can stop starting transfers after a target was powere=
d
> +        * down and up again while the controller ran, and keeps that sta=
te
> +        * over a runtime suspend unless the power domain collapsed. Rese=
t
> +        * the controller, with the interrupt mask set first so that the
> +        * reset-done interrupt also arrives after a power collapse.
> +        */
> +       ret =3D cci_init(cci);
> +       if (!ret)
> +               ret =3D cci_reset(cci);

If we don't know the state, it's probably better to just
unconditionally cci_reset().

> +       if (ret)
> +               cci_disable_clocks(cci);
> +
> +       return ret;
>  }
>
>  static const struct dev_pm_ops qcom_cci_pm =3D {
> --
> 2.53.0
>
>
