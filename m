Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B31DF74F
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773229681; cv=none; b=BmhXjqLfaLhX9opaasuIPdQ4RmU0DJSEpJsrK4BBYfd77rHGWenjA+e2AcwewMtaqAK6wYMdfWeYDubiXjFNb2Km+VlaHC83hbLzSZsiA3kSnADYZbojUSeWFAAf1El5hWlTnts+SLppEhVHWZjQfrDWRCkMKQ+V0ipTgMJYvpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773229681; c=relaxed/simple;
	bh=UpCdeoAotGFrzkbYhdGq7UuCNNLz9pTlfRWi1V4zvJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUjX36aQlA9uD4RqvnCb+yAOPE8B7rQbqJ7Rrud/BLU9Rq6qt983UQ2qLFFV6a81tyPm4qlgoOb6YGv6RbXe0H18rnBKGwfXqllwC+EG4mY655vkX0if4gI5ckvIHwxjiTwwU6IdK5+3NHZdlPvc5/smFpltwB/mh94/Q0UYvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=V7FvJweq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V7FvJweq"
Received: from [127.0.1.1] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DB4E5A5;
	Wed, 11 Mar 2026 12:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773229610;
	bh=UpCdeoAotGFrzkbYhdGq7UuCNNLz9pTlfRWi1V4zvJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V7FvJweq9I2Ub2vi//0H24rq99e0STd4Uu6nu30lgaHagplXRcYKlwgcj/CmD4R6u
	 f3NYRxnkRqYNUSSH3Bmra/cqz31FhX1nfqsASFvoomzhOAlXN40BuXCaUTXdRAoMte
	 ZhZcTi+h/NULlAR5jX5IvpoXIrMOg4hyjtPpPp6Y=
From: Daniel Scally <dan.scally@ideasonboard.com>
Date: Wed, 11 Mar 2026 11:47:43 +0000
Subject: [PATCH 1/2] i2c: imx: Don't recover bus when arbitration lost
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-i2c-imx-fixes-v1-1-e625034d8202@ideasonboard.com>
References: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
In-Reply-To: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Daniel Scally <dan.scally@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=dan.scally@ideasonboard.com; h=from:subject:message-id;
 bh=UpCdeoAotGFrzkbYhdGq7UuCNNLz9pTlfRWi1V4zvJM=;
 b=owEBbQKS/ZANAwAKAchJV3psRXUyAcsmYgBpsVZsIm9LnM5mRYvkLs6V3NTDX/SVzP3hLpQQR
 5VARND2QaOJAjMEAAEKAB0WIQQqyuwyDnZdb+mxmm/ISVd6bEV1MgUCabFWbAAKCRDISVd6bEV1
 MvZ4EACq6m83vIvK4eB+hyCgQ843YkE736URpfMxpMVWqHcjkb+poNcAV11cPph7LEsbU5qAPbb
 epyZ9JYYI9097b6+aSaIjmfc12zVMDV/3s2y1KHAWW4r6G0BBgHWXj+U7zOtwHBUgnhSCn5VHSF
 +ryJ5tiFauTD1EPI9ti2aA0r07nmv7HNNoOXFMB+0OBh/+doH+UL+xysmwH3X91b73iOVh5lnBM
 eCMLYYRBHd3GKVazRsunj0QF9O3OP2gVDONQiTIA+Kyo5+H+8rCXb1xZW06ri5apZ/ZhoN1V4YG
 UNCs+KUYxeYGj6R/t0SwHnWFSavdgw3duMX7OjmNFtgeTWf54cXT62zo4xbyKghqYyHc9HhyjvY
 ka/7gvJWhuRUC2TZjMTnYV6tcV8ybqEklYgnkypElJ022E7NcxUOl8RixqFu0Zpzi0jiuJN8XjH
 53eDplG2f2r+nBYcLU7Xod5ahQaegX3cSX0ZUrxeY+vTBJQ9yiWA/Eajog2/g8h1pWU/UZ60eAH
 C6e8WBqGON7/5KAvpsQj15WlkbLzl3kwusrP59J++w7l2r+AvbQ2T7OXm5j1k5TQpWJ0kCmhmPN
 a6LgpbzA7LikBf+SutHXE6Oq6Qb96OPnrOAUPguGbjAOfT1rZnwOTjXqgPqebxmCGWzYmyXgMvt
 0DP1VJ2hqbr19Eg==
X-Developer-Key: i=dan.scally@ideasonboard.com; a=openpgp;
 fpr=EEC699ACA1B7CB5D31330C0BBD501C2A3546CCF6

The i2c-imx driver runs i2c_recover_bus() if i2c_imx_start() fails.
One of the failure modes is an arbitration-lost signal from the
hardware however, to which bus recovery is not the right response.

Do not try to recover the bus if it loses arbitration during start.

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 drivers/i2c/busses/i2c-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 85f554044cf1eec7d28310c3d9e7a7346237afdb..ed2316ab1ba8b6261dabe8af4377136a002e2f0b 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1539,7 +1539,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
-	if (result) {
+	if (result && result != -EAGAIN) {
 		/*
 		 * Bus recovery uses gpiod_get_value_cansleep() which is not
 		 * allowed within atomic context.

-- 
2.43.0

