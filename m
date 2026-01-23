Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648EC331204;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155385; cv=none; b=Rq6yO/4q5wewE6i1Jk3XDnZ4hBXq5jGSStrqEe2WbcIfZXrdprvE+nC1m6v1QGSAVuoYvmldwdYg/rTa1irhDzAe3GBfUtTqwfNRcs0eL9zrxKiCIuV03rfxyAB+ZW5Br5EU3N662eVVEIMq91WfRsid382IL4P7b/ywwhVbRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155385; c=relaxed/simple;
	bh=Xir6qCWx3Kn1i0hDSDtt04zmgse5Q9Xo6I9ownNJMS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBR1h6+FiQa2tFsJ2cVbGQS6Td0vxxF46jTwVozYHTnH9fK7vj3FPuZZ6Jj03qIMMa8V1bIsegcy3d9RDiI7U9DvkgvLYalWUpNUQrNMC1pjg7ibpZzgRqppWf2N9CUgTDBBgsPuTK+aujRVBqS0D90OrfFlv6rrjPHNRuLCEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTB1bj9y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTB1bj9y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22BF7C19425;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155385;
	bh=Xir6qCWx3Kn1i0hDSDtt04zmgse5Q9Xo6I9ownNJMS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aTB1bj9ypXRsPTKwVFqV7xOuk8x07YzwHaFj4cIA8GQpq3hJnrH6WgvUB6NKE/xyS
	 stiAF0iVs8c2a2/7gv1Us6ULy3bUk2pdEUhQ+8996WAu5IQG7cg+QaL5CeMN3Oz+1I
	 Wp/FzNXwAweSuI8DDG+TrQB8uOhdZ80le0MDTJVuUhKrLC9W7jfFQO8V6BrRa0C5SJ
	 LYWH4N5cMc4dlHwa15EVMmi2YsZ2qEsSZQZNMGis4a/pl9rxHoeGpXMxhTzfvrQ935
	 6+rrOWDEnSCaY7iAyxyEadtxR5eXdIQetrH30TvrHutPkZ491r072JQ88943hZ+nLJ
	 qI33bJFiiMRBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10565D72348;
	Fri, 23 Jan 2026 08:03:05 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Date: Fri, 23 Jan 2026 08:02:45 +0000
Subject: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769155384; l=829;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=jX19wNjldXvkgpDnhpI8JjXsRDG7OWfTod3nsZBV2bo=;
 b=OKAesYfKMSjHZqJsxbM+6VRSrcQKeu5XI3rbg7EWS0f4Af49BaJVG/nmff/qmIVwbt+paDW+x
 R+cl09zLzWuACIoSgxvs6nRlqvCtIhtNyDVspfUPhXD0/C64d70dyZP
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Simplify the error path by switching to a managed version of mutex_init.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/busses/i2c-xiic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 603a246a1445..79643c27e75d 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -1461,7 +1461,10 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 	snprintf(i2c->adap.name, sizeof(i2c->adap.name),
 		 DRIVER_NAME " %s", pdev->name);
 
-	mutex_init(&i2c->lock);
+	ret = devm_mutex_init(&pdev->dev, &i2c->lock);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_init(&i2c->atomic_lock);
 
 	i2c->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);

-- 
2.52.0


