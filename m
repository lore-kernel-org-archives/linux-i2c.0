Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602248032C;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=ZHqhslCfGelAM7YE7AnN4/y6/WChkBVpSVqDG7aRggXNoj67JGgwxI9ujQ5BFaW+PNvfRY3XhQyLJB/LwV5IgdeHzyZWT/r9ayULgiTS2W75MGvFIAH+IYwDtwoSUWZtm1vghKMe4TJe7PWCHh6gnSxT4ndFvAjpDR+UaiRhUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=tGAqDrEa0NZzzkYgDzVwNuk1zf8s33MQTeXZP9FSPmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keWev+0P4VQ2DpONs/2slDERlJE4RByeislp80T358J9hcBxEtx8Rzq7sNh43GoBnwhAnRSCGG9Ik1wJg4pM09scGX6KcvBCZMKUX+lh4PcxIQiWWMikf2Kwr3MTGxNjkxHla3QSEBB0e/dk7v3eWSxQFADuliR+iHFSj3iZRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiGfcIHU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiGfcIHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCFEC2BCC7;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=tGAqDrEa0NZzzkYgDzVwNuk1zf8s33MQTeXZP9FSPmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TiGfcIHUWKZtcFnUlrQzOissJbMWXxwQ66jOSOJb8EZpVN5UvyxINGTJniIP16d4v
	 Wp4A07YYWbZfGhOkNUB0JMnvXWMGhBSkX/LXXNKz3zmWiWbZlt0fVrTtjHtVQPi3A2
	 Dqw67Gq7tz9fX3Y6DwEkx8JhsQ96sbzEr6C5R+ADbkr8zPpcvkVjqey9h97zAPCxWl
	 5G32Om/KEk5xBtm7Jlic63Zr0Jh0bUpoCYb7Ke8soyj0ZwR21kx3Qws7zXJkMTHTXR
	 6hF5jGpMzDcDORuFcPpstKbEtLiw9DNguUzNf8JDES2nLeWdfxQ4dM6tmg9rvHt3iE
	 A1+iKJG3wGX/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Kt2-0bzp;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 6/8] i2c: core: fix adapter deregistration race
Date: Tue,  5 May 2026 16:25:45 +0200
Message-ID: <20260505142547.795054-7-johan@kernel.org>
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

Adapters can be looked up by their id using i2c_get_adapter() which
takes a reference to the embedded struct device.

Remove the adapter from the IDR before tearing it down during
deregistration to make sure its resources are not accessed after having
been freed (e.g. the device name).

Fixes: 35fc37f81881 ("i2c: Limit core locking to the necessary sections")
Cc: stable@vger.kernel.org	# 2.6.31
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index be909d6bc776..6209c5587e99 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1799,6 +1799,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	/* First make sure that this adapter was ever added */
 	mutex_lock(&core_lock);
 	found = idr_find(&i2c_adapter_idr, adap->nr);
+	if (found == adap)
+		idr_replace(&i2c_adapter_idr, NULL, adap->nr);
 	mutex_unlock(&core_lock);
 	if (found != adap) {
 		pr_debug("attempting to delete unregistered adapter [%s]\n", adap->name);
-- 
2.53.0

