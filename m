Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9C366055
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352633; cv=none; b=KwP52GzadmENVAUtRWKxgEePxlkvo/xiyt9J9z36f2pVd8om5hnPEB0ZpC9N+5d5G/QpEsyWN8JDxp1uKuTcAUu1sHD3KfOYm6fWYcHyqP5taPPAtqNdP9ermCZ26ttPXiQxfVpJH85tAEoEmNRBfZjaA/2diOCb12qJxfogccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352633; c=relaxed/simple;
	bh=/aRY/vb3/hIBTIMJYLxhoggrOSD5XZpzRvD5IEGaQ84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDpJ9w5Ye7U5K5XFxobvU9Lyi8FZR26Kl8R6jPUQuz10SPHX65KbLD02yghR2uPUokuGsLBVZ39hz+stalNKH7invmp0BhPGcJQHb7KaUIDUf9a0dKXRyVmNYY0hYQU2S+pCbdaN9s1+dhhC+tFnysIlQnKhiTkWx4izYht2vXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHrTiXeE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ult06zW4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHrTiXeE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ult06zW4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2T0iu3815926
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=; b=oHrTiXeEYw0WRHRT
	0JryuBJBVPGqSxjyOTxM5WpWR6iIX+t5Ehvvw7Ijy/GBhhIDg6CRp4j3QlEKLHrd
	+T96al+7FsYIjjP2jU6FOexSof2OZMQ8rNPgA0pbm1sVXGeUZU2LmQlLaiX36fx3
	MG+nBBELBSvdKBlncwtRnvz10SEQ3fEi44Jsy2GFv/ny2/9kv77+p55hQ3FGnrzQ
	IKaYfJHP4+j/gv2GVgK5+Euq6Esk471OF7JFruDCfx2cLtA7CQELRBGCRGfJBFlZ
	KngEWPif/BD7w3A+cd5xrKALQ79BP1Zurh4FsssoVkSxxz+bgCaXm7XUBHfW97zx
	+2sblA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9saa19h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-515224a8aa0so96277701cf.0
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352630; x=1779957430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
        b=Ult06zW4HVLp8XwVxMFM/dMUx+/NdTDIB/xJQ96L4q5ETDlTIujP5d7zTOwu0Vo8mQ
         wlOXujXvYcixyGI2AvY1qCbPPlsbcUbdBMS2wHUFRlQ4u+fdKJIxqHjEJGpBN7lcTHUz
         +QubifqY8VLV8xvuq45rDlWQD6FlzZUs1JIXs2B0m0BD9kMm09vA6S9ddxpXoCUxhxTK
         NbZciLIzp9O3ypns4X6lzJ0oRrKsPj/S7eHTjVk5jRTDf5zZRRpSA+Rq4iQhfZsffEHM
         WDwA4nm8YdE+pbHwydll6kKMxJzgx0n2uet/eFPBic+dzkvxXnLbxGzZc3Z9O++L293X
         BqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352630; x=1779957430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukktCil6qFV5J1LkkLCVMIGTbGIgPkyHII6gX5uRxIU=;
        b=HJ/p6HomJY0ZENNp3OWHMl8+qTy9yXpajHvayoS0fuCZFxFgseSzDcrup5+1/pbe/Y
         PdaV6Z8azLqadQ48r1pOxpnOge3HVwHD4nB8A+2GVojYUyddpJCL9HrAnICtddQwjp0n
         9k7hE9021ezAyexYzY0MHNqfya5uO/kPYGsBnHv6cuOsldNxe7OOERkZVwl5D2p2DFqz
         0h0aHSbVJnV8B+qB4EIsGbYScT41NA0CohFcYwybpQ0gJ03Oo98xob+lo2XCtpUUewSq
         5EjitUEWp9n62wDqYwMPWUFBHB766A8LlITKliRlN2avqbkuQ0N/YVNJ7Lu+M9vmquiQ
         BXXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QCKHtwb0cIPu1Jt7ffcp19QNODBHHwhkEIyH34KbWb/gW7yGDG6pzlWsm9sYMiWKmY/yQ63plwSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF9vreirbKCNAYrmmC7A2mz7J1DqMigF8vX8aL2mMWJGphKZEF
	ZB3uFhoyqtOCJnA8nTEGzpAuQRJVenO/BSWH24GA62y1IpVFNmqqNmI0NbdTuGo+AMG7tFF6b/j
	zZ9TjqREZoP+5xu9UtXzdhrdfGAxDmon2WbPBb/f53YJdtj349Svpm8Qi76wIz/4=
X-Gm-Gg: Acq92OGwq1giHZvuL2S6xH/OgjSAQ6KfslYUVQvPxHWqweZoV6E/FFYPr7//VHezKuv
	UmOlydnRESHjM+hAt0lz3j3FO6Cdh+GHLrvFZos43bnB+TBKV0VcgsKT/TH6X3k9w/zzEyhRjk7
	p3D4rLijKl6i6jnxNV9DTMRFz/S1dMzXsA3xvghGFYffIeBJ1+KPyxDOZcxn3xpUW4hJcZge5V2
	FnG569iowy0qmfm7GdTzbvfK00Jw5m7S/pwTWwIon3ZNnzH7hLPlhKH8ieX12zpANxPNZpNh1uH
	4weoG2/gRsb2Kpon7BuuhZPxvj8RXhP0Mr2CUOyS6XhvdNdyRodPU+4JgohGLD16C4HzHJJeTIu
	nHfoDYEFi6ss6wrjSVpO8BWmKwpzo6Fwt6M1hZjhHZYGrY+KOdlo=
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id d75a77b69052e-516c5477e17mr25148221cf.13.1779352630349;
        Thu, 21 May 2026 01:37:10 -0700 (PDT)
