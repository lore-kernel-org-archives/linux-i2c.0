Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16563CBE6F
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826125; cv=none; b=XDov8w3j252U5THPpF6xnUc4BjKRkI6G5F/wmUIBT4ZWZ9Jir/g2Fe40RRTwuaffqywoPkDEELgrxWdh7ZTezTLx4P5goixn7ECL99yULaW5hsKl9fnGH/f4zv2ZCzfazFdSh8G4cdl4xnX7Jgl/4DeuaU6rw407P6I9BLUn8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826125; c=relaxed/simple;
	bh=T75uIJF6E8Ip7b6sKHOlpJ4KZAuWgwYRX00M8gii9yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oy/TToH33sG5rCrvpx8Jrg/mr44iRe5FdvJGyLohUoVBdZ7tLu7enwIkJjSvJgIBbgsoPiQHxfTfu5GOIx0XTIHgIpcP2cZudGTqRL719YkhH6AkEqnNU3SPb7R8xYQOgT2g+0o5h0IteSZNp7ze4LHppex2Q+OIjU0aujhjzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWmy/npL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N/6K44Kf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWmy/npL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N/6K44Kf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9HGcZ3090807
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p+rTFisNXNz7OsUKeVd+5xUQnGfggCzBE6XaxC2TuDo=; b=CWmy/npLIyaOVuQ0
	Dacsq0xDeDUsELFEh3tJPe9Q+2zxMn9yrOApVTjnpDLu/FuhP4x8E1t/qvZ5Q+A8
	EZMdr9RUzBB9pohch9lX+f+ZlUhlW8pwq91zis9gBrLbUgbWBQ8ES9HlvWtg6ehF
	DhtmfuSje5V/uHaneqg5Ugm6EA5BwvtN9GqMmN8i7rp//EWKpnx6NjP8+gr7aJy4
	5y1rBgmWO/LKJEwpIZKFKFJs8NYjRWdGCm9ZiEjNlcTlkDvfr72mu+U6KeJUMWRa
	E+JFaYjJb3j9O/9sMGQqHS4NmGA/poFmRsJTkMZfzJQvmX3t/s1xiU2YpdxqAqIg
	VEdtNA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwkb1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 10:21:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc132709c76so1060140a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787826106; x=1788430906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+rTFisNXNz7OsUKeVd+5xUQnGfggCzBE6XaxC2TuDo=;
        b=N/6K44KfnxASHxYCe80ZpIUHFx3hZNZSmC2dRJa4WHkrPBqYHSP5qQ88qjFN+2Ny0J
         T2NVlGIgrUG5OX5Ivg/0KKp2Hj4jE4bF6iPELBrMXFQFYKG8+TvAZ+e7wacTtftilUwU
         l52kZ3rpLH0ghTzxSutbOfLfQJGoqunTZmI37aXvg/G37PvjxLzfBWy00V4kfiAXm79k
         3ryFo5l1/SQ6WLxcGInw6+7nw1hDt0TXw6NO+Fgt4uxFaogjnHL2hsc0cs1BVDSh/eB4
         6yjDGG7sfomdbePGdqHSprQ+C8QGQbyMbXab6hPr0TbHT39zBiHeMv87WRBznDnD+dOL
         tEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787826106; x=1788430906;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+rTFisNXNz7OsUKeVd+5xUQnGfggCzBE6XaxC2TuDo=;
        b=Q6a4h4Xx12p6FfxTF9CKwBOw4xG+71se5JcKjp3pSO3tbWaQ3ZmIokpbB7wuFbcK5y
         MLkqsArixBh0yJxqFWa2WtzSMZMyMrznUzn4I5Z16+hDDJE3pb1oWLWeWKLJsxBOHEMI
         o25l0nZAYVWI7jUd6n3ph1Exwcy/EhfKIdLA6Gref15O9Tl07hU0Fz0ILv7Td0Z0dNTg
         i534MxwPB5WZCJLPQb7bGapykKBnvP8vvYhTgNEWFKLumS0rIpajrc9DU60IGqYNWhs3
         kRoqITWBSQhWSTxKvD+damCltVClBdpGqtTwiFu1PVEMvAbBUkVsBqKWj+Qt60nCGHHZ
         d78A==
