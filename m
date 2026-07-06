Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042114314B3
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341940; cv=none; b=mfzoptkFZPjup22yoRT2FnUL5K4sSQdOkzVAD2D0Q39BpZCvQkK3F0QSgmM+uFLSI8F0AI8ZurdU0iYff1Pc7tEot5ace3AuoKKx1qPm3TT7ZB9rwltLBIpHy4FYMA5Bz9WKy5hyR17vmi2WX7gV4jcA7J5XVjQiddh5B37zpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341940; c=relaxed/simple;
	bh=NdHbJPjvsu2u7F3hdYrPvFRlBpPy98KniXg8xIhSKCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ph1xoHWS7pJ1i458MsN/0zw9ec1F5zGXk/T+7cUakX7SKS5WcCSOryHpjdjY2dkntAQYDy/LtW1e0bzjuLrO8DSuhRLkO9ulT3VltfD3cAELXMx2Ka484Qn1VrB8tB2eWADlMj5wpsq947CPuHCLINUi0n/0BQhJIyR9beK97AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUx5BzmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W/xxKhTt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUx5BzmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/xxKhTt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxVQF402246
	for <linux-i2c@vger.kernel.org>; Mon, 6 Jul 2026 12:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=; b=GUx5BzmGdeI3Evy4
	TAdA/IjbYevjVSOOVEM/jHBANLO/MzvCLIDPyIiN9HGOV3lzrtsxDYh2CWy24aEK
	e5pwxDyUvASqAikj67tpYkJEHSqpVZx3/eXDlvj8KZ4YJmq04TuS4yBAg4Qm/eRM
	ZEODUiB8+by0n15kbnlqjOE9269w5Ym9DK32zJnFCj0bqmMBm70riK2KGmEZoCu8
	JkOkwNLn1fuC88jPUs0mvgPD+1NSV/SEeU+G8k2TrSp+bpuv33JoNGSTFOPm26k0
	myU/VmbL6eCNFjIuinle8aMsQaDP1VEBKYV0quH0XkvrWv1IekNPOEs/A387VrsR
	n2AyQg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3grm2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 12:45:34 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e63df032bso328950285a.0
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jul 2026 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783341933; x=1783946733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
        b=W/xxKhTtQrNrmSVK8gPzwLzTHOiTtjTkQq01dH1LjU3+tAB2N2sKjqpienwhBepvqf
         rgljMNHFobpfTwrVn0OvpdIuCTupp+MoRMuafPTgGOdii/THENeSNlslXXvpt87P+9/y
         zeeZyrwUuUDBPAX4XjZxHzXSDL13CFg0By6Ts/u17xnxxZcW2vAPZnuoHq5uYmu1NEnm
         ADGJLR6ACphQdCqwU7RXp9NRH1T4SO0zgmkdDmr96UYHm4R7yn88P9Bc/U/361FIZXKi
         cxDKgNlWuWTTnF69SeTRUOFryW7fVCi0URnEBBo3DWWRQEh6xcTQc1ifmcUG8etXd/RJ
         ui4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341933; x=1783946733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POK9tIxGCiwp0V/tTMSRyw6r6KDPw5Ng8BAFX9Ifcc0=;
        b=dNmiSSX4XTqMAgzjnH7l/SRbXWBMloHT12FSwAiwedcbYDRncs/FaWzN78JQGsF8+0
         2ciPaih/j/ITp2RhSxExDRukXvaOj5sH1DFrevm0FYF6VXWmG/Yu73paCx5vkpM1jpok
         1IIGhNT08HLZjWgQbOjztzjHx5J3Tc1LMSGA88+CKCDZkKtmX5Pa3fjQtE55R3+Vj09Y
         /a18FAayNB+qyYzPoAJfnBZY9QTSyuXHA6qO/d1dn9S3u9NcKzqV4OYCPVkF4zh50qh1
         MgiVIhFm7cjs3yyql/RdpbaeIRwJiC7F6hnYK7bbKSk4ONgdQYSqUCP8qYBCc0RhEtz/
         0omQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRXsUY7PEtVTVEI1OcfKYAsWotukWg4f64lwfy5P2biHubER0MQ6kEofe8nIyQbRC5O3G2QbTU84w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrw2JtyVR5eABYLjf7gf4wAQ6qoo7Rbd9kWNDWXnPBKWqyqpEg
	lq2Z/aoCh4TZnde0OlMpwKGlb7LVWymxaD3frpT3KfYcVVKJjMcuJOkKcx5I9422+XAFlBMh84t
	3d1lZpHwxpju6Po5V54ToG8Z9dLncnkJKHRyszhtco5CfvwTsoV/EJpnVM+C7BRE=
