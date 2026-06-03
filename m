Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1863E6DC3
	for <linux-i2c@vger.kernel.org>; Wed,  3 Jun 2026 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456316; cv=none; b=KSl+PbPU2of7hFy5E9teCihJZFAdjHHVd+obuZ3vw7UusTqM/pKq7S9Trx0cU6B29KqO8HaYn2kiOE/amYSXH+Z+LgQ9wqchGz8WJ4xR7P6FEg6QG2R7Jpf45ZTVdbcLdzEK10oKvHd8VEaNGvL8vAZvPRu/wHHY5e/4f+7bW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456316; c=relaxed/simple;
	bh=u5GCTN95aHRCMBoDJHkFf/S+06sOFg7W9gSYZb6FdkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NU8L4vAwfqC19RfMpO56mz3/71CKQprsRF/Cp7Co13mZ0wmfCMaCZb89HbiiFHAd8ciEpiizZu0zPnPhSdc/vMiczY5uIVnkMgsvt782YkIyqrThVYwhj8Y/hNE0aMF5pyD5yx6W8pF/a2Z1miuvQOtpCNc6VCqKEcQbNNl+yEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcnTM3MR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcnTM3MR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b9328c4aso25082345ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jun 2026 20:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456314; x=1781061114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgpTLB1hzkqNPPrde/I8zx966U5X1f7Z9OQaGxgrfCc=;
        b=TcnTM3MRIgAD8lNaq6NB+2bYRSH1qki01qmxq6e1JJjIBckIGpCxsxeWRCuHBWka4Y
         OJhOZm2SJWf2alxVMSbP+X6c5EjJF5zWLbLUY71xDo/EpLrPHvNeSwXXwd1IOu2+FPpw
         PNgAJgM0S4t3aWm5qaoqqBexzs21TtfnnGWoZisyV5G4qyzHW7lZjgDpgkbkGg9rEdL4
         gHayxSDpfCUkDO88CbKbulNe2BPh6Pg7bp3sf11374gtnDikjct4cf5mv6V8g/Kll9Fu
         gAawl7ncOZ86ZNXdUoUNdqTXG/Vm568lr/5/YwcJG4GPy6FJ/TQUHYDHBqz8rI5prpl9
         w90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456314; x=1781061114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgpTLB1hzkqNPPrde/I8zx966U5X1f7Z9OQaGxgrfCc=;
        b=HTiBuvR4bSu5nxuGk/S1IfGy9yqoX/vp9dY9yHMwiEjsm8zupTgFt2IV1ibo1u9Oha
         f2XWsB3LHYC7J4/VCQpdUBYZuVEcMPmQ1tnnUJswc4hQmW2VbR9bqEii20CBr2jEZLMb
         iEY/gVQNAE9vs+cBcoJhgIYZgWMsw5DyLKnpzP1Tq/2ySsA5Z+2lGr30bcdByUv9WQ1c
         EPHNGns6DbALHs1/pC4pOjWJ5Ulkvq/KpuTv+0gia1B3QLXvA4ZWY5xSclgw4QsqRh5f
         O1VdgmLnc9qD/xMnxEpedbG+kbvTtLrFt6Aif2Cdjtet+BFHzV2QuCOWL7jcXrTPSpLQ
         KsSg==
X-Gm-Message-State: AOJu0YzfKOkypH8jjOKKfk415z+fE5Sa4w2rFwbs4fpRPGrKweh+vEbQ
	0uhLPKynjE0Wu0BQfdTPuwK6e8RbBCHQ/W/gm/CWsuDVzy8c7VMk7wOnJ16swdjK
X-Gm-Gg: Acq92OFWa6CZbXLW5aYkiusG+Vi7VJxx4R/f57kG/eBYPqOkRqgn5wT8y1lsCz6ncOT
	ZRKFkb+eNqKOUWdE/4YIpQTvMr8/iLm/LYJefChdLSmkeFrujM6Xt8MPEkuaStHG7P9H9Szx9Ac
	y8BAFcHDzQ5CdbldJB9EEmjeLqC/b9DTtYM9LF7jbzo4f7LUVzfmPYqdV+YXb/bykn/0SjEJAky
	+xj/2tBUNukj2sPr38Cm5KwCSBOh8B3XFJY+OmykV5qv4AT1XVu510wneOQZ7h8ve44rvA4wcpA
	siZV+S1kpMtntwcbX1qabiu0qXy+qwRJ+BkMy9ybrntRU73CMcp+U82sjgxyqftwxwrGV+PVqkk
	yvS5rJuEjGwr+4B4rUZjqlfjbrUpnI0kgU077E9JBRGa5Kcr/5K9/sJ1Tq4vjpYMqgkEsuBGTsE
	9yaw44EnBOH10nimkd7IBLwfw0JZ1QHbvNHCOaDrg8pVK93Y77ZDosBrYHQN+lWlEakgeSBshq1
	wLng8o7Wsq5YvVHDwwwFuZnwAYiLmfCyvcpAvTl2HMHog==
X-Received: by 2002:a17:902:f545:b0:2bf:211c:4980 with SMTP id d9443c01a7336-2c1644d5834mr13983125ad.35.1780456313668;
        Tue, 02 Jun 2026 20:11:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f96b3fsm7211795ad.29.2026.06.02.20.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:11:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] i2c: mxs: add missing kernel-doc for struct mxs_i2c_dev members
Date: Tue,  2 Jun 2026 20:11:35 -0700
Message-ID: <20260603031135.289302-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc documentation for the struct members that were previously
undocumented. This fixes warnings when building with W=1 and ensures
the struct is fully documented per kernel-doc conventions.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: fixed Signed-off-by.
 drivers/i2c/busses/i2c-mxs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 08c9091a1e35..4e07babea9c3 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -108,6 +108,14 @@ enum mxs_i2c_devtype {
  * @cmd_complete: completion object for transaction wait
  * @cmd_err: error code for last transaction
  * @adapter: i2c subsystem adapter node
+ * @timing0: I2C TIMING0 register value
+ * @timing1: I2C TIMING1 register value
+ * @timing2: I2C TIMING2 register value
+ * @dmach: DMA channel
+ * @pio_data: PIO data for DMA
+ * @addr_data: address data for DMA
+ * @sg_io: scatterlist for I/O
+ * @dma_read: flag indicating DMA read
  */
 struct mxs_i2c_dev {
 	struct device *dev;
--
2.54.0

