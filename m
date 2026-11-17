Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910435;
	b=Pk5S/QYK99SFD4P2uc0tWa2g9Ie1lPg5ux71npe5V9MHxnY3bcyjGSb0aoPsNHruCgkv
	 dpKiasDdPtrRZGvtzUBR2RMYxdf8BTxNRKvn2DtHQuGFUIggyNMQAwBRMD9BzpgiJphUF
	 b4Cqdey4/LeJpjocKpDfglWqqOhE28QDWHimtCn4e7qgbzrhOdWeweJRUDr0B6AKai7gi
	 NmT4ZWz7u4wfPQ6OvGsS41sgTX9nqgCp3z677EWfcTJ5XzL0V4Ml8dPemibORuEorCWlp
	 2l2pfECBFS73JcR+ABbcucZJiEPkf6uJJxGQtBOix0rUUrjnzvD9pLocHk1GO8V6S4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910435;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7yIdft+GsM2FNrOSTp5Juy10o2nzMv02s3M695q6MEs=;
	b=Q6CyAEmkLeRZi8osGdtGr9Je0dGamChY7gejfpBU32s/55oQMB+nAw6+PTgzA9sAKMIw
	 g/epUrJAKmjXIWED8nd00hzZjlYfWcTZ4m3l/r+wiKnxQECt+mDlnJs23t1r9SL90w17t
	 LG4ewLHekOSq2dnAkwr+/GqL42YZgsUZUOrPMF2tIdEw9dN+oZUbqxruC5lAQKy90ODyX
	 tPyleKs6RxUzha62/V9VEGQshuKQORDC5lgbxMzzdy1jgsmnAZsNB0AxVw4rwsKmXECLk
	 k/cr8JbO2ahio0Abi4UoZxRT3COtKTulsgmAROVeQhjSmFyAuswfg9CWpAhl5PpHGLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxeu8PCG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D1606A886;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxeu8PCG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A5F1F000D2;
	Tue, 17 Nov 2026 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910435;
	bh=7yIdft+GsM2FNrOSTp5Juy10o2nzMv02s3M695q6MEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxeu8PCG9UTpySO7vvOzbxDjWF+CrS1Gzcvq4D1Dxo4/uLi7+TaHwMj735T/mlvol
	 KFOHYkwHriRNTrKY1gOcPXVWMBdEt9PPyB0eVbtdqnx6EX09ld8/cDo9e7j3r0aBUQ
	 SaA0rbcSdeHGJifYy9zGvaTidH8Bw34JCY9S+MF48EyCPMWtI8YlrXdcTA9mstAopW
	 x28VFEiW87lTAhseTbgvSnSfiY+nuzlwi44Z/NzBD7NyTM0OJRueGygqyInKcswJmd
	 bLya86YZjGFTDZ87sQ8473OtGSJ9vrkIXnx1e8rw7rYxd1x5cBOaqLuKeQmMWrpJx6
	 M4zlkVbi1pjIQ==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xTGCG-0000000470l-1Mgs;
	Tue, 17 Nov 2026 11:13:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v3 8/8] device property: fix fwnode_get_next_child_node() comments
Date: Tue, 17 Nov 2026 11:13:36 +0100
Message-ID: <20261117101336.980216-9-johan@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117101336.980216-1-johan@kernel.org>
References: <20261117101336.980216-1-johan@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent pointer in fwnode_get_next_child_node() may not point to a
primary firmware node so update the comments to reflect that.

While at it, fix an indefinite article in an earlier comment.

Fixes: 190069255582 ("device property: fix infinite loop in fwnode_for_each_child_node()")
Cc: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/property.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 51109794d727..bfc424a193b8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -810,7 +810,7 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 
 	/*
 	 * If this function is in a loop and the previous iteration returned
-	 * an child from fwnode->secondary, then we need to use the secondary
+	 * a child from fwnode->secondary, then we need to use the secondary
 	 * as parent rather than @fwnode.
 	 */
 	if (child) {
@@ -822,12 +822,11 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 	if (IS_ERR_OR_NULL(parent))
 		return NULL;
 
-	/* Try to find a child in primary fwnode */
 	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
-	/* When no more children in primary, continue with secondary */
+	/* When no more children, continue with any secondary node */
 	return fwnode_get_next_child_node(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
-- 
2.56.1

