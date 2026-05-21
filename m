Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D13B101D
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352661; cv=none; b=i2NzgXQosxX6V/A5wFBRajMqqfGf0GPH4u5TeBSZkoeCEIwZ3EtsniLX1qntsW3ufOpQvg1mPNGRL6EY7a7kRpCd7pwqPH2LSnPGDZLeZID463Z5SsQquV5hJVWNqOX8GHs56j1/Behf0ZND20JiwgH2Y459mdfP0r8EX4qZUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352661; c=relaxed/simple;
	bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgQdBteXMBzVOGjNFu9Guk63hZ8+FOBnWri1SZdfdIBuU05cq1ppNwAg5TaQLi1vfYaiBCMR4RSEuIoKhsHd3gDFXzL615Htiopplg6H4bdY7BVBfYknwSLxxoVkvCyf9Qk1aqVcj3cjg6ebvL2JwC1Q5X53AQbRsZoGM5zlkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wx0mkrfh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S541eTz1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wx0mkrfh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S541eTz1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L8V7Ip748454
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=; b=Wx0mkrfhTR25R2CR
	P19rj34FWn9V7nFvEfRskX2RWdvrWsW1njjrnxOrV/EhPy3AZr/lBeiimxCLDs+u
	IvefMDwBXsucLiZrWeC3atAcK7tXPEKVXMmJ4Nu/9snsAU+7uZdGmON+ofOmgpK0
	WO1RCTJ11flpN+fzXzevrwr/Z3XDSRoOkYyINb6plIMdZqx3juYxIFE/7fD6O4KK
	r+8sRezB6kVXkXTd2sh7wG3GEfPxaiqpsX2h9VwexfrfY1lrJ2CU6NL6wHOIZbRd
	3u8kPyV7Qyk2R2UHNkvKTnwsaZCdUtQLADvT9TPpntLC8xoYJj9rguVoTpLjy3Ff
	Aza/Ug==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kj8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 08:37:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516879bf1a7so158281571cf.1
        for <linux-i2c@vger.kernel.org>; Thu, 21 May 2026 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352655; x=1779957455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=S541eTz1z5f11REOnKuCdHBWcAHxjoxLbUAHqDvnMnpKy3wbK8AzB3+gwHKpYODDon
         NSnpMZFiWR6hD2AZwVpikjb5TPMEM7Sq42bbZltAiHCe7CzyOP9R/7zLotMYSYJx/qOC
         STuOI28d/bm7YcQt/KLONESGOldVw1t+yioN5CsCl65FJIMQxYLHE07W2Tw53xrbdvOH
         9PTveTl2MhrVcjEyhNh+HhTnatLDXdUptUTwm7evW/xFWEiI1ePtrfHprHp546Zsk5PJ
         mIhwDK6GF0NCa1OnKD8ByRPqkqZ3MailbI312nPWh50isM0YUHKbjaqTDV7TnqbuU27R
         LFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352655; x=1779957455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5cAewiO2Q2GR7KlmQQdZOQuEhoEBjBTz5dtw0Vf2kkM=;
        b=ArfgeIIwtb6cY76UPPt5kGR/1a31zw3jAqwfUFqnzr1btKjR3++Vz06BMct8ETbgpJ
         AXYEhoVlN/oZBf8Y/HQKTnnYfZndiARy0bVtg1XFhsev5xqpe8lJK2eJArF3IXjTSoL+
         sMnGrCgF8fmNO1kQXmL/tw+HNrvvy3DBMELLNM/uLvXDCEl6o5MULUguV5b0/lGP0Wew
         V0bVuZl+3WKnT+UDxPES+/dy2WqWliGB5SQAwOEURMfpeaFX0AnAcv9TcZObn0dxQk0e
         FVDH9rWVVT8pnW9i+RZ5D7WpSjrCr+f3Iw6piuD8Awucx5/OuWRbT6XsHyFxdXQZ1hXY
         AHtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pDDTzF8flklamryanvLSKuCd43OagGLUReDCavlnEE6eiZ8p50UN9DACjIv6ry648BsKjZB259rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwhnt0TQBW6qDf7BOyibwXPk5VPQq9bj2b9vusi2LX5wqpAXn9
	2M8Md2xL4IihEwjQ/mNCinwgcInjIeKipSYDUyqxNsKdMyvT/PosFhyhqaKruLGxGAoUaFsLfXP
	G3y1tnqUR/1HXMTgQLZiNGGkhfh8XworNkMeKKq7eBKE38Bn27jYR8t8wBU4NPBI=