X-Forwarded-Encrypted: i=1; AHgh+Rqzfar1eR7hqZfaSfSTnjnNt0RYeFerReiagk4sF8aRSzeGvKu4Vr5nhSM6I/pvq9ZJqM3GrfUvehE=@vger.kernel.org
X-Gm-Message-State: AFuF++lYQ6abDoB1K38DLz8+laDiz62XgXI6bgVKCF6iDuj2Zrt0Is5t
	57sxwDbPhCciII6eWz72Bl2piq9eXLw6Y273rVno4G4/md/ibXux0OOxuDFR+XMMmzpHkvRjEWC
	nf/IfiANVAjluoI4RJDRVcfOOcujk8yymwvU8GLLr4V41n6iRL8WLDupc7bfZFRY=
X-Gm-Gg: AR+sD11+PoObWUXCNPCjQ+7Ag2wjoyaydKpEzJbSO0//cECY9KlXneRuHx1mO9Dv9Cf
	NsJYb0DwV3Cl1XQZ4jEbCmUdKL5uUJUjt2gua7w2Ap4TXEbsb4ookruh+u6NRrOkaMmw1/G4GMA
	YwxUfIvxgH4VGhmMishxCU5D4tTRULXXApG5d0T63OuYr3Lh7iCU7nSNBK2S5UXEtYCY0h5qJ7f
	BtSPipdW5W/zm/6e87Rz3YaMaFxJb13jrWIENtj4l+k6iBGuEZi1ghBBuXdjUp4ePIIKT6QMBgF
	aZUp1O2jQsO7eDWqtQWmRu/3vXF0xQWjavnlx9YLlsvSu+4/lKUrfsIq5m8qEsMFpkdk7R9UVF9
	qsgE/nUGR++9dbHIP956UfqpqhrZrbrpbZS8=
X-Received: by 2002:a05:6a20:9c11:b0:3d0:d1f1:6ec5 with SMTP id adf61e73a8af0-3d0d1f17398mr15447894637.4.1787826105487;
        Thu, 27 Aug 2026 03:21:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c11:b0:3d0:d1f1:6ec5 with SMTP id adf61e73a8af0-3d0d1f17398mr15447768637.4.1787826104883;
        Thu, 27 Aug 2026 03:21:44 -0700 (PDT)
Received: from [10.217.219.186] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328593b6b7csm6628940eec.19.2026.08.27.03.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 03:21:43 -0700 (PDT)
Message-ID: <bead05f4-6df9-49ac-88e3-0a8758e7b78b@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:51:38 +0530
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 10HJPtpVdoAD91NQwTKfejDTDmBLIgin
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a900fba cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=plGCb_doOOwzpP1BYrEA:9
 a=inJLjF9DGj1vjSAe:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: 10HJPtpVdoAD91NQwTKfejDTDmBLIgin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4NiBTYWx0ZWRfX4uA/QbgL4nbo
 b3M8QcRAidqpNDN/0oFMpi1M6fbbJ6CeLRBInizAlf0KQwLhnfWZofsGGag8oq5ARviAAdbKafL
 SOE2+WdZJYFmpI1+vdiT7VIHYtSzB87Zyd3ytch37jHaxWTsDsA2Q4ZM2/ytbSKsnhKSnIzkLRb
 nxFaACm06dqUuFtfquXYM61+4b69wIfkmJtIXJ8daslhk7XbhRsCOjOmNaI+01QwXQn9zg2rmrq
 Gj59/TncKRhrYUxMseHY5EcNS+inpOZcOd5GCBdUyrIC9xaHESHhzqbq/LEjGEzOJfaw8d3rKG4
 p5AoFvBHcE7aFsvGHALHTBM6jbnyupKSGhopjn1irgiJq9JrtgQQiJ+3teCmOSc8b8yNa1arEk8
 RHfFvTsmvTF+EMSyUfcbTJiteRSIgL4wsze6uzMRc82ib71APwmeKRxVS7ZozK3Ag5YgXPpHChU
 ULKx7Azx9ybfKBM4wwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4NiBTYWx0ZWRfX5qwO+Ff0bFEk
 +Qx8lEARMTnTSoFQ9aPxP/gCS/BQwngZpLB+uY/+Itcyh6rVzq9YpLsE22BQ+DxYNn2zsOcZKWQ
 L8AaMQS85twNvxM732eN6xJlkoBope8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270086



