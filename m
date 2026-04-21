Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DA1AF0BB
	for <linux-i2c@vger.kernel.org>; Tue, 21 Apr 2026 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788203; cv=none; b=NlaWV5f76kZmYgQv8OzS7vZdBqsvfdlkum6+92CP8rrcoeV3hVnf5rCrzCZJG/6zw6PnrHpU3QLFRrjV8NImt3HDZerMbh3w9Cvbj1oXAv/5ovBhnsRt8VXYb/PCCD6ixB3kQ4Thh3IWHui/lYgcSJsMFvybtU4NC/4Fa/vMd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788203; c=relaxed/simple;
	bh=/fQxde6GwWzc9iNzwFqwm+1/SSmHBFT0PkWwBa4Erlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pg64eLNOkBZcmg5xQcPcDP8+tHU4xmZdWT3ArtA9R+17zDz9N13+eyERWCgWedaaJk7EgGICb/sUX1ivWtB8ouuZNRAYF527bRRoXVMknt1KmDzpIG+IDI0rmtFWS0NFLNIUG/r9dnsG+xrYD9xHzXAoo2tMQe5lXZsND2ZKE50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lr8rHzVF; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lr8rHzVF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776788199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KTRrIi7tM0u21ks32XbxVIleTJ84Vy5LeGCOm55VgAY=;
	b=Lr8rHzVFgjxHV2qgECS5wucppIKiKt3k3qHNochn/I6pcnu+YuUDPWiVirWHR+tVR+4R1p
	g8TTf+zaa5SEJItyEb8kAMY6mimwBnM3c1/X7ZxVaG/nT7po2lrPWiabFa2EA/7N7cUUet
	VvKh60hZ0A9W2/zd+fno6eJEjztSkVY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] i2c: change return type to bool for i2c_check_functionality
Date: Tue, 21 Apr 2026 18:16:09 +0200
Message-ID: <20260421161607.61314-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=thorsten.blum@linux.dev; h=from:subject; bh=/fQxde6GwWzc9iNzwFqwm+1/SSmHBFT0PkWwBa4Erlk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnPFx3/aaTqHBal99pi7q6VO6+zXpnGv/L5gndO9/9P3 3Z8y8SGRR2lLAxiXAyyYoosD2b9mOFbWlO5ySRiJ8wcViaQIQxcnAIwEbP3DH+l7sREca9feu/C FjfzySH7V+yIKyngDEwqY73RFXh/Le8Mhn9qLNlaDrrfM8+x7q58qqaTqpfi+bVWoXf9zkZJz+a NjjwA
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
