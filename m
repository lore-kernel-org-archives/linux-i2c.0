Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FD3AE1BB
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744320; cv=pass; b=cvN8pv+dgCC2GN1zwjfeHpOk4EHrXn1W1sUBEjuZKJ8gEYcY/fL+VJuZ1f8XX/mQv35LchU9ZquglbhylfSE5MzBO8IN2yK+bjZnEdCdNVyg+rJ5DtQDz2QOouoVkQ06Pnh1ssRQ4cT+c3CfXzH+RJmWYqrsruiiEF0YLS88kzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744320; c=relaxed/simple;
	bh=/NHNGEjHtmOoe9VGhQsAW5VveB82CAtyW6o5egu+LcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBuD66ZaSCfLQdyiYiA6LJUI99m5QoSGEnfF3o4uSwwHD9ecjSPV9QE9Cqeo4v1gKBo3pj+X587XwAHd8ehd1E8LbK4FG1TSpSvSvc1FGRgko1RYj1nLwVX7KNJDmBkBiprKKHjQrJsMfVylbsn87Erwic1mxtK0VcbEEbjbPLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ipFnr3SM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fzH6hT77; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ipFnr3SM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzH6hT77"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736Eti0005446
	for <linux-i2c@vger.kernel.org>; Mon, 3 Aug 2026 08:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OA5SQ0dn6UOvGx4roheMqJj+ovAwmM+gfhO0UKFk4Rw=; b=ipFnr3SM2kVKsLOD
	IVy04eTdmVC0UUwQYUB9ZgdU6t6fssbd/tac+zBoZEJFvQAcJvvI80ACwBWgFfpd
	vGTtFSQEsqP2Msyf12mFCTXst0AuMULK9pipImdEprbUOE0BPdalZhwmT07cOuQO
	uxhR2NeikM77Jv2JhhOOv2CoZ6lwSRv48dTLN+d4DwzN463JxYk+rrfmzVPKqMxS
	2xoxTWMP2n0TDWLtOpqOErJVmkpqD+MWo8PMV1Kt1RVOWI3D6eRp8+dGCuTKRJX6
	tcGNFbELs/YVYV3mgYdqxVDI8LWHcSsHNTMimtkteNERavkNWJWi8HlYfB2pVu3R
	e1y2jw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj78e28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 08:05:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91931144870so308139385a.1
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 01:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785744316; cv=none;
        d=google.com; s=arc-20260327;
        b=TnNgJPdKLZHQh6dkHaPe9Sd7ViHyENTE+x0hJ9BQGiA3/HtmLn4jXrHJiogns0PCFl
         st5lLlp7eId8SZms1EPy02KxIYwfLmovr/sXIm/4VqHnKhTYg97TX8mWMbfTmHnBc7Kx
         OKZHjawjLvOhVzHi0juoEsgPxnlMMQ/x2YS3HFkiEGVkkCIke7EnLfTseI+YxjAyCraa
         J2bYFFiUsQPgL2BwwVzqcfB4by/3P5V8oqzOzTxkK4bxblKgfTWlpjSKO1GwxQa0Vv2b
         /kGQxZhsYYbehCGBIGmvW24EqNtlXq9xwCNxe5ZF5rLYxQpCjcTKZeoWidoc1Mgo8QLR
         CkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OA5SQ0dn6UOvGx4roheMqJj+ovAwmM+gfhO0UKFk4Rw=;
        fh=MIZSSdzirsFW9UFJEXg38zb/AkqIZOaen5anSQ9FlLU=;
        b=PHG5WDuBJKIYQf2h4LwBR17EUfDP6xiplai+VBsla+stGyazCoe8BdFYlwR4s7m14n
         eZOPW/8D0UqBgcnaYf5Eo3BSyhWzI89Qe2auAqBpkAdqiDfs5ZoDpj24sm/KyJ8FJbfR
         dOL+EUazqi/EAKVjjeuTO9bqZwNZhtqmFooLaWr48J+wlh/oYLm5PqMqSQzrKzbvfLBB
         z6UEr/tKrAvsgA0Ffo2d+HreWkwaXDSPzImSNcNzekMN/nU4O/ZEHt008qoxiaH3dELL
         5ZbwlGJklPSN18oRuUaKvLCRJq7rEjQnlbFCAFnPVEPc89mBlXrd8WGoZvLiEqSfeoko
         1u3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785744316; x=1786349116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OA5SQ0dn6UOvGx4roheMqJj+ovAwmM+gfhO0UKFk4Rw=;
        b=fzH6hT77s8LNMWQZ7oU4DAuJpPzWDCs67xk0slQOwjqCKXLirCqj9cCOg8cfTEQH2C
         +AFuKTfNNi1r1v6akf11RWUMM3QjNRNNkJOtzlqDv3wmdJXXMYh8Gu7TiuhCPixBkWaA
         drrZGSMyS8X74cauPE4l+wFR41pTJyLUfOZ0UN1HyWzrj8nHub7Et2B/H491xmEI1LGa
         2zKGW/byI5dvCPFqRr3xGfZAHAAdKDAi4+x0yuYmrNenPU7p36Yt9o0+HylO0q3cVNJs
         l2XeupkH02+JTh8VBWExpSyFQuq3L63+cIov+blf7MTWyqY2aLDj+fOpLqM8wOZ3FG+F
         udtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744316; x=1786349116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OA5SQ0dn6UOvGx4roheMqJj+ovAwmM+gfhO0UKFk4Rw=;
        b=aP34QmIOSFBB8jBjkmQJqE8+fAAVJx2O9u67SjiHRZirzTKlqDZ/SNSK6rD9vJYE8R
         n3nx5e/zPMRVOAf039KQtoB0HnVu+SdwOjpPB5lIgCDStsfWnqRJlITzPTwYbUm9YdNb
         E64Ld4DXk5a0QkhSFvknqr9smHpsI7OWHtMzxW4JgZS3W6WT3BbH5EMkeze791dqwhea
         X31c1yh/sm5fZlRhh0zgPMAahVeIKTie8sseSg6+n2pvY6DkRJkr2Ih6x1yscd7UL+v9
         6RvhUvGiZfnoOIGObefFxRN48aa1bImLuG818nct3uGQV5x4n14SJAt3P4LcoxzCKUnp
         6dcw==
