Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381653F99FB
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724388; cv=none; b=Iur41oGEYlxzVlu6PCILQBJSGoSNkQ8rJ15M8fRKAAwlH52d74QZifIIELBxUNK620iWZgQkpoEtFTGk1/wBFGJmOX8oFZLE1iZ5+cQfZlSJ0OVcr9XQhcoGZ2zkzHHBNngVgS+dUeaChLQqrJr7OUIzdpWiJCr4HVU/y+EKv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724388; c=relaxed/simple;
	bh=dGc6l0sHyACFM3cxNlrW03xZ13Z1lTT+PlM/FFhNpQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNUVZgtV5dDogSk3rXY2UcakbF2CkTwImwNe9ew3Cp5U5gSmcW8oDGa3JohT6SArnYZq6OGAnlhBYu87xDUkKaO+LMC2xEQ+41XYxb9viuMEabDD6nJcQb0o6Bt2nViRHGuFrffaIl6coa8tC+WXBCWTHcvrM4v8uedC/WjHypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NsQ1+L/H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N+oVpNn1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NsQ1+L/H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+oVpNn1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8wY8i2391272
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 09:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M5i5ctxLVJhSZjko8lbhXGrG7Lp0ur4VIkT28ZThogg=; b=NsQ1+L/HzzKa/jbr
	PutaRtGLs/lqX0Hjoiy8VwvPfU0EngaJzRmdcnLjON5Ful8r9tnjj0g6HkOQ+3qw
	HUBxYxvfVQTfRrw+ZWuHVRQbsGZYp3AGMD1pI+2iIX0z30CONkJIPssq1xiHkRDQ
	b5yFfU3yxMkivv1ZJgpAd66upGERpF32Prjeof3PT0ZRZ1kzD6Whz22LolmanKDh
	KlnMVQPobtWOdkr+HLUURTTFpK35nsjTQQK2dMHJ+mUORwjHkvSZCCeK4p+yfTaT
	sjebXbTO4fbFiWzDEt8DPRM9X3Xlm3GpOGpiYNZYBhHBVwB8hdSPjW1nDSOAxM3p
	6Z1yow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw8208-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 09:13:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5740so139211885a.0
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724384; x=1783329184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5i5ctxLVJhSZjko8lbhXGrG7Lp0ur4VIkT28ZThogg=;
        b=N+oVpNn1ihJIHhgh54qaVitXNpdtKRtdX/uvWTYZ29ER30PLYd6NZQTui3R9CwBxUs
         T/p/oeyzLCXgKDCI8mt5raqJYp7Z6AlkmNC5w/LFhj3KqRDZhFBoPlAt25vSoP6YMK7u
         HB748nAEQIbDy9wWSh+xaburQ1JDZvL9MErT7PUTdcAkLVhB+Ul+mJWyDx7wOaisqbp/
         KhJejJ/Gnwy+E352LpMlC0djZ+LxAN3utv1KCV1DahTpf+jjg2+CpZiesn2bsibSqG5O
         Iq0ektolDbbhK9G7VFbT/V3ExetTU/wnjLV5+qRPGI62Pvn9hqNYuTSN2QttXQXi3EV8
         GGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724384; x=1783329184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5i5ctxLVJhSZjko8lbhXGrG7Lp0ur4VIkT28ZThogg=;
        b=XZ/1K0qcmPEuLQ0C474ceEfCv7kkx4T5oj+RvzotGEhGiw2CFS8DMVvsYADtBga+M9
         OmbM/gSEIvcuZYhb3GxlsYjYGJcK+cu/hMVye8Jtr9l0WFXQ7a8nDgnhUlI4r9yBqqck
         RULJajRXz9vu6CnZjCAf21uNvDTLwwex/Q0Nr+YtNzcDJ2V55eLPPOMlXkaOrsb06rC3
         PMXragvMUnGvaeFSiO0aCJosKc4kre/B0N/PGCGy/JcoeJJXbzDbobuy/sTRzmRm4bk1
         c1atSMFNOF7micGIO+XZCTq252rSCE/Bu59v0S4Z/U/FblN7eFfjuq1n50NqkctVXA+S
         j4Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8/Dln52MwvJxmMI+y8dQFzeWdESjRAwFN2dXnPjyh1aqQ9q/A0nmc8DP0RN6/4TSLuL0jvvP6eu6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rwVtsHsNmJik/EZCdPNzZ0i9Zo2mGk7ZSS2yF2Oqals5nZJO
	4njgf+Q97qyx/r/ilBuQIAKGMQPmF2d4mIHGAlBBgj7y3WmmHFRAOg9i/3YuJbTQXofyZk2gfS5
	Gu5Ev2G3v+N9k2TLR3RNiMIffynNo+wbvvT5EqrGWC4MEzwNU0a4v9qtq79TEBnU=
