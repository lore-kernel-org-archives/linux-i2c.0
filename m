Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9578C4BCAAE
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341927; cv=none; b=pvUHEeovYmQlUiy+A53nuGhjDQ762ybWvRDQOGoJgTPh/+X/UQ2qBNM+GqEQWX6PRFOKrJDGn7+02htCo4qVmU9nbl1KP7n5eIHVhttvsGd2t1Nu7CN1/GrdZ3apNBLyOHWg6SNxeG9nEPXXYl23eKHNJLDO/SOARJkLtQQoFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341927; c=relaxed/simple;
	bh=6rZCe/y2D+a9YrBo7o44HEaRO/K53E+00VjO92+29A8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGERyEdKqkbm3yJ6jsi46CwVqR0rnukYAQa3848lynVO7rwKYPAKIMwl85v6AF19Nt2G7XDqVErV7GZIZGd57UgnXvdYWd3QqrME/mlCtvotU4g/6JHo4BdYCF4SUURm+Zkdw0yMo0VDUCHvGxPMaCkQNTxeBjVt0xr7PiOrXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a9nGmkj7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b3nIYnMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a9nGmkj7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3nIYnMY"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxPKB174990
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 12:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xl89k/DVW/7Z5ZCZ0MfgdfeY7qOMrXozhfna0OAi74Y=; b=a9nGmkj784flMoWo
	nlKDw8oMF+f2NfnRndN3+dZK88CW/gRhqy/CF50Haqk143r8bBMiDmKMu4SsVtTJ
	JqRxsX/BvCSiWsJvNyWg3st2ohyg760/41Uz1k0Srb2HbopSvNxu6pOv0OaB5K+I
	4uCMM1F9+Prtbl/F7/vwUeslmBjrfxxhAtTMWAxI2r7PSpQSvLEV8h+t1EAB5Wfw
	H6gZRSu6PVH1kQ+/H/1UgtqRMwirgBgGE3rTfctlD07zovPLGyBUEE6zjhNroxkL
	6krnr/WfWomJ3jWUjR6rnlZP8NRu1grRW5qBkb60Sr0uPQMVjU95lg3j9GL0etUi
	MTbyWQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxs970-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 12:45:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e73fc29bfso429124585a.1
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341910; x=1783946710; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xl89k/DVW/7Z5ZCZ0MfgdfeY7qOMrXozhfna0OAi74Y=;
        b=b3nIYnMYKYnYtgoCrLdqFoqTy1uyv1ZwpNlji2FXSEjqBgXkFke0rrCVUhlaOQPbb7
         ezyHHlaEzK1XinBZE/8CD3QCkAZ/IXo0gvAQ0EpMCHxrecITCWDN8v2pwuuKwxxEBdQ3
         7iiODW2ANQpdwWLw9gYyAMaJR9LMGGMwg/HKJpKWn+aoK1HAqgyKarxtLUevgNNEFlKN
         4p+u+ZtloA4X5vVC+8L6b7NXoQsdOu7CgVFiPJmbdHLQdML5PsAa4AvTQ7hoGpgkyPXG
         oqzthyxc0u7iIJxw2xj/kVhCHfQmxR8SEgSXUYbAc9aKEhbzge5z+AiSVTdrvQvB0WJO
         +8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341910; x=1783946710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xl89k/DVW/7Z5ZCZ0MfgdfeY7qOMrXozhfna0OAi74Y=;
        b=h5CuuxeRnXPV5ooLSYEEkLwz169cZRA8+vLij29pknFbr3P/343gsPuMylWfxYgjhJ
         6JDc1F6pqksCrCDC78fHg+tHDzdTiACPAi2mAgn0/h1zW0HTp8md/tKPYgNlJGB0U2D+
         ffnGCR2TxgArUbIDC3SPRJiRx0fK6Bu26DDC1mnvjnfDfIoU0NudobQtlrnjyUTHSqmw
         b/lV+FP6u4DkpWATqIaCk+mRlze0oQ809kbHSftLzpuOylbDsfehIrLVha7pblqW2RVl
         eBIcEBfzFcbYbi8YhNhnfOkhUqZDC9/8WIN00JrbD9BlpZf/4cafOdZyA8bYEQ7j0b7T
         blEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9LKvAXr2hKQZN8nZ4J7hfRomD2FfL5TmrZZx/StuF4eDdpUPxNnBe3Fznd/djHhReLtwJFT+zhcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKwy+zdcYjUYrrkwa3FtNLRkbcdwOBZBLZj0FEsHCH8oGnFAp
	CNIshFHu/4dDyoSsrObPFh52j8iChHqebdR+6kYm6UCSIH/LefTOY2vQ+oO226Fp5JG5C9GL0CC
	+QwTQ6xNyToFn84V8XjU0ei2skAJYqkQAnOvw6yaTC6DdIrzqObN3ANMS3FejhUY=
