Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA9480354;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=LE6cur4MAa6R3WSfvLh8gVths/Q0LzTiEJ2m4FaKrllp/F3lJ7FyOsxwC/6kknfMDQl9/y7H7TIDxCONWfC9hyoGD+ocAm1sKH+DLEv6+ao1YIbfqvE2NLCX+pSAlUX86+kZpT0P+qF7T+8nRNCIMokidCoIob77W1RCoawjoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=3CYu/nGSgQGBuqnz2Dwr8lbzgdlgelmyYppWDzvi27M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWgh6ZYk6UiL8LHlUO/44tc8LiMkBMouVBVEWPAZobYBuQd85CkGrjd9oBmSE6AeicrUcLigJU+Tqyh0BicJrtJUs6zLcsoPZh1N4LAeRgMmoYQh0xEiBew09sUgN8O2wn7D2xZKUGhwBgMXRxgqV5glQURDq0GNAwjeVtOWTAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6GeaPf/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6GeaPf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9EC2BCFC;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=3CYu/nGSgQGBuqnz2Dwr8lbzgdlgelmyYppWDzvi27M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6GeaPf/2D48V/BEH07sJpA+gXuQuG/EwI8R1FF4MpH6+Tz5H3lYJN/rVhyHwbQuN
	 6cux5ndo+tIbQ+0zfjq6m/8nU7uZ0wEMoc0mlaf5epx/wB9rHXN9xvrdNL1B4UsU5g
	 uY787lgyhPTYCziEY2TDiJe+VhNpYCdmuVEogJ0S+BZZvfyE4z0IuN+pgvGnUw7X7y
	 dQ/Km0yEri/1muADWoOVeQWTBAqQmhzvfwzNyDcQKDgcflmiAbLFKgd0sZoFABLrJq
	 jD357fUkiGff7gS2YuiR17yt0UmxjJPD+ac3QVsHrv097tDi/H3OswwmGaT+CuiZwr
	 yYXKSeK5eTJIg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Kt0-0ZGF;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 5/8] i2c: core: fix adapter registration race
Date: Tue,  5 May 2026 16:25:44 +0200
Message-ID: <20260505142547.795054-6-johan@kernel.org>
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

Adapters can be looked up based on their id using i2c_get_adapter()
which takes a reference to the embedded struct device.

Make sure that the adapter (including its struct device) has been
initialised before adding it to the IDR to avoid accessing uninitialised
data which could, for example, lead to NULL-pointer dereferences or
use-after-free.

Fixes: 6e13e6418418 ("i2c: Add i2c_add_numbered_adapter()")
Cc: stable@vger.kernel.org	# 2.6.22
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 31f7d43e4ab5..be909d6bc776 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1587,6 +1587,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
+	mutex_lock(&core_lock);
+	idr_replace(&i2c_adapter_idr, adap, adap->nr);
+	mutex_unlock(&core_lock);
+
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */
@@ -1633,7 +1637,7 @@ static int __i2c_add_numbered_adapter(struct i2c_adapter *adap)
 	int id;
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adap, adap->nr, adap->nr + 1, GFP_KERNEL);
+	id = idr_alloc(&i2c_adapter_idr, NULL, adap->nr, adap->nr + 1, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
 		return id == -ENOSPC ? -EBUSY : id;
@@ -1667,7 +1671,7 @@ int i2c_add_adapter(struct i2c_adapter *adapter)
 	}
 
 	mutex_lock(&core_lock);
-	id = idr_alloc(&i2c_adapter_idr, adapter,
+	id = idr_alloc(&i2c_adapter_idr, NULL,
 		       __i2c_first_dynamic_bus_num, 0, GFP_KERNEL);
 	mutex_unlock(&core_lock);
 	if (WARN(id < 0, "couldn't get idr"))
-- 
2.53.0

