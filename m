Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B23806D0
	for <linux-i2c@vger.kernel.org>; Tue,  8 Sep 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788848788; cv=none; b=DQznU3qOKlmdGd3uHzKbFFmFugPGVPGk7tuUkyaUW8aEyuNVtZBFbhD03B8Rf2XV6yghHAcXhCqp5va4at7YXMmjOcXQQc9TVU2/fN07egMp8n8BUxivY6Dv5UqB5C0BwHj107tR8VqHGudI9aj/ikzYfyA1yYmSJDekEJ/kHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788848788; c=relaxed/simple;
	bh=Yk2YL2UD+FGXW2dMqL1qmIyf7rf2SMaMRMfp5GgJCSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBM08Pxxz4k0tQWYGmQurezu9+zAOylcAptdKilR7HlaIozDBUG9/W2lacUVyU5RLpGbWJYWTawWw+fk9cEAl4gnJ93oC5z4SiVBusD/mjcXq777h+ZnCgVd333BjvSW1Xp5GT6YXNxuYiyWrY4nCVwMRFA/hXCtzSUd+DunuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/z2QLmo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/z2QLmo"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso4051464a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 07 Sep 2026 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788848786; x=1789453586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2A6ylyPMvOhYX3B65YMjMtxuaf6aCsl7CTkZbc9h9k=;
        b=X/z2QLmod5Qy5TS8dhQNMzd4r/Zm4yPnWzQEG7LFC6BEYOxSnhxKuMtgo2VCQRvYlq
         nfsMMoSCYEb9Q5LyEBDgVVvI9id1qvs8S4aBvKpkMT7s1IUmxR91bTkDAXMKzm31Wpvg
         G5yQCfSj6G79yXWsACdKR++ezjBsJk8OfuCWYv52uZ9fl3c7C59FMOfHe/jtaqjes3/s
         aj1z0tD4RfiS4b6JQv8DnwCMLadgrkWT0CueyMmTGHgp1TR9iXgsCQENVkQOTGi7SobM
         RJWaKWluwqm5q8msiiafm/9/6dhROkm4MEx+r2q3tLd01nLIifLh3ztzdefaU/Y5dEDi
         d8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788848786; x=1789453586;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2A6ylyPMvOhYX3B65YMjMtxuaf6aCsl7CTkZbc9h9k=;
        b=jy+EjcR/S9PtBQ0+LYHKiudBiteNNT3KpWYO5LjeT8AHZOS836fery7x2dtu9k5beC
         TmXufutA8R2Dld16gxMAqeNQp1a0AE5npTrQOY03v1tnP/04ySx5qx1NIJyJtLTI6PLE
         LWvTx9deYLcBJAsJSbcUsffhyZulsYKSMkVM3h6aQoCfCk+2ihHgHpAeIv5PqndF3d1/
         Z3UYpcXLy23bv4CdJyQcwTl6hmhztb6JO9prwGWlRmkab0Hlz3WHOteMDBfpdHGUSqRh
         X0R1w6d60iYqYIfDBR978XPf3q/IEwGOva+rO1NNPnABOUFO80TTvK0eAMY4BCBhOM+K
         1WHQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgnGOmP0PZqy0W+gdvtlNDf5FJs9ulzIAOgK00dPVc0uWFvSIL3QNMFMyjIq7iwXAD9/tV6h3j7VE=@vger.kernel.org
X-Gm-Message-State: AFuF++l8MBf/pN25AZ9UsspcsGqKBXh7eQf2f0+RQYZQtWvFfRZKOw9x
	SNE3zzR3Ee3r2XjV8nQj/hWkqPxuY458SyWnBpUL2KT9RYxa/nRWS/da
X-Gm-Gg: AYBFou2xADJxnevfNvtv/zZlYM0JA18xsQAb+GJbo5bDBiUX5PPnOhB5sIzJ6J6c9B/
	sINajbrZnjvo1JGGtcuIEJpPESldOJKvnJpBwFwCai7/KMiAkBD/Q8znWTjqkfXQKeawO8TnSAw
	Hvzy51rNXBZ/hRuox0ReLaCvzMoueYEl6TMXIOYeo98UdIyOCXCW3J18LAkKplMU8A8s0iKmEhV
	7/Jt+QMqD02LazZ99PtN8cgLrTtQKPuTJ07xSAVSF2B5QXp9BTQunm32BciUU2cFyE7LN7zfCWl
	Kq9rI264EqGtzdrj6eUJZXuOxAW+M4R7qU3qMB6DFo7jJw1JbCnxhmKiJGAWKbqThdZjevpD02N
	ljEk58T2oTYwYGqAmdfdY7WbsaYad18C6QuvtBOMQUxzawXKXuwHwua3owfKGR5MpzuxWqQouLk
	TO4BOWNoEx3jQ8EJZH6U3muovNuksIVrX/iWznQrUVPN7CG/qcmnqO5HhWTIyNrkLZ71SaR3ejb
	lRoA4lamjNm+MJroAWN3HwJmX//mCDBNW+tkuYeotDqrp/wvPDCQdkh4GolE+wdRZQAMKR9bdRB
	YUVDUV2q3BX7sBBvZkeEDKn6GHy4Wmw=
X-Received: by 2002:a17:90b:580e:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39b261cfd97mr38329981a91.14.1788848786168;
        Mon, 07 Sep 2026 23:26:26 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm30960386c88.11.2026.09.07.23.26.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 23:26:25 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] i2c: mux: Propagate firmware nodes to channel adapters
Date: Mon,  7 Sep 2026 23:26:21 -0700
Message-ID: <cover.1788623619.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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

Changes since v9:
  - Declare dev_node, mux_node, and child on separate lines in both patches,
    as requested by Peter Rosin and agreed by Andy Shevchenko.

The broader __free(fwnode_handle) cleanup remains a separate follow-up.

Validation:
  - git diff --check
  - strict checkpatch with an 80-column limit
  - x86-64 GCC W=1 object build of drivers/i2c/i2c-mux.o
  - mailbox replay onto the declared base with an identical resulting tree

v9: https://lore.kernel.org/r/cover.1788298883.git.ahmadexp@gmail.com/

Ahmad Byagowi (2):
  i2c: mux: Factor out channel node lookup
  i2c: mux: Propagate firmware nodes to channel adapters

 drivers/i2c/i2c-mux.c | 98 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 46 deletions(-)


base-commit: 1f3e66348d2527c31b9bedb0b4d9e28bdad9bc83
-- 
2.50.1 (Apple Git-155)
