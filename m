Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0B3C2BBA
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737909; cv=none; b=dIHZYdZLaalONduomkNMfYNRgyoylfG0dGOxI/NxgkMaBpmCz+Wt0bvZBHdhDj8b6GcwubD6ofP8pZjIAPTCH9DK63EloMHBAgU5j+ZBXeEbN1V9TsU3AqxW6j6nn1sCgjnNZhAsS6rJztJHOV6KJJSXJhduz28e5yRdoBXVarA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737909; c=relaxed/simple;
	bh=drjM92BuPDEa2C1FXr4sJ/Zwdd0Em+XHwb412MyNjkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naGhKxFv7LHGM4k/eSFTf65ep52KORjOKTfwHIkPS/aPZsFH/zEz5e5lEwAHrksGIjdi+kfrXOJSQE8w7nt9KmsNLO+f15+CN0C3KaC3AZFFbP1CZFdA4DtNJvsxnSa3OFRAx5D2RDNZ4jvWNM9+9s3cMYJSnMiqATdzKd8Hy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NaWl7ZXd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GncBr4ht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NaWl7ZXd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GncBr4ht"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q9CZhp1062598
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h2jTLTwKpZJ87HzGbqUxwHGxXGje8BRmPNMHjr9cQgI=; b=NaWl7ZXdjAwyaERd
	L80A8lfmPOsbqn462Shc+Aon2g037rc1huElZXPDz92ZF3WLmzwKuLZ4LJ+BANaZ
	pG01mDnFSXNOKUiT8cKWl6oIzthhIlyuge6abdb3pbVqGhYK1u/plHI8XqLLV56p
	sIySQYEWc0nUb9xQIfyHqSfRwx/odE30ujEBOZaLeLt+emn/qzwf54x3ztfE1rML
	tvywStTHFyo7l5sYt9uLGOjj43R7EjnF/CeiBrgSaeHpF0yJAbwcaz5vRRthDaxU
	8IJ2AzCBBNnnjyY8clqW6g7yiHdH1Xjms+iuYsmIrWHNMbtnOBREpLOrgwiPzZ+L
	g6PKcA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxk9tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 09:51:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so972551a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787737904; x=1788342704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2jTLTwKpZJ87HzGbqUxwHGxXGje8BRmPNMHjr9cQgI=;
        b=GncBr4htonPRJNInlZPB/HV+FK0VQ4I5NVNrAQ3eN6W6nDZ4ECTF59nw9ExpriYMdG
         itQeqSZOSWsNbGtkh0bLcdAcwvk9t9nc2iuh6o8XXHH6Bjd/88ms0+rruk36kUqF8oLD
         Y85kHctXvkxupNBZBhBqIyP3W3nMGwvjb01f6zIpe5DqmyFFZhgeOAeB69mr869416xW
         ZFSWpBKIV58QoPxqEHIwAhPMwCc5j8KOq2f8xCIPeKN3aZWqOcFZB3iePTro3Lk3IVG5
         pTqL+KYgkET957EVEGxzGxHECYYP0DRwifwcTEMmGCsSuh0b2Tng17a7ugY2KwgTlAXf
         /Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737904; x=1788342704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2jTLTwKpZJ87HzGbqUxwHGxXGje8BRmPNMHjr9cQgI=;
        b=VQTf4R6pO/kwoLq3oBPTX8QsbaHJ25tXCFzfoisW/cQdiy1dCQ3gyTig+hfQDtkN8r
         uBcmekWO99fB2A+SU15u1yhAl8nK3uZyKBk53dFNhIzPqw/YHgRtoLWW8DOBx4hxm+JU
         g+USmt/5JLYTZX6hR1rhsagaNV9FArif2LUdfOaCvcDBIYadhYZCk3aQFmQixqWcnO7W
         KJdbJTcIdxzBJudcjOhzOlkbcKpc1om3Gmz9TAw1eU5LdmzyPpGuCppwyPLxZI4VqonF
         tsFhju7Yza8vIPZgIpN+ct5qoQnEbj40lpOwgmzp5X7EWXUfreeW2hS/HR2bI1j1g3GC
         5lrA==
X-Forwarded-Encrypted: i=1; AHgh+RozytKy6eprktL+SZy7KWNMW+iHI13oibFg25CNtsr6fa8M6Y6Xc7420YnskRvNbelOc5kV272COVI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFrJzVGVizUZEDkCTT8Ju27yz3w9DAdcm0EownxHDreuZ9j0hG
	rY5jMnNSxJ8dQ/Q1j5UWnxEG6WRGtTJ0m2HmaZCtFvQ5JMhtXaWlBA/IEXydmK+JIP6+99F0WBb
	nn6AVB/G0kIxiZalw5WA+xFdQmMdfL58N5F/j2NpH1U0RCnwcHpVmxVJzSIOWdvk=
