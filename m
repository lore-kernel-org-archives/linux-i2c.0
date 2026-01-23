Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C33081B0;
	Fri, 23 Jan 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186057; cv=none; b=oPgdGY6FdahGBPMhcU6RgjtOeyqZUMVdg40nShhSLeg/Rn+Mp89rBX0PqjrP7n7zIR4i3T3DnSN3N5A0jepxXowjEwBtUPobj8e2pSy9UVazUKVGbmJjI6sSh1cJcb17a4LooZrjHE3mb3lQu5W715JzR5pw8cOqbbtnZMqP1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186057; c=relaxed/simple;
	bh=Uwth4qQHTqLwY75OKA44FVxHDgLRiSU4SpL+uWLAnHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ogf27tMFJf0hUekNhdXtZNt8RYbKArpgl3vTAPZLoN4+jwIEowRdjpZkGpozZPMGodhvukXR/POcZtp+tIHOUMKalZt7bfW86WviSSUd3QX5RVxGKegffwonYdWGmSrWmABV5nGZhHCG5Xkpyu+95GnOKBUEQrd5UTHiZ7F6uMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phg4aZ3L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phg4aZ3L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DB9C2BC9E;
	Fri, 23 Jan 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186057;
	bh=Uwth4qQHTqLwY75OKA44FVxHDgLRiSU4SpL+uWLAnHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=phg4aZ3L6uad6Zyl19V4tpu029pg4BalZYOeH4yb/P1e8qu6m5tKRdx7qERNh+TgL
	 g6/tg8mhIytDyJFtWDikAdA+75BUE9XyONFXzZ/Rb/9sZ7wbdWusZ0n6JsJbCOZG3F
	 5ehBlMau0UoU2i3IvW6SnqZIA1TyHrRDJX4BPLcJ1lz2j5q0kQVWpFht225h+53Jv2
	 WGv5/IEnT3hjfvel4kd0VhssX623UPqVItZ5I8WsGw11alRRFC44zFDvThL6QaxxLI
	 a3XUH9eXsLZ7LERNKI5GnaR7DlO8RQWX/QOjIuZxcsxe/LHrPSDaaU7ZmR0UElV2vo
	 X6bdZvDlWs0pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE73ED6CFA7;
	Fri, 23 Jan 2026 16:34:16 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 16:34:17 +0000
Subject: [PATCH v4 4/5] i2c: xiic: remove duplicate error message
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v4-4-4a3eba3510ce@nexthop.ai>
References: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769186056; l=832;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=BSG/SlNQJILNTQbChjjZzK6BX9LQhT0R0SiLAYGmwP0=;
 b=t0BNbvH3/YpRUwikr6asJyBLXrzq6x9Q0JfwDHrCRBlEXFsYW4E2uVF2n7yiAIgM599aax/1O
 FVC8s6Uy88lDmkb899+kUDIqiIDSZBIXbpqxwOhNkM58eUdSwizZ3Or
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

The devm_request_threaded_irq() already prints an error message. Remove
the duplicate.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6d47c9972719..800a27413978 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1491,10 +1491,8 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
 					IRQF_ONESHOT, pdev->name, i2c);
 
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Cannot claim IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	i2c->singlemaster =
 		of_property_read_bool(dev->of_node, "single-master");

-- 
2.52.0


