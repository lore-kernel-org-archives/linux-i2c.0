Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44849439F8A
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789906063; cv=none; b=KxNaVbr1muBJd0v6BeUpkEcaYl9w+iLyl7gGoOv8sZ94TgUzj6pB8RA2u+BJjeXHgF2nAQnKEfNtSX+Mdksxwk7LRNcQuwM26DNu8HC7I/lGNeEI4hAo5aIAbDSkbUg19Noy4tRWHjYi+ARSTOzwoTRGOPisl5V1e3YLirC9hHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789906063; c=relaxed/simple;
	bh=wMIMqVYVcUuk3I2WR9qBH0mF9g0ILjNSose0cq0pFGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUIKC4a3tUuquhXF+VnIxGVPB44DTbx1EAC7NUrYjOhazoL/Bc+3eYpQBhOaK7BRKUVbNCXVvrcRnwygIrGs09QBwzCI3mOsxgi0aWhrnDdrqaaeNyl6I9ImuQD/wJStlL8a3abwpsO8hMqpnB8Jjv7/v/tFcfi8SeM/SoicTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJOJIipM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sc/LK5B5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJOJIipM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sc/LK5B5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBo1pQ1761486
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q44BARlj5l9YGAlj+x+tZB6yMYyY94DbD3TNED9Jnj0=; b=gJOJIipMcz7C0QCO
	NB1NYlhvVY81vNoyHR0OYrBKxk7L/0oPRb/KEKlhkbWzHNJUVbOq8AqoY7qLcTHG
	b64OwIq29ufVV5PEVD0P9fRV4waR9qLZLZYJhYNL4de2V9R2BRLQvdprsLHbaoqs
	bFiaSAKR49rmZpG5xcaDz1Ytte7SWx9lQwSMYnBPM80C9lJ2by88LWf4TFZZO3EI
	JOihPNc6odiqva5z3kiNRxByF5kJh72rPT5MpojuiJ+UEqUAGHgEuNuZQlReYE39
	C+IiNSPtORvISqYaypQCQuEGfTZdVy829BJp4bey+Jz1ChnvvDCV3JMq4Ap9y8c5
	k6RhZA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsk5eju9a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:07:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so3451168a91.3
        for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789906053; x=1790510853; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q44BARlj5l9YGAlj+x+tZB6yMYyY94DbD3TNED9Jnj0=;
        b=Sc/LK5B5FCfD/z0GqyiGIuk2YF+Uz8HY9fha4OBvZavREUxlL3X374DsXUKlaEzYzW
         hYM70nC4GZTL5e0KJrArqT29XeyUXiGAGgW+RTwAMSOOVbNQdV+eVasAOe53COK+IRp9
         nwNSpqRZtjwwpmzeOoDUcwcYlmvwLNLeOapQRZRotGlJEzUeJahhd3lsXIaou4/F1Dr4
         pFKFmwfgo3MO6Hh3VX4MThc2v0pueBvGHjykMqpVpcqUAIjCSiMYiV+8i0X2MpOadrHZ
         HVG2l33GDO6CL0LyIfD74G40YAsJzm6vC+hH62KPsTk3nEqekG5BtZXohivPNuUfOtYE
         KPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789906053; x=1790510853;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q44BARlj5l9YGAlj+x+tZB6yMYyY94DbD3TNED9Jnj0=;
        b=VGmhctud1TmI0YKrqpEHWfzBXpQMKiP9xvE6Gw34A6dzcaQM78WuTGy6iAvG/dB6zQ
         vM82T48gUK8me0yt/l8mn1YEMTPCYxa+0Ub6nOe55jtFiEKATiHd6Hd1nxNLL98qY7IA
         i0LQs2NwzpowQg6AiYJmUZjOwpKfXEbImZkDkl/kKE+1utiYjNT/E4akgxRUU6ayPikl
         2VOuD8dvoiiXYG/QGJFKJXZvUdc2yAMLoRbu862f+VKLIFWhPC9XT1VPfH4k5a4FyZhY
         rvwDTKWN2jduXKfpvTbsiQGZ3xbRWibN8cwwO+hgb8V0OXgW8xjSswhgdBOyAe/IqNp6
         imHg==
X-Forwarded-Encrypted: i=1; AKwUvBy5h2Ve5FjtS6eYOIwGrOHFNOeKpyw8qIp6FkudeXuyt11G/fwI4+zH4kXLv9xM5LR2v1+pBDAaIA0=@vger.kernel.org
X-Gm-Message-State: AFuF++ndus+5q7bRoPPINY7zt21N0YxwUWBY7LMGlt0PszMjA0Y4dci+
	8FDdjYcXd3JGXlqDUK903oQozMNsBEtz3/Hn+bnGKK4WovnQF2Zir+kTjtHsIXcsTqZ01BIIVUx
	fnFpH5qdWte8fJldfofhqg1McikDoLXZbdN9jcRsOKJGk952+sxAkQk2St2Lm8uc=
