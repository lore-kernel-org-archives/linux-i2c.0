Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD7381AE3;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=pn5zOuPG7RbfhtBTiX4sOo1oIWHdHu09DdHb+O2LovL9m//86Q6XwU0BpDTmB+MZKWvuSra8QKyrO3tyjAtuvJDB09V9nbInFjpEX5wdKNV53D6NIk1KlpoENbO9NlkkfGyhzdza6QeLVo1IJr8hfHHUteMjt1YKwWlVS1nvbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=D8vN4bT/q3VsYLc/zBF2Wx5uVsdZitkHCv0LNJ5DYfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARraSOXRFq7SGgttYLKVvEGNKuNECsZuCdoawReadIdSLA3YttBibXPsBQ5oZY573GwRiECaqFlkQGSoHEWH/fG96a40TmNRNdoq4wJwXnapJCJcXlTCzD1AxHf0Tt+ou639KB+V3JpMAVYCdZcxTWtylOmWZ8sJPXsv3ISQg6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trPmGS2r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trPmGS2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CAFC2BCFD;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=D8vN4bT/q3VsYLc/zBF2Wx5uVsdZitkHCv0LNJ5DYfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trPmGS2r2Ee/P3CQjBagCunNXhUKQi0KfP2r4r4YYfV0pbPBwsAaAUwrQbTSTFKB5
	 Ls7rkmu6al4cSrfpoOVKgMflCz0i5JzKgciQ66Etf8OUT+nKok+IsoadroLPaspFAP
	 hcvdeuFTzcrJupCFjxF4rzoNIAkNt4TMEPQ/D8dShySc11XB0pfwmhswFpIc6X/Sfs
	 QaKWem5DSJgobm3Kwr6IyBIc1u7j530bAGroARzT+OLbKFgAeolZlm8kXdpQhmVTEI
	 oyWau4PkidWD14IN/E4Ksog4XNGi6Oxrn9bAQjvRRQxm5GskvWPKMEH0D/ZO1XIYck
	 1/1BkTlkBE1wA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7K-00000001ahC-066a;
	Fri, 08 May 2026 11:03:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Jean Delvare <khali@linux-fr.org>
Subject: [PATCH v2 7/9] i2c: core: fix adapter deregistration race
Date: Fri,  8 May 2026 11:03:09 +0200
Message-ID: <20260508090311.379333-8-johan@kernel.org>
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

Adapters can be looked up by their id using i2c_get_adapter() which
takes a reference to the embedded struct device.

Remove the adapter from the IDR before tearing it down during
deregistration to make sure its resources are not accessed after having
been freed (e.g.the device name).

Fixes: 35fc37f81881 ("i2c: Limit core locking to the necessary sections")
Cc: stable@vger.kernel.org	# 2.6.31
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 4863d660faf6..f72f15a1b067 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1801,6 +1801,8 @@ void i2c_del_adapter(struct i2c_adapter *adap)
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

