Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756755;
	b=1Wc+o7TjxEILpeJJ+UAkRVuQ/y1LOVd654zzWA2+7jNrbdT+0Fa5e5nuulN1txGiYwP9
	 2MlALP6YDihdDbVSMvW+ETMOtK/pHoTqVoHt0yubcoecTj+t4+9CPzyvslVSyBXQHpY/e
	 zdyTvp1Mku5alp8JctlMb/ywWBnCKKZI0PgXeMut91c4yJZ0T76z5rqlhUerMmjsny4Xo
	 SJ9i8WQoD4V/vhmjw1iVbqBnYbxpbGyFRMwRB1nX7R6lqgPZLnX0aot/B8SFR7TB4KBUL
	 HBQFTErs7jYzlYXoy+AN5jNo42gPN1DxkzlWKIi0widJQnmUvzAYBuZ35+Ia6c8Hcbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756755;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=na6xSLnE3Pm8ngp1HS/VIQjflttDtqVqQqL2aDwuLBY=;
	b=mSZsCPLj1GeKIZhNj4wTL5QIhfIScp+pPsYybLDK2/X6gR7eTyqpHuu4E2Yn0E30ohN+
	 HB9fJp/hU3TJYacxfu7bsxMH/kYnTqZEX8Ss/vyPpJGVHQNsgOVlN4gP79tXwzpy8ZKq7
	 B9qLypdte4rs/xslYkydvz0ONln2FsjSrT7F+Fu59izQDDgVoZxleyQjlnU53IN7qkH92
	 nXJd4PAoujZ0vPIxBYy4dpXY7Y2xXuZtZUaZO1B4IXj1pTiKryPQGkOa5SuFUsxTanpEM
	 ZxgZZ0ji7iMMaLT29aWfnzPhvxfIdidDx7VdsK6QDg/lmkBcb+/EESxa1WMSzx3DqWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Koch2Aal;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dqXiNvpS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E3606A321
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9E3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Koch2Aal;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dqXiNvpS
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAATYx2164235
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	na6xSLnE3Pm8ngp1HS/VIQjflttDtqVqQqL2aDwuLBY=; b=Koch2Aal/g0tnV2H
	XlAFj5CvuGHn5/ZdQ9q3MbzgEoHnN1JPkpnfhqAeAmWstNwKkucHiTd/hguxbv1U
	jEvj1gJYDqUiCpjmNrMFAxwdqIWpyR97PoBgAT5l27vJGWdTK5Z9mLjQ6aN08vtP
	8Lwqvp4XCUhYgJ8MSLpij8RF3XJ0bdyEPDF4Il56ZCbEvdt2zIwrcxmSKwt9CQqU
	DS0lcS6oiUJgLMbj1X07yV7yk1YPEd8BHXXUQYGMk0/l0cTE6XY3KtwmLidxX7Jr
	2E1ZFKnV38ReDZQWAtzQwWcR1yEMSiCPRxH0WDG5EOzCpJ0YTObzch9W3dkRzxVf
	lUjwbg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahuyxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 11:59:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3692c5b061bso2429603eec.1
        for <linux-i2c@vger.kernel.org>; Fri, 23 Oct 2026 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792756753; x=1793361553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=na6xSLnE3Pm8ngp1HS/VIQjflttDtqVqQqL2aDwuLBY=;
        b=dqXiNvpSkUHYIQ3k3ueuZfDfV2sOUx/omvQlWTErSPhmdexk3MldJm6jiti/mcmpdQ
         ygTXFWy0C+gECbrcVSnxE2n4hrLiqymwgdwDOJncysDjtOoTNRZD258xLAWgG4Z/04vj
         /+W6XKa/g+hzHm9rQ1/GkgK3ewkF86wh3/6IA4zErWY1ivEuDmApi4P8ow4u8w3FUwt5
         0DmkTSN1N2O4H7hY2dF93qhjOI+z7WcFuz5X5svyxrxUR+X9pUo2e33FNTQGm4SIfFbV
         chJEKPj+NK6dvIy+9RPn4FWhvVkxXvNrFQ+QY+yXK5v/OWWLQfFsb6MB8H4HSg58vta6
         nViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792756753; x=1793361553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=na6xSLnE3Pm8ngp1HS/VIQjflttDtqVqQqL2aDwuLBY=;
        b=ytyRBgLEuql03nVw19flrNJTD68dQm1KUubjv+NAi4guaSxtS+Gai0Moa9J+X8s9oG
         wkgPOTCO3YahrpEdUfAZvdsyEZhdcJ0xyk4aIBc8YGvpKfJLE8OMFKu0ahwRMNmtWqX6
         7kF7ktifhWuPj9Rt89ic0CAaAMN8VFvsgzs83mfXJVTS7fk+cK4OJ0aqjeLM9Kq5RF3a
         uPG/HVfuqDcf2H57iUzbOS3p3oTPiFibmf5OuVLUnNhILJgaiKr5fWWF+eF2aA/B0Srj
         zjkqZl+eA0XdgPu0R+w1PLFyyjMWQGbmtM8TK9904K0kILUGNNfikDloSJr7tcFeJK1/
         kixg==
