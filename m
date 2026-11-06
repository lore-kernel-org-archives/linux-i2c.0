Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948591;
	b=JvVyQgovVc/kRZhyMTe41RwRbeduOLNUAum6WG4TBqNp32I40Kkp7wZ344HVpTXu061u
	 IZQBGL0WHC773GdxOKInCY+jplKdpHznZj7+z9Goe671s+RRAQ1kPzOgml2p0ktxisqDu
	 Nkb/bklXJxHCjEvgyhOHR8mp1De9saY+F5N10426StI1h9XnnDPwFr+yKjKzjbQJaIqod
	 AvZyTQCAjNfUqw3yaqWONmIDXWwcuWmLT1mBmGFgYXPurz3uBIsioicdlWk8+Zs2f634j
	 grt10Hlr54iQPINwyS0A7QWuCvoeHLkfyNyxySOCaR0Ru+B76Hkn7JQHa6MSS8Ftr0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HJgFJeGyP2RXmPUrqatqK2hfmi9m5K+BAW+Bimi7a/M=;
	b=ZqtwRKmbmrPE8cpaRQirP1b7mUaXsy2Hy+6dVaFZyukAdmFJM7Yg73qHFZJWACTHPVt8
	 NWup8CbyU0L930kvzHxuoHlg68w1d9JBvUnCH6OSwYsWVe8ctMkZ2MfYYCg5t81BTKvVo
	 sgHZXHhkwT710bDbuE5fydzcvRrZpUeF+5assRsy3t1I+R4jv0oOX7znAbvNCV5NvndFq
	 k+bW9H4mvTT41VW3Byr1x20iJZDuNEJXJj6BhzvVa54Vo5ZK+T8fLHXkJfSvfzZW7fmr8
	 HfL5l2hMbziKT+AKr0OTKqi0Sq96fEqDP39dZysDyLu6comcjIp5dfD4S/2qNEzS7og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAP9lf4L;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE56606A329
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 07:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE56606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAP9lf4L
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36cad25b8b0so518717eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 23:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793948590; x=1794553390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJgFJeGyP2RXmPUrqatqK2hfmi9m5K+BAW+Bimi7a/M=;
        b=vAP9lf4LC4FognGLWC813NI09sXXLXgYu+exp7h2HyG1VRhASWFg6ggPWl7g0Fp7Km
         r/OGFfuD06IX8lTQwX2Rl853ZBiZ0HIlpoisbD0b7iSMw8k94MQv8nmtrI9fodGjnFwI
         75A06TjtqLP2IYZy+eose7VvNp3Ph6rNlFpLdMzBXx74UHoCN0WyOjsqxQGivxxHGcAx
         cXWidSUT/WRXmwak6JS+jitRHyc+M1I2Kto+WQvca5ukv0PyhNShhUWceo/lV0ER1MId
         AIGGR/uhVjzKa24nI4x7qyO94PJnq3plxJ5iFj1UIa/TSPM8VR/FOvJjpRCLIwVhvGvC
         M0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793948590; x=1794553390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJgFJeGyP2RXmPUrqatqK2hfmi9m5K+BAW+Bimi7a/M=;
        b=M2OtaNxBvkd3arysf13UnuFgHUgjuyx8BoT8Nmf24eNGUYN0MKK4VhlxEBT/oY3Iaw
         3LjRlxWx9SCMG/f2t61Oip9Hh4Et+SkSxF//97dqfH43bBCj3Agy7QgjeZUq6N0c0cNx
         eBR2JQ68YVAsrY45X2TnHLaYcu5BNZ4QEhfYLmYWAr3WYIHfy5wU11OdUe8oQ31OUXtD
         Bc193GRWx9I9MJanA8MT91TYuGY0wsaEjWE0aam4MR1hzVlXECiUx2y2o222XI6LjkZO
         vQuFfy4/RwndxnRSpHVLYjm3hha7fS5GicJYYNIb1bp9W8DlFGjgKF3vgGMfN2xxGhpt
         Al7Q==