X-Gm-Gg: Acq92OE5ah9fFSzFVD9oUxKfjHP/alDa4pBemj8y1QpOj1hsQlzMhh0uiUbJ+OER1LM
	7kqqOxb7J9eQV6f1g5tGujezzC3kpnS5qiTpnDeDzEeh95BpKUs23cUIlQRbrLnZ1GguLRCk6pQ
	8AoeoS5mb3FwkNURkKtr2CYEkn+N3AjlilCrORZgYV9lobNVS9i67sihC0s4o8PS56Y2kl0e/YI
	XU2IZ8NWYrI2NrptoihlYuI4Fu7UqFAvnQ0vlJjKMJxt8/A7PGydcePe4kfdHLnk/muAfObmxSJ
	0kjkI6jAY0p5Tv9AZaWHHDNsSeNOuCR62RDO+nno2xe8IIZDPbC4X2WTbZYAybH+tPpRE3QKe22
	xOS+8LGMr4LpQ4lgkqe6JHTn9xY+lEs9keTtw4Xeu9fumaFQBR5E=
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1393591cf.39.1779352654927;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
X-Received: by 2002:a05:622a:558f:b0:516:cd8d:c7fa with SMTP id d75a77b69052e-516cd8dcb16mr1392831cf.39.1779352654276;
        Thu, 21 May 2026 01:37:34 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:32 +0200
Subject: [PATCH 09/23] of: platform: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-9-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=877;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=62Oz1SbeAMwV4fv895oAqyFh69nhboZTNIz+xPLsUyA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQmchZFDFTztRU29nkcmIf2nW/nwlzDTpQz8
 +2keRMrA/6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EJgAKCRAFnS7L/zaE
 wxw/EACn8eHQOwjd+Dgeolnl1EcseWe/xGk5I4KpBP1p2m+G11f9vLsOUXBOPZGZSyzUPO47NAC
 iyozeeVO+OH2RpEvb/3X3MbeIb+N7xCFhIXoBy9dHt8TFTc2eZb0zdOcQaQ7HwDPqPAsbDyDPAa
 tScifI1XmoBcqV9V1S5KHZLhhWr1TPVqyUBvQJBVFTDr9Dgc4IxSYyYTSp4oxZAseFDlwBM3oMv
 trGKhh+xWYBpqycF8F3nEAvyJKUpMT1WskDUb1hehpfJpEVsb7kEOzTj7zGh9PP3osTLQB1dDAu
 k93V0oRYboHvSnoLrZOA0OfqTfGPC94giWuIlDQxQBJ1QYipOf/9/bJ8EwDeKu9NiKwsunEwdwv
 ZDsejl4PufjMEpJ7PptHLqO1X/ktVBTcRplnmlTo53Vs9em3L/5kSW//1XptpJg5MHQKstiGNhT
 JwXkhQKxsEWHTU8bBlJ/KnCl5YeVz4bAiwE5K3LMZGTXxaPrKNPQE2a7OgCcqKI7GJZN+MbaSR5
 iRRE4GsITdqUI+V0a9GmZFcR/ACxIhFigTivLDROyYp52uEEBqs41OjLaek/Tn/8+GAbu/+LBlq
 9u9KFLbmZmj68Q+6ZlZNIN+DZ4GjJ1qCQlnSFJk++NQiAZCIzxiS7FBUV7Sc4R1rjga7Eoru04k
 30fJtzl/FkuS5GA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec44f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: GgvV-lrwlB3dE0Kfoq2X-tqzLMgQDP64
X-Proofpoint-GUID: GgvV-lrwlB3dE0Kfoq2X-tqzLMgQDP64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX/iOcC+5ky2H1
 8CCCuuLAtx2sBaZZkNU8iwM23wbkbLwsM6EiW6lPIQdMVlrp50ifHYRT604lg2/BKn4Waa2pbjj
 HX0QVJu/WZLOym7PNF4yJLxDiNuM5g5SZhe6/qGKkWzrwMjDEJrM/y1+ljTEweZuoxplhGB4Nng
 Rmo3+mDqPbTWdk1QPZVKHYbntXQ/Ew54RT6VE6Nt3J60AAIKs9oqtNmQByeaIsz3FeOWl2P6Di6
 IXYZ1FZyGb/fB2+kvRWgZ7pPd04XQ3DdNVKoTiGRcM5Hpynpy/+PAcihp19HFt9b7bAQuCl0bTu
 yRADcvbQ3GqAdjRcLar1jJzV5J4B+5rLC+nocCKa2aTqNTltT66lBEIp1NU509fr5ULpxHWtqc5
 ++6v9h0jJakyeZY9SgRlZGFyaNHKX33iqJ4jIjUDijwvce8R18MOEgpDfIC2LNlUifZ6wM64073
 Tq6t/acIn0CJYrM185w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index a42224f9d1a888a6e6cad7534cd2c5f110e995da..db45d1e99bf9b027548aac3a15bf754b3c023161 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -126,7 +126,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(of_node_get(np)));
+	platform_device_set_of_node(dev, np);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)

-- 
2.47.3

