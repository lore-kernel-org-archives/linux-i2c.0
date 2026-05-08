Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDCC382388;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=D2xMCghU5GrIY1mTmq2fTSsfWeIKNkNVSzM5yfzhIWEW3aEbEdTu3oUIu7kSf19zf5nc7xXrrkrK4pKkvXWRE050dIp7/BSxWhynRn0Cr6o8I7SExuO2NjbOKeubHF7bdw9Ev9QhxvirSjXpJYG2SMHotDGFaJMMfuGz4U4B+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=Qq6J0RU0HW755i12+ls3OBnnmBATDz0rz09PJ4LsHqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD+8n8DAf557H1xh4EPvCeoP3MQoE7I92GGkG7aofJH6xJ9ooF44dx11CNsHqAS0FRwcPzXKn2sIRXUSKA+oBpUuHsjEGKoKMEZC1/U7ShK7ndKk4KRq3hZcp2Y0bUauNPtGfqMr1BVRJLjVykG5OYXuudR+kw8l+ryjUSA0OtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3hpb7qd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3hpb7qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31178C2BCF7;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=Qq6J0RU0HW755i12+ls3OBnnmBATDz0rz09PJ4LsHqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3hpb7qd5oDM6VvDdP2wskyg1UbweGBGLJlBkO4TXlNh18r20kgGfne1hGQRvYY7O
	 B/PvkgqFQSLXQ82DcJlxojiAXN6rTEF3AgllVrUPziKPg8ouFM8Dgtn37grdUSF/9e
	 PT75T5G0cRu3stSpdpBWwTyLJWOy7G9qb/cimUEL1A+TMIHEEer8lBdFJcRTtIY8QY
	 ehI7HNkgj2TxYZH0NA6XLyoDpSgZ82AwApaz+5otrD/lL8QMhSZGs+IMG9Tj+wk7Ng
	 2OJtsK7rPSEsJ8VfCeumfojaobLFHNifbKMer7r215vQ45yK7ylWKuWsvjKucIx8tP
	 YWcFLqKmhUL3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7K-00000001ah8-019k;
	Fri, 08 May 2026 11:03:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v2 5/9] i2c: core: disable runtime PM on adapter registration failure
Date: Fri,  8 May 2026 11:03:07 +0200
Message-ID: <20260508090311.379333-6-johan@kernel.org>
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

Runtime PM is disabled by driver core when deregistering a device (and
on registration failure) but add an explicit disable to balance the
enable call when adapter registration fails for symmetry.

Fixes: 23a698fe65ec ("i2c: core: treat EPROBE_DEFER when acquiring SCL/SDA GPIOs")
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8bf85aa2f0c2..20d48cb84a6c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1609,6 +1609,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	device_del(&adap->dev);
 err_remove_debugfs:
 	debugfs_remove_recursive(adap->debugfs);
+	pm_runtime_disable(&adap->dev);
 err_put_adap:
 	init_completion(&adap->dev_released);
 	put_device(&adap->dev);
-- 
2.53.0

