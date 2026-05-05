Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08148034A;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=Ps+0Xo3pHDHpR5bUyLMmFWNq/7OGIWHsm3YGbyAgRJ3u5eMmMvgbB+VadZoW0egyOuXGd6dnPlgfTGR+dTZNJCIumxQAKvKO59CNXDsl1zY3fUqxoOY0pP2iOXS/sn+NFDv8sU6PxkmAZ8kuOe14qjip1CtjCe1e/WJovujKO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=K6HCzeH4GdbTOgUpIKqBp7V+qgvqdBS9GyKwFcHGQsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzXy1zjR2ZTorONHzvJkn2u+0/JaYUtZdqC+YAn7y+/QF0pyJQae1g+s/Ziz8+eeG7Fq+9lNJSHdpX9PpwcRRjhtJwLD90VOg/g/jimFwWZzUghFdjIf09REVh26S3JQTPCxBedseysoLx9CUVc5qllaX6lS4PAjfGLfQuW+XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWdYCPpl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWdYCPpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E5C2BD01;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=K6HCzeH4GdbTOgUpIKqBp7V+qgvqdBS9GyKwFcHGQsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWdYCPplYbddW/qIjCLcnF3uNNkU4++X5v/0atzNwPppUG58ZKVhmWawSa0dDm8xE
	 1BZL3stQ1E0XtD5Q4ZPiNSRU1gk3u8zPMOAJF0ytFGpoNNRYYe13PBw23GTknkGlhs
	 JZySX+Smm1gQX1slpKSJWVRZD6NSgpV6evsiIk8AJSCsFyAdp/BU+Bzkpb1TMXhHK/
	 avHTIPSH8roZKFKXSqGytVPS1mWehkU8YEfkISQKHRWpcMQoe74vum68IOwMBmRYJo
	 oSWFxM/0aQ7g+zoooN1F1mJYeFv3GiyWROoX2qjw929mmPjIrwfLGMes+A9IrJjB97
	 oY4EINVlA6mOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Ksw-0UjK;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/8] i2c: core: fix adapter debugfs creation
Date: Tue,  5 May 2026 16:25:42 +0200
Message-ID: <20260505142547.795054-4-johan@kernel.org>
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

Clients can be registered from bus notifier callbacks so the debugfs
directory needs to be created before registering the adapter as clients
use that directory as their debugfs parent.

Move debugfs creation before adapter registration to avoid having
clients create their debugfs directories in the debugfs root (which is
also more likely to fail due to name collisions).

Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
Cc: stable@vger.kernel.org	# 6.8
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 2832e1aa0ca3..6f198d1325a6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1575,14 +1575,14 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	pm_suspend_ignore_children(&adap->dev, true);
 	pm_runtime_enable(&adap->dev);
 
+	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
+
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		goto err_put_adap;
+		goto err_remove_debugfs;
 	}
 
-	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
-
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
 		goto out_reg;
@@ -1606,8 +1606,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 out_reg:
 	i2c_deregister_clients(adap);
-	debugfs_remove_recursive(adap->debugfs);
 	device_del(&adap->dev);
+err_remove_debugfs:
+	debugfs_remove_recursive(adap->debugfs);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
-- 
2.53.0