X-Forwarded-Encrypted: i=1; AKwUvBySfYtzLp3Rd7LutFMYavoXUC1icFaPFhCDAMLACr2unqPdce2BlFEB0p2guHsE5+t52Cgfc9hMnsc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvfN9y019PbAzPvLgqrF/CepulfWRcQD1vtN2N614tyJo2rMBM
	gL9FZpovyx7bXt7wuI6qEH/2rRrGpcmyRimWnNCvgZVZ0TI8+6tY8b+IaQicxAanQ/hEEn2/5Oh
	98ZHYu0d38jKDrqGKGcjMZbwie7yvnOWCQHdGUrwn9IDyDInPWeW/UifotfwgjjA=
X-Gm-Gg: AYBFou2LHaFkWoTLN9Ltk3OathFY1lODxBUfB7ux9LsWMKJES1938x8EXSEQXyQy0Js
	wqPwVu6osPvdBOeu8hArUMyEbpwxwN3JkDy0YkHN02slAcNrIApz9TOI42oZs2hqJqhALt4CNyO
	UFZWBfom7KZbTfy4/7xzcHWYGG2QAnt2EpmMpxJZhMBdUXYimRj3KwXiKIIAQxUYhJZRCytQhnd
	qMJIBwISGhJTB/OZvIp2NwPTP93N3WhlD1YuiiEtqn9Q96fu4/QxcrT5N9q38FgqDGOmCZFmlJU
	sP24sIf0GUPoT58+3bSLIe5pi8V/Y9ShCmswBZEVDckB4ngCS/rdpQLpISpQNRirNs+K9PWrH9G
	LpRONzVk40YtuXCvqRF0TrElAUxQaod7bUA==
X-Received: by 2002:a05:693c:4083:b0:367:414a:c8db with SMTP id 5a478bee46e88-369d975c6c1mr3066316eec.14.1792756752580;
        Fri, 23 Oct 2026 04:59:12 -0700 (PDT)
X-Received: by 2002:a05:693c:4083:b0:367:414a:c8db with SMTP id 5a478bee46e88-369d975c6c1mr3066266eec.14.1792756751838;
        Fri, 23 Oct 2026 04:59:11 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm8786134eec.5.2026.10.23.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:59:11 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:27:59 +0530
