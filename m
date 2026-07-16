Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639D40929C;
	Thu, 16 Jul 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208695; cv=none; b=kTUniMlnxQNzESIPs8+djQZ4PsQIdB8cDSaGcQPT7mJ6QuQVVrWhZb44Wx6FB6dzzqHvGYHfHasZua/J6BpshOkc3b43ngFfmJ5hBBfLXCNp/wFDr9q5KfD5gkwnZPB7kcTTEb13/TxTWZmqo6IaIhbzYl8fjMH7X+fNUiSTOwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208695; c=relaxed/simple;
	bh=fAX7AE49F0xkh2VXwTfjpprI9otDa92+i9zzaP1xLY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8MvcvNazQ8YgnC1rlKPG+4J8jSp+OipNRDGy+6CM3z5ttiYGjRWcaRtw1w1WH0ah1duql8r7KWOrljw9INsktABGzISsbye5kId1o4S/+8ojWELo4+NeuvHjutUwCS0qJFv0MXXj+1zV3dS+sF7f2L35HhxXLxpf5ETZLczvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNikVE0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNikVE0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B7A1F000E9;
	Thu, 16 Jul 2026 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784208694;
	bh=+3Fv7Q3tvcpKCMRhkriVV4RAWZ/+tqrnASaC9EITWuU=;
	h=From:To:Cc:Subject:Date;
	b=cNikVE0d7rbCf5wmIGD/bmt8irlxWhxihnujMyLSYE/NCKj84XMHCI3QrtavAnnwf
	 xar2EhK6CBkPit1ApUlUp3ggqZXbhNb5l8jNEUujj//98nz2IfSAPeO6iI58tBd1sY
	 nbaiCvbWcPWJ4SAmf05GnVDRpguNUYvSgIQPTPs5Ycf5kzt6wPDeph/DbnJwJVeFFD
	 ekaSW1ZdIL4yuDbeOgxK1MUm+urvhLtk17eChz6A5RWSeCjzdUZHHBiVeffkdZDCtA
	 JRoKY0tWWkLr6h8ivEcYrqNs11XF1X1dEd1WXuEK+OOcUg2zI8iWuuOA7DB9xdGxoV
	 74zLbtv6Ori/Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wkMBY-00000006ZMm-1h4G;
	Thu, 16 Jul 2026 15:31:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] i2c: core: document preference for i2c_get_adapter_by_fwnode()
Date: Thu, 16 Jul 2026 15:30:29 +0200
Message-ID: <20260716133029.1565853-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Document that i2c_get_adapter_by_fwnode(), which also takes a module
reference, should almost always be preferred over
i2c_find_adapter_by_fwnode() so that an attempt to unload the adapter
module while in use fails gracefully instead of blocking
uninterruptibly.

Note that by implication of_get_i2c_adapter_by_node() is also generally
preferred over of_find_i2c_adapter_by_node().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 3ec04787a737..dd4a813d4360 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1895,6 +1895,9 @@ static int i2c_dev_or_parent_fwnode_match(struct device *dev, const void *data)
  * If no adapter can be found, or @fwnode is NULL, this returns NULL.
  *
  * The user must call put_device(&adapter->dev) once done with the i2c adapter.
+ *
+ * Note that i2c_get_adapter_by_fwnode(), which also takes a module reference,
+ * should almost always be used instead of this one.
  */
 struct i2c_adapter *i2c_find_adapter_by_fwnode(struct fwnode_handle *fwnode)
 {
-- 
2.54.0

