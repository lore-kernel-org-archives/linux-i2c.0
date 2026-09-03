Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247DD50AC0C
	for <linux-i2c@vger.kernel.org>; Thu,  3 Sep 2026 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464492; cv=none; b=LL0/R/1mEzuyin4WjEd0yghuuLkBz4Uc9197OjB0auqmiEuMlyFVoWU5Q1bNL1uTo05KNJ5l4bbh5ahlY2DpxH26DzN+AisuK6X1GBUcj2NoHqSDCL4LV9UxwqucKUAUGvuO4uvuTa8vA9iOvO2FKosruh88DX5E6udmKa4N1YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464492; c=relaxed/simple;
	bh=N+U2wZhd3H6jH4C6wah6BhkYUFxPu8drpgr0MmmfjXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9QOzUcoogKC/acCRYPfXB3GxM0+al4G4bvMyupQ7tg4LoVfCBkXNhJE1C1d5wcays4sJLPU+hN1IOYLttaj0a/YscGD7PaqEOynaHnSJI8j9Kc0+qQlhqy529/r/oX7cDJgY6tql8WbYXJleEDvMsNppSqB1M8CI3yRMBF0f7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLCz11yu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLCz11yu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d9b60c652aso2290705ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 03 Sep 2026 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464478; x=1789069278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALsQc4Pki/X6P5tsWmhZ+GXdkUBRbPhGv6524WdN+nw=;
        b=hLCz11yu3eDXk3MVZ6H6E4CJTPpaWP8DbGb5XVPs/vsk9hgG7Iy82eKk/ewpN3vTR7
         4ZaFlMqdN9GKWsnmL6D7dx0MAlhph6UvQgHD+bMEmeAbWZrn/yjWuO4RuuAFy6vCiNDC
         MyeCwjeKVmYpojBLkOqMDAohxksllPQOGVFIDL1egwAIVqSn7mlbh0v0tHRqx7eRdypO
         c8ieYhktdbqYSnKKY1wB5zFgXdD+zzs1G8JYsv3pr2lTutKsQ7h7EMzPJj08mawayVWs
         iGdQ7nxuCeed1qpAJviMi72Qn+YuB92EictjZgOyu9dKctc0c3x/VMUEMMOlyTrvre15
         fQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464478; x=1789069278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALsQc4Pki/X6P5tsWmhZ+GXdkUBRbPhGv6524WdN+nw=;
        b=rkCeKtw9zOJJJPa2lIvSd89ShZ8Opmz9raG5nLQ1RTFj0AFfPkgDaeUU+FP+mA8nH8
         Y4bw+T0jBn0/5wguaqLlRlXCsOtIuNWzsMite4ksD6DooZ0dleMLp7uNyFKz1CuYcewo
         2Z6iyEIh2HMrzaIDKPqklQ6y3sx4dLaVvRctwib3bhER7MI+nJQRL8N3lYoPlLqYXf85
         /HfeOtQLIAH659J57Q2CCJ+xzNIVTPso63t2uuhNMyhf3gBoPo6HmBT9RILpDCt3AUKn
         fPWi9ivPyCb+JX21i4Uyt5KY7fpPpdBlcV3HS3uh1q12VqGMTd2lTZzjrEhbddKbMKoy
         clpg==
X-Forwarded-Encrypted: i=1; AKwUvByIbIKM5bLWFRXFC0pA1CSA2BlAacNhhHtwII1mBoCsmVsjKeugKb95/DcTTnS8d5swvYFb6RfPFho=@vger.kernel.org
X-Gm-Message-State: AFuF++kKWMg5LJZOQjw0Om6iiBQRezEczjxYhczz/2Hs0SegzrwViL7I
	nHHjC0yhKb5JWDrxyxuzgYtbvgxMgk/eu0kh2qA/98xDc6KRQpLQH2Swrak4mKMs
X-Gm-Gg: AYBFou2MBm/SGLSXnckcog1/RawjEQsLuZTRHsHpOTR41TOu08ArJE0zJvBPWclEwCh
	Z7ZGj+Xc0TaPYsGBqq9Ks2IBnlCQzvlBPosuLVixUJ67QIapzHGFBOGVEmBO/APOiARotP8IOXs
	UkbiV8Z0/0Mig4bf1zXlmcBM9g1ZLr9HMK8BTZIzGP9XFu/PcEYHjt5AHEXGTnr+KrVFHOJwTOl
	PLF/YjEKjULJzxfrdp8d8b7OygQwe+lS7Nd5DIoTydKSUqhJabEX43akGIkDyyYAQG6EGfuOg9Q
	ieslsSJzxYMc9kfATuGRtYmYgX2aIYhp1wo0BX6FCvDlkMy99imAER42yKXehjp3NpkCMrGoBBS
	E6Wq4xyR0Vuf01cPr5nlcFxJkVtHrbI7vvWHE1EAZJCTWg1v2g6d1VXAYULm959EN6uKEJJt0Yl
	WaYUYORZDCaIHLVXUlUGsjw6rqa7T0tIpuNJ4EvV7W3s9soMyZmpvVB7EEI74AAmpiIDj4GPLuy
	2bvz0CUjAJ1HxcduOv+w7gFMbEFJo+Jo0n7IQq819Hd2LOK9HuzOGv7/50s49Q=
X-Received: by 2002:a17:90b:4a48:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39b260d2d58mr1134016a91.6.1788464478281;
        Thu, 03 Sep 2026 12:41:18 -0700 (PDT)
Received: from mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm888285eec.18.2026.09.03.12.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:41:17 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v9 0/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Thu,  3 Sep 2026 12:40:54 -0700
Message-ID: <cover.1788298883.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent firmware-node descriptions are not. Convert the
existing lookup to generic firmware-node operations so software-node and
ACPI descriptions can use the same property traversal.

This is the remaining I2C prerequisite split out of the Time Card series.
The channel-node leak fix from v7 was applied to i2c-next as commit
385c7af4e3b9 ("i2c: mux: Fix channel node leak on adapter add failure"), so
it is no longer included here. The first patch factors the Device Tree
lookup into a helper without changing behavior. The second converts the
helper and node lifetime handling to generic firmware-node operations.

The existing acpi_preset_companion() call remains in place after the generic
lookup. A separate reference to the node returned by that lookup is retained
because ACPI companion setup may replace the adapter's primary firmware
node. The dependent ptp_ocp board profiles will be resent to net-next after
the LED and I2C prerequisites land.

Changes since v8:
  - Split the dev_node declaration from its assignment and use
    dev_of_node() in the Device Tree helper, as suggested by Andy
    Shevchenko.
  - Preserve the split declaration and assignment when converting the
    helper to dev_fwnode().
  - Leave broader __free(fwnode_handle) cleanup for a separate follow-up.

Validation:
  - git diff --check
  - strict checkpatch with an 80-column limit
  - x86-64 GCC W=1 object build of drivers/i2c/i2c-mux.o
  - mailbox replay onto the declared base with an identical resulting tree

v8: https://lore.kernel.org/r/cover.1788181174.git.ahmadexp@gmail.com/

Ahmad Byagowi (2):
  i2c: mux: Factor out channel node lookup
  i2c: mux: Propagate firmware nodes to channel adapters

 drivers/i2c/i2c-mux.c | 97 +++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 46 deletions(-)


base-commit: 1f3e66348d2527c31b9bedb0b4d9e28bdad9bc83
-- 
2.50.1 (Apple Git-155)