X-Gm-Message-State: APuU4Z9XQvTU+SR158RHhU6kjCQVHlJxWpyfredNHlIpcw27zLUxbR2d
	RxdWKNp3ESE6/6qcjKf2URE9VtkLgaF4DnIirS1WYnht4u5J0+eAq2STMXKBEkk=
X-Gm-Gg: AYBFou1ZBIgX5O/5ANuvwQ5S0ujkkszpHkln9j7aSMq/Zke7GZgF18cCF0K5nLCN0k2
	eequAfhkgIjRdyjiMB9s224dqYQC6T6E+Bvjl5W9/p5hX0iOL5KT2UZmfigAhax8RIomvf+s10a
	5lLVAg6mE0/U8b3O3Qip71kIKU6ZqHxQfmuIIJiewTani6mAeMdlXMCMzqbbiQ1P/RLTBNMYpy0
	Ax9JTsu/KhDDYKTO2+0dP2c8/318ljH4Sr49tgr3VlM2/iY9Dwer6n8mix7LHOSRwAd5pZ8tuTj
	pVKF+GWSjHeJCf/NpjjKoKSiwPT+J2PmKnYLvlVjcpiVW3pKbFY+k2caCFhZK3LJYudSn4iv/Ab
	SXv4sA6tJx6TWIp683eKVzoBX+8IXvVeoZhw+6Z7bZFhw/NHDzS17/NluGyJos9IpAdEbA8ImJZ
	3RBOoROqJvgCLAmXzp4rLP1B9cQ0zANBCO7EWwnyyG8fcz+8+Otb2UgEkEC+RTeSJegyfVbUTzk
	sTXdFrYXuuS20wWy3QrFShLxN4izIkrAHTadjO4M6Ym1fB8unQY73Szl7/d1VOotKHBtQI3U47K
	l3/5MBLywL9BPIpdPZZp4p4rs2tRYxSzlxCTKmAt0pIw/+NvrH4=
X-Received: by 2002:a05:7300:ea95:b0:36a:18d2:8c79 with SMTP id 5a478bee46e88-36f76117e58mr2224940eec.19.1793948590001;
        Thu, 05 Nov 2026 23:03:10 -0800 (PST)
