Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300728;
	b=P3WGMPgNZEcgGBqm0S88DFs+BxdI5Mxdj4GP21pPj98IoWAZltBSdvvtQiWrDPwmtzVJ
	 oHmNwoqhATeq3hpn2iqPdvFagydL9iVTBDyzwy1K+SVxt0rte1eYjZJzh67n29Oz2LWx3
	 83piI5fu/L1aOaH8om33c8QTQ3Q27FUOkvYU9wvds41dLE+f++oG1TWu8LwHhqQm93doW
	 fMHh7DXH8qztUBZjJHtNMIBCFRIh6QRtmGjS4AYszXlP0PLwo/xILoo5o1BtnxQbD0LUR
	 vINXqAVWQePPHlJnchcneZOj6CJpLGiEBJ73/fSplNeRjistoxYJ9GecrwlgsglQNkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300728;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R+e3kpbpPde9VoezRbcL7JxDyHszt965T/owVz7GYhE=;
	b=jv5YltHoLCaB0Yoa5WAbZWYx1uhEiM9XyQG5BRbKMuicWILFDE7Wuyl++gKFcIOnx+QY
	 YpS8K5NF1HG2n2j71EJP+bjHaFZnlp3j5No8HstK6gjH7P5haf4FASimh/JA+ExhaR6rB
	 Z3JR6p1Hxp8Lqw9u0uPU4UrHUON/b1zQR75wlLQgW7wkpEGQMefu4xzUNB9LWSPr2RExE
	 5UmeRtGCNwYpCQVWByP8FnXnV0C+41QcXB7GFuC3wiplkaos/5/WuLsQv7929FrZCd1co
	 CwCjgE94x9OeotAz2VDBc1KBWB8RC7j15eUkbwK2+ws2faBz0PPdeSOy8MfbVzSZE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oenIbExN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E788606A332;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oenIbExN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966251F008A4;
	Tue, 10 Nov 2026 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300726;
	bh=R+e3kpbpPde9VoezRbcL7JxDyHszt965T/owVz7GYhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oenIbExNIT2iO7aDPRfI4ai6ipJqLPbC/frxda06e2Dtu0SmeDoavXbaXoaHauHVq
	 XzA+FV7Pf/2fV0lzV/jbQjlN1kSCOesEwkXujnIH/zgWAOJRXe/JIjsmbyToxCNrHs
	 ci39SkcHEGfEiSccwwOuirTgWg4m6VMYH8uaSUIRCKJsYj9D4haFLsP4psvN+qdsvh
	 4cyQCPcZlyqwtdjlc52CSQpoJhdNQlSYLGo6vcoRzm0N2xwPruLuMjuSaOoezZdUvA
	 wKO8ByrWLfr3WUwiyL7s1TGy7R3muHrxVHy0ox7lSQFZINwupCj6siu5zMCHzFxF+A
	 L0F5EGiPJZbTw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQhaG-0000000AdcK-0QT2;
	Tue, 10 Nov 2026 09:52:04 +0100
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
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH v2 8/8] device property: fix fwnode_get_next_child_node() comments
Date: Tue, 10 Nov 2026 09:51:24 +0100
Message-ID: <20261110085125.2535508-9-johan@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110085125.2535508-1-johan@kernel.org>
References: <20261110085125.2535508-1-johan@kernel.org>
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

While add it, fix an indefinite article in an earlier comment.

Fixes: 190069255582 ("device property: fix infinite loop in fwnode_for_each_child_node()")
Cc: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/property.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 51109794d727..32df0c6724ac 100644
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
@@ -822,12 +822,12 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 	if (IS_ERR_OR_NULL(parent))
 		return NULL;
 
-	/* Try to find a child in primary fwnode */
+	/* Try to find a child in parent */
 	next = fwnode_call_ptr_op(parent, get_next_child_node, child);
 	if (next)
 		return next;
 
-	/* When no more children in primary, continue with secondary */
+	/* When no more children in parent, continue with any secondary */
 	return fwnode_get_next_child_node(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
-- 
2.56.0

