Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA13644A4
	for <linux-i2c@vger.kernel.org>; Thu,  7 May 2026 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184326; cv=none; b=UOIN339ZZT7eAEljgB58Wb1hgbWoHNSNDeAbwxBjgHzQRZPToRXhNhMub4MEIKTeErIwF9RyiWmUm4lOFsu1tuWTxEx/34MZW+QEwirVNp4X9TxURYh8jBJq6BUPcEER8GIgut6zWGAf2AwhVwK7xKA3Snf8A1CDfXxHOL50yI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184326; c=relaxed/simple;
	bh=Oc5uAz/uYSFLgaMHLuonmdBsOam9MFJorSalJ6/K7XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsB/akD8ELTrWuWkdaajep1fClF00FbFif0cOZGOHrdQDnibzMlyS+GVXAT2LAcdB76imiRC0kd620UBmbWmVRTvsaTxGdQ7gFSReKsUjM5jCTcHiOZr5mKYWof0YythnEtZ7wAEdJQTZXB9neVZWcR/h6hg97L+4d43d1LwZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=BcaUe7C4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="BcaUe7C4"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8026aa4d53so797002a12.3
        for <linux-i2c@vger.kernel.org>; Thu, 07 May 2026 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778184325; x=1778789125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak/jJ3kjPdO09tXdhAf8w2E2HP3MFaM+RhiEMxW3OfY=;
        b=BcaUe7C4cHEChkVAkBNZ53xvVCUmGa8iT2Tdh9k7jgXR4WHj+FQ9brIdAHSPyTt2W5
         QNelk+lAlo3Dq7xlrPTeuG8RySaOvEhS8sut6y57brdsDOsKKZ7M4KwgFRV/B9J3GksL
         FwYXUxjt5CXhlMCxpuyG5GFfREc8yXxjCkzOcaXpnjbCoaLONSrMpE4hnebt3Qz3GqSn
         OoGVY90csKNiEp0sqth/RWTRnprZEz3+tSWp1dUKxFYp0U9piAFxXq+AzDovGF5K+Z/c
         YeCp+ZbMU7h2qX7/eyTC+2yMcw04mHmM68CKFuDFAIaaDrXRotSz1ruoq38Jt7b+o6Of
         cwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184325; x=1778789125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ak/jJ3kjPdO09tXdhAf8w2E2HP3MFaM+RhiEMxW3OfY=;
        b=p0ZR7PPO14djPSrtSGJqCtamHsHd//KztFwS8gxfxN24dLbx+akP4qKE7tSn28IvHV
         TzieWdFINK2WCR0SlYjP6kKbu329kdFMTv3wzI2lIJVUFNc1wgE3/s+1/szVa40AYu/g
         bQle4ojmG3+a0QX2qGZwznDpyxEbKfm6irgfYMX404SJmfsJG56OGXVk07RAb9Kk66Bb
         hPWs1kxhVUfi/jzVFxDPAo3HDB0Swc1aP/0SUqPHEunruI1z3cAR94DDoNNS8g1zJggd
         kkppKcjwYmfmutGg9htYc6V2B86gvFwzQR0A44GO1a2wBIHlchIm8n8y7mn1fkw1Vd/G
         uXbA==
X-Gm-Message-State: AOJu0Yzhbt4E31n80qe0AVwWQj9SUQRIm68SsYzA2eNPOnLbcIUHPF1S
	eSLEp52ltnFFaO0+AxsRt6nDFXOAXA4MpUoSXOtEUoKxkZs/H++Ym+TZ9Uqi+V31NuU=
X-Gm-Gg: AeBDieu2/tyqPGa2zEJr4B+OyIc7iwWOf4LG2piUcsk6kCcmxIcisuDllktgeAUVT1N
	Rk05XPp31qG6fkB/vCgYy3CbErHbVJVTrADF+TtszoaRaBrvVe9uLzYQtA94cWyIQNXOkmRp9Fa
	4JRHdQBh5Wanav1bHKiukjvGOIg78BjRR72M/n/3xg+Qy2egT16DOt5Rjhb20QiNLCgLXknUbE2
	k7fEO4ENU87nwYgj6vcRMqcNjujF8duD3yqRxzBEcfaFDmrQFundGvJpo8Dok9h0oQVdARZpRk0
	cpuXeUBr+tTqDXdnK1odI7I+mW/pko0YVQG7yVcvt9CrP6Lza++shVSqfJQCCl5I67mvqCfVHBW
	G+7o8FtTxD6qrVVVDKrf54GWOD415TPQvGS3pfM8X9eBzqgOz1WVKX5D3XhyE2uypP2jml+Eazw
	diXMQJ4QDgYbJrJBLnfs028NKh7II1HVzG8py5p6B+YSVz4m9dA0MJhqEX612Kt2luESoYvpayU
	ssVz3TMFrV7tHk=
X-Received: by 2002:a05:6a20:3941:b0:3a2:9c28:9c3c with SMTP id adf61e73a8af0-3aa5a831d73mr10599771637.11.1778184324647;
        Thu, 07 May 2026 13:05:24 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8263ff29c2sm443200a12.12.2026.05.07.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:05:24 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Thu, 07 May 2026 20:05:16 +0000
Subject: [PATCH v4 2/4] i2c: designware: Convert PCI driver to use shutdown
 hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-dw-i2c-v4-2-9a447b23bfdf@wkennington.com>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
In-Reply-To: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
the controller to gracefully NACK master requests during system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f21f9877c040..ab21d4414681 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -356,10 +356,24 @@ static const struct pci_device_id i2c_designware_pci_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, i2c_designware_pci_ids);
 
+static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = pci_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct pci_driver dw_i2c_driver = {
 	.name		= DRIVER_NAME,
 	.probe		= i2c_dw_pci_probe,
 	.remove		= i2c_dw_pci_remove,
+	.shutdown	= i2c_dw_pci_shutdown,
 	.driver         = {
 		.pm	= pm_ptr(&i2c_dw_dev_pm_ops),
 	},

-- 
2.54.0.563.g4f69b47b94-goog