X-Received: by 2002:ac8:5f47:0:b0:50f:bcfe:e8e0 with SMTP id d75a77b69052e-516c5477e17mr25147771cf.13.1779352629775;
        Thu, 21 May 2026 01:37:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:09 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:24 +0200
Subject: [PATCH 01/23] mfd: tps6586x: fix OF node refcount
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-1-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/aRY/vb3/hIBTIMJYLxhoggrOSD5XZpzRvD5IEGaQ84=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQdlJ6Gw9yankDCBt9FSOgN2Xq2huOUHVWq2
 3Mrh55a7QuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EHQAKCRAFnS7L/zaE
 w8nQD/4loqIyi5npUB0pcQ0If2+y1OYKJ5I3fRWNoD+DI2qAw7RvRg8s8P8r3CAXndoCmybnGcM
 5m1IEHBWc6qOHq0mh/OkumNuSy1hZr2x107TEzMLDEBT9H1M+UZPMvVEe/aPC79WmowHUUF9TuQ
 GP5vrZ4LpMcgS4O084BJEASA5nzY7uelq72L6TarvzcMxyS5TjdWC6urxNMBWCi8R8jZzxGqvRA
 QLmH/AE/4+uNzpnvf0hKdeOVPd6gbvE0i6b80v+PHjuoXIi/p1jUehPLgdPjIZdjebdM2TlVbq/
 P+9OrZKLw4SE+WRjUcN+UTnJ9tUAy0e3et+WqqPo3jUL89kKacqheQ1e2WkNXwGyi4uVuDNHzDN
 EvguWALMcMSEtupOOdXvE7nDWlVjqiY+3PMQILeq7NqMN/sFl6eCYnlTfomjSu+m/Em7L8Wq1ZD
 tFuwrfOg2BDxS7mr/FYdjg8+gBUNSZIL7MNlfzoXNWRl0rfwXF4Z8tdBbpD/g0zNTdhf5OZgAls
 IYx3BCJ1rkEwyphre8P9P953xIKshhJ4v9FpWul23QHiCYgcx00qs38wMQFaQ+tcpndPkewXAjf
 F/6YGVrg7Nc4nlGb9xf9H82vk+Y3HR5kALW1hO/kymu1NlKKvAubzUwld/OTrCD9MzeUjTa2CC3
 KvJGbKuQmkv3QvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX1n2LG6fBPjpb
 82VGZIktkFKDPcpsMKi/5LKeRA2D9O7sKcGvBPf2boUYouc91ix6BAO/vVP3bz6YbImf9kcZPmv
 I0eulAGo8ZrQLJHJsKhQ5LG2dTB0Ft6HpbOdUf8XjAsi42u12+isrwkoNy/3uG/xp87YOLxhGL9
 ign4cyv477cOgna+VYa+O3USaErS+HeF7tIPekctD3pLaMKdw4eTpuenxx5o8MGtyQhHdxUgLIi
 lpDPPZZXf756D6PzUbJf1+mSpAhCVd6cTJj0+CHJciXayo8SPzmbbNeFzHvNqiXFfas6IsZvLJC
 G7qF/finLX8DN+ZfaEErBIFnQq/+pM1hObs516q/o9kqoqzMFluid22lONI7CJckQRSygBTbSYe
 RBDoSsMfpxMKBZbCbVRfFHqsWywV76t2cM8j7/EOxT9fT3ehifmGyfX21ZVrFVsocpDL/vlB9YV
 ZlvSriCZxY9DR8bHSKw==
X-Authority-Analysis: v=2.4 cv=Qe9WeMbv c=1 sm=1 tr=0 ts=6a0ec437 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=4gvjGX-radYMG0rQGxsA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ItG1K7UdL-C2uTa1OzzxfN2xYssGE_6g
X-Proofpoint-GUID: ItG1K7UdL-C2uTa1OzzxfN2xYssGE_6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210083

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 62f6b0879304 ("tps6586x: Add device tree support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/mfd/tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8d5fe2b60bfa550d0aad30acd0820fac354028ac..f5f805446603315ba76ce1fc501c908f1cec0d16 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -397,7 +397,7 @@ static int tps6586x_add_subdevs(struct tps6586x *tps6586x,
 
 		pdev->dev.parent = tps6586x->dev;
 		pdev->dev.platform_data = subdev->platform_data;
-		pdev->dev.of_node = subdev->of_node;
+		pdev->dev.of_node = of_node_get(subdev->of_node);
 
 		ret = platform_device_add(pdev);
 		if (ret) {

-- 
2.47.3