X-Gm-Gg: AR+sD103YkIIgllEKR1fiKn600/nULOtUriM+4bdiL4Ym/9tlKRCtKRU3Proi6d3dSj
	Pg+VixdcDRgeNXZOlcq9o7TWOxpijPmm/CkOTlGG4p+oJZdckhoBtI4tzElhMPmj06IyAWPNc4c
	fzU+8yvPhaOIpBHWJrVBKDOOj5A/sCh5CqX4qZRz+PKzG5b6QfJNOGsVKDW/hBbNW8jbkdMRLGu
	/aoV8oE6zu/HGZBaP1Kd4qf+xbVFgckKSPQmYoBRMvJDXiph4mHdVSYUZHS1qiB09HY5OE8QOTD
	mmLvoHu9GoK54VMuqemAJf6RjNwuweKTCuT03T1q+5lq/h2gb/uiqEHiAXFISnRDuFaPaRkDmT9
	6pjndnqefpUwQoFAc6pd3OYRw2hj1ph2/Bkw=
X-Received: by 2002:a17:90b:5286:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3966d446193mr12138751a91.9.1787737903791;
        Wed, 26 Aug 2026 02:51:43 -0700 (PDT)
X-Received: by 2002:a17:90b:5286:b0:38f:2168:b9cb with SMTP id 98e67ed59e1d1-3966d446193mr12138681a91.9.1787737903315;
        Wed, 26 Aug 2026 02:51:43 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm7249738eec.23.2026.08.26.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:51:42 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:21:23 +0530
Subject: [PATCH v1 2/3] i2c: qcom-geni: Add bus recovery support for FIFO
 mode
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-i2c_bus_recovery-v1-2-203f0ec76f84@oss.qualcomm.com>
References: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
In-Reply-To: <20260826-i2c_bus_recovery-v1-0-203f0ec76f84@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787737891; l=5356;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=drjM92BuPDEa2C1FXr4sJ/Zwdd0Em+XHwb412MyNjkg=;
 b=6XgULsn2mDaX9ZNwcFHerfE6sFjJXNroleemI7OI8OVzHeEOWHTrXEh3Kzgfv7V3nR2pWT6J8
 6KlutnTvzKFAF6vsb74aD7W+LY6Me3cNn6VH18HKpMxwllL0uXL0dMV
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8eb730 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RDp_BpDB7XvTh3UEEWoA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: HrShXKMKaLsHYeVh9p6Mo7CV8ne8ppLF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX5lTtLlifsDAD
 nJEsIRsVKX2Q+e3VbTzPwn22qteBDMSuEIEsl+vsb0zmQVNcZa3X+r37lvzB+aNZDSW0XHfqbzl
 mwN6dWAgLUmpuJO+pVO0FzBQVLjg4EN19qDlfNvnrc3kYzDPce5uUeSuzUEwHJ+8sVQ67IytjYC
 36UbDGgfPaaamrIalTO1OfYNJWxksro0dM8SND51kh4ODmfuAKNQ6PIZD1MWEJ0PKPDg618e3qI
 SXQMQPirq5Rz7Q1Th4o+S5oUM9CJ2wicHMGLyyJYzdMc5eE9yd9C/Ik4JHfsc7XOPATRzO/t3L/
 os19FxHKXfBPwJvUbhf4rS5Drbs34LI+UXjHKE3zUbnBrcE93ZJQv6DhYf0vaI7fv2mUD3beGF1
 3+dPI//SHU9pc6BruB+AX2MaAGtthzDkcBgHluhcNhywamks17DeX1DC8wbVlsURXRk+JxJW+J9
 PAs/1zx/SzSehqRMobA==
X-Proofpoint-GUID: HrShXKMKaLsHYeVh9p6Mo7CV8ne8ppLF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MSBTYWx0ZWRfX7sfPLDKq/5Un
 QVVaqiwjS4INrI6uSgToEwlxBlOswnARWSkLCMZRalI0NlSWVmGyPU40tLAELYdmaACPpTOJadL
 MLERfShuyZVoK5rYCrRyzmoEn/x0HTM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260081

I2C transfers in FIFO mode can fail with -EPROTO, -ETIMEDOUT or
-EAGAIN when a target holds SDA low, leaving the bus stuck and
preventing subsequent transactions.

Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
hardware opcodes to restore the bus to an idle state. Check the SDA
line state through SE_GENI_IOS.RX_DATA_IN and skip recovery when the
bus is already free. Trigger recovery automatically from
geni_i2c_xfer() on -EPROTO, -ETIMEDOUT and -EAGAIN (arbitration-lost)
errors, and register the recovery callback through i2c_bus_recovery_info
to allow recovery via i2c_recover_bus().

