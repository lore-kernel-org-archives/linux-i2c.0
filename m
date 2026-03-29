Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157993815D1
	for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802191; cv=none; b=urU4jYkkkvFBMrGxSCjUHUAdhyATwFjhxDB+F2iAuJd1OcfqF63SSeYyWwE27S5RBvGlFY1c6PvAgZd/5QwGUJR6e6EnKMp82v6UJ3ivtqcDlLzCWwWiNDFIflUEoHVddy4hfZQT91Kpi5AUbOCrLq0jl79FUWpdy1anAinitE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802191; c=relaxed/simple;
	bh=/fQxde6GwWzc9iNzwFqwm+1/SSmHBFT0PkWwBa4Erlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjGer7Cr2Xq3yaa5Gz/OioODcRXp02IqA+JXTbr97as1L6209aHuqsAc7gU5V2jCuHd/eVXlUMiZpJaiOHDyZKG/HFsTmqh9mHY7n+L1fh6qUFU2h2yUNWiht1iLSfmn49JZ93XejcIuraZ5ZLzAbQe7cpTl1VKXxKUvqAOxhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W5xa7si8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5xa7si8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774802188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KTRrIi7tM0u21ks32XbxVIleTJ84Vy5LeGCOm55VgAY=;
	b=W5xa7si8i8Mososrpyk2R+wD2TKBotbKLW5jounWyDZjOqkh534M6Wni9Na2FzTnyHxrCu
	OquBudwbNXWIidvaiIG2az4eZyCzYzVTqGUkyC3VlPpwiDvcWypCkZ6vrSBocCIK6+gw9e
	fioYDQiHn4uihtzyE/LcwnsPiaLZ6Nw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: change return type to bool for i2c_check_functionality
Date: Sun, 29 Mar 2026 18:36:13 +0200
Message-ID: <20260329163613.366885-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=thorsten.blum@linux.dev; h=from:subject; bh=/fQxde6GwWzc9iNzwFqwm+1/SSmHBFT0PkWwBa4Erlk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJknQ/7+NFJ1DovSe20xd9fKnddZr0zjX/l8wTun+/+nb zu+ZWLDoo5SFgYxLgZZMUWWB7N+zPAtrancZBKxE2YOKxPIEAYuTgGYyO+VjAwb5E6J5azf929i zLWLK068vbbk05SdsiwbEmLOR3yPn6crwsgwu+zztthZC9hd2ph2zjy5Qe3x3NTACtl7XGstAku aXd+zAgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

i2c_check_functionality() returns a bool - change the return type from
int to bool and update the comment accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/i2c.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..6737bcbc5d7a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -919,8 +919,8 @@ static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
 	return adap->algo->functionality(adap);
 }
 
-/* Return 1 if adapter supports everything we need, 0 if not. */
-static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
+/* Return true if adapter supports everything we need, false if not. */
+static inline bool i2c_check_functionality(struct i2c_adapter *adap, u32 func)
 {
 	return (func & i2c_get_functionality(adap)) == func;
 }