X-Forwarded-Encrypted: i=1; AHgh+RpkeXUPlBfRAxNTwGL/2U/OcbCuw/XLmMFGVBTvecjJDYtLhX+KBg4Rvx5XbjiCmnJ3mCKBYMIY4vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXshM+hwZ1GHejqQIyjbSNrtVFvoI1XNxxuSpu29fin1kKron
	HNnHbZhE81RPVrmjNkiX7JQi9SZpY+5mvl4HThOkLE+jyivHJmoG3g5DyjQKjUDJLJh5mpG3KmX
	qSSwf+Bpbw7Qa6wwnqLnykF0+S8atgr3uBTSuA/8CxjXlgefNFxbYcXwTf5yRKSREV1snDYKlr2
	jMO0XNKZt0RBSUTPZRUydqKGtEHGLlkIigQ5kAPA==
X-Gm-Gg: AR+sD11tt/EXNTQAgdOQ/kSlxHRChWIGC6MNFBEKbz2prCy/h4WJ8inqn0p3j33iiv+
	lAZOY2hfAFU4fvds/UUwdm7q6zqU1RAd+OnmpwNuEW9HYRpTCb0feGVhG/06VznJVeUvd7GGTcM
	uIwo9TVOgQI9uwepoBdNVkfSqC88UL1/9u83702nenhak9RZ1ZRg0PHECruoek1yptG7Np5+F+O
	kW+aSFvJD/NiQeHQZ/JB/XsQo8WxCwRRfLlU7A/KCy7stYAXkWq/vwQPmaTIRDLsvcpqIfi6Ls=
X-Received: by 2002:a05:620a:a713:b0:92e:73fc:154c with SMTP id af79cd13be357-934a0750f3bmr1467396785a.7.1785744315692;
        Mon, 03 Aug 2026 01:05:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a713:b0:92e:73fc:154c with SMTP id
 af79cd13be357-934a0750f3bmr1467389285a.7.1785744314727; Mon, 03 Aug 2026
 01:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com> <20260802-i2c-qcom-slave-v2-2-27653118fa75@oss.qualcomm.com>
In-Reply-To: <20260802-i2c-qcom-slave-v2-2-27653118fa75@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 10:05:03 +0200
X-Gm-Features: AUfX_myovM_jIXxfhl6oPBmMqcLrLkj9HfXTt-nS83z1WoFewV5YkHvrywaFJ8g
Message-ID: <CAFEp6-0GkLx3G=8DxH6Rmk_niEnPKO0D4HZxeME5O9UB3bFZcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: m7Syfl1m-F_j9VJ1Wa2OQ9zSqyV7-J_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3MCBTYWx0ZWRfXyWzmZjSggPb9
 wrcA+y7bmj0pTHOpQa/gv9BSSUG2AWZK021ZCbJNRtwYs0NxX0FYtzvNqgNnKAfj49RDkr0uoRa
 QPehQnhyCUMCiK0zpz3n/MvaTM+W+ESbHxn/fk9ik/EqyuUGiJ7fWGkrBn2DC59HkfVamKZ8Tfw
 YhBbxMHgPxsM5TwWZ7U9x6Gx/4BCvmX3zub8X0s4jkRUccJZfTiZXxzMJW0IS2vLFnCyK14ND1e
 vpy0q6U+jsn6U5Zt0covTtA29NCs4IBPvGhqnyVoIQvvQmm8ldYzjufH/BJK5dH/DeUkYKXq4R0
 C0ciHAEyGoJUIdEPPRTHpM+QkP3OjQ39MFTAxBaQsi42eGXHScZdfqnr9QsiqLfAxwSHtrR2vRG
 X8OO4cdQion4gXFFNOuA2yl+pJhdXO2VMYxN0l6UhFVqSnHdEoSz2ulluQ/UacJXp++0Tf+Nyvv
 UuCVnR+qr4A3G9msJCw==