This adds bus recovery support for FIFO mode only.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 109 +++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..9fa1a8ac400c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -138,6 +138,7 @@ struct geni_i2c_dev {
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
 	const struct geni_i2c_desc *dev_data;
+	struct i2c_bus_recovery_info rinfo;
 };
 
 struct geni_i2c_err_log {
@@ -956,6 +957,90 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 	return num;
 }
 
+static int geni_i2c_fifo_bus_cmd(struct geni_i2c_dev *gi2c, u32 cmd)
+{
+	unsigned long time_left;
+	unsigned long flags;
+
+	/*
+	 * Clear cur so the IRQ handler does not attempt FIFO watermark
+	 * filling or draining while the recovery opcode is in flight.
+	 * cur and err are shared with geni_i2c_irq(), which reads cur and
+	 * writes err under gi2c->lock, so take the lock around this reset.
+	 */
+	spin_lock_irqsave(&gi2c->lock, flags);
+	gi2c->cur = NULL;
+	gi2c->err = 0;
+	spin_unlock_irqrestore(&gi2c->lock, flags);
+	geni_se_select_mode(&gi2c->se, GENI_SE_FIFO);
+	reinit_completion(&gi2c->done);
+
+	geni_se_setup_m_cmd(&gi2c->se, cmd, 0);
+	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	if (!time_left) {
+		dev_err(gi2c->se.dev, "timeout waiting for bus cmd %u\n", cmd);
+		gi2c->abort_done = false;
+		geni_se_abort_m_cmd(&gi2c->se);
+		time_left = ABORT_TIMEOUT;
+		do {
+			time_left = wait_for_completion_timeout(&gi2c->done, time_left);
+		} while (!gi2c->abort_done && time_left);
+
+		if (!time_left)
+			dev_err(gi2c->se.dev, "abort timed out for bus cmd %u\n", cmd);
+
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * ARB_LOST and BUS_PROTO interrupts may be reported while the bus
+	 * transitions from stuck to idle during the recovery sequence.
+	 * The opcode completed successfully so treat these as success.
+	 */
+	if (gi2c->err == -EAGAIN || gi2c->err == -EPROTO)
+		return 0;
+
+	return gi2c->err;
+}
+
+static int geni_i2c_recover_bus(struct i2c_adapter *adap)
+{
+	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
+	int ret;
+
+	ret = pm_runtime_get_sync(gi2c->se.dev);
+	if (ret < 0) {
+		dev_err(gi2c->se.dev, "bus recovery failed, error turning SE resources:%d\n", ret);
+		pm_runtime_put_noidle(gi2c->se.dev);
+		return ret;
+	}
+
+	/* SDA is high means bus is free */
+	if (readl_relaxed(gi2c->se.base + SE_GENI_IOS) & RX_DATA_IN) {
+		pm_runtime_put_autosuspend(gi2c->se.dev);
+		return 0;
+	}
+
+	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
+	if (!ret)
+		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+
+	/*
+	 * Recovery succeeds only once the slave releases SDA, so the bus
+	 * state is the authority: RX_DATA_IN high means the bus is free,
+	 * while a clean opcode status with SDA still low is a failed
+	 * recovery.
+	 */
+	if (readl_relaxed(gi2c->se.base + SE_GENI_IOS) & RX_DATA_IN)
+		ret = 0;
+	else if (!ret)
+		ret = -EBUSY;
+
+	pm_runtime_put_autosuspend(gi2c->se.dev);
+
+	return ret;
+}
+
 static int geni_i2c_xfer(struct i2c_adapter *adap,
 			 struct i2c_msg msgs[],
 			 int num)
@@ -981,6 +1066,25 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 	else
 		ret = geni_i2c_fifo_xfer(gi2c, msgs, num);
 
+	if (!gi2c->gpi_mode &&
+	    (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN)) {
+		/*
+		 * Only attempt recovery if SDA is stuck low. -EPROTO and
+		 * -ETIMEDOUT indicate bus errors where the target may be
+		 * holding SDA low. ARB_LOST (-EAGAIN) on a single-controller
+		 * bus indicates a stuck target, not a real arbitration loss.
+		 * GPI DMA mode extends this trigger separately.
+		 */
+		if (!(readl_relaxed(gi2c->se.base + SE_GENI_IOS) & RX_DATA_IN)) {
+			int recovery_ret = i2c_recover_bus(adap);
+
+			if (recovery_ret)
+				dev_err(gi2c->se.dev,
+					"bus recovery failed: %d (xfer error: %d)\n",
+					recovery_ret, ret);
+		}
+	}
+
 	pm_runtime_put_autosuspend(gi2c->se.dev);
 	gi2c->cur = NULL;
 	gi2c->err = 0;
@@ -1188,6 +1292,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (!gi2c->gpi_mode) {
+		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
+		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
+	}
+
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret)
 		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");

-- 
2.34.1

