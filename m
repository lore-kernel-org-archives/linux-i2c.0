Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3137F75E;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=tUe+mZ7GcBDkZatK5LJIms0ssNvF0lj10nt7Rux6XEU6Z1xlebggn5xHqIS9GhEr+8dt6Q98nL98ttJqPl6mEyGtyIi9j3tx7N/JYD4It9AMmHFwzBIXjt9h154oEv0y7/X9Qm6DZCErixTWBVo5tt9xneplzncWd/5Lb+tnIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=KhgTZ6PbzQKtcR1d2ZrOX8dboBUitE7o+QYct8JBHy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeZ/39kur8LhefH6Vg/HuLEKJLt+l9xSO+bKCmQ8bjZ4Ap5VCFJnnD0UXpnIeZegRchC2V0Xvxxvc5DqVlmvYK8v/nCKIXza9N+dpq8UOKBKU2b9m+9VJazrVUL7/7CdgyAJBtwumCN9Qma3z9drXm9Mtz2OTjMyXBSPLOHKoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQQyEgu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQQyEgu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD2FC2BCFA;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=KhgTZ6PbzQKtcR1d2ZrOX8dboBUitE7o+QYct8JBHy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQQyEgu1BlBRnDmGLm8kA71QdXiVqWedNLKaN2ICwLfu3JPZgVoRUvMQJ7GcoFFkm
	 foegLZ4StlnDQJnCTSN7TsZaUbltWjLRHrTAc2LBmzZRgMCIvvE6XD+ldDbovDS0lv
	 TUObkYs9OzhwS93mGajJ9RpUp/pVbN3HeU1kAhQY+09ot2hz/HImTJ6oaTBD+xcm4Y
	 77m8vi5A0FKYwinG7GvnNirqYBLVYlLSliKvT8xAe6iQOnSFU4xpXO3MLsktLJUTiw
	 cfhATrBz8BgbD63a0c6XxABHbd04L7qguQMS1qjFVKGRbDAMGr+nUeL7Jiv03USnRy
	 fY2tU1UEzUxPQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7K-00000001ahG-0AaA;
	Fri, 08 May 2026 11:03:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 9/9] i2c: core: clean up adapter registration error label
Date: Fri,  8 May 2026 11:03:11 +0200
Message-ID: <20260508090311.379333-10-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508090311.379333-1-johan@kernel.org>
References: <20260508090311.379333-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the adapter registration error labels by making sure that also
the last one is named after what it does.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5350ee54132b..029ebe44c68e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1618,7 +1618,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
-		goto out_reg;
+		goto err_deregister_clients;
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
@@ -1637,7 +1637,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	return 0;
 
-out_reg:
+err_deregister_clients:
 	i2c_deregister_clients(adap);
 	device_del(&adap->dev);
 err_remove_debugfs:
-- 
2.53.0