Subject: [PATCH v2 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-3-93572b453d6f@oss.qualcomm.com>
References: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
In-Reply-To: <20261023-20260826_aniket_randive_oss_qualcomm_com-v2-0-93572b453d6f@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792756735; l=6225;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=4XUqVRHPT/nOQcSpYQFNUSSQOV8f0erhy6EgBgADG/k=;
 b=yZ+JJUchkli5/Ca6hUN4VwPukd7U2SgSV7eE8lHilPsi2ArYFrtf94BQ3x+M0G1LrWm/qN/AS
 PiX6P1KQdZdDxtmq/oWim4sjAQDAGrzF65mhpk53xjTZeRVmT6QZsA2
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX6SowY3/ahBH6
 dZxq1ykXD2F9hfsbLZy7ThQJN1admcP7sHOIB9izuoQEwUsfMOvds3uPrC+maBNYSQjzHJkElrh
 MvuBIr7v58PKDa1WS82pT8x+SHh0SbY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX88ztO/5M6DU8
 gB1/5yeJ1LdFJeuO84hTQH2Z14171IHcXyHe0kdbwkterdndazaema7pN4hfEzL9TFIw+M+ZKSn
 NU1WDwdlJWWDTEUo82tKU7xacxTdDjecDYyEekiAPv8SPVcWGzqakjZvBPfJxKNOoIrXCZv11bQ
 s1WzuHj60m3V1UWPTGMZ4nm8/vC4WUx6gdiYqFeYfHDDoVOqzfmxHlIqolnwrV4uWtGNLXF7+ML
 OhZTkjCHmUiMbsRFcNc/lQkLZfXGoRrllSx6bvI07dFvpiaPdjlsI2pQsu7C8vVvj8eS/Lbl8Nl
 DrxdU+dJtn4ycxDARu72pTEoTKOgdkudtgMR9p3dA+pRjcV4MzRAyzoC2caP2AQqKvpmMwuWMWB
 WMBUI/CnShW5TuFoUGIIxOtECVar5hN3jFVU/u6IAycli8GePha7FJhag67/ZU1Gff9EmRKpMHC
 ZhuKs2942XMLqzA6Trg==
X-Proofpoint-GUID: 6NeQvDqyB8VEdr5hFNes69rXXXtUu2Tw
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb4c11 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tOGb6KSYT5r5fpq5OAUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 6NeQvDqyB8VEdr5hFNes69rXXXtUu2Tw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230046

I2C transfers in GPI DMA mode can fail with -EIO when a target holds
SDA low, leaving the bus stuck and preventing subsequent transactions.
The GPI completion callback reports a NACK and a genuine bus error
alike as -EIO, and the existing recovery path switches the SE to FIFO
mode which is not valid in GPI DMA mode.

Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
SDA and SCL are already released. Extend the recovery callback to dispatch
through the GPI DMA path when gi2c->gpi_mode is set.

Use the adapter timeout for both FIFO and GPI recovery commands, and
preserve the DMA configuration error code when GPI setup fails.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 104 ++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 065d7240de04..31f811bdc051 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1034,7 +1034,7 @@ static int geni_i2c_fifo_bus_cmd(struct geni_i2c_dev *gi2c, u32 cmd)
 	reinit_completion(&gi2c->done);
 
 	geni_se_setup_m_cmd(&gi2c->se, cmd, 0);
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left) {
 		dev_err(gi2c->se.dev, "timeout waiting for bus cmd %u\n", cmd);
 		geni_i2c_abort_xfer(gi2c);
@@ -1065,13 +1065,82 @@ static bool geni_i2c_needs_bus_recovery(struct geni_i2c_dev *gi2c, int ret)
 	 * -EPROTO and -ETIMEDOUT indicate bus errors where the target may be
 	 * holding a bus line low. ARB_LOST (-EAGAIN) on a single-controller
 	 * bus indicates a stuck target, not a real arbitration loss.
-	 * GPI DMA mode extends this trigger separately.
+	 * In GPI DMA mode the completion callback reports NACK, BUS_PROTO and
+	 * ARB_LOST alike as -EIO, so the SE_GENI_IOS I2C_BUS_FREE check
+	 * distinguishes a genuinely stuck bus from a benign NACK. Recovery is
+	 * skipped when both SDA and SCL are released (high) after the STOP.
 	 */
-	return !gi2c->gpi_mode &&
-	       (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN) &&
+	return (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN ||
+		(gi2c->gpi_mode && ret == -EIO)) &&
 	       !geni_i2c_bus_is_free(gi2c);
 }
 