On 8/13/2026 9:22 PM, Viken Dadhaniya wrote:
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
Neat:
Though second paragraph gives good information, but i would suggest to 
keep  new lines to make it easier and simpler.>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>   MAINTAINERS                          |   9 +
>   drivers/i2c/busses/Kconfig           |  15 +
>   drivers/i2c/busses/Makefile          |   1 +
>   drivers/i2c/busses/i2c-qcom-target.c | 588 +++++++++++++++++++++++++++++++++++
>   4 files changed, 613 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe67f7bfa44c..7a2d66385e36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22380,6 +22380,15 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
>   F:	drivers/i2c/busses/i2c-qcom-geni.c
>   
> +QUALCOMM I2C TARGET CONTROLLER DRIVER
> +M:	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> +M:	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> +L:	linux-i2c@vger.kernel.org
> +L:	linux-arm-msm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml
> +F:	drivers/i2c/busses/i2c-qcom-target.c
> +
>   QUALCOMM I2C CCI DRIVER
>   M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
>   M:	Robert Foss <rfoss@kernel.org>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d7b89508311f..2e18238e0ae6 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1070,6 +1070,21 @@ config I2C_QCOM_GENI
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-qcom-geni.
>   
> +config I2C_QCOM_TARGET
> +	tristate "Qualcomm I2C target controller"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on COMMON_CLK
> +	depends on INTERCONNECT
> +	select I2C_SLAVE
> +	help
> +	  This driver supports I2C target mode on Qualcomm Technologies
> +	  SoCs. If you say yes to this option, support will be included
> +	  for the built-in I2C target controller on QDU1000 and other
> +	  compatible Qualcomm SoCs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-qcom-target.
> +
>   config I2C_QUP
>   	tristate "Qualcomm QUP based I2C controller"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3755c54b3d82..ab3070cdb144 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
>   obj-$(CONFIG_I2C_PXA_PCI)	+= i2c-pxa-pci.o
>   obj-$(CONFIG_I2C_QCOM_CCI)	+= i2c-qcom-cci.o
>   obj-$(CONFIG_I2C_QCOM_GENI)	+= i2c-qcom-geni.o
> +obj-$(CONFIG_I2C_QCOM_TARGET)	+= i2c-qcom-target.o
>   obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
>   obj-$(CONFIG_I2C_RIIC)		+= i2c-riic.o
>   obj-$(CONFIG_I2C_RK3X)		+= i2c-rk3x.o
> diff --git a/drivers/i2c/busses/i2c-qcom-target.c b/drivers/i2c/busses/i2c-qcom-target.c
> new file mode 100644
> index 000000000000..277ea944eedb
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-qcom-target.c
> @@ -0,0 +1,588 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interconnect.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/* Register offsets */
> +#define I2C_S_DEVICE_ADDR			0x00
> +#define I2C_S_IRQ_STATUS			0x08
> +#define I2C_S_IRQ_CLR				0x0C
> +#define I2C_S_IRQ_EN				0x10
> +#define I2C_S_CONFIG				0x18
> +#define I2C_S_CONTROL				0x1C
> +#define I2C_S_FIFOS_STATUS			0x20
> +#define I2C_S_TX_FIFO				0x24
> +#define I2C_S_RX_FIFO				0x28
> +#define I2C_S_DEBUG_REG1			0x3C
> +#define I2C_S_DEBUG_REG2			0x40
> +#define I2C_S_SW_RESET_REG			0x4C
> +#define I2C_S_CLK_LOW_TIMEOUT			0x50
> +#define I2C_S_CLK_RELEASE_DELAY_CNT_VAL	0x54
> +#define I2C_S_SDA_HOLD_CNT_VAL			0x58
> +
> +/* I2C_S_CONFIG register fields */
> +#define I2C_S_CORE_EN				BIT(0)
> +
> +/* I2C_S_CONTROL register fields */
> +#define CLEAR_RX_FIFO				BIT(0)
> +#define CLEAR_TX_FIFO				BIT(1)
> +#define NACK					BIT(2)
> +#define ACK_RESUME				BIT(3)
> +
> +/* I2C_S_SW_RESET_REG register fields */
> +#define SW_RESET				BIT(0)
> +
> +/* I2C_S_FIFOS_STATUS register fields */
> +#define RX_FIFO_COUNT_MASK			GENMASK(31, 16)
> +
> +/* Interconnect bandwidth vote in bytes per second */
> +#define APPS_PROC_TO_I2C_TARGET_VOTE		1190000
> +
> +/**
> + * enum qcom_i2c_target_irq - IRQ bit positions in I2C_S_IRQ_STATUS
> + * @STOP_DETECTED:	I2C stop condition detected on the bus
> + * @RX_FIFO_FULL:	receive FIFO has reached capacity
> + * @TX_FIFO_EMPTY:	transmit FIFO is empty
> + * @RX_DATA_AVAIL:	receive data is available in the RX FIFO
> + * @CLOCK_LOW_TIMEOUT:	SCL held low longer than the configured timeout
> + * @STRCH_WR:		clock stretching during a write (Rx) phase
> + * @STRCH_RD:		clock stretching during a read (Tx) phase
> + * @GCA_DETECTED:	general call address detected (not used)
> + * @ERR_CONDITION:	unexpected start or stop bit detected (error)
> + * @RESTART_DETECTED:	repeated start condition detected
> + */
> +enum qcom_i2c_target_irq {
> +	STOP_DETECTED,
> +	RX_FIFO_FULL,
> +	TX_FIFO_EMPTY,
> +	RX_DATA_AVAIL,
> +	CLOCK_LOW_TIMEOUT,
> +	STRCH_WR,
> +	STRCH_RD,
> +	GCA_DETECTED,
> +	ERR_CONDITION,
> +	RESTART_DETECTED,
> +};
> +
> +/*
> + * TX_FIFO_EMPTY is excluded: this driver fills the TX FIFO one byte at a
> + * time in response to STRCH_RD (clock-stretch during read phase), so
> + * TX_FIFO_EMPTY adds no value and would double the interrupt rate.
> + * GCA (general call address) is unsupported.
> + */
> +#define QCOM_I2C_TARGET_ALL_IRQ	(GENMASK(RESTART_DETECTED, STOP_DETECTED) \
> +				 & ~(BIT(GCA_DETECTED) | BIT(TX_FIFO_EMPTY)))
> +
> +/* Bit indices for the status bitmask, used with set_bit/test_bit/clear_bit */
> +enum qcom_i2c_target_status {
> +	READ_IN_PROGRESS,
> +	WRITE_IN_PROGRESS,
> +};
> +
> +/**
> + * struct qcom_i2c_target - Qualcomm I2C target controller private data
> + * @dev:		driver model device node
> + * @base:		base address of HW registers
> + * @adap:		I2C adapter (slave mode)
> + * @ahb_clk:		AHB bus clock
> + * @xo_clk:		XO reference clock
> + * @icc_path:		interconnect bandwidth path
> + * @slave:		currently registered slave backend client; written only
> + *			under disable_irq() in reg_slave()/unreg_slave() so the
> + *			ISR sees a stable pointer for its entire execution
> + * @status:		bitmask of enum qcom_i2c_target_status flags; must be
> + *			unsigned long for set_bit/test_bit/clear_bit; accessed
> + *			only from the ISR and from reg_slave()/unreg_slave()
> + *			under disable_irq(), so no additional lock is needed
> + * @irq:		interrupt line number
> + */
> +struct qcom_i2c_target {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct i2c_adapter	adap;
> +	struct clk		*ahb_clk;
> +	struct clk		*xo_clk;
> +	struct icc_path		*icc_path;
> +	struct i2c_client	*slave;
> +	unsigned long		status;
> +	int			irq;
> +};
> +
> +static void qcom_i2c_target_dump_regs(struct qcom_i2c_target *target)
> +{
> +	dev_dbg(target->dev, "I2C_S_DEVICE_ADDR:               0x%x\n",
> +		readl_relaxed(target->base + I2C_S_DEVICE_ADDR));
> +	dev_dbg(target->dev, "I2C_S_IRQ_STATUS:                0x%x\n",
> +		readl_relaxed(target->base + I2C_S_IRQ_STATUS));
> +	dev_dbg(target->dev, "I2C_S_CONFIG:                    0x%x\n",
> +		readl_relaxed(target->base + I2C_S_CONFIG));
> +	dev_dbg(target->dev, "I2C_S_IRQ_EN:                    0x%x\n",
> +		readl_relaxed(target->base + I2C_S_IRQ_EN));
> +	dev_dbg(target->dev, "I2C_S_FIFOS_STATUS:              0x%x\n",
> +		readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
> +	dev_dbg(target->dev, "I2C_S_DEBUG_REG1:                0x%x\n",
> +		readl_relaxed(target->base + I2C_S_DEBUG_REG1));
> +	dev_dbg(target->dev, "I2C_S_DEBUG_REG2:                0x%x\n",
> +		readl_relaxed(target->base + I2C_S_DEBUG_REG2));
> +	dev_dbg(target->dev, "I2C_S_CLK_LOW_TIMEOUT:           0x%x\n",
> +		readl_relaxed(target->base + I2C_S_CLK_LOW_TIMEOUT));
> +	dev_dbg(target->dev, "I2C_S_CLK_RELEASE_DELAY_CNT_VAL: 0x%x\n",
> +		readl_relaxed(target->base + I2C_S_CLK_RELEASE_DELAY_CNT_VAL));
> +	dev_dbg(target->dev, "I2C_S_SDA_HOLD_CNT_VAL:          0x%x\n",
> +		readl_relaxed(target->base + I2C_S_SDA_HOLD_CNT_VAL));
> +}
> +
> +static void qcom_i2c_target_hw_init(struct qcom_i2c_target *target)
> +{
> +	dev_dbg(target->dev, "HW init: resetting FIFOs, enabling IRQs\n");
> +	writel(CLEAR_TX_FIFO | CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
> +	writel(QCOM_I2C_TARGET_ALL_IRQ, target->base + I2C_S_IRQ_EN);
> +}
> +
> +static void qcom_i2c_target_write_requested(struct qcom_i2c_target *target)
> +{
> +	u8 val = 0;
> +
> +	if (!test_and_set_bit(WRITE_IN_PROGRESS, &target->status)) {
> +		dev_dbg(target->dev, "Write phase started\n");
> +		i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
> +	}
> +}
> +
> +static int qcom_i2c_target_drain_rx_fifo(struct qcom_i2c_target *target)
> +{
> +	unsigned int rx_count;
> +	int ret = 0;
> +	u8 val;
> +
> +	while (!ret) {
> +		rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
> +				     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
> +		if (!rx_count)
> +			break;
> +
> +		while (rx_count--) {
> +			val = (u8)readl_relaxed(target->base + I2C_S_RX_FIFO);
> +			dev_dbg(target->dev, "Data from RX FIFO: 0x%x\n", val);
> +			ret = i2c_slave_event(target->slave, I2C_SLAVE_WRITE_RECEIVED, &val);
> +			if (ret)
> +				break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
> +{
> +	/* Clear error bits before SW_RESET; the reset may not be instantaneous */
> +	writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
> +	       target->base + I2C_S_IRQ_CLR);
> +	writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);

line space > +	/*
> +	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
> +	 * Use a conservative delay to allow the reset to finish before
> +	 * reconfiguring the controller.
> +	 */
> +	usleep_range(10, 20);
> +	qcom_i2c_target_hw_init(target);
> +	writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
> +	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
> +}
> +
> +static irqreturn_t qcom_i2c_target_handle_error(struct qcom_i2c_target *target,
> +						u32 irq_stat)
> +{
> +	u8 val = 0;
> +
> +	if (irq_stat & BIT(ERR_CONDITION))
> +		dev_err(target->dev, "Error condition: unexpected Start/Stop bits\n");
> +	else
> +		dev_err(target->dev, "Clock low timeout\n");
> +	qcom_i2c_target_dump_regs(target);
> +	qcom_i2c_target_hw_reset(target);
> +	i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
> +	target->status = 0;
line space before return> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t qcom_i2c_target_handle_stop(struct qcom_i2c_target *target,
> +					       u32 irq_stat)
> +{
> +	u8 val = 0;
> +
> +	dev_dbg(target->dev, "Stop bit detected\n");
> +	/*
> +	 * Short-write corner case: WRITE_IN_PROGRESS was never set because
> +	 * no RX_DATA_AVAIL or STRCH_WR fired before STOP. Do not call
> +	 * qcom_i2c_target_write_requested() here — STOP ends the transaction
> +	 * so setting WRITE_IN_PROGRESS now would leave a stale bit after
> +	 * target->status is cleared below.
> +	 */
> +	if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {
> +		unsigned int rx_count;
> +
> +		rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
> +				     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
> +		if (rx_count)
> +			i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED,
> +					&val);
> +	}
minor as cleanup: give a line space > + 
qcom_i2c_target_drain_rx_fifo(target);
> +	i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
> +	target->status = 0;
> +	writel(CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
> +	/*
> +	 * STOP terminates the transaction, so any other Rx or clock
> +	 * stretch bits latched in this same status read have already
> +	 * been serviced by the drain above or are now stale. Ack the
> +	 * whole word rather than just STOP_DETECTED; clearing only STOP
> +	 * would leave those bits set and immediately re-enter the
> +	 * handler, which for a co-asserted STRCH_RD would push a stale
> +	 * byte into the TX FIFO.
> +	 */
> +	writel(irq_stat, target->base + I2C_S_IRQ_CLR);

give a line space before returning.> +	return IRQ_HANDLED;
> +}
> +
> +static void qcom_i2c_target_handle_rx_data(struct qcom_i2c_target *target,
> +					   u32 rx_irq_bits)
> +{
> +	int ret;
> +
> +	dev_dbg(target->dev, "Rx data event (rx_irq_bits=0x%x)\n", rx_irq_bits);
> +	qcom_i2c_target_write_requested(target);
> +	ret = qcom_i2c_target_drain_rx_fifo(target);
> +	if (ret)
> +		dev_dbg(target->dev, "Backend requested NACK\n");
line space for neat> +	writel(ret ? NACK | CLEAR_RX_FIFO : ACK_RESUME,
> +	       target->base + I2C_S_CONTROL);
> +	writel(rx_irq_bits, target->base + I2C_S_IRQ_CLR);
> +}
> +
> +static void qcom_i2c_target_handle_strch_rd(struct qcom_i2c_target *target)
> +{
> +	enum i2c_slave_event event = I2C_SLAVE_READ_PROCESSED;
> +	u8 val = 0;
> +
> +	dev_dbg(target->dev, "Clock stretching during read (Tx) phase\n");
> +	if (!test_and_set_bit(READ_IN_PROGRESS, &target->status)) {
> +		/* Repeated-start: master switched direction from write to read */
> +		clear_bit(WRITE_IN_PROGRESS, &target->status);
> +		event = I2C_SLAVE_READ_REQUESTED;
> +	}
line space> +	i2c_slave_event(target->slave, event, &val);
> +	dev_dbg(target->dev, "Data to TX FIFO: 0x%x\n", val);
> +	writel(val, target->base + I2C_S_TX_FIFO);
> +	writel(ACK_RESUME, target->base + I2C_S_CONTROL);
> +	writel(BIT(STRCH_RD), target->base + I2C_S_IRQ_CLR);
> +}
> +
> +static irqreturn_t qcom_i2c_target_irq(int irq, void *dev)
> +{
> +	struct qcom_i2c_target *target = dev;
> +	u32 irq_stat, rx_bits;
> +
> +	/*
> +	 * Dispatch priority (highest first):
> +	 *   ERR_CONDITION / CLOCK_LOW_TIMEOUT  — hardware error, triggers SW reset
> +	 *   STOP_DETECTED                      — end of transaction, clears all state
> +	 *   RESTART_DETECTED                   — repeated start, resets state before
> +	 *                                        any data phase in the same snapshot
> +	 *   STRCH_RD                           — read-phase data supply
> +	 *   RX_FIFO_FULL / RX_DATA_AVAIL /
> +	 *   STRCH_WR                           — write-phase Rx, coalesced into one drain
> +	 */
> +	irq_stat = readl_relaxed(target->base + I2C_S_IRQ_STATUS);
> +	if (!irq_stat)
> +		return IRQ_NONE;
> +
> +	dev_dbg(target->dev, "IRQ status: 0x%x\n", irq_stat);
> +
> +	/*
> +	 * Load target->slave once. Both reg_slave() and unreg_slave() disable
> +	 * the IRQ before writing the pointer, so it cannot change while this
> +	 * handler runs. Sub-handlers may dereference target->slave directly.
> +	 *
> +	 * The core is enabled only in reg_slave() and disabled in unreg_slave(),
> +	 * so no bus activity is expected here. Clear and discard any stale IRQ.
> +	 */
> +	if (!READ_ONCE(target->slave)) {
> +		writel(irq_stat, target->base + I2C_S_IRQ_CLR);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (irq_stat & (BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT)))
> +		return qcom_i2c_target_handle_error(target, irq_stat);
> +
> +	if (irq_stat & BIT(STOP_DETECTED))
> +		return qcom_i2c_target_handle_stop(target, irq_stat);
> +
> +	if (irq_stat & BIT(RESTART_DETECTED)) {
> +		dev_dbg(target->dev, "Repeated start bit detected\n");
> +		target->status = 0;
> +		writel(ACK_RESUME, target->base + I2C_S_CONTROL);
> +		writel(BIT(RESTART_DETECTED), target->base + I2C_S_IRQ_CLR);
> +	}
> +
> +	if (irq_stat & BIT(STRCH_RD))
> +		qcom_i2c_target_handle_strch_rd(target);
> +
> +	/*
> +	 * Coalesce all write-phase Rx bits into a single drain+ACK. When the
> +	 * RX FIFO fills at threshold, RX_FIFO_FULL, RX_DATA_AVAIL and STRCH_WR
> +	 * can all assert in the same irq_stat snapshot. Pass the combined mask
> +	 * so ACK_RESUME is written exactly once and all bits are cleared together.
> +	 */
> +	rx_bits = irq_stat & (BIT(RX_FIFO_FULL) | BIT(RX_DATA_AVAIL) |
> +			      BIT(STRCH_WR));
> +	if (rx_bits)
> +		qcom_i2c_target_handle_rx_data(target, rx_bits);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int qcom_i2c_target_reg_slave(struct i2c_client *slave)
> +{
> +	struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
> +
> +	if (target->slave)
> +		return -EBUSY;
> +
> +	if (slave->flags & I2C_CLIENT_TEN)
> +		return -EAFNOSUPPORT;
> +
> +	disable_irq(target->irq);
> +	WRITE_ONCE(target->slave, slave);
> +	writel(slave->addr, target->base + I2C_S_DEVICE_ADDR);
> +	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
> +	enable_irq(target->irq);
> +
> +	return 0;
> +}
> +
> +static int qcom_i2c_target_unreg_slave(struct i2c_client *slave)
> +{
> +	struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
> +
> +	if (!target->slave)
> +		return -EINVAL;
minor comment: line space > +	disable_irq(target->irq);
> +	writel(0, target->base + I2C_S_CONFIG);
> +	WRITE_ONCE(target->slave, NULL);
> +	target->status = 0;
> +	writel(0, target->base + I2C_S_DEVICE_ADDR);
> +	enable_irq(target->irq);
> +
> +	return 0;
> +}
> +
> +static int qcom_i2c_target_icc_init(struct qcom_i2c_target *target)
> +{
> +	int ret;
> +
> +	target->icc_path = devm_of_icc_get(target->dev, NULL);
> +	if (IS_ERR(target->icc_path))
> +		return dev_err_probe(target->dev, PTR_ERR(target->icc_path),
> +				     "failed to get ICC path\n");
> +
> +	/*
> +	 * The controller only needs interconnect bandwidth while it is
> +	 * powered. The vote is placed here and across resume with
> +	 * icc_set_bw(), and dropped with icc_set_bw(path, 0, 0) on suspend
> +	 * and remove, so the vote and unvote are always symmetric.
> +	 */
> +	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
> +			 APPS_PROC_TO_I2C_TARGET_VOTE);
> +	if (ret)
> +		return dev_err_probe(target->dev, ret, "icc_set_bw failed\n");
> +
> +	return 0;
> +}
> +
> +static u32 qcom_i2c_target_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SLAVE;
> +}
> +
> +static const struct i2c_algorithm qcom_i2c_target_algo = {
> +	.reg_target	= qcom_i2c_target_reg_slave,
> +	.unreg_target	= qcom_i2c_target_unreg_slave,
> +	.functionality	= qcom_i2c_target_func,
> +};
> +
> +static int qcom_i2c_target_adap_init(struct qcom_i2c_target *target)
> +{
> +	target->adap.algo = &qcom_i2c_target_algo;
> +	target->adap.dev.parent = target->dev;
> +	target->adap.dev.of_node = target->dev->of_node;
> +	strscpy(target->adap.name, "qcom-i2c-target",
> +		sizeof(target->adap.name));
> +	i2c_set_adapdata(&target->adap, target);
> +
> +	return i2c_add_adapter(&target->adap);
> +}
> +
> +static int qcom_i2c_target_probe(struct platform_device *pdev)
> +{
> +	struct qcom_i2c_target *target;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	target = devm_kzalloc(dev, sizeof(*target), GFP_KERNEL);
> +	if (!target)
> +		return -ENOMEM;
> +
> +	target->dev = dev;
> +
> +	target->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(target->base))
> +		return dev_err_probe(dev, PTR_ERR(target->base),
> +				     "failed to map registers\n");
> +
> +	target->xo_clk = devm_clk_get(dev, "xo");
> +	if (IS_ERR(target->xo_clk))
> +		return dev_err_probe(dev, PTR_ERR(target->xo_clk),
> +				     "failed to get XO clock\n");
> +
> +	target->ahb_clk = devm_clk_get(dev, "ahb");
> +	if (IS_ERR(target->ahb_clk))
> +		return dev_err_probe(dev, PTR_ERR(target->ahb_clk),
> +				     "failed to get AHB clock\n");
> +
> +	ret = clk_prepare_enable(target->xo_clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable XO clock\n");
> +
> +	ret = clk_prepare_enable(target->ahb_clk);
> +	if (ret) {
> +		clk_disable_unprepare(target->xo_clk);
> +		return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
> +	}
> +
> +	target->irq = platform_get_irq(pdev, 0);
> +	if (target->irq < 0)
> +		return target->irq;
> +
> +	ret = qcom_i2c_target_icc_init(target);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0,
> +			       dev_name(dev), target);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request_irq failed for IRQ %d\n",
> +				     target->irq);
> +
> +	qcom_i2c_target_hw_init(target);
> +
> +	platform_set_drvdata(pdev, target);
> +
> +	ret = qcom_i2c_target_adap_init(target);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "i2c_add_adapter failed\n");
> +
> +	return 0;
> +}
> +
> +static void qcom_i2c_target_remove(struct platform_device *pdev)
> +{
> +	struct qcom_i2c_target *target = platform_get_drvdata(pdev);
> +
> +	writel(0, target->base + I2C_S_CONFIG);
> +	i2c_del_adapter(&target->adap);
> +	icc_set_bw(target->icc_path, 0, 0);
> +	clk_disable_unprepare(target->xo_clk);
> +	clk_disable_unprepare(target->ahb_clk);
> +}
> +
> +static int qcom_i2c_target_suspend(struct device *dev)
> +{
> +	struct qcom_i2c_target *target = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = icc_set_bw(target->icc_path, 0, 0);
> +	if (ret)
> +		dev_err(dev, "icc_set_bw failed on suspend: %d\n", ret);
> +
> +	clk_disable_unprepare(target->xo_clk);
> +	clk_disable_unprepare(target->ahb_clk);
> +
> +	return 0;
> +}
> +
> +static int qcom_i2c_target_resume(struct device *dev)
> +{
> +	struct qcom_i2c_target *target = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(target->ahb_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable AHB clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(target->xo_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable XO clock\n");
> +		goto err_disable_ahb;
> +	}
> +
> +	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
> +			 APPS_PROC_TO_I2C_TARGET_VOTE);
> +	if (ret) {
> +		dev_err(dev, "icc_set_bw failed\n");
> +		goto err_disable_xo;
> +	}
> +
> +	qcom_i2c_target_hw_init(target);
> +	target->status = 0;
if the status is 0 here after target init, what about other places ? 
does it need to change status ? OR is it inherent to framework ?

Any comment can be help while changing status ?> +	if (target->slave) {
> +		writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
> +		writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
> +	}
> +
> +	return 0;
> +
> +err_disable_xo:
> +	clk_disable_unprepare(target->xo_clk);
> +err_disable_ahb:
> +	clk_disable_unprepare(target->ahb_clk);
line space before return> +	return ret;
> +}
> +
> +static const struct dev_pm_ops qcom_i2c_target_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_i2c_target_suspend,
> +				      qcom_i2c_target_resume)
> +};
> +

can we also add reason here to add NOIRQ callbacks ? My generic question 
would be why not system PM or Runtime PM callbacks ?
This will help later stage for any futurstic changes.

> +static const struct of_device_id qcom_i2c_target_dt_match[] = {
> +	{ .compatible = "qcom,qdu1000-i2c-target" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_i2c_target_dt_match);
> +
> +static struct platform_driver qcom_i2c_target_driver = {
> +	.driver = {
> +		.name		= "qcom-i2c-target",
> +		.pm		= &qcom_i2c_target_pm_ops,
> +		.of_match_table	= qcom_i2c_target_dt_match,
> +	},
> +	.probe	= qcom_i2c_target_probe,
> +	.remove	= qcom_i2c_target_remove,
> +};
> +module_platform_driver(qcom_i2c_target_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm I2C target controller driver");
> +MODULE_AUTHOR("Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>");
> +MODULE_LICENSE("GPL");
> 