X-Gm-Gg: AfdE7cmiv5EptUuwjP97niFJl5YOUooflSP2XOLHXQ0DT9NPAA3Lb4UZ+dYX6bMgyIm
	del/TtGW8jtFFO0+Rz9qGegAOJjRK8fX5OdHo6+LVnKo55ZS+TXWW7qUrD+fACmtKbEAhq3j5QX
	2tUIyReUlkUdg4bY9mgByS9L2/Ek+jD+Bw347g3/LlLtQsdWOtKMH3SjMq/aJIrXK2D/YwZMp5Z
	UG6fCA7rUGNKnzbo9l6KljeJP81BSH486yA9P41OgBivzGvcHmi3q8U/mYR8RnJ0nrd/KTaLhLN
	0MYYefA0cOxOGxKssbRR/NA7G04GX1wwOmouK3gCWh1P4hvbe1xh37lSTcQaRcyrlspMJZ6rSZ2
	iT9nG/jVsmKBH+7kz6FxSUIbuPJroQKjW6EvfZ045
X-Received: by 2002:a05:620a:f0b:b0:915:87ad:d5b1 with SMTP id af79cd13be357-9293bb44956mr2587312185a.15.1782724384264;
        Mon, 29 Jun 2026 02:13:04 -0700 (PDT)
X-Received: by 2002:a05:620a:f0b:b0:915:87ad:d5b1 with SMTP id af79cd13be357-9293bb44956mr2587304685a.15.1782724383600;
        Mon, 29 Jun 2026 02:13:03 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:13:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:25 +0200
Subject: [PATCH v2 02/19] driver core: platform: provide
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2715;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dGc6l0sHyACFM3cxNlrW03xZ13Z1lTT+PlM/FFhNpQk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcH6bhLnzENX1KDtInjn8wNXEVpMzGG3K0/Y
 VfF5Qbu/KqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3BwAKCRAFnS7L/zaE
 w4YzD/4oZ/19j0EElAZKwXbz2OGnGHF3kpDRVJlSY4nTjKIU/q/5g4kAa7g7HgqD5/wTjxILTIW
 sQAeorU9mn+9EOVvNwHtxzokSU8k5EdcBHrnhZzLTnTiBB9JQPU8R4V0i4MpGDeIHmxDSzMQbKm
 1qvG48V6xMQvrq9cWgpJBLCcEgKgIbh2vT6IIGlWvQdjeXmMN4wjap6L+/BqoLyLPzFUEiK0NUz
 8rZFF3XmWxzgB/COKFdLQ+l1mfFdwqETFxCfKl7m/wlALdCPiZqlBan1LYtlxBacT16ZhkxcnWM
 n4DtiyUZW2YeD2ic8XqiqdXEIEdisXT2qT9CgrKqvFu9IHg3B2DkgC4nGN3lIdSJKeAQtnXNaQM
 bDQa2In+ALslR5euQObzgt4MUsT1uB7S+qcZwLK96ljTrOrdfJ5dPQLki/Di/npkZ7yHPwBblMy
 nu0OYE3AxVeX3Oe3klNK8TgKJ/ek6EsoOx2xGm9m/oNoMyZHZyN6rsJgnMYdDsqo+KsryX8cMGs
 MM081TDD+/Gt9QQtKLej1rmD3sbjoMMijsRWkX0PPZr8SVPUYTfi25heFzCCg3p0n6WDTVOoMdc
 xsZC4MFCIiH/aRsCNyUoEd1H3nEYdGmx1lbKlX5RztoZdgA+SPn1tasURA4uiJrB6mgL4GIJjpo
 Um6GSc3yn04pyLA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXzVjpFejMoJUu
 eF2eXA3F9IFJ0XyXayS8erB1FQ+F80ZwUDdZzX+60aPU+rKPEwcuKX2AoQj0RPTPOPQX2CWme7i
 vjdOYUGrDaSPJaSZtFHz6IIXN1H9qrY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfX+9bWrbLx4UK6
 4QnedHzVkaQvQ/7cGDOlirYlia6v9gceRdA6mqZyVDl3oq0MJ5LRqdwRZYGBKk2Dw7yPlWlz0p3
 JSmlIg1TUfmjQ9nm9QZRvcriJoN8AFy88u63kKj/4dG1epBXcYUgYTPhlq/j1z4JAZYu9UGR9C4
 VbIffbJz6VvErribPu81wORprODRtS+l5I6FPrezW2y8SK0mxctlfpzuMRjiYqTBBJ1FkY5FD/W
 l0rVdMXYHe2F4du3h3E5IWpGN/Gz1o2TtrCg3DCPqbdZXWfhSRCtZkseeMDqgHs769lAzcF5sL+
 PyUw5Zvk0ea41WoZ8bkZUOE9oFZ2gkoLDk0g2iDgDERBNUS2qDFg2XU0RD6j8yPkhJ1oV3TsR47
 sSrSKoCmzDYOlVPMmT6419s489+Ll7tnN4ctJ2OqLHlF1l6J+p6HHW3Go5mUpQpwgXRdpYX3LUi
 c4QWz4T7E+I8DH919VQ==