+static int geni_i2c_gpi_bus_cmd(struct geni_i2c_dev *gi2c, enum i2c_op cmd)
+{
+	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
+	struct dma_async_tx_descriptor *desc;
+	struct gpi_i2c_config peripheral = {};
+	struct dma_slave_config config = {};
+	unsigned long time_left;
+	unsigned long flags;
+	dma_cookie_t cookie;
+	int ret;
+
+	config.peripheral_config = &peripheral;
+	config.peripheral_size = sizeof(peripheral);
+
+	peripheral.set_config  = 1;
+	peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
+	peripheral.cycle_count = itr->t_cycle_cnt;
+	peripheral.high_count  = itr->t_high_cnt;
+	peripheral.low_count   = itr->t_low_cnt;
+	peripheral.clk_div     = itr->clk_div;
+	peripheral.op          = cmd;
+
+	ret = dmaengine_slave_config(gi2c->tx_c, &config);
+	if (ret) {
+		dev_err(gi2c->se.dev, "dma config error %d for bus cmd %u\n", ret, cmd);
+		return ret;
+	}
+
+	desc = dmaengine_prep_slave_single(gi2c->tx_c, 0, 0, DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EIO;
+
+	desc->callback_result = i2c_gpi_cb_result;
+	desc->callback_param = gi2c;
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return -EIO;
+
+	/*
+	 * cur and err are shared with geni_i2c_irq() and the GPI callback
+	 * i2c_gpi_cb_result(); both write err (the IRQ handler under
+	 * gi2c->lock). Reset them under the lock before issuing the transfer.
+	 */
+	spin_lock_irqsave(&gi2c->lock, flags);
+	gi2c->cur = NULL;
+	gi2c->err = 0;
+	spin_unlock_irqrestore(&gi2c->lock, flags);
+	reinit_completion(&gi2c->done);
+	dma_async_issue_pending(gi2c->tx_c);
+
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
+	if (!time_left) {
+		dev_err(gi2c->se.dev, "timeout waiting for GPI bus cmd %u\n", cmd);
+		dmaengine_terminate_sync(gi2c->tx_c);
+		return -ETIMEDOUT;
+	}
+
+	/* ARB_LOST and BUS_PROTO may be expected during recovery; treat as success */
+	if (gi2c->err == -EAGAIN || gi2c->err == -EPROTO)
+		return 0;
+
+	return gi2c->err;
+}
+
 static int geni_i2c_recover_bus(struct i2c_adapter *adap)
 {
 	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
@@ -1097,14 +1166,23 @@ static int geni_i2c_recover_bus(struct i2c_adapter *adap)
 		return -EBUSY;
 	}
 
-	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
-	if (!ret)
-		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+	if (gi2c->gpi_mode) {
+		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_BUS_CLEAR);
+		if (ret)
+			dev_dbg(gi2c->se.dev, "GPI bus clear returned %d, issuing stop anyway\n",
+				ret);
+
+		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+	} else {
+		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
+		if (!ret)
+			ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+	}
 
 	/*
-	 * Recovery succeeds only once both bus lines are released. The bus
-	 * state is the authority, while a clean opcode status with either
-	 * line low is a failed recovery.
+	 * Recovery succeeds when both bus lines are released. Trust the bus
+	 * state over the opcode return path, which cannot flag a benign
+	 * recovery event in GPI mode.
 	 */
 	if (geni_i2c_bus_is_free(gi2c))
 		ret = 0;
@@ -1351,10 +1429,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (!gi2c->gpi_mode) {
-		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
-		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
-	}
+	gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
+	gi2c->adap.bus_recovery_info = &gi2c->rinfo;
 
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret) {

-- 
2.34.1