X-Proofpoint-GUID: m7Syfl1m-F_j9VJ1Wa2OQ9zSqyV7-J_s
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a704bbd cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=t2W4Nf_wFVEeCp1OhBgA:9 a=LE4JqWSOfUlPNiRa:21 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3MCBTYWx0ZWRfX1NhGAUK6fJII
 jjgEikPiNdontkMBSgRx/FlQgDJw1PD1pLGIkb9fJcU7gRHnPv6HNvwfMc+bSaUWvuWRM/ZWogk
 koKCOUh7bED7aryzrn7xBKKbu+u5vM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030070

On Sun, Aug 2, 2026 at 3:16=E2=80=AFPM Viken Dadhaniya
<viken.dadhaniya@oss.qualcomm.com> wrote:
>
> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
> controller that operates exclusively in target mode. The existing
> Qualcomm I2C controller drivers (GENI, QUP) are master-only and cannot
> serve systems where the SoC must respond as an I2C target on the bus.
>
> Register the controller with the Linux I2C slave framework via
> i2c_algorithm.reg_target and i2c_algorithm.unreg_target so that any
> standard slave backend (e.g. slave-24c02) can be attached at runtime
> via i2c_slave_register(). Handle IRQ events for RX FIFO service, clock
> stretching during read and write phases, STOP and repeated-start
> conditions, and error recovery with SW reset. Enable the required AHB
> and XO clocks, vote for interconnect bandwidth, and restore hardware
> state across suspend and resume using the noirq PM callbacks.
>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   9 +
>  drivers/i2c/busses/Kconfig           |  15 +
>  drivers/i2c/busses/Makefile          |   1 +
>  drivers/i2c/busses/i2c-qcom-target.c | 560 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 585 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe67f7bfa44c..c3f273b0002b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22380,6 +22380,15 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>  F:     drivers/i2c/busses/i2c-qcom-geni.c
>
> +QUALCOMM I2C TARGET CONTROLLER DRIVER
> +M:     Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> +M:     Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> +L:     linux-i2c@vger.kernel.org
> +L:     linux-arm-msm@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml
> +F:     drivers/i2c/busses/i2c-qcom-target.c
> +
>  QUALCOMM I2C CCI DRIVER
>  M:     Loic Poulain <loic.poulain@oss.qualcomm.com>
>  M:     Robert Foss <rfoss@kernel.org>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d7b89508311f..2e18238e0ae6 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1070,6 +1070,21 @@ config I2C_QCOM_GENI
>           This driver can also be built as a module.  If so, the module
>           will be called i2c-qcom-geni.
>
> +config I2C_QCOM_TARGET
> +       tristate "Qualcomm I2C target controller"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       depends on COMMON_CLK
> +       depends on INTERCONNECT
> +       select I2C_SLAVE
> +       help
> +         This driver supports I2C target mode on Qualcomm Technologies
> +         SoCs. If you say yes to this option, support will be included
> +         for the built-in I2C target controller on QDU1000 and other
> +         compatible Qualcomm SoCs.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called i2c-qcom-target.
> +
>  config I2C_QUP
>         tristate "Qualcomm QUP based I2C controller"
>         depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3755c54b3d82..ab3070cdb144 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_I2C_PXA)               +=3D i2c-pxa.o
>  obj-$(CONFIG_I2C_PXA_PCI)      +=3D i2c-pxa-pci.o
>  obj-$(CONFIG_I2C_QCOM_CCI)     +=3D i2c-qcom-cci.o
>  obj-$(CONFIG_I2C_QCOM_GENI)    +=3D i2c-qcom-geni.o
> +obj-$(CONFIG_I2C_QCOM_TARGET)  +=3D i2c-qcom-target.o
>  obj-$(CONFIG_I2C_QUP)          +=3D i2c-qup.o
>  obj-$(CONFIG_I2C_RIIC)         +=3D i2c-riic.o
>  obj-$(CONFIG_I2C_RK3X)         +=3D i2c-rk3x.o
> diff --git a/drivers/i2c/busses/i2c-qcom-target.c b/drivers/i2c/busses/i2=
c-qcom-target.c
> new file mode 100644
> index 000000000000..79b0b9ff7b9b
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-qcom-target.c
> @@ -0,0 +1,560 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/i2c.h>
> +#include <linux/interconnect.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/* Register offsets */
> +#define I2C_S_DEVICE_ADDR                      0x00
> +#define I2C_S_IRQ_STATUS                       0x08
> +#define I2C_S_IRQ_CLR                          0x0C
> +#define I2C_S_IRQ_EN                           0x10
> +#define I2C_S_CONFIG                           0x18
> +#define I2C_S_CONTROL                          0x1C
> +#define I2C_S_FIFOS_STATUS                     0x20
> +#define I2C_S_TX_FIFO                          0x24
> +#define I2C_S_RX_FIFO                          0x28
> +#define I2C_S_DEBUG_REG1                       0x3C
> +#define I2C_S_DEBUG_REG2                       0x40
> +#define I2C_S_SW_RESET_REG                     0x4C
> +#define I2C_S_CLK_LOW_TIMEOUT                  0x50
> +#define I2C_S_CLK_RELEASE_DELAY_CNT_VAL        0x54
> +#define I2C_S_SDA_HOLD_CNT_VAL                 0x58
> +
> +/* I2C_S_CONFIG register fields */
> +#define I2C_S_CORE_EN                          BIT(0)
> +
> +/* I2C_S_CONTROL register fields */
> +#define CLEAR_RX_FIFO                          BIT(0)
> +#define CLEAR_TX_FIFO                          BIT(1)
> +#define NACK                                   BIT(2)
> +#define ACK_RESUME                             BIT(3)
> +
> +/* I2C_S_SW_RESET_REG register fields */
> +#define SW_RESET                               BIT(0)
> +
> +/* I2C_S_FIFOS_STATUS register fields */
> +#define RX_FIFO_COUNT_MASK                     GENMASK(31, 16)
> +
> +/* Interconnect bandwidth vote in bytes per second */
> +#define APPS_PROC_TO_I2C_TARGET_VOTE           1190000
> +
> +/**
> + * enum qcom_i2c_target_irq - IRQ bit positions in I2C_S_IRQ_STATUS
> + * @STOP_DETECTED:     I2C stop condition detected on the bus
> + * @RX_FIFO_FULL:      receive FIFO has reached capacity
> + * @TX_FIFO_EMPTY:     transmit FIFO is empty
> + * @RX_DATA_AVAIL:     receive data is available in the RX FIFO
> + * @CLOCK_LOW_TIMEOUT: SCL held low longer than the configured timeout
> + * @STRCH_WR:          clock stretching during a write (Rx) phase
> + * @STRCH_RD:          clock stretching during a read (Tx) phase
> + * @GCA_DETECTED:      general call address detected (not used)
> + * @ERR_CONDITION:     unexpected start or stop bit detected (error)
> + * @RESTART_DETECTED:  repeated start condition detected
> + */
> +enum qcom_i2c_target_irq {
> +       STOP_DETECTED,
> +       RX_FIFO_FULL,
> +       TX_FIFO_EMPTY,
> +       RX_DATA_AVAIL,
> +       CLOCK_LOW_TIMEOUT,
> +       STRCH_WR,
> +       STRCH_RD,
> +       GCA_DETECTED,
> +       ERR_CONDITION,
> +       RESTART_DETECTED,
> +};
> +
> +/*
> + * TX_FIFO_EMPTY is excluded: this driver fills the TX FIFO one byte at =
a
> + * time in response to STRCH_RD (clock-stretch during read phase), so
> + * TX_FIFO_EMPTY adds no value and would double the interrupt rate.
> + * GCA (general call address) is unsupported.
> + */
> +#define QCOM_I2C_TARGET_ALL_IRQ        (GENMASK(RESTART_DETECTED, STOP_D=
ETECTED) \
> +                                & ~(BIT(GCA_DETECTED) | BIT(TX_FIFO_EMPT=
Y)))
> +
> +/* Bit indices for the status bitmask, used with set_bit/test_bit/clear_=
bit */
> +enum qcom_i2c_target_status {
> +       READ_IN_PROGRESS,
> +       WRITE_IN_PROGRESS,
> +};
> +
> +/**
> + * struct qcom_i2c_target - Qualcomm I2C target controller private data
> + * @dev:               driver model device node
> + * @base:              base address of HW registers
> + * @adap:              I2C adapter (slave mode)
> + * @ahb_clk:           AHB bus clock
> + * @xo_clk:            XO reference clock
> + * @icc_path:          interconnect bandwidth path
> + * @slave:             currently registered slave backend client; writte=
n only
> + *                     under disable_irq() in reg_slave()/unreg_slave() =
so the
> + *                     ISR sees a stable pointer for its entire executio=
n
> + * @status:            bitmask of enum qcom_i2c_target_status flags; mus=
t be
> + *                     unsigned long for set_bit/test_bit/clear_bit; acc=
essed
> + *                     only from the ISR and from reg_slave()/unreg_slav=
e()
> + *                     under disable_irq(), so no additional lock is nee=
ded
> + * @irq:               interrupt line number
> + */
> +struct qcom_i2c_target {
> +       struct device           *dev;
> +       void __iomem            *base;
> +       struct i2c_adapter      adap;
> +       struct clk              *ahb_clk;
> +       struct clk              *xo_clk;
> +       struct icc_path         *icc_path;
> +       struct i2c_client       *slave;
> +       unsigned long           status;
> +       int                     irq;
> +};
> +
> +static void qcom_i2c_target_dump_regs(struct qcom_i2c_target *target)
> +{
> +       dev_dbg(target->dev, "I2C_S_DEVICE_ADDR:               0x%x\n",
> +               readl_relaxed(target->base + I2C_S_DEVICE_ADDR));
> +       dev_dbg(target->dev, "I2C_S_IRQ_STATUS:                0x%x\n",
> +               readl_relaxed(target->base + I2C_S_IRQ_STATUS));
> +       dev_dbg(target->dev, "I2C_S_CONFIG:                    0x%x\n",
> +               readl_relaxed(target->base + I2C_S_CONFIG));
> +       dev_dbg(target->dev, "I2C_S_IRQ_EN:                    0x%x\n",
> +               readl_relaxed(target->base + I2C_S_IRQ_EN));
> +       dev_dbg(target->dev, "I2C_S_FIFOS_STATUS:              0x%x\n",
> +               readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
> +       dev_dbg(target->dev, "I2C_S_DEBUG_REG1:                0x%x\n",
> +               readl_relaxed(target->base + I2C_S_DEBUG_REG1));
> +       dev_dbg(target->dev, "I2C_S_DEBUG_REG2:                0x%x\n",
> +               readl_relaxed(target->base + I2C_S_DEBUG_REG2));
> +       dev_dbg(target->dev, "I2C_S_CLK_LOW_TIMEOUT:           0x%x\n",
> +               readl_relaxed(target->base + I2C_S_CLK_LOW_TIMEOUT));
> +       dev_dbg(target->dev, "I2C_S_CLK_RELEASE_DELAY_CNT_VAL: 0x%x\n",
> +               readl_relaxed(target->base + I2C_S_CLK_RELEASE_DELAY_CNT_=
VAL));
> +       dev_dbg(target->dev, "I2C_S_SDA_HOLD_CNT_VAL:          0x%x\n",
> +               readl_relaxed(target->base + I2C_S_SDA_HOLD_CNT_VAL));
> +}
> +
> +
> +static void qcom_i2c_target_hw_init(struct qcom_i2c_target *target)
> +{
> +       dev_dbg(target->dev, "HW init: resetting FIFOs, enabling IRQs and=
 core\n");
> +       writel(CLEAR_TX_FIFO | CLEAR_RX_FIFO, target->base + I2C_S_CONTRO=
L);
> +       writel(QCOM_I2C_TARGET_ALL_IRQ, target->base + I2C_S_IRQ_EN);
> +       writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
> +}
> +
> +static void qcom_i2c_target_write_requested(struct qcom_i2c_target *targ=
et)
> +{
> +       u8 val =3D 0;
> +
> +       if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {

If (!test_and_set_bit(...)) ?

> +               dev_dbg(target->dev, "Write phase started\n");
> +               set_bit(WRITE_IN_PROGRESS, &target->status);
> +               i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED,=
 &val);
> +       }
> +}
> +
> +static int qcom_i2c_target_drain_rx_fifo(struct qcom_i2c_target *target)
> +{
> +       unsigned int rx_count;
> +       int i, ret =3D 0;
> +       u8 val;
> +
> +       rx_count =3D FIELD_GET(RX_FIFO_COUNT_MASK,
> +                            readl_relaxed(target->base + I2C_S_FIFOS_STA=
TUS));
> +
> +       for (i =3D 0; i < rx_count; i++) {
> +               val =3D (u8)readl_relaxed(target->base + I2C_S_RX_FIFO);
> +               dev_dbg(target->dev, "Data from RX FIFO: 0x%x\n", val);
> +               ret =3D i2c_slave_event(target->slave, I2C_SLAVE_WRITE_RE=
CEIVED, &val);
> +               if (ret)
> +                       break;
> +       }
> +
> +       return ret;
> +}
> +
> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
> +{
> +       /* Clear error bits before SW_RESET; the reset may not be instant=
aneous */
> +       writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
> +              target->base + I2C_S_IRQ_CLR);
> +       writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);

