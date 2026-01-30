Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17A321420;
	Fri, 30 Jan 2026 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788366; cv=none; b=OSoFrlVS4RUuLpCj963G92YsByRHaaYkGTNnmX5zwH/YPTyhwWmT10TTkZPduLILaDLtlgt0ddG3gNgcojzoWoek8cABrjJQn9J92XIB2Uqvh0WGViCgHGSWp6VMgBTl12hbjflcMBfztDw1wlzyV82Xjp6dPvJMYz+ACve26xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788366; c=relaxed/simple;
	bh=ApxOrQpDMjEJhdkSBRxGfqTTbzZOtiod9j0i+Zp1jWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4WvevUNC8Aus4TtehprCCnD2jwqowqcZEnUzmYJgRpEuDJqUB2MQqh3BtfiPKJmxi36KkHhOiumCJ2rdACC7/plVXkpVFC5mJggC3y1CQOnXGMcPA53v+KEoEY6kQJQJ190c8XLvZzhHMLWIDpL5TgesiH3kWVXp6TypNzvA/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1eovMb+n; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1eovMb+n"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 858531A2B3E;
	Fri, 30 Jan 2026 15:52:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5530E6075A;
	Fri, 30 Jan 2026 15:52:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 348FB119A8884;
	Fri, 30 Jan 2026 16:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769788362; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BstxskABvsI003jCtpoX3POBTaIibi1yMKxKOA/4L2g=;
	b=1eovMb+n+Ttm80knIID4hgFEO4iM9VOxiSANqKFT6vsQFsKE+gJMv/M55um08oG/0aBeqV
	dGmPsPIkMyDLKBd3jIbfckIMQo6hmplvDhsf6PIF9G6Duoe8vPYelbd5g5KRtnfZUzq0wB
	SLYHd2X/AKnrgOgKUlmFIVH3C7SLaJKV/FFBr17JxPLTG10l1LAlSDDSD3iKjwWmIO91Th
	8LpNZqyoME9mpSc/ZZJk309CEd2P362UZEZe3lUcChO9PWparK9HvZR+SOyUoztP1TcywL
	3JorVmBi6M6r/47QclSf2GZlcfE8IjUsiatXdrGn0wyIK0TwHLdpXwZXbn+VXw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 30 Jan 2026 16:52:30 +0100
Subject: [PATCH v6 2/3] i2c: designware: Use runtime PM macro for
 auto-cleanup
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260130-i2c-dw-v6-2-08ca1e9ece07@bootlin.com>
References: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
In-Reply-To: <20260130-i2c-dw-v6-0-08ca1e9ece07@bootlin.com>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Simplify runtime PM handling in i2c_dw_xfer_common() by using the
pm_runtime_active_auto_try guard. This adds the proper handling for
runtime PM resume errors and allows us to get rid of the done and
done_nolock labels.

Also use the dedicated PM_RUNTIME macros in amd_i2c_dw_xfer_quirk()
instead of ACQUIRE()/ACQUIRE_ERR().

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a466511dadd4..73d9347a6a08 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -296,8 +296,8 @@ static int amd_i2c_dw_xfer_quirk(struct dw_i2c_dev *dev, struct i2c_msg *msgs, i
 	u8 *tx_buf;
 	unsigned int val;
 
-	ACQUIRE(pm_runtime_active_auto_try, pm)(dev->dev);
-	if (ACQUIRE_ERR(pm_runtime_active_auto_try, &pm))
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
 		return -ENXIO;
 
 	/*
@@ -846,11 +846,13 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 
 	dev_dbg(dev->dev, "msgs: %d\n", num);
 
-	pm_runtime_get_sync(dev->dev);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
 
 	ret = i2c_dw_acquire_lock(dev);
 	if (ret)
-		goto done_nolock;
+		return ret;
 
 	/*
 	 * If the I2C_M_STOP is present in some the messages,
@@ -866,13 +868,15 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 		for (cnt = 1; ; cnt++) {
 			if (!i2c_dw_msg_is_valid(dev, msgs_part, cnt - 1)) {
 				ret = -EINVAL;
-				goto done;
+				break;
 			}
 
 			if ((msgs_part[cnt - 1].flags & I2C_M_STOP) ||
 			    (msgs_part + cnt == msgs + num))
 				break;
 		}
+		if (ret < 0)
+			break;
 
 		/* transfer one part up to a STOP */
 		ret = __i2c_dw_xfer_one_part(dev, msgs_part, cnt);
@@ -880,14 +884,10 @@ i2c_dw_xfer_common(struct dw_i2c_dev *dev, struct i2c_msg msgs[], int num)
 			break;
 	}
 
-done:
 	i2c_dw_set_mode(dev, DW_IC_SLAVE);
 
 	i2c_dw_release_lock(dev);
 
-done_nolock:
-	pm_runtime_put_autosuspend(dev->dev);
-
 	if (ret < 0)
 		return ret;
 	return num;

-- 
2.52.0