X-Proofpoint-GUID: ko3Tt0pbK57rAT7IVJ7VS3gXk-VJpAlj
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a423721 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Q8RKEeUEMY9O-VPP2I0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ko3Tt0pbK57rAT7IVJ7VS3gXk-VJpAlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290074

Encapsulate the reference counting logic for OF nodes assigned to
platform devices created with platform_device_alloc() in a helper
function. Make the kerneldoc state that this is the proper interface for
assigning OF nodes to dynamically allocated platform devices. This will
allow us to switch to counting the references of the device's firmware
nodes, not only the OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/platform.c         | 18 ++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index fb9120b0bcfe0e7dd9dfc0d29b91e0ad40a01440..3188d5aba5f90622f821c695049cacda030204fb 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -693,6 +693,24 @@ int platform_device_add_data(struct platform_device *pdev, const void *data,
 }
 EXPORT_SYMBOL_GPL(platform_device_add_data);
 
+/**
+ * platform_device_set_of_node - assign an OF node to device
+ * @pdev: platform device to add the node for
+ * @np: new device node
+ *
+ * Assign an OF node to this platform device. Internally keep track of the
+ * reference count. Devices created with platform_device_alloc() must use this
+ * function instead of assigning the node manually.
+ */
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np)
+{
+	of_node_put(pdev->dev.of_node);
+	pdev->dev.of_node = of_node_get(np);
+	pdev->dev.fwnode = of_fwnode_handle(np);
+}
+EXPORT_SYMBOL_GPL(platform_device_set_of_node);
+
 /**
  * platform_device_add - add a platform device to device hierarchy
  * @pdev: platform device we're adding
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 26e6a43358e25cce2e2c38245dc0f0fc43923bf5..870d168aeff8558749eae71723e657ab150ce0be 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -19,6 +19,7 @@ struct irq_affinity;
 struct mfd_cell;
 struct property_entry;
 struct platform_device_id;
+struct device_node;
 
 struct platform_device {
 	const char	*name;
@@ -262,6 +263,8 @@ extern int platform_device_add_resources(struct platform_device *pdev,
 					 unsigned int num);
 extern int platform_device_add_data(struct platform_device *pdev,
 				    const void *data, size_t size);
+void platform_device_set_of_node(struct platform_device *pdev,
+				 struct device_node *np);
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_del(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);

-- 
2.47.3