You mentioned above the reset is not instantaneous, is it safe to
configure hardware from there or should we wait for a specific delay
or bit (like RESET_DONE or READY)?

> +       qcom_i2c_target_hw_init(target);
> +       writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);

Why not configuring the address in qcom_i2c_target_hw_init.

> +}
> +
> +static irqreturn_t qcom_i2c_target_handle_error(struct qcom_i2c_target *=
target,
> +                                                 u32 irq_stat)
> +{
> +       u8 val =3D 0;
> +
> +       if (irq_stat & BIT(ERR_CONDITION))
> +               dev_err(target->dev, "Error condition: unexpected Start/S=
top bits\n");
> +       else
> +               dev_err(target->dev, "Clock low timeout\n");
> +       qcom_i2c_target_dump_regs(target);
> +       qcom_i2c_target_hw_reset(target);
> +       i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
> +       target->status =3D 0;
> +       return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t qcom_i2c_target_handle_stop(struct qcom_i2c_target *t=
arget,
> +                                                u32 irq_stat)
> +{
> +       u8 val =3D 0;
> +
> +       dev_dbg(target->dev, "Stop bit detected\n");
> +       /*
> +        * Short-write corner case: WRITE_IN_PROGRESS was never set becau=
se
> +        * no RX_DATA_AVAIL or STRCH_WR fired before STOP. Do not call
> +        * qcom_i2c_target_write_requested() here =E2=80=94 STOP ends the=
 transaction
> +        * so setting WRITE_IN_PROGRESS now would leave a stale bit after
> +        * target->status is cleared below.
> +        */
> +       if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {
> +               unsigned int rx_count;
> +
> +               rx_count =3D FIELD_GET(RX_FIFO_COUNT_MASK,
> +                                    readl_relaxed(target->base + I2C_S_F=
IFOS_STATUS));
> +               if (rx_count)
> +                       i2c_slave_event(target->slave, I2C_SLAVE_WRITE_RE=
QUESTED,
> +                                       &val);
> +       }
> +       qcom_i2c_target_drain_rx_fifo(target);
> +       i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
> +       target->status =3D 0;
> +       writel(CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
> +       /*
> +        * STOP terminates the transaction, so any other Rx or clock
> +        * stretch bits latched in this same status read have already
> +        * been serviced by the drain above or are now stale. Ack the
> +        * whole word rather than just STOP_DETECTED; clearing only STOP
> +        * would leave those bits set and immediately re-enter the
> +        * handler, which for a co-asserted STRCH_RD would push a stale
> +        * byte into the TX FIFO.
> +        */

How do you know no data arrived in the RX FIFO since the last drain?

> +       writel(irq_stat, target->base + I2C_S_IRQ_CLR);
> +       return IRQ_HANDLED;
> +}
> +
> +static void qcom_i2c_target_handle_rx_data(struct qcom_i2c_target *targe=
t,
> +                                           u32 rx_irq_bits)
> +{
> +       int ret;
> +
> +       dev_dbg(target->dev, "Rx data event (rx_irq_bits=3D0x%x)\n", rx_i=
rq_bits);
> +       qcom_i2c_target_write_requested(target);
> +       ret =3D qcom_i2c_target_drain_rx_fifo(target);
> +       if (ret)
> +               dev_dbg(target->dev, "Backend requested NACK\n");
> +       writel(ret ? NACK | CLEAR_RX_FIFO : ACK_RESUME,
> +              target->base + I2C_S_CONTROL);
> +       writel(rx_irq_bits, target->base + I2C_S_IRQ_CLR);
> +}
> +
> +static void qcom_i2c_target_handle_strch_rd(struct qcom_i2c_target *targ=
et)
> +{
> +       enum i2c_slave_event event =3D I2C_SLAVE_READ_PROCESSED;
> +       u8 val =3D 0;
> +
> +       dev_dbg(target->dev, "Clock stretching during read (Tx) phase\n")=
;
> +       if (!test_bit(READ_IN_PROGRESS, &target->status)) {

You can use test_and_set.

> +               set_bit(READ_IN_PROGRESS, &target->status);
> +               /* Repeated-start: master switched direction from write t=
o read */
> +               clear_bit(WRITE_IN_PROGRESS, &target->status);
> +               event =3D I2C_SLAVE_READ_REQUESTED;
> +       }
> +       i2c_slave_event(target->slave, event, &val);
> +       dev_dbg(target->dev, "Data to TX FIFO: 0x%x\n", val);
> +       writel(val, target->base + I2C_S_TX_FIFO);
> +       writel(ACK_RESUME, target->base + I2C_S_CONTROL);
> +       writel(BIT(STRCH_RD), target->base + I2C_S_IRQ_CLR);
> +}
> +
> +static irqreturn_t qcom_i2c_target_irq(int irq, void *dev)
> +{
> +       struct qcom_i2c_target *target =3D dev;
> +       u32 irq_stat, rx_bits;
> +
> +       /*
> +        * Dispatch priority (highest first):
> +        *   ERR_CONDITION / CLOCK_LOW_TIMEOUT  =E2=80=94 hardware error,=
 triggers SW reset
> +        *   STOP_DETECTED                      =E2=80=94 end of transact=
ion, clears all state
> +        *   STRCH_RD                           =E2=80=94 read-phase data=
 supply
> +        *   RX_FIFO_FULL / RX_DATA_AVAIL /
> +        *   STRCH_WR                           =E2=80=94 write-phase Rx,=
 coalesced into one drain
> +        *   RESTART_DETECTED                   =E2=80=94 repeated start,=
 resets state
> +        */
> +       irq_stat =3D readl_relaxed(target->base + I2C_S_IRQ_STATUS);
> +       if (!irq_stat)
> +               return IRQ_NONE;
> +
> +       dev_dbg(target->dev, "IRQ status: 0x%x\n", irq_stat);
> +
> +       /*
> +        * Load target->slave once. Both reg_slave() and unreg_slave() di=
sable
> +        * the IRQ before writing the pointer, so it cannot change while =
this
> +        * handler runs. Sub-handlers may dereference target->slave direc=
tly.
> +        */
> +       if (!READ_ONCE(target->slave)) {
> +               writel(irq_stat, target->base + I2C_S_IRQ_CLR);
> +               return IRQ_HANDLED;
> +       }
> +
> +       if (irq_stat & (BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT)))
> +               return qcom_i2c_target_handle_error(target, irq_stat);
> +
> +       if (irq_stat & BIT(STOP_DETECTED))
> +               return qcom_i2c_target_handle_stop(target, irq_stat);
> +
> +       if (irq_stat & BIT(STRCH_RD))
> +               qcom_i2c_target_handle_strch_rd(target);
> +
> +       /*
> +        * Coalesce all write-phase Rx bits into a single drain+ACK. When=
 the
> +        * RX FIFO fills at threshold, RX_FIFO_FULL, RX_DATA_AVAIL and ST=
RCH_WR
> +        * can all assert in the same irq_stat snapshot. Pass the combine=
d mask
> +        * so ACK_RESUME is written exactly once and all bits are cleared=
 together.
> +        */
> +       rx_bits =3D irq_stat & (BIT(RX_FIFO_FULL) | BIT(RX_DATA_AVAIL) |
> +                             BIT(STRCH_WR));
> +       if (rx_bits)
> +               qcom_i2c_target_handle_rx_data(target, rx_bits);
> +
> +       if (irq_stat & BIT(RESTART_DETECTED)) {
> +               dev_dbg(target->dev, "Repeated start bit detected\n");
> +               target->status =3D 0;
> +               writel(ACK_RESUME, target->base + I2C_S_CONTROL);
> +               writel(BIT(RESTART_DETECTED), target->base + I2C_S_IRQ_CL=
R);
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int qcom_i2c_target_reg_slave(struct i2c_client *slave)
> +{
> +       struct qcom_i2c_target *target =3D i2c_get_adapdata(slave->adapte=
r);
> +
> +       if (target->slave)
> +               return -EBUSY;
> +
> +       if (slave->flags & I2C_CLIENT_TEN)
> +               return -EAFNOSUPPORT;
> +
> +       disable_irq(target->irq);
> +       WRITE_ONCE(target->slave, slave);
> +       writel(slave->addr, target->base + I2C_S_DEVICE_ADDR);
> +       enable_irq(target->irq);
> +
> +       return 0;
> +}
> +
> +static int qcom_i2c_target_unreg_slave(struct i2c_client *slave)
> +{
> +       struct qcom_i2c_target *target =3D i2c_get_adapdata(slave->adapte=
r);
> +
> +       if (!target->slave)
> +               return -EINVAL;
> +       disable_irq(target->irq);

You should probably introduce proper locking...

> +       WRITE_ONCE(target->slave, NULL);
> +       target->status =3D 0;
> +       writel(0, target->base + I2C_S_DEVICE_ADDR);
> +       enable_irq(target->irq);
> +
> +       return 0;
> +}
> +
> +static int qcom_i2c_target_icc_init(struct qcom_i2c_target *target)
> +{
> +       int ret;
> +
> +       target->icc_path =3D devm_of_icc_get(target->dev, "i2c");
> +       if (IS_ERR(target->icc_path))
> +               return dev_err_probe(target->dev, PTR_ERR(target->icc_pat=
h),
> +                                    "failed to get ICC path\n");
> +
> +       /*
> +        * The controller only needs interconnect bandwidth while it is
> +        * powered. The vote is placed here and across resume with
> +        * icc_set_bw(), and dropped with icc_set_bw(path, 0, 0) on suspe=
nd
> +        * and remove, so the vote and unvote are always symmetric.
> +        */
> +       ret =3D icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE=
,
> +                        APPS_PROC_TO_I2C_TARGET_VOTE);
> +       if (ret)
> +               return dev_err_probe(target->dev, ret, "icc_set_bw failed=
\n");
> +
> +       return 0;
> +}
> +
> +static u32 qcom_i2c_target_func(struct i2c_adapter *adap)
> +{
> +       return I2C_FUNC_SLAVE;
> +}
> +
> +static const struct i2c_algorithm qcom_i2c_target_algo =3D {
> +       .reg_target     =3D qcom_i2c_target_reg_slave,
> +       .unreg_target   =3D qcom_i2c_target_unreg_slave,
> +       .functionality  =3D qcom_i2c_target_func,
> +};
> +
> +static int qcom_i2c_target_adap_init(struct qcom_i2c_target *target)
> +{
> +       target->adap.algo =3D &qcom_i2c_target_algo;
> +       target->adap.dev.parent =3D target->dev;
> +       target->adap.dev.of_node =3D target->dev->of_node;
> +       strscpy(target->adap.name, "qcom-i2c-target",
> +               sizeof(target->adap.name));
> +       i2c_set_adapdata(&target->adap, target);
> +
> +       return i2c_add_adapter(&target->adap);
> +}
> +
> +static int qcom_i2c_target_probe(struct platform_device *pdev)
> +{
> +       struct qcom_i2c_target *target;
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +
> +       target =3D devm_kzalloc(dev, sizeof(*target), GFP_KERNEL);
> +       if (!target)
> +               return -ENOMEM;
> +
> +       target->dev =3D dev;
> +
> +       target->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(target->base))
> +               return dev_err_probe(dev, PTR_ERR(target->base),
> +                                    "failed to map registers\n");
> +
> +       target->xo_clk =3D devm_clk_get_enabled(dev, "xo");
> +       if (IS_ERR(target->xo_clk))
> +               return dev_err_probe(dev, PTR_ERR(target->xo_clk),
> +                                    "failed to get and enable XO clock\n=
");
> +
> +       target->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
> +       if (IS_ERR(target->ahb_clk))
> +               return dev_err_probe(dev, PTR_ERR(target->ahb_clk),
> +                                    "failed to get and enable AHB clock\=
n");
> +
> +       target->irq =3D platform_get_irq(pdev, 0);
> +       if (target->irq < 0)
> +               return target->irq;
> +
> +       ret =3D qcom_i2c_target_icc_init(target);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0=
,
> +                              dev_name(dev), target);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "request_irq failed for IR=
Q %d\n",
> +                                    target->irq);
> +
> +       qcom_i2c_target_hw_init(target);
> +
> +       platform_set_drvdata(pdev, target);
> +
> +       ret =3D qcom_i2c_target_adap_init(target);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "i2c_add_adapter failed\n"=
);
> +
> +       return 0;
> +}
> +
> +static void qcom_i2c_target_remove(struct platform_device *pdev)
> +{
> +       struct qcom_i2c_target *target =3D platform_get_drvdata(pdev);
> +
> +       disable_irq(target->irq);
> +       i2c_del_adapter(&target->adap);
> +       writel(0, target->base + I2C_S_CONFIG);
> +       icc_set_bw(target->icc_path, 0, 0);
> +}
> +
> +static int qcom_i2c_target_suspend(struct device *dev)
> +{
> +       struct qcom_i2c_target *target =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D icc_set_bw(target->icc_path, 0, 0);
> +       if (ret)
> +               dev_err(dev, "icc_set_bw failed on suspend: %d\n", ret);
> +
> +       clk_disable_unprepare(target->xo_clk);
> +       clk_disable_unprepare(target->ahb_clk);
> +
> +       return 0;
> +}
> +
> +static int qcom_i2c_target_resume(struct device *dev)
> +{
> +       struct qcom_i2c_target *target =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D clk_prepare_enable(target->ahb_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable AHB clock\n");
> +               return ret;
> +       }
> +
> +       ret =3D clk_prepare_enable(target->xo_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable XO clock\n");
> +               goto err_disable_ahb;
> +       }
> +
> +       ret =3D icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE=
,
> +                        APPS_PROC_TO_I2C_TARGET_VOTE);
> +       if (ret) {
> +               dev_err(dev, "icc_set_bw failed\n");
> +               goto err_disable_xo;
> +       }
> +
> +       qcom_i2c_target_hw_init(target);
> +       if (target->slave)
> +               writel(target->slave->addr, target->base + I2C_S_DEVICE_A=
DDR);
> +
> +       return 0;
> +
> +err_disable_xo:
> +       clk_disable_unprepare(target->xo_clk);
> +err_disable_ahb:
> +       clk_disable_unprepare(target->ahb_clk);
> +       return ret;
> +}
> +
> +static const struct dev_pm_ops qcom_i2c_target_pm_ops =3D {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_i2c_target_suspend,
> +                                     qcom_i2c_target_resume)
> +};
> +
> +static const struct of_device_id qcom_i2c_target_dt_match[] =3D {
> +       { .compatible =3D "qcom,qdu1000-i2c-target" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_i2c_target_dt_match);
> +
> +static struct platform_driver qcom_i2c_target_driver =3D {
> +       .driver =3D {
> +               .name           =3D "qcom-i2c-target",
> +               .pm             =3D &qcom_i2c_target_pm_ops,
> +               .of_match_table =3D qcom_i2c_target_dt_match,
> +       },
> +       .probe  =3D qcom_i2c_target_probe,
> +       .remove =3D qcom_i2c_target_remove,
> +};
> +module_platform_driver(qcom_i2c_target_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm I2C target controller driver");
> +MODULE_AUTHOR("Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>
>