X-Gm-Gg: AYBFou0iY2fUlGfW3t4nwzwUBnjFAjBQKH8puHodpZ9rxwIVcS2YlIukg1587A59Szr
	kToQYQwGUaG50GUZCABLOjwzlu5MPn0AMj/9td1/n71d0Zf10hO9dFoz0dYfq0rH2U4c6uYgEBV
	QTol5NQGJIfeUx/eJscBld20ZyQxF5HyQFGOlVQCh8/WYQ444bous+8gVI2d3QvyeX22PVBkZj7
	QQhUnv7A1z2tFgKyCAeu0I8A8WB92afZ0aEUMT1BIrFvFORLGiC36SvYaEuYmb2seWZHOpU2aJS
	astRrO6XU+V6aUVuDl9DrbrRE8k6sZOZSZBGICnMTOo2sOXp3GHSV4wTqfbyqHpvMtV+XAXqGJe
	YQja81YJQXprzef0hwL7JsqHj3XSkd5GP1g==
X-Received: by 2002:a17:90b:4c46:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39e54922644mr17296031a91.0.1789906049197;
        Sun, 20 Sep 2026 05:07:29 -0700 (PDT)
X-Received: by 2002:a17:90b:4c46:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39e54922644mr17295718a91.0.1789906044272;
        Sun, 20 Sep 2026 05:07:24 -0700 (PDT)