Received: from localhost.localdomain ([155.69.103.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faac86a96sm3508887eec.29.2026.11.05.23.03.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Nov 2026 23:03:09 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephan Gerhold <stephan@gerhold.net>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2] i2c: qup: Release DMA channels if interconnect lookup fails
Date: Fri,  6 Nov 2026 15:03:02 +0800
Message-ID: <rc-review-20261106-v2-vc48-group-8e29ee9ee1f6@gmail.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qup_i2c_probe() acquires both BAM DMA channels before getting its
interconnect path. If devm_of_icc_get() fails, the direct return skips
the DMA cleanup and leaks both channels, including when probe is
deferred. A later probe can no longer acquire those channels.

Use devm_dma_request_chan() so probe failure automatically releases the
channels. Group the two requests so a failed RX request also releases
TX immediately before probe falls back to PIO. Keep reusing the acquired
pair when the transfer path calls qup_i2c_req_dma() again.

Close the successful group so it can be released explicitly at the
existing probe unwind and remove sites without releasing later device
resources. Release the group directly in remove, preserving the channel
pointer state there. The direct interconnect error return is covered by
the automatic devres cleanup.

Fixes: d4f35233a634 ("i2c: qup: Vote for interconnect bandwidth to DRAM")
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Changes in v2:
- Use devm_dma_request_chan(), as suggested by Konrad.
- Group TX/RX requests to preserve immediate rollback before PIO fallback.
- Reuse an existing pair in the transfer path and release the closed group
  at the existing probe unwind and remove sites.

v1: https://lore.kernel.org/r/rc-review-20261105-vc-48-dbf6a486c74f@gmail.com

Based on linux-next next-20261102 (2637bdec0535).
Validated this package on arm64: the W=1 i2c-qup module build and
a DMA_ENGINE-disabled driver build passed without warnings.
QEMU KUnit/KASAN passed 11 expected observations using real
DMAengine/devres code and a synthetic DMA provider. These checks
do not execute QUP hardware transfers or prove concurrent unbind
safety. No QUP/BAM hardware test was available.
AI assistance was used for analysis and patch preparation.

 drivers/i2c/busses/i2c-qup.c | 54 +++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index ce30634e1f402ddbc092d9b220532d76455fc047..865c03d9aa891b9fc38538ae184541f74c0a2819 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -637,10 +637,7 @@ static int qup_sg_set_buf(struct scatterlist *sg, void *buf,
 
 static void qup_i2c_rel_dma(struct qup_i2c_dev *qup)
 {
-	if (qup->btx.dma)
-		dma_release_channel(qup->btx.dma);
-	if (qup->brx.dma)
-		dma_release_channel(qup->brx.dma);
+	devres_release_group(qup->dev, qup);
 	qup->btx.dma = NULL;
 	qup->brx.dma = NULL;
 }
@@ -649,27 +646,32 @@ static int qup_i2c_req_dma(struct qup_i2c_dev *qup)
 {
 	int err;
 
-	if (!qup->btx.dma) {
-		qup->btx.dma = dma_request_chan(qup->dev, "tx");
-		if (IS_ERR(qup->btx.dma)) {
-			err = PTR_ERR(qup->btx.dma);
-			qup->btx.dma = NULL;
-			dev_err(qup->dev, "\n tx channel not available");
-			return err;
-		}
+	if (qup->btx.dma && qup->brx.dma)
+		return 0;
+
+	if (!devres_open_group(qup->dev, qup, GFP_KERNEL))
+		return -ENOMEM;
+
+	qup->btx.dma = devm_dma_request_chan(qup->dev, "tx");
+	if (IS_ERR(qup->btx.dma)) {
+		err = PTR_ERR(qup->btx.dma);
+		dev_err(qup->dev, "\n tx channel not available");
+		goto err_release_group;
 	}
 
-	if (!qup->brx.dma) {
-		qup->brx.dma = dma_request_chan(qup->dev, "rx");
-		if (IS_ERR(qup->brx.dma)) {
-			dev_err(qup->dev, "\n rx channel not available");
-			err = PTR_ERR(qup->brx.dma);
-			qup->brx.dma = NULL;
-			qup_i2c_rel_dma(qup);
-			return err;
-		}
+	qup->brx.dma = devm_dma_request_chan(qup->dev, "rx");
+	if (IS_ERR(qup->brx.dma)) {
+		err = PTR_ERR(qup->brx.dma);
+		dev_err(qup->dev, "\n rx channel not available");
+		goto err_release_group;
 	}
+
+	devres_close_group(qup->dev, qup);
 	return 0;
+
+err_release_group:
+	qup_i2c_rel_dma(qup);
+	return err;
 }
 
 static int qup_i2c_bam_make_desc(struct qup_i2c_dev *qup, struct i2c_msg *msg)
@@ -1952,9 +1954,7 @@ fail:
 	qup_i2c_disable_clocks(qup);
 fail_dma:
 	if (qup->btx.dma)
-		dma_release_channel(qup->btx.dma);
-	if (qup->brx.dma)
-		dma_release_channel(qup->brx.dma);
+		qup_i2c_rel_dma(qup);
 	return ret;
 }
 
@@ -1962,10 +1962,8 @@ static void qup_i2c_remove(struct platform_device *pdev)
 {
 	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
 
-	if (qup->is_dma) {
-		dma_release_channel(qup->btx.dma);
-		dma_release_channel(qup->brx.dma);
-	}
+	if (qup->is_dma)
+		devres_release_group(qup->dev, qup);
 
 	disable_irq(qup->irq);
 	qup_i2c_disable_clocks(qup);

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
