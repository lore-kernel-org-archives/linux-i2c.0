Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5BA15624B
	for <linux-i2c@vger.kernel.org>; Tue, 17 Mar 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707258; cv=none; b=XDXzKznJxEyksVjKLRrXBRYhVZOM4z+YCtpL5V02B5b7ouJYJ71DNGrsZnbxihRr5A2Vi/c4x4rMPgtOgI6zdtzL4aM85duIucOtHQJ5Zxu86poHJxA71UFstYZRp1yt3sD5xcjBguOyZ+PF+UOiB1kEJkMwg+Wn6HU8tWPKWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707258; c=relaxed/simple;
	bh=gNmjgpW/Y+P21Wq8CTMHqjQ/bWwEJX3LvBxNpqU5zVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBkSti0Pd170xQLrAlXjgPUtp5INV3uOLwRTT+faSR02bbHgkZRa34IH6Ix7sMN/E5CPHAdfqEuHgBmE0gfy/t/0Osf1DhiBDckjiP+eIZ2LuSJX4mcA5YRdi2wPf7UD/nUlAuaTYYUMwtvgRareZ+xoJihwdd6PDPv0HY+Fh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nopC97FT; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nopC97FT"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82985f42664so3358540b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 17:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707257; x=1774312057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl3Hhb5H1W1bOTwoWwjPrvMCUzzs+o+s/sL0FfKCb8I=;
        b=nopC97FTM6i8BAwa3VutD749G2ZkfpA8S93A3cw0cO0XaiGNtuxv4Otph1Srjf9LrO
         mzANeb+Zfqs786w3gysMLAaQZkM+c2UZSZNKqGpjwSPAGkzjtA89n43yzg7t9aJTHv/C
         D8QLUUKBk3RkM5nMP8rOCtQb2Rg17O4mjO2XOj/tO5WmYlj8zXEcAL2Np1OoBVbQedh/
         8IkysXu1POsBM62UWM50lits1XcfZCeO90ibkGE+yHQXb/jF3G4XD/G1tuDlIA1uuFDk
         NOakRCh3jUoVSTaFxltJmNln15ul0RpjZIJ04JdjrAbpZgccT2K3XkoEoNa+V+CW3WTU
         MqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707257; x=1774312057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl3Hhb5H1W1bOTwoWwjPrvMCUzzs+o+s/sL0FfKCb8I=;
        b=PrENctRSJ9ogBjxk1PM//6/G2fEf/1gwtUs1NRPv5BJhx3zW/tUAO4Kn9nM/8SRJK6
         zL08qGZaBNq6FZogB4fTQGyWYBkeY7Pc28EGrHjIQvSaBvliY1s9SMgB053+KaG8BkcM
         VsDQd3BZhSdxtSSWYt/+TNTJQsVDdYS46whcHybvDKtJX6kiiwXmON3sRXR5vn2Vvsgu
         YaI/n48uTviw6zWHOi7u0xx5Cgxzu9/yEtH+VnXd+r3ZNzrZtR3OHYQHHRs+Kvm7yBOh
         U+O2ko4qOlfS1obekCoFZOEx7eVwpTPeVtXUrZJmpGXis/8ugLMPy6h5uAADJej9DUir
         8gmw==
X-Gm-Message-State: AOJu0Yyrx5YBoskA+LT/KGmFfewtxbzA8xUg9UJQqv+DOFBc0S9coTDO
	VSfuOabKz4Et91SDnELty70bFFlaQwS+knFZ2c1pTfFDt7pwztGpnNHvQ4buHHe+
X-Gm-Gg: ATEYQzxdWvuX+fPvzbgMx7Vn2Flfhg0OF6kNJs91VaniJj+DnBxhmX4nEWOb4UjxkNw
	+JGlWLPvUqOH0spKYnnUzALV/ym7OJGQ/oY/mR3/Zmrn3RKdJhkqN5CHgAqEq98gqIFBTL8Phub
	4zbHNb1KUE7g9Q8UkoHpFvr3IHJZQwyxPiAhjtmJaKzJjlyK5EeRN6UC5oE8yGYMP80eunnbEl+
	a3Z301+pdi1KvkBZPDT3ee3GRmBNJFL2rqkUot/iuUe0+htUJbyYF+zLqLeH3iyQA0keC7TVtwO
	+f+DTF/UHQV37rxTvXiXVFyser5sEkZQXBGMeSpoKbqOtHpuRilTxviO3NQUmtmoKgYCBibRK0R
	gGAIgVUdzr7nXgiHbtJkmS9XsrMx8SqbVFsow+I9Qw83m6zmDAdZv72AjVrL/rHu3mn9GsspBGO
	9JfQZT3Yi2reE88Pd2YO4ReWMu3MSCKj+KHt53/AGD1ERstLSdJrx564Q=
X-Received: by 2002:a05:6a00:130f:b0:81f:50b1:51f2 with SMTP id d2e1a72fcca58-82a198ac3b2mr13377514b3a.41.1773707256696;
        Mon, 16 Mar 2026 17:27:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340518sm14720798b3a.34.2026.03.16.17.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:27:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] i2c: keba: simplify allocation
Date: Mon, 16 Mar 2026 17:27:17 -0700
Message-ID: <20260317002717.70829-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc into one
allocation.

Use __counted_by for extra runtime analysis. Move the counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/i2c/busses/i2c-keba.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keba.c b/drivers/i2c/busses/i2c-keba.c
index 9420c8b342b5..23ae8a609008 100644
--- a/drivers/i2c/busses/i2c-keba.c
+++ b/drivers/i2c/busses/i2c-keba.c
@@ -51,8 +51,8 @@ struct ki2c {
 	void __iomem *base;
 	struct i2c_adapter adapter;
 
-	struct i2c_client **client;
 	int client_size;
+	struct i2c_client *client[] __counted_by(client_size);
 };
 
 static int ki2c_inuse_lock(struct ki2c *ki2c)
@@ -508,19 +508,18 @@ static int ki2c_probe(struct auxiliary_device *auxdev,
 		      const struct auxiliary_device_id *id)
 {
 	struct device *dev = &auxdev->dev;
+	struct keba_i2c_auxdev *adev;
 	struct i2c_adapter *adap;
 	struct ki2c *ki2c;
 	int ret;
 
-	ki2c = devm_kzalloc(dev, sizeof(*ki2c), GFP_KERNEL);
+	adev = container_of(auxdev, struct keba_i2c_auxdev, auxdev);
+	ki2c = devm_kzalloc(dev, struct_size(ki2c, client, adev->info_size), GFP_KERNEL);
 	if (!ki2c)
 		return -ENOMEM;
-	ki2c->auxdev = container_of(auxdev, struct keba_i2c_auxdev, auxdev);
-	ki2c->client = devm_kcalloc(dev, ki2c->auxdev->info_size,
-				    sizeof(*ki2c->client), GFP_KERNEL);
-	if (!ki2c->client)
-		return -ENOMEM;
-	ki2c->client_size = ki2c->auxdev->info_size;
+
+	ki2c->client_size = adev->info_size;
+	ki2c->auxdev = adev;
 	auxiliary_set_drvdata(auxdev, ki2c);
 
 	ki2c->base = devm_ioremap_resource(dev, &ki2c->auxdev->io);
-- 
2.53.0

