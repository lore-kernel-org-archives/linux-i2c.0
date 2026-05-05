Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAD47F2FB;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=g1+VA1Dd92rWq2BQlElDzBBSzYB6GhK/jL7BGb56KgNFKJ5W18RRCfyC4fhn7kXPthMAJeDuy8E+5ITIK6Drd5uhZY7+FkU4BwZQdqXTkFv8u0dwufM9AFcmbXPfFDeQG0PWYWw2frKVTb0XAocyW+pnBJHxxq7bG3/a/hbl9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=duwJXyKH0PhnB0SbKDxmy6a7yaoZ+d5QnVkJv4atU4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtLwsfG9L9uuR6eJ1n3rA9Ly/MiWhGOt6fVWQTj5J7eCmKKCmbbWChzG8phaok6rI+I8+dfIUyNFwgk3dTTJEaVp4XHHwdpottUOgNaLq8BeiHxLr+CVR6SxBWPNOPrVoEA1PESU3Avw5wUtfScxsv4AFK97+xePHqY6ltWAdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCRAMxO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCRAMxO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D2C2BCF5;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=duwJXyKH0PhnB0SbKDxmy6a7yaoZ+d5QnVkJv4atU4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCRAMxO86xgXuci4Q3D4cxbgCfeW/Yok2gAm2Vmku4W5nXJdbXP5BEyw9hkfadTUN
	 RZj9pxzC6Tf0fDDW/uI6ZNFWy2ZY8WMv9B5N4IYFKbC3gp13v4pp5JKOP4baTKv/fJ
	 142BuDai8LeRicX54u3OHNIuvBh+IAfgxM8lDN9BHgkBg1MZc4Eq+6GLmgpfLXYqVt
	 4PhYbYzWtGKU2y8XWRzOTf05FF/AMnbYypSqVHXuuYCQU0C7z7sUzCKpyFGCdGI/PX
	 NUxc+vXz0pNlMaka50kops7GmIC1PO8iVJRhaplkOomAyMSALTNr1ZmA+wG/1//iq7
	 ldT33ehqQH6XA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Kt6-0gek;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 8/8] i2c: core: clean up adapter registration error label
Date: Tue,  5 May 2026 16:25:47 +0200
Message-ID: <20260505142547.795054-9-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505142547.795054-1-johan@kernel.org>
References: <20260505142547.795054-1-johan@kernel.org>
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
index 27cd9ca0ae81..8139e1531734 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1614,7 +1614,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
-		goto out_reg;
+		goto err_deregister_clients;
 
 	mutex_lock(&core_lock);
 	idr_replace(&i2c_adapter_idr, adap, adap->nr);
@@ -1637,7 +1637,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	return 0;
 
-out_reg:
+err_deregister_clients:
 	i2c_deregister_clients(adap);
 	device_del(&adap->dev);
 err_remove_debugfs:
-- 
2.53.0

