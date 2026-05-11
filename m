Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9B3FE37B;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510244; cv=none; b=mdtjNsGbsQK0J+YiL9fDflYjz1zBGN6TDEitWHc0IdCWFvVKxUNivnFILDnTtj9SHuyhqIHXTJZi1hosYRlvAyhCqGYzLDNa+JFA1oMxOjfy00Ee6nsR8UmGJ8rLagEi1HTMtqK0i+Vu1gpcz4sRVm4PPrCXZYlXR5Gl63wx/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510244; c=relaxed/simple;
	bh=b94tPEnD6maJKXICVqXB7tFOvSmpC6EOT8BuhpCgtgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGgBfUkyONIRRQgVykIy1/eM5XFrueRflz1+wSX+rdEPsCdpLuP6tJoOe780YfJ0Qhg/JvoWUJF3ndxxsC2os+Hw2rprgLiZCflL85+lFUri95xKnZupD+94UxvL3a27D1dOekCWyysy5l3v06LP54EIrPn0dBNs2PdNgiJyFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdJRGHpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdJRGHpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94831C2BCFA;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=b94tPEnD6maJKXICVqXB7tFOvSmpC6EOT8BuhpCgtgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdJRGHpylu0t2fSVXW9buUFmD6IDAUh6Cuk5eEafpil1GejTRk0LKtUYbr3PthSgC
	 B2q4PHB2QGAvhl5GUipAjT4Qp29xD/u7gPaxBdVLKSEWncFaQabk28nlu1VlfFJsxB
	 cP2N6+d7nkafCKIRKoIseFOL/hRw4LHgiFcJSzsMSV1QMji9eCOybmglEBAabszVn9
	 1/jjvbt3VIcp/tguT47ZYA0pZeOG9PgwgOKmxxoVwoCzaq/bx+83+yj/O1+6pcmz/p
	 l/gKw5C7LGXI5ELovyCzefdzdzs4oB6AcqqGXa7tgvjeBFiDp0yyerQ8TZBNE5nwuR
	 7x9NV6LTmhYIw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033qP-17a1;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 10/10] i2c: core: clean up adapter registration error label
Date: Mon, 11 May 2026 16:37:15 +0200
Message-ID: <20260511143715.729714-11-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511143715.729714-1-johan@kernel.org>
References: <20260511143715.729714-1-johan@kernel.org>
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
index 2cd384433d83..5ddd985dfccb 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1621,7 +1621,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	res = i2c_setup_smbus_alert(adap);
 	if (res)
-		goto out_reg;
+		goto err_deregister_clients;
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
@@ -1640,7 +1640,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 	return 0;
 
-out_reg:
+err_deregister_clients:
 	i2c_deregister_clients(adap);
 	device_del(&adap->dev);
 err_replace_id:
-- 
2.53.0

