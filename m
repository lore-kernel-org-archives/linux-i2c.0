Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85D31B82B
	for <linux-i2c@vger.kernel.org>; Mon, 27 Apr 2026 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310938; cv=none; b=EIfqk+V5hS8VBH5cVAX3dWq4ETRe4AZNImTahwaxoutR1pZfwR6WJT2w4O5QCMF0LhcSEY5Xa21zn0Gdk+GKM4ukYwPi/7e7DfQQqa+37N1Vzq5aD7sScN7PRVZnhw/Bpr6MelGnIs4aXXnya8dEhGY7Gcc4rX73hpul4n/wTSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310938; c=relaxed/simple;
	bh=2J8IvNBGpGcTobEzMhZ4xqVe6sViwCgHjDX081pccbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DI9QeZ47/ZuGr1TzQgx9LxKVPSvaUquGqKgWFrQKXThjbhnRGGrp0R6WfIHpd/LMMruZQdgM25jqQlHGyZO/CotelwmSWxvwf2w2OTvRySk+MMhlvEIbY5j2mlgYES+qNH8hO0wOHOszwsClo1GjqG/Ppnn/MvgH9XZdqZBVUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snpqCeZ3; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snpqCeZ3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777310923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TbJLCfa8V/+kmDfsDozd+eyS+MfmcSV9H15c3yTrp4E=;
	b=snpqCeZ37/1mW/pKVsnyLpgkirSuzTLjxOHcsIkY/1GAi5cghYHi8dneVoq+8zcVzoHR0o
	auRXCTtwrDP6BEGAFuBo3SDVl1UNvCFyikg+SGpPvGKTfevWdjnhwmZ9/a/1Ef6CqBSCth
	q0BvkwsyddJKKWzWWFolSBI/J/7IuFg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] i2c: atr: annotate i2c_atr_adap_desc->aliases with __counted_by_ptr
Date: Mon, 27 Apr 2026 19:28:19 +0200
Message-ID: <20260427172817.417614-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=662; i=thorsten.blum@linux.dev; h=from:subject; bh=2J8IvNBGpGcTobEzMhZ4xqVe6sViwCgHjDX081pccbI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnv52zUXL04StyqKURs5bX5c3ZaeD26e8NY62HD7k+75 12c9nba0o5SFgYxLgZZMUWWB7N+zPAtrancZBKxE2YOKxPIEAYuTgGYCDsfI8OJdfutrsotsT9y pUtzy1/fo19/dB7RW5Mlt7K68YuQq7wHI8O0fYXG01TXPPJNSZw25c+zRx9yI/ekVlXN3xFV80A 7T4YBAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_ptr() compiler attribute to ->aliases to improve
bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/i2c-atr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c-atr.h b/include/linux/i2c-atr.h
index 2bb54dc87c8e..b52a7b9ec536 100644
--- a/include/linux/i2c-atr.h
+++ b/include/linux/i2c-atr.h
@@ -71,7 +71,7 @@ struct i2c_atr_adap_desc {
 	struct device *parent;
 	struct fwnode_handle *bus_handle;
 	size_t num_aliases;
-	u16 *aliases;
+	u16 *aliases __counted_by_ptr(num_aliases);
 };
 
 /**
