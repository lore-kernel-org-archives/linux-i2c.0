Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CE3DCDA3
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496623; cv=none; b=KJ5rdVuaAPs8gOOPwS2LejW41TKLtnwkcPMmWf48wgH9rvsED/SSyupScBgTWvCzrnWfdnqxxjPmrkha5+IlHdaSHpZbVqqdDuk62SDTeQ8geUPjFpq3YZhPemBxWqZPNmFopWN/G40y81b8T03zxNmvyRMQGsPPaDAKDt69Yog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496623; c=relaxed/simple;
	bh=UMHokYtPlxGLqlFn1s7L/v/RKjltr1Gg0nWG5mvjPNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsPJ3fImU+EOCKSfPDlOIbkQpb7XZsflLmM745MuADkGKbYpIB3rWN3Hb8k8rVupJiR92lh/2Nqd05naa2P0Ze/MEDsk1Afa533LlL7c8l5AxeqEo45okAeeE6cdt41/ramxGe1G4IT3/D5h741hukOj2oQ3Cnly8MWEhzUKY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bWNuv8gZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bWNuv8gZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778496619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3WjgpvBfHJSkpGCIwIsqVsTJc5uH5P43/rSGgl6tjRk=;
	b=bWNuv8gZqO3H74xXcV60OHpc/CbA59bDTUjOpdhp/N67gQCqJ9H2xkNMLdo69ap3bGfGqx
	cGfpxub0j+eVALNBU/WYuz2ibLbRV0/wIMubFLyUHcGf3e8eNrXn5Qc3wgqHJGPuI/Fcww
	LDeUUmOEhbG5ws2uTeP7sGCD5Ce40xY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: algo: bit: use str_plural helper in bit_xfer
Date: Mon, 11 May 2026 12:49:13 +0200
Message-ID: <20260511104911.183606-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=thorsten.blum@linux.dev; h=from:subject; bh=UMHokYtPlxGLqlFn1s7L/v/RKjltr1Gg0nWG5mvjPNQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmMWzTEDKO+HzAOm1KTquNjpMSamGCptNLh6Qn9a/8mN 3rNZGDsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgImcucrI8Ie/s+GD7rYXygue f44R8IxcEqSkbBx7y32tUc/njaxr9BkZ9tiXcrkdirm6nkNtXpzETaXEtX16BbZK2U58pnMesXM wAgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralizations with str_plural() to
simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/i2c/algos/i2c-algo-bit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 6544d27e4419..d1d9a6c1a1e2 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/string_choices.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -562,7 +563,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 			ret = readbytes(i2c_adap, pmsg);
 			if (ret >= 1)
 				bit_dbg(2, &i2c_adap->dev, "read %d byte%s\n",
-					ret, ret == 1 ? "" : "s");
+					ret, str_plural(ret));
 			if (ret < pmsg->len) {
 				if (ret >= 0)
 					ret = -EIO;
@@ -573,7 +574,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 			ret = sendbytes(i2c_adap, pmsg);
 			if (ret >= 1)
 				bit_dbg(2, &i2c_adap->dev, "wrote %d byte%s\n",
-					ret, ret == 1 ? "" : "s");
+					ret, str_plural(ret));
 			if (ret < pmsg->len) {
 				if (ret >= 0)
 					ret = -EIO;