X-Gm-Gg: AfdE7clX27ZNs0ctDRx4s+1xWOjbMLBaDWCTsCzR/+PQz0HCz769Noe5xa7R/OrN+bX
	rXULL8SKi3xPx2PzOqVGRp5g/Qrg3suKJ/CzlKrH/+BXp8BjE8FJEu7Jcg686krS+Z+cmGlgXVL
	4ben8Tg0twDDHOQSp4INwW86qKrrhWeKKlq1rzeMajd1U3pHl2vN0dvxs0bOqDP2iF2Co3xNcZv
	AkelsBeIvszRYC9bp6blllkjQqZDGy0MaPvzxeJy2+r6UvYuxmBP1zK7JoacW8qUllJCnagVav3
	wM3w/+vbZx3ddETikQEexc07JpjISyeHgqklabGMxx9cBBRBIBLXWnIm2Dppqc4L5J1XE4oUl70
	cHg7ff/4CqSg0ADMFiJ8BE/w2wUuaIYJGK9enolIW
X-Received: by 2002:a05:620a:6888:b0:915:4211:baa1 with SMTP id af79cd13be357-92ebb514d03mr45488785a.33.1783341908960;
        Mon, 06 Jul 2026 05:45:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6888:b0:915:4211:baa1 with SMTP id af79cd13be357-92ebb514d03mr45480385a.33.1783341908161;
        Mon, 06 Jul 2026 05:45:08 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:18 +0200
Subject: [PATCH v3 06/20] of: platform: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-6-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
In-Reply-To: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
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
        mfd@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6rZCe/y2D+a9YrBo7o44HEaRO/K53E+00VjO92+29A8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6MzbEKkoY7zHwdHh1nhL7+KUq6bmwPT/0qpN
 3KEErC5TPeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujMwAKCRAFnS7L/zaE
 w60EEACTZsP51kWnjlnO2jdIFQ7rVOfzFGs6vreWn5WZ/mLyIg9up5SCC/v1gGODbvvSYMfrpPm
 Ad1NgJk61lE4Uat3YIah8N/690VRcsB8TdioMaFx8Y507jYHNEaWoY88xEeK0CJ4Mwike6XPjOR
 GEO5nxlIQw9xvALF8fVuc8iaZTOixQX/ObFGe7Cs2CT7+t8RLsF+Vxm0rGC8QVHfxBQTI8GfgLs
 WHKZ7rFwOFnGNa+BbflSlCxSvtd0M/BxMgc6OM70xU0/uHmP+w5qVUUYk1RNOONSyK+8Gqf/M8t
 +qNGS/XhygjkdGCarvI58e1YP2vFOezVdRt5CV9xA0gqIAKViiNYuOcbF7EdfSKGVzL+aM83HVn
 IB2+oUWPmEglBLJUHCHjCS5ZrCwk0j2/2SWTJhkvp9/5G9keP0q3kdVub06bMDW+1mOjw3j4CgI
 E1deH3qz7a10c7gmtthQqcIkdsGpqVgLKi8G/nsA9i/5VkNcLM9yCKpo1lQ+UWH1cYYetKLY8Mx
 961OZ+RmlwG9djjwf5eDpCQxOakUVoDX2RnGxJzOuTkKwEH8RxMxuwwM9l+Ml+7i/bsnScdRX9N
 Iqy3R+yve8htINya0Mxi38Q1JZfJ/lWL8CdNpHdWyO8KCAgK3PTqQlKGkyjmPLRj458OO2fr0ta
 Mo9Bsbw78owdeyQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: n_hGxHzb5WS-mE7msdUMln_HyeXh3mvp
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4ba357 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Jb7EFCjKRuSTjX4XlnwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX9n8ZIyCLHiKr
 /61OCKPnsMzAulgbOE376NTyWBa2jjtZ9VrpCReEO2O8e49Fvg2gJOakQIf0nWL5MTvWanSL5nG
 4s2/81fXdCjxWUA7LwXZoO6pm/2Hmxo=
X-Proofpoint-GUID: n_hGxHzb5WS-mE7msdUMln_HyeXh3mvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX882BbggRyxls
 qPjR3LattLNbsM6LhJP/MUxPDjipzkrWpCeiElXdMateyEdPL58uH8LWom7ngJF9sgp+aqqLqwY
 PYE9SBbAn/qFMwmFbt4f2SJ9cA3Z+LGFdElTMeZ4pkL6nZrWgmHXH1GRfgoB790L7Hx+qbYIqXN
 whHPDNBJk7oTvnEIZo4PZZa6jiEcoN1tM2yCf7kkdkmPEQH17ZhSw7fTb3JNoDSZTQftGxMaoXI
 6m8lCFVeWvAnHFHwvT4AEahw2E+OaYV81/45Eh714bIz22hiozCTdgiYcO4pIIhP18AaoKl3ct1
 T9nDBB6og+zZR+qvyuCnh8Ih7pUj+TZrd8VM48Che4Uq/uv2ESLZs8w3r4ZpD//LfMvJ45QPnzW
 liQVt3FycfetJ9dts1QPv2Z4W0ImzTGHW08NmwMbZfIs3Q/fJD6Cu3CsJMj9tQa095WYerMXRWb
 I2Lqwi6Jjjh1dKtSFJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 53bca8c6f7810ce2235b4d084a361626b1d2da33..8b1e7640778253492c080085b4015e1423389d83 100644
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

