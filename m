Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F595137923
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837570; cv=none; b=H43ZllnJF70fu2hRcPUHzWFzn/fxsxVgSwsML/ppyjJbqetyCWNlDux/R9J6E27/ibcPCwni8rl1BnXFlGp/aspkuhstUwsG7HU4zBEFJR9KjNu+dBlMxlzYntNGL+eeAC5qhLQAmddkmAwtk5R6o1OCqEpw9voWFsVAkwAybeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837570; c=relaxed/simple;
	bh=w5QiyKZ/sytBbiuy/pPV3fyHy9AlIC8Mm/XcZ8uxqD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvGfZouSgv32pE7hVUZdxtJR9KjE0Ngn7kYCdR2ujLWp2K/mCfeDv3oCoCtY2tQwLGc02KqUB2QshKtPrZiT1rBVmMZcpfv79IoGskSTiBhFhr8EzAp9xULJGxgtDDZ/UNR29VznaRrPz4hak/2xnqGQBwQueuU15KM3pBVCsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ahskkLVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rqr6Mx56; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahskkLVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rqr6Mx56"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MJj5Bn2425433
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PO5AtSucKAso++k1EL0+rR2+HTJk9Mvc5WVuDOn4oE=; b=ahskkLVjml4qs9Rs
	abCFDBueRJNKtfpxcsZThuGyOucLq3meLgxH0ube6aVttmNU36suWaOf44Bv2nQQ
	1pfOdalqzdw3RfKy++ZA/7fzftLPvTlNshwRP2387r+aukqiXBCG9y6hee3cY+nN
	Sk1V7J6kgBT9xOjGEIrrtzUqQHo/rGA9QeAUArWMdsojv2ZNB59Iy0HOMSf8qeDF
	Iskx/NWnpwlizui7cHAx9aLM9oogcOA6rth7ibovhjsGOQObyv6Z1msX7oSOjdiB
	U5tTLVDtTA3ostC7ZtJ5jyp75duyFqgqkPVr8iwxurCyrQEUqe59XxHCPXDqcrXG
	MgPrHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv3ee-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 09:06:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb3b6b37d8so3776729185a.3
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 01:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771837567; x=1772442367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PO5AtSucKAso++k1EL0+rR2+HTJk9Mvc5WVuDOn4oE=;
        b=Rqr6Mx56LbiLjCYmRzojvIjzN68+ZjInxDHwMp6x3I88vn1YysEMx2RnX2BM+B6NyI
         P+yu8jgLWDqDxsS3uTlI/MWfOmkKXpqqz4DkJivI6/SIk/9O33HtWJXk8QLJOJwn+Rv3
         /k4jcFkefvTSv6tJaiMBUn5/llMMgOycf0rfEjt5hz76qLLP6kYfTj3DMLPC3x567Oru
         RN63UIOxMsGmJ9sdnB/56oRaJdrIs6K8evLTkFfkuFJyEi7XMY3ULOmwypA9x7GlI+M2
         trCbQEnQIyevzK8VzfGF9wkigZnza4+REXaWS1RqfhBmISDX571RFrzEwLqYgL+rO5K2
         2fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771837567; x=1772442367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PO5AtSucKAso++k1EL0+rR2+HTJk9Mvc5WVuDOn4oE=;
        b=nL8LNFikagHFH3BEozqabhZi22IbJS0DkVIbmez7gn1wZzj6+0UD/gKz60ixe6Ox70
         Q/BKtaSArojETJdJXGUUid5zPSb92zFxhdhgCj0bfTGep2RIGRbK5S/G9mmd/UCph/Zs
         1A0VgzbpDrEqOfKYyau+tgOicxiF3S6YrDdFGWgA2Roc8TPXWPWzgpyQI94y1MdqStsK
         PNnvKVZCOEDyL5TaeF4XB/jbmr/Iq9lqLg8UbmUZ7JFPcbOsJlNiM2fGHOg/TiGoRjfJ
         +qBOGlGpECnnJfsmbL/nhoyKqO0gKJjTZJUJ3sQPjjqfGMvU1NwahTX+t3UVGmd/LISl
         /jUA==
X-Forwarded-Encrypted: i=1; AJvYcCUwKCCMrSKd9nQVh+b6EBeUm8vhB5AWQ43TK1nzbWbaWe240H7rVnjMZo+YyGMDmR7Fzd/YZEb4Fb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJoCxVKWRV0MjLPh+I2BUViyXA6+5FdVt/W0IFlor8KKuL7tGP
	DK6gN2ZEHJAb2cqm0RBnqtm0rbPmR+94WhB4NmezyiKulnQdIAR51W4b98BetDuBNBc61muH/SI
	LjX/zfD9exrVDgYgmqompUpglfUJucUUm7hJQ3kLwqW6jRnzUCqSHdAA3VlxFxEs=
X-Gm-Gg: AZuq6aLOiaWTuyCyaff36H/O6sVI/gvnZoPhyj72A/vfK4fW/I+7HUKJ00AWjXSHDfn
	mgmtS3OFIVbWOrY0iHCmC+aaEQ8VaA977pCdDrnUOhYD2ytgC57CVPZP1KN2O7dNDmP64Fd9xH8
	VF/VsgXy5nawEeK6OpQ9IRLHZOgu+qp2v0MNwGtlBxju1k1inLIL8J/cek38x2+KgxXzrKyWezS
	DwBwGdtdKYd7l4cV+DtMUo+b5bnd0onF4chP+MwEUp8qVk4pVUUO25+V1drkBnBh4YWyEAoyQms
	IXT1PZ/eqQzrjqlK6fKJWgKHcgf2c9w0XHS7ZVNcpmhiNrOZLvTGHajPZaWw95f5WP9EYbtfORo
	6smzVdDioQ0sMvFOrNXh4J7WhubgcTwUNuRJzIsGW4/4giQyLcqzN