X-Gm-Gg: AfdE7clF21drDFFZESuj1eOJ4DZTy04ya8YZvPFem6tBRRqIOrV+83vluVZ2KBUypYp
	Qlc/y9vb38+TWl07y3NL8WD6GeD0PoBNgdJE0tzZOSsCk5kgPltISe4/SjDdFDw2APHNl8Gaa2z
	+6bcnyNp8DB5ZMlzKtP7fr7jRexM0rBmbIKymR/PGg2JVlUV/RG6y1y6T/a+QbBx/zBYobN63ij
	jw9rG/7qY7k/1sm2GAm0unoPBcRscRUzuwA9f+uOJ1W1BPOyVkzXzxoBVbOfL4FKVGOHcYfZYJN
	ZpY9+5W4mLsOh9QcNe7h+lGT3vE763elGlTr5Qd6ur/Wlr7KyiUcdH6YJ9jsEEPb+uypwlk43BB
	EfnZcMuOdoz0dpxQwbj0AEg5MWtHVZXbTjXQB1yuC
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id af79cd13be357-92e9c9bae7bmr762472785a.18.1783341933202;
        Mon, 06 Jul 2026 05:45:33 -0700 (PDT)
X-Received: by 2002:a05:620a:630a:20b0:915:9eb1:f08a with SMTP id af79cd13be357-92e9c9bae7bmr762466885a.18.1783341932688;
        Mon, 06 Jul 2026 05:45:32 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm22126539f8f.31.2026.07.06.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:45:31 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 14:44:26 +0200
Subject: [PATCH v3 14/20] net: mv643xx: use platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-pdev-fwnode-ref-v3-14-1ff028e33779@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NdHbJPjvsu2u7F3hdYrPvFRlBpPy98KniXg8xIhSKCg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS6M6kp8yOiB9vvJ5zjdHbWe6Po7/EnS4ga+ev
 hCyTVpoxO+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakujOgAKCRAFnS7L/zaE
 ww7dD/0amg46FTyYgYW8LYZgcSVagN2XNs/hYCpCDsj0WIQWByz3JPvcwF61FhdVtvUFuUYV+eg
 X7P9kb9yoTHoN1zMJCWDP0kdPaf12F5JdaMy+qsgjzl2P2MgGwuqQQML8cdGlCndeIvBfZzo7nO
 9qijrM7bVX71vT/EpqOJHbzX5gMZmLrDW9GuxO5m4CIjxHImLkOcRCikfjxnV8hepAxrK1AMx6R
 Mc6flJ2X5DdAi7Cru+Q+uLRr4o4JKNA7AxDT5X6V7Ns88ytfrTL5oV6D2eulc/QkqAYGEtknJw6
 chwScCFvjEXtvO9lO7ahl3qlNLbLc+YlVO1T4bKSi285G+axZpIEKet3oauOfTFCM/saAVEif4M
 KuvsN9jfwcJ0xXMRvreW//zyuhY8LNwY3Qn55M1FVhdMhR15xLP9t3gOyKyxu8id1cdmortkJpD
 qrpspj/OgEujquTmIu1nsViAjjB0bI1BWn7odOKePTyRWnujpCUPRgGD9GE6y5D1J3d2h2us/s3
 C+UML2ty3Ar0TmOdfF8nD81xCWgHBwz96BBI0ipfe0fz1VLXXim6Z24Z8Tpg6aFGf6ilHkampD5
 kfVoicCCwzU+89dyn7GdpnULRhUez+rKMA82vKy1zopgY/6h3TvBwUmDbFlk6k9PYM2h/XaSG9p
 jy0y60D4DWCJRkg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: --VU42YHsLdUbTbRNxyd_-70uTmgkW_y
X-Proofpoint-ORIG-GUID: --VU42YHsLdUbTbRNxyd_-70uTmgkW_y
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4ba36e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=KA_NOx0aAURzDPfFvPsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfX2E2lo/V9NrRA
 hwtGZAapjyLvi+PGzI33P+YIewWGhxXL2AhJalLxP32/MXZRWlkpkk+GE+F+nMeDMl5qT9UhYKu
 Ewtkjb+T2+qbA2iqqFi8akuOPpsJ9SMmhlEYreVwCh1OJFW4VmNwFf+MwoYlDuJn7TOiEFiiwsL
 /2XgmK68TIy+WivGk4N/q3X8JpzV5WmMMxBPSDrdbSqh2mC2RQCUzAa2V8tuhKG+elDGGo1dh23
 g4YYw/pY8Kk8JeP+GjbY6XQQ1zXMIztP2wUv8hmQoEwW9tk7Bp6SF/hO22i/AxH+INdQ1nm6Zru
 oyaBaGoTv+i7Ziw7qUrdK06oxD3y++/exi7rT5998GpXRqRUU9CfWaOVgOozyox0mdIPnb6P1D/
 nlqEa6Irg6tHSs8z/8EYiG7J/J2dvby+wjPn8kzxd8jl7IjYg7EWvfSmpUlesabkPBBcDFHlGfx
 ePmSwniMZBX4JfaYwdw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyOSBTYWx0ZWRfXx64YNUqkZxal
 QudOUJbjeVvnAOf6G1IcQUkM/NUtihbsg0pPu3H1QcsLihIwKJi2t4ZZnG6SG+jJG+q/ErfiwWx
 JpbbmNBWEW5RHUEdJh2Bx8kg7x/3CeU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060129

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 1881583be5ce2e972fceb14c2b8348280c49ad1d..9caa1e47c174c9d7a161b7f2e2ee12a829b813d4 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2780,7 +2780,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 		goto put_err;
 	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-	ppdev->dev.of_node = of_node_get(pnp);
+	platform_device_set_of_node(ppdev, pnp);
 
 	ret = platform_device_add_resources(ppdev, &res, 1);
 	if (ret)

-- 
2.47.3

