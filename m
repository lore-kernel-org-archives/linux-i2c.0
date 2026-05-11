Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65037DEB7
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529992; cv=none; b=Y7PrwN18eQMQpjvRw7hoKPZDXYHOi4Kw2YC1+RZ6BGnPfuJ8VIEa6jlISEc6RhPbohpGLs7BVeSsTLapM2PLQX71j9UkIwdLdEBdP6gnkMfydetqY3rXIThUYHbNifNTOi8HBha7+8ea/gMuBDeEEiIEgLs1AlG79NKMWQkqaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529992; c=relaxed/simple;
	bh=Ao1+s9xEtiD6QBHowI6J7Mkv3FXHYl0iJlmorIy3mQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=saT1cRmpioFxpM/1/1a21gxbCzTcXg/yxpguVz/cFyZs8EM7s09RZJ9DVha1Wv5bwp+GIkbsulHfM1X4oRi1hYBiDTOn891Gi6vUFkBZo3OXnuVIuoXU1hKP1eWL5XZ8PCpYRKcC2InbXn0i9HIaV/cndKCmP4EDCmtSFBt10qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com; spf=none smtp.mailfrom=wkennington.com; dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b=pUmyBP6d; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wkennington.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=wkennington.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wkennington-com.20251104.gappssmtp.com header.i=@wkennington-com.20251104.gappssmtp.com header.b="pUmyBP6d"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6354188eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wkennington-com.20251104.gappssmtp.com; s=20251104; t=1778529990; x=1779134790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4YeuQQs5xPCqUDNxVj/DEq8wwCdgbhYL0v3c1ldlH8=;
        b=pUmyBP6dpTkLgscSKNDvdAsWyvS41oDGkdPFHZY4fYG+3Bqo/yGMvpfz3Am1hj6hpq
         ZcWCHGGlALaCcSz5RSzbyltt5yvIDCDvkvrkuSSAntHXqIcw9YZutBXhyO/mVJBOrVst
         KYMBLg5P5oTja1zo9tesLlpzGkS8b344rkLTo4SX+1Nr8gk9bXg2HImxvp1TjY4A5ImW
         6Tt65J4hCwg7VAeag3j0i/e0Kv70ifXzpC76c8qLjMckY/sM6rmBWLFd3b3KfnBHdNUl
         62MnXnsGAK4bRN8jGqCNq6ZUSvG2qEA9JAC/UoTdz0atITZqB0TbAUOZEDJnavCRH8DH
         Kd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529990; x=1779134790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4YeuQQs5xPCqUDNxVj/DEq8wwCdgbhYL0v3c1ldlH8=;
        b=GXOYLMHPhJdRMWBQUnzes5nMsxoRNMsPxU8COf5NkHR7PH5JKSZMuEQQOEDPm19a1q
         Yqta9N2G1VhKQKwI/7J0Qy3mcHbBT5WYFXQA58CE9s/T5JrZZeL+vts5hrByURIvDZrO
         Zb/c5LX/sAjjWVBRU2fGXgFIWlGphyQw/jTC8I53uFYHoLlQwIF11lqoxSFuR+hKO0a1
         7+S/veK7BVye60b6toPpACx23lltyelFfd3X/p1fq4iECs7yaxvb13+HGo2TMUYxwTSm
         bWxlQde+3oG+JU0z4sZjnGXY4fHK/WSxApXJ6dV+sDGoPgkMjDKZEWAwRw+WNHqhRuTp
         eNIg==
X-Gm-Message-State: AOJu0YyFdAIpghBqZ8Nfxg4dNqlMXjS4lweFn3mk6Wm9al+a+SR06Ckw
	OZmkJ2H5svL1d828s4dB2dy6L9jMGWKNysEyccw1NjZkYAYGO8CjMNygeJRkFDwHakE=
X-Gm-Gg: Acq92OHji2zlV6rvTd9BfOXzMGM3FpZoEF3vxAldBqfWIt1D4vZe8BqYOt1NR33bB0x
	frlNInfv/rsLzMczFINQHM0ha2uYPhsZzXelU6IPYGp0dLJtmFKuTLzqHVZ3s5amlFHcsTEOtUp
	UGbh7EaScBmM8fj1PSuOl9Lee14jtWKEyX0Ed+xsq544qJeO4EiFSDfpWNjiySlLstPrem6AP7Y
	K6mczabSo03KnpTlPfDkx60oOdugd+dIrU46Q/PeCfXYfgFmC3AIXZkprimO/48iGwUP4uzUgsZ
	LKNjBS2VUsewBbTaEa4CPotBYERpcqaRltBggGemG0eYq30DzrOqspTZd+G55X6wOjvSleYxDNE
	3Ty70jjllmM/tW98eYEYcP+GRnOnyG5GkLsOTTiBIGiPTS2zU3ZyCdKKsvmYGbHOuih4bJDRAQq
	FIy8mgOgD50a3HD958Mu95N2aOufGU0jRaNHuHgvy5/VN1TLG4B2pYS0qgslVIyUyYrevk8F7BH
	qkItSIKxhtTT23xIOFO7XgvDA==
X-Received: by 2002:a05:693c:394c:b0:2df:71f0:e5b3 with SMTP id 5a478bee46e88-2f54f9447a6mr12068082eec.20.1778529990290;
        Mon, 11 May 2026 13:06:30 -0700 (PDT)
Received: from wakbuild.c.googlers.com (123.143.125.34.bc.googleusercontent.com. [34.125.143.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm15066942eec.24.2026.05.11.13.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:06:29 -0700 (PDT)
From: "William A. Kennington III" <william@wkennington.com>
Date: Mon, 11 May 2026 20:06:28 +0000
Subject: [PATCH v5 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-dw-i2c-v5-3-6c382e1b5de6@wkennington.com>
References: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
In-Reply-To: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "William A. Kennington III" <william@wkennington.com>
X-Mailer: b4 0.14.3

Convert the platform driver to use the new i2c_dw_shutdown() hook,
allowing the controller to gracefully NACK controllers requests during
system shutdown.

Signed-off-by: William A. Kennington III <william@wkennington.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3351c4a9ef11..da2babd6188b 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -289,9 +289,23 @@ static const struct platform_device_id dw_i2c_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, dw_i2c_platform_ids);
 
+static void dw_i2c_plat_shutdown(struct platform_device *pdev)
+{
+	struct dw_i2c_dev *i_dev;
+
+	i_dev = platform_get_drvdata(pdev);
+	if (!i_dev)
+		return;
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		i2c_dw_shutdown(i_dev);
+}
+
 static struct platform_driver dw_i2c_driver = {
 	.probe = dw_i2c_plat_probe,
 	.remove = dw_i2c_plat_remove,
+	.shutdown = dw_i2c_plat_shutdown,
 	.driver		= {
 		.name	= "i2c_designware",
 		.of_match_table = dw_i2c_of_match,

-- 
2.54.0.563.g4f69b47b94-goog