X-Received: by 2002:a05:620a:199b:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cb8ca94d09mr1041099685a.79.1771837567284;
        Mon, 23 Feb 2026 01:06:07 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:8c6:b14e:6569 with SMTP id af79cd13be357-8cb8ca94d09mr1041095585a.79.1771837566841;
        Mon, 23 Feb 2026 01:06:06 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bd71:422c:5e83:8b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9feasm17791593f8f.6.2026.02.23.01.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:06:06 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:05:47 +0100
Subject: [PATCH v2 01/12] i2c: allow setting the parent device and OF node
 through the adapter struct
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-adap-dev-config-v2-1-d78db0a6fcf7@oss.qualcomm.com>
References: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
In-Reply-To: <20260223-i2c-adap-dev-config-v2-0-d78db0a6fcf7@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Vignesh R <vigneshr@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=w5QiyKZ/sytBbiuy/pPV3fyHy9AlIC8Mm/XcZ8uxqD4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnBhwPaKoFJzyHUF6OMpnWGL6DX+ETQlRO5Y8c
 Ld6Qx2JUB6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZwYcAAKCRAFnS7L/zaE
 w/suD/4iFUyy0Dy49wTZDnpa2IU80l3NwdwALBtTFaokDwHgcweeaZLnFS+uMukTPoA6AdldIU6
 Xh4ZwjycC2TaenfGxYlTYVfa5ORU+p7HYVK0s6JQgqEhaXYdLLoxW2wC0VPADhBaNTKDgKjjyhu
 rmn5Has0Jd2hjrBY+aV96wRmo4/gieVqjUGAa1ClHeWOCy99MMh39cnk0y+MwKbQe24DIH0T/dq
 zQ3TSL8mqDXnKtnas9OqHTj0FEyC6uyiytZ+Zr4aezeellH2itHJzzI8Jy2y0BfRSkivHURH0xi
 VWmPtgxSeZs/nGjgUfAglbxQ7shfCBLe4jvM3sB+pwQIkucLvoYAmIsezdq4UrtRjy2Dq4iKvjz
 fCSlFthKTFiU/egqBN3hYrjM8ZxVkeT8PyTIf9ar4sQHLWHskPP2L+SGJjK6aEuVMorXFC3KMx/
 UxFIVf25usT/B/LO2Nj2evp9DYvPdMiOBLKKSP3O7zHjrYATLcdyDWew4Ps4033GbN7hK62/tgz
 3Q3aQrO1e/Vj2dQNHSETTjc0RefDW0cNSPbQbKoEpBbad4m1l6PsaVvZTw8px5OViT/l5ZKU6Ui
 J1+wlOaLdLrFzwfvmmWzxVt15PQWip1vRosoqASWqdOzpUvj2zAjxnzF7hszS1+6h31ZgPaMma8
 Iyx96xyVHty1QFw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4MSBTYWx0ZWRfX8u7LkrkpZgtG
 te7QA/MId4iQrcn0H0wvCtaJeoV9jhVB6bfkys554rQmaKTwHnodXB2KQJYFQ1zOpeeh/9r7eM9
 H4JDqr1AboRsK3inGiFdVA8rl7R4C6jLtTPUR1GaWhTdCOTA26drBMBYIwXPvE32EqZI6jPmv0F
 Mjm7trOouoCYKvp50Mi7n1I427MrhoAtSXmK+oQAzJzeSw55qMjtRL+3A+nzkz/Ifgm1eebeS3W
 CTLFJljYNWhsOfyQMgk7lYgHBq1MqjNREFcj0uGmdsIJqVxTc8/1+Eu9EpaVd7Sd3JynQN1zL1K
 /aWW7h3amT9x3QPPnzIlLQpqj6HHBzB/vCU+fssGgRfTIFYpx+EpL+mIiqz20YHM3b/LXDO0AAg
 +tzfL2NoIcPQDbDOHyZuW7YNygxDNZ6jg4bHX28PCQgE9emtsw+jmRfKw69fuU2ISOvl//KqeMg
 JP+NxfDEajCmrBmd5Pg==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c1880 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GqsknrqNkdw30Ab-NAsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: XMrse99jDtAr0hacen3_KQf4UzROCg5J
X-Proofpoint-ORIG-GUID: XMrse99jDtAr0hacen3_KQf4UzROCg5J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230081

In order to stop i2c bus drivers from dereferencing the struct device
embedded in struct i2c_adapter, let's allow configuring the parent
device and OF-node of the adapter directly through dedicated fields.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/i2c/i2c-core-base.c | 5 +++++
 include/linux/i2c.h         | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506d15d53b9b7d6b592709de56e41b9..dd8cec9b04c64b8340d20e018ab5ba28f1f7f5c9 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1561,6 +1561,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	if (!adap->dev.parent)
+		adap->dev.parent = adap->parent;
+	if (!adap->dev.of_node)
+		adap->dev.of_node = adap->of_node;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c85ee1665395c07345faafd8e2fca..72677f29aff161530bc3c497d1e07144a44eb9e4 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -761,6 +761,10 @@ struct i2c_adapter {
 	struct irq_domain *host_notify_domain;
 	struct regulator *bus_regulator;
 
+	/* Device configuration. */
+	struct device *parent;
+	struct device_node *of_node;
+
 	struct dentry *debugfs;
 
 	/* 7bit address space */

-- 
2.47.3