Received: from [192.168.1.9] ([106.222.235.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55cef9bsm12317623c88.10.2026.09.20.05.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 05:07:23 -0700 (PDT)
Message-ID: <565ae1e8-22f0-4bfc-8d1b-a453026961e8@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 17:37:18 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
 <bead05f4-6df9-49ac-88e3-0a8758e7b78b@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <bead05f4-6df9-49ac-88e3-0a8758e7b78b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8u7tjcMy9QVfzSrFgj10U70ihU2pUi1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfX9n/oQ1x8FWkG
 i+cDqGhav/VMIizreKmlKWazpckjweKUy89CPvRF4TtzTEVGWD+lNT6RqgcMbs8URM4eH473MUO
 xzPoYYHKHKDiWsDMHUdXXdOSoZUnHyvkbV1N4XN8SzAkXFRVn7P+w8YL1zfV/+vYF7T4pW2eOPx
 JXWoZzE5x1VrWxhg0FjwHRNM1WBiDxv9kcxiJQqiTinUm3mqPIQGYj53IX5BdP7dK3wmYE+sRFg
 c/AhdsjgInu/zksRpcNbwFEGvo1cW4CKZvOArPy4zZKYQ0yidoigmkN8EVgHGlrF+VxPpM2gQET
 MtBMcxbtl4YKhCttvASmwv/HMR6v4ilveJRMOJJ2NHG0CNDmro5DXFOpE/DU9+K+Wknr+0BkjjK
 fqF+HchU82rBNG7LGY0tMNvuKBc6vX8jauEwLKWVndwcosLnzO5V7MlVKQlDPMZVEyRasRKilS1
 6WFzB/IRYc8SDQpx8+g==
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6aafcc86 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=pmtpKdcgZ0pbyg+hYGrA9w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=jE1y32YtHgH84QjmgL4A:9
 a=inJLjF9DGj1vjSAe:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfX38eHJmRZf9ot
 l2ri4/0y7dpFpMDOgnsqaBroG7UY1M4Arc9w2TxkldicQCLdIxd3QHStI8jAxpgG1cVPGyZSBMx
 6zvNSaJpE0TKyUsrvSFRXepg4go11sE=
X-Proofpoint-ORIG-GUID: 8u7tjcMy9QVfzSrFgj10U70ihU2pUi1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200175



On 8/27/2026 3:51 PM, Mukesh Savaliya wrote:
> 
> 
> On 8/13/2026 9:22 PM, Viken Dadhaniya wrote:
>> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
>> controller that operates exclusively in target mode. The existing
>> Qualcomm I2C controller drivers (GENI, QUP) are master-only and cannot
>> serve systems where the SoC must respond as an I2C target on the bus.
>>
>> Register the controller with the Linux I2C slave framework via
>> i2c_algorithm.reg_target and i2c_algorithm.unreg_target so that any
>> standard slave backend (e.g. slave-24c02) can be attached at runtime
>> via i2c_slave_register(). Handle IRQ events for RX FIFO service, clock
>> stretching during read and write phases, STOP and repeated-start
>> conditions, and error recovery with SW reset. Enable the required AHB
>> and XO clocks, vote for interconnect bandwidth, and restore hardware
>> state across suspend and resume using the noirq PM callbacks.
> Neat:
> Though second paragraph gives good information, but i would suggest to keep  new lines to make it easier and simpler.>

Updated in v4.

>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                          |   9 +
>>   drivers/i2c/busses/Kconfig           |  15 +
>>   drivers/i2c/busses/Makefile          |   1 +
>>   drivers/i2c/busses/i2c-qcom-target.c | 588 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 613 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fe67f7bfa44c..7a2d66385e36 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22380,6 +22380,15 @@ S:    Maintained
>>   F:    Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>>   F:    drivers/i2c/busses/i2c-qcom-geni.c
>>   +QUALCOMM I2C TARGET CONTROLLER DRIVER
>> +M:    Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> +M:    Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> +L:    linux-i2c@vger.kernel.org
>> +L:    linux-arm-msm@vger.kernel.org
>> +S:    Maintained
>> +F:    Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml
>> +F:    drivers/i2c/busses/i2c-qcom-target.c
>> +
>>   QUALCOMM I2C CCI DRIVER
>>   M:    Loic Poulain <loic.poulain@oss.qualcomm.com>
>>   M:    Robert Foss <rfoss@kernel.org>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index d7b89508311f..2e18238e0ae6 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -1070,6 +1070,21 @@ config I2C_QCOM_GENI
>>         This driver can also be built as a module.  If so, the module
>>         will be called i2c-qcom-geni.
>>   +config I2C_QCOM_TARGET
>> +    tristate "Qualcomm I2C target controller"
>> +    depends on ARCH_QCOM || COMPILE_TEST
>> +    depends on COMMON_CLK
>> +    depends on INTERCONNECT
>> +    select I2C_SLAVE
>> +    help
>> +      This driver supports I2C target mode on Qualcomm Technologies
>> +      SoCs. If you say yes to this option, support will be included
>> +      for the built-in I2C target controller on QDU1000 and other
>> +      compatible Qualcomm SoCs.
>> +
>> +      This driver can also be built as a module. If so, the module
>> +      will be called i2c-qcom-target.
>> +
>>   config I2C_QUP
>>       tristate "Qualcomm QUP based I2C controller"
>>       depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 3755c54b3d82..ab3070cdb144 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -101,6 +101,7 @@ obj-$(CONFIG_I2C_PXA)        += i2c-pxa.o
>>   obj-$(CONFIG_I2C_PXA_PCI)    += i2c-pxa-pci.o
>>   obj-$(CONFIG_I2C_QCOM_CCI)    += i2c-qcom-cci.o
>>   obj-$(CONFIG_I2C_QCOM_GENI)    += i2c-qcom-geni.o
>> +obj-$(CONFIG_I2C_QCOM_TARGET)    += i2c-qcom-target.o
>>   obj-$(CONFIG_I2C_QUP)        += i2c-qup.o
>>   obj-$(CONFIG_I2C_RIIC)        += i2c-riic.o
>>   obj-$(CONFIG_I2C_RK3X)        += i2c-rk3x.o
>> diff --git a/drivers/i2c/busses/i2c-qcom-target.c b/drivers/i2c/busses/i2c-qcom-target.c
>> new file mode 100644
>> index 000000000000..277ea944eedb
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-qcom-target.c
>> @@ -0,0 +1,588 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interconnect.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* Register offsets */
>> +#define I2C_S_DEVICE_ADDR            0x00
>> +#define I2C_S_IRQ_STATUS            0x08
>> +#define I2C_S_IRQ_CLR                0x0C
>> +#define I2C_S_IRQ_EN                0x10
>> +#define I2C_S_CONFIG                0x18
>> +#define I2C_S_CONTROL                0x1C
>> +#define I2C_S_FIFOS_STATUS            0x20
>> +#define I2C_S_TX_FIFO                0x24
>> +#define I2C_S_RX_FIFO                0x28
>> +#define I2C_S_DEBUG_REG1            0x3C
>> +#define I2C_S_DEBUG_REG2            0x40
>> +#define I2C_S_SW_RESET_REG            0x4C
>> +#define I2C_S_CLK_LOW_TIMEOUT            0x50
>> +#define I2C_S_CLK_RELEASE_DELAY_CNT_VAL    0x54
>> +#define I2C_S_SDA_HOLD_CNT_VAL            0x58
>> +
>> +/* I2C_S_CONFIG register fields */
>> +#define I2C_S_CORE_EN                BIT(0)
>> +
>> +/* I2C_S_CONTROL register fields */
>> +#define CLEAR_RX_FIFO                BIT(0)
>> +#define CLEAR_TX_FIFO                BIT(1)
>> +#define NACK                    BIT(2)
>> +#define ACK_RESUME                BIT(3)
>> +
>> +/* I2C_S_SW_RESET_REG register fields */
>> +#define SW_RESET                BIT(0)
>> +
>> +/* I2C_S_FIFOS_STATUS register fields */
>> +#define RX_FIFO_COUNT_MASK            GENMASK(31, 16)
>> +
>> +/* Interconnect bandwidth vote in bytes per second */
>> +#define APPS_PROC_TO_I2C_TARGET_VOTE        1190000
>> +
>> +/**
>> + * enum qcom_i2c_target_irq - IRQ bit positions in I2C_S_IRQ_STATUS
>> + * @STOP_DETECTED:    I2C stop condition detected on the bus
>> + * @RX_FIFO_FULL:    receive FIFO has reached capacity
>> + * @TX_FIFO_EMPTY:    transmit FIFO is empty
>> + * @RX_DATA_AVAIL:    receive data is available in the RX FIFO
>> + * @CLOCK_LOW_TIMEOUT:    SCL held low longer than the configured timeout
>> + * @STRCH_WR:        clock stretching during a write (Rx) phase
>> + * @STRCH_RD:        clock stretching during a read (Tx) phase
>> + * @GCA_DETECTED:    general call address detected (not used)
>> + * @ERR_CONDITION:    unexpected start or stop bit detected (error)
>> + * @RESTART_DETECTED:    repeated start condition detected
>> + */
>> +enum qcom_i2c_target_irq {
>> +    STOP_DETECTED,
>> +    RX_FIFO_FULL,
>> +    TX_FIFO_EMPTY,
>> +    RX_DATA_AVAIL,
>> +    CLOCK_LOW_TIMEOUT,
>> +    STRCH_WR,
>> +    STRCH_RD,
>> +    GCA_DETECTED,
>> +    ERR_CONDITION,
>> +    RESTART_DETECTED,
>> +};
>> +
>> +/*
>> + * TX_FIFO_EMPTY is excluded: this driver fills the TX FIFO one byte at a
>> + * time in response to STRCH_RD (clock-stretch during read phase), so
>> + * TX_FIFO_EMPTY adds no value and would double the interrupt rate.
>> + * GCA (general call address) is unsupported.
>> + */
>> +#define QCOM_I2C_TARGET_ALL_IRQ    (GENMASK(RESTART_DETECTED, STOP_DETECTED) \
>> +                 & ~(BIT(GCA_DETECTED) | BIT(TX_FIFO_EMPTY)))
>> +
>> +/* Bit indices for the status bitmask, used with set_bit/test_bit/clear_bit */
>> +enum qcom_i2c_target_status {
>> +    READ_IN_PROGRESS,
>> +    WRITE_IN_PROGRESS,
>> +};
>> +
>> +/**
>> + * struct qcom_i2c_target - Qualcomm I2C target controller private data
>> + * @dev:        driver model device node
>> + * @base:        base address of HW registers
>> + * @adap:        I2C adapter (slave mode)
>> + * @ahb_clk:        AHB bus clock
>> + * @xo_clk:        XO reference clock
>> + * @icc_path:        interconnect bandwidth path
>> + * @slave:        currently registered slave backend client; written only
>> + *            under disable_irq() in reg_slave()/unreg_slave() so the
>> + *            ISR sees a stable pointer for its entire execution
>> + * @status:        bitmask of enum qcom_i2c_target_status flags; must be
>> + *            unsigned long for set_bit/test_bit/clear_bit; accessed
>> + *            only from the ISR and from reg_slave()/unreg_slave()
>> + *            under disable_irq(), so no additional lock is needed
>> + * @irq:        interrupt line number
>> + */
>> +struct qcom_i2c_target {
>> +    struct device        *dev;
>> +    void __iomem        *base;
>> +    struct i2c_adapter    adap;
>> +    struct clk        *ahb_clk;
>> +    struct clk        *xo_clk;
>> +    struct icc_path        *icc_path;
>> +    struct i2c_client    *slave;
>> +    unsigned long        status;
>> +    int            irq;
>> +};
>> +
>> +static void qcom_i2c_target_dump_regs(struct qcom_i2c_target *target)
>> +{
>> +    dev_dbg(target->dev, "I2C_S_DEVICE_ADDR:               0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_DEVICE_ADDR));
>> +    dev_dbg(target->dev, "I2C_S_IRQ_STATUS:                0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_IRQ_STATUS));
>> +    dev_dbg(target->dev, "I2C_S_CONFIG:                    0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_CONFIG));
>> +    dev_dbg(target->dev, "I2C_S_IRQ_EN:                    0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_IRQ_EN));
>> +    dev_dbg(target->dev, "I2C_S_FIFOS_STATUS:              0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
>> +    dev_dbg(target->dev, "I2C_S_DEBUG_REG1:                0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_DEBUG_REG1));
>> +    dev_dbg(target->dev, "I2C_S_DEBUG_REG2:                0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_DEBUG_REG2));
>> +    dev_dbg(target->dev, "I2C_S_CLK_LOW_TIMEOUT:           0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_CLK_LOW_TIMEOUT));
>> +    dev_dbg(target->dev, "I2C_S_CLK_RELEASE_DELAY_CNT_VAL: 0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_CLK_RELEASE_DELAY_CNT_VAL));
>> +    dev_dbg(target->dev, "I2C_S_SDA_HOLD_CNT_VAL:          0x%x\n",
>> +        readl_relaxed(target->base + I2C_S_SDA_HOLD_CNT_VAL));
>> +}
>> +
>> +static void qcom_i2c_target_hw_init(struct qcom_i2c_target *target)
>> +{
>> +    dev_dbg(target->dev, "HW init: resetting FIFOs, enabling IRQs\n");
>> +    writel(CLEAR_TX_FIFO | CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
>> +    writel(QCOM_I2C_TARGET_ALL_IRQ, target->base + I2C_S_IRQ_EN);
>> +}
>> +
>> +static void qcom_i2c_target_write_requested(struct qcom_i2c_target *target)
>> +{
>> +    u8 val = 0;
>> +
>> +    if (!test_and_set_bit(WRITE_IN_PROGRESS, &target->status)) {
>> +        dev_dbg(target->dev, "Write phase started\n");
>> +        i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
>> +    }
>> +}
>> +
>> +static int qcom_i2c_target_drain_rx_fifo(struct qcom_i2c_target *target)
>> +{
>> +    unsigned int rx_count;
>> +    int ret = 0;
>> +    u8 val;
>> +
>> +    while (!ret) {
>> +        rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
>> +                     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
>> +        if (!rx_count)
>> +            break;
>> +
>> +        while (rx_count--) {
>> +            val = (u8)readl_relaxed(target->base + I2C_S_RX_FIFO);
>> +            dev_dbg(target->dev, "Data from RX FIFO: 0x%x\n", val);
>> +            ret = i2c_slave_event(target->slave, I2C_SLAVE_WRITE_RECEIVED, &val);
>> +            if (ret)
>> +                break;
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
>> +{
>> +    /* Clear error bits before SW_RESET; the reset may not be instantaneous */
>> +    writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
>> +           target->base + I2C_S_IRQ_CLR);
>> +    writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);
> 
> line space > +    /*

Added in v4.

>> +     * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
>> +     * Use a conservative delay to allow the reset to finish before
>> +     * reconfiguring the controller.
>> +     */
>> +    usleep_range(10, 20);
>> +    qcom_i2c_target_hw_init(target);
>> +    writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
>> +    writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
>> +}
>> +
>> +static irqreturn_t qcom_i2c_target_handle_error(struct qcom_i2c_target *target,
>> +                        u32 irq_stat)
>> +{
>> +    u8 val = 0;
>> +
>> +    if (irq_stat & BIT(ERR_CONDITION))
>> +        dev_err(target->dev, "Error condition: unexpected Start/Stop bits\n");
>> +    else
>> +        dev_err(target->dev, "Clock low timeout\n");
>> +    qcom_i2c_target_dump_regs(target);
>> +    qcom_i2c_target_hw_reset(target);
>> +    i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
>> +    target->status = 0;
> line space before return> +    return IRQ_HANDLED;

Added in v4.

>> +}
>> +
>> +static irqreturn_t qcom_i2c_target_handle_stop(struct qcom_i2c_target *target,
>> +                           u32 irq_stat)
>> +{
>> +    u8 val = 0;
>> +
>> +    dev_dbg(target->dev, "Stop bit detected\n");
>> +    /*
>> +     * Short-write corner case: WRITE_IN_PROGRESS was never set because
>> +     * no RX_DATA_AVAIL or STRCH_WR fired before STOP. Do not call
>> +     * qcom_i2c_target_write_requested() here — STOP ends the transaction
>> +     * so setting WRITE_IN_PROGRESS now would leave a stale bit after
>> +     * target->status is cleared below.
>> +     */
>> +    if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {
>> +        unsigned int rx_count;
>> +
>> +        rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
>> +                     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
>> +        if (rx_count)
>> +            i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED,
>> +                    &val);
>> +    }
> minor as cleanup: give a line space > + qcom_i2c_target_drain_rx_fifo(target);

Added in v4.

>> +    i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
>> +    target->status = 0;
>> +    writel(CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
>> +    /*
>> +     * STOP terminates the transaction, so any other Rx or clock
>> +     * stretch bits latched in this same status read have already
>> +     * been serviced by the drain above or are now stale. Ack the
>> +     * whole word rather than just STOP_DETECTED; clearing only STOP
>> +     * would leave those bits set and immediately re-enter the
>> +     * handler, which for a co-asserted STRCH_RD would push a stale
>> +     * byte into the TX FIFO.
>> +     */
>> +    writel(irq_stat, target->base + I2C_S_IRQ_CLR);
> 
> give a line space before returning.> +    return IRQ_HANDLED;

Added in v4.

>> +}
>> +
>> +static void qcom_i2c_target_handle_rx_data(struct qcom_i2c_target *target,
>> +                       u32 rx_irq_bits)
>> +{
>> +    int ret;
>> +
>> +    dev_dbg(target->dev, "Rx data event (rx_irq_bits=0x%x)\n", rx_irq_bits);
>> +    qcom_i2c_target_write_requested(target);
>> +    ret = qcom_i2c_target_drain_rx_fifo(target);
>> +    if (ret)
>> +        dev_dbg(target->dev, "Backend requested NACK\n");
> line space for neat> +    writel(ret ? NACK | CLEAR_RX_FIFO : ACK_RESUME,
>> +           target->base + I2C_S_CONTROL);
>> +    writel(rx_irq_bits, target->base + I2C_S_IRQ_CLR);
>> +}
>> +
>> +static void qcom_i2c_target_handle_strch_rd(struct qcom_i2c_target *target)
>> +{
>> +    enum i2c_slave_event event = I2C_SLAVE_READ_PROCESSED;
>> +    u8 val = 0;
>> +
>> +    dev_dbg(target->dev, "Clock stretching during read (Tx) phase\n");
>> +    if (!test_and_set_bit(READ_IN_PROGRESS, &target->status)) {
>> +        /* Repeated-start: master switched direction from write to read */
>> +        clear_bit(WRITE_IN_PROGRESS, &target->status);
>> +        event = I2C_SLAVE_READ_REQUESTED;
>> +    }
> line space> +    i2c_slave_event(target->slave, event, &val);

Added in v4.

>> +    dev_dbg(target->dev, "Data to TX FIFO: 0x%x\n", val);
>> +    writel(val, target->base + I2C_S_TX_FIFO);
>> +    writel(ACK_RESUME, target->base + I2C_S_CONTROL);
>> +    writel(BIT(STRCH_RD), target->base + I2C_S_IRQ_CLR);
>> +}
>> +
>> +static irqreturn_t qcom_i2c_target_irq(int irq, void *dev)
>> +{
>> +    struct qcom_i2c_target *target = dev;
>> +    u32 irq_stat, rx_bits;
>> +
>> +    /*
>> +     * Dispatch priority (highest first):
>> +     *   ERR_CONDITION / CLOCK_LOW_TIMEOUT  — hardware error, triggers SW reset
>> +     *   STOP_DETECTED                      — end of transaction, clears all state
>> +     *   RESTART_DETECTED                   — repeated start, resets state before
>> +     *                                        any data phase in the same snapshot
>> +     *   STRCH_RD                           — read-phase data supply
>> +     *   RX_FIFO_FULL / RX_DATA_AVAIL /
>> +     *   STRCH_WR                           — write-phase Rx, coalesced into one drain
>> +     */
>> +    irq_stat = readl_relaxed(target->base + I2C_S_IRQ_STATUS);
>> +    if (!irq_stat)
>> +        return IRQ_NONE;
>> +
>> +    dev_dbg(target->dev, "IRQ status: 0x%x\n", irq_stat);
>> +
>> +    /*
>> +     * Load target->slave once. Both reg_slave() and unreg_slave() disable
>> +     * the IRQ before writing the pointer, so it cannot change while this
>> +     * handler runs. Sub-handlers may dereference target->slave directly.
>> +     *
>> +     * The core is enabled only in reg_slave() and disabled in unreg_slave(),
>> +     * so no bus activity is expected here. Clear and discard any stale IRQ.
>> +     */
>> +    if (!READ_ONCE(target->slave)) {
>> +        writel(irq_stat, target->base + I2C_S_IRQ_CLR);
>> +        return IRQ_HANDLED;
>> +    }
>> +
>> +    if (irq_stat & (BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT)))
>> +        return qcom_i2c_target_handle_error(target, irq_stat);
>> +
>> +    if (irq_stat & BIT(STOP_DETECTED))
>> +        return qcom_i2c_target_handle_stop(target, irq_stat);
>> +
>> +    if (irq_stat & BIT(RESTART_DETECTED)) {
>> +        dev_dbg(target->dev, "Repeated start bit detected\n");
>> +        target->status = 0;
>> +        writel(ACK_RESUME, target->base + I2C_S_CONTROL);
>> +        writel(BIT(RESTART_DETECTED), target->base + I2C_S_IRQ_CLR);
>> +    }
>> +
>> +    if (irq_stat & BIT(STRCH_RD))
>> +        qcom_i2c_target_handle_strch_rd(target);
>> +
>> +    /*
>> +     * Coalesce all write-phase Rx bits into a single drain+ACK. When the
>> +     * RX FIFO fills at threshold, RX_FIFO_FULL, RX_DATA_AVAIL and STRCH_WR
>> +     * can all assert in the same irq_stat snapshot. Pass the combined mask
>> +     * so ACK_RESUME is written exactly once and all bits are cleared together.
>> +     */
>> +    rx_bits = irq_stat & (BIT(RX_FIFO_FULL) | BIT(RX_DATA_AVAIL) |
>> +                  BIT(STRCH_WR));
>> +    if (rx_bits)
>> +        qcom_i2c_target_handle_rx_data(target, rx_bits);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int qcom_i2c_target_reg_slave(struct i2c_client *slave)
>> +{
>> +    struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
>> +
>> +    if (target->slave)
>> +        return -EBUSY;
>> +
>> +    if (slave->flags & I2C_CLIENT_TEN)
>> +        return -EAFNOSUPPORT;
>> +
>> +    disable_irq(target->irq);
>> +    WRITE_ONCE(target->slave, slave);
>> +    writel(slave->addr, target->base + I2C_S_DEVICE_ADDR);
>> +    writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
>> +    enable_irq(target->irq);
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_i2c_target_unreg_slave(struct i2c_client *slave)
>> +{
>> +    struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
>> +
>> +    if (!target->slave)
>> +        return -EINVAL;
> minor comment: line space > +    disable_irq(target->irq);

Added in v4.

>> +    writel(0, target->base + I2C_S_CONFIG);
>> +    WRITE_ONCE(target->slave, NULL);
>> +    target->status = 0;
>> +    writel(0, target->base + I2C_S_DEVICE_ADDR);
>> +    enable_irq(target->irq);
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_i2c_target_icc_init(struct qcom_i2c_target *target)
>> +{
>> +    int ret;
>> +
>> +    target->icc_path = devm_of_icc_get(target->dev, NULL);
>> +    if (IS_ERR(target->icc_path))
>> +        return dev_err_probe(target->dev, PTR_ERR(target->icc_path),
>> +                     "failed to get ICC path\n");
>> +
>> +    /*
>> +     * The controller only needs interconnect bandwidth while it is
>> +     * powered. The vote is placed here and across resume with
>> +     * icc_set_bw(), and dropped with icc_set_bw(path, 0, 0) on suspend
>> +     * and remove, so the vote and unvote are always symmetric.
>> +     */
>> +    ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
>> +             APPS_PROC_TO_I2C_TARGET_VOTE);
>> +    if (ret)
>> +        return dev_err_probe(target->dev, ret, "icc_set_bw failed\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static u32 qcom_i2c_target_func(struct i2c_adapter *adap)
>> +{
>> +    return I2C_FUNC_SLAVE;
>> +}
>> +
>> +static const struct i2c_algorithm qcom_i2c_target_algo = {
>> +    .reg_target    = qcom_i2c_target_reg_slave,
>> +    .unreg_target    = qcom_i2c_target_unreg_slave,
>> +    .functionality    = qcom_i2c_target_func,
>> +};
>> +
>> +static int qcom_i2c_target_adap_init(struct qcom_i2c_target *target)
>> +{
>> +    target->adap.algo = &qcom_i2c_target_algo;
>> +    target->adap.dev.parent = target->dev;
>> +    target->adap.dev.of_node = target->dev->of_node;
>> +    strscpy(target->adap.name, "qcom-i2c-target",
>> +        sizeof(target->adap.name));
>> +    i2c_set_adapdata(&target->adap, target);
>> +
>> +    return i2c_add_adapter(&target->adap);
>> +}
>> +
>> +static int qcom_i2c_target_probe(struct platform_device *pdev)
>> +{
>> +    struct qcom_i2c_target *target;
>> +    struct device *dev = &pdev->dev;
>> +    int ret;
>> +
>> +    target = devm_kzalloc(dev, sizeof(*target), GFP_KERNEL);
>> +    if (!target)
>> +        return -ENOMEM;
>> +
>> +    target->dev = dev;
>> +
>> +    target->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(target->base))
>> +        return dev_err_probe(dev, PTR_ERR(target->base),
>> +                     "failed to map registers\n");
>> +
>> +    target->xo_clk = devm_clk_get(dev, "xo");
>> +    if (IS_ERR(target->xo_clk))
>> +        return dev_err_probe(dev, PTR_ERR(target->xo_clk),
>> +                     "failed to get XO clock\n");
>> +
>> +    target->ahb_clk = devm_clk_get(dev, "ahb");
>> +    if (IS_ERR(target->ahb_clk))
>> +        return dev_err_probe(dev, PTR_ERR(target->ahb_clk),
>> +                     "failed to get AHB clock\n");
>> +
>> +    ret = clk_prepare_enable(target->xo_clk);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "failed to enable XO clock\n");
>> +
>> +    ret = clk_prepare_enable(target->ahb_clk);
>> +    if (ret) {
>> +        clk_disable_unprepare(target->xo_clk);
>> +        return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
>> +    }
>> +
>> +    target->irq = platform_get_irq(pdev, 0);
>> +    if (target->irq < 0)
>> +        return target->irq;
>> +
>> +    ret = qcom_i2c_target_icc_init(target);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0,
>> +                   dev_name(dev), target);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "request_irq failed for IRQ %d\n",
>> +                     target->irq);
>> +
>> +    qcom_i2c_target_hw_init(target);
>> +
>> +    platform_set_drvdata(pdev, target);
>> +
>> +    ret = qcom_i2c_target_adap_init(target);
>> +    if (ret)
>> +        return dev_err_probe(dev, ret, "i2c_add_adapter failed\n");
>> +
>> +    return 0;
>> +}
>> +
>> +static void qcom_i2c_target_remove(struct platform_device *pdev)
>> +{
>> +    struct qcom_i2c_target *target = platform_get_drvdata(pdev);
>> +
>> +    writel(0, target->base + I2C_S_CONFIG);
>> +    i2c_del_adapter(&target->adap);
>> +    icc_set_bw(target->icc_path, 0, 0);
>> +    clk_disable_unprepare(target->xo_clk);
>> +    clk_disable_unprepare(target->ahb_clk);
>> +}
>> +
>> +static int qcom_i2c_target_suspend(struct device *dev)
>> +{
>> +    struct qcom_i2c_target *target = dev_get_drvdata(dev);
>> +    int ret;
>> +
>> +    ret = icc_set_bw(target->icc_path, 0, 0);
>> +    if (ret)
>> +        dev_err(dev, "icc_set_bw failed on suspend: %d\n", ret);
>> +
>> +    clk_disable_unprepare(target->xo_clk);
>> +    clk_disable_unprepare(target->ahb_clk);
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_i2c_target_resume(struct device *dev)
>> +{
>> +    struct qcom_i2c_target *target = dev_get_drvdata(dev);
>> +    int ret;
>> +
>> +    ret = clk_prepare_enable(target->ahb_clk);
>> +    if (ret) {
>> +        dev_err(dev, "failed to enable AHB clock\n");
>> +        return ret;
>> +    }
>> +
>> +    ret = clk_prepare_enable(target->xo_clk);
>> +    if (ret) {
>> +        dev_err(dev, "failed to enable XO clock\n");
>> +        goto err_disable_ahb;
>> +    }
>> +
>> +    ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
>> +             APPS_PROC_TO_I2C_TARGET_VOTE);
>> +    if (ret) {
>> +        dev_err(dev, "icc_set_bw failed\n");
>> +        goto err_disable_xo;
>> +    }
>> +
>> +    qcom_i2c_target_hw_init(target);
>> +    target->status = 0;
> if the status is 0 here after target init, what about other places ? does it need to change status ? OR is it inherent to framework ?
> 
> Any comment can be help while changing status ?> +    if (target->slave) {

Status is private transaction state owned by this driver; it is not
managed by the I2C slave framework. It is cleared on STOP, error reset,
repeated START, slave unregister, and resume. Resume clears it because the
controller/FIFOs are reinitialized and any transaction state from before
suspend is no longer valid. The initial probe value is already zeroed by
devm_kzalloc().

>> +        writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
>> +        writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
>> +    }
>> +
>> +    return 0;
>> +
>> +err_disable_xo:
>> +    clk_disable_unprepare(target->xo_clk);
>> +err_disable_ahb:
>> +    clk_disable_unprepare(target->ahb_clk);
> line space before return> +    return ret;
>> +}
>> +
>> +static const struct dev_pm_ops qcom_i2c_target_pm_ops = {
>> +    SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_i2c_target_suspend,
>> +                      qcom_i2c_target_resume)
>> +};
>> +
> 
> can we also add reason here to add NOIRQ callbacks ? My generic question would be why not system PM or Runtime PM callbacks ?
> This will help later stage for any futurstic changes.

Updated in v4.

> 
>> +static const struct of_device_id qcom_i2c_target_dt_match[] = {
>> +    { .compatible = "qcom,qdu1000-i2c-target" },
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_i2c_target_dt_match);
>> +
>> +static struct platform_driver qcom_i2c_target_driver = {
>> +    .driver = {
>> +        .name        = "qcom-i2c-target",
>> +        .pm        = &qcom_i2c_target_pm_ops,
>> +        .of_match_table    = qcom_i2c_target_dt_match,
>> +    },
>> +    .probe    = qcom_i2c_target_probe,
>> +    .remove    = qcom_i2c_target_remove,
>> +};
>> +module_platform_driver(qcom_i2c_target_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm I2C target controller driver");
>> +MODULE_AUTHOR("Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>");
>> +MODULE_LICENSE("GPL");
>>
> 

