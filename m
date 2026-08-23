Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442A1FBC8E
	for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502882; cv=none; b=qxLM6F2VZIr1smsI/a+2l8ADAq1y+NHQtVsMe4nsAn4Dx2hncXCNpVswXvhzDFk4WEVx8PC6ipk1KIUgEZcy/BNrqvbEVftMrTBRxm+TPVawxuyHT8EOkzPNZq4gQd2s5/IvApnenrzuLY7EJmodrrba4gQBAi6BPOWLQgUOEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502882; c=relaxed/simple;
	bh=EbN1/J7NyFAesm0YIMkY7NgzVua37K6iIPmF+Cbslek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np1353Up5tUe4l0hb15pXaQOUDUGS7VZR2cFbHnb7iapgObpM5xq2Dszk5fjw6/4iNnJDI44Q+dPeWkyeqmDJVveFIUdrLgirppqcSWs25/4L3BNZVGbUy/2zL3FT7SRbRLBFv7RhSJxMrODTqwsJUk9i6ARbYrzaiHV+KdpLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUSizI81; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUSizI81"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d01663d816so21293335ad.1
        for <linux-i2c@vger.kernel.org>; Sun, 23 Aug 2026 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787502880; x=1788107680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRZGP91hmqwJACNaVBPS28tDx/Jx08bZped2WwvQ79c=;
        b=CUSizI81GVXPNs/Zw599Gv7Yv+rQaoanDHogR3eMF/pPjGDANbymm5tJzRnpo4RSO+
         fA3hV+PGTjZw4dPUL17wAAW/OY67c3rJHkCLvCSK/IofwPxFTdKlZGp/dVHL+73ljB76
         Dsw6warlJDrI8wcZ2kfE/DOCsyWA4FM7m4FoggU6Ha8uhuKhe4NAiiHG8IRZU+iM7+ui
         rRrZP1a1pcJSWHGA43Inv3Kc+1We7huMvNqU2upgL7FOZfC0RTOp/64cDG+kVncx7GIM
         HII83r1g/LIy5lUPigAmBo2ZbLEoqVoX6L6lXPUf6OuM35QLTz7oLZOmyUAhqg45ntMO
         1ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787502880; x=1788107680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yRZGP91hmqwJACNaVBPS28tDx/Jx08bZped2WwvQ79c=;
        b=LekOyCMXZlF+ih4lhiaY17lwuqerSBtznx1LofDKUzEdBZVWcry9JzO2HcrEx8y4wz
         ZoX/IoHvBNcFrd8+7rU8JVdxpSRBrFqa9nl/SGyrGE1EyZmSqqwg/yBcsSAb4qtqERxX
         kOOlCM3wM30lcgcAr2kg4xNmnEwEDtnWhsNeyR7zEOA1S7cB1Vi/iqGAhrgPwQDeCDXL
         uU8adqb8Qu4nZdawnDpQal5OG4HAtuaj+IoJuAWYwlRb01wdvMpSIWFvmDcWay27HsZN
         rkrXsh4sLOuvwNXsswYwsIpwcEmNL0MqX3UykQzZ43H7zA5lHWaA2bLLpmfQFXSCdNRD
         iK6w==
X-Forwarded-Encrypted: i=1; AHgh+Rojk12oN0nRGHGW0Y9hpmO8ucedTP9yncCAgJx5l7dlNvOjMpCmmUePVonl5n+4vZtFk76OwBYEywY=@vger.kernel.org
X-Gm-Message-State: AFuF++m/oCJN5l9Ulx5nxB8Iq9tMRjoYFYKgEHcUfWljzXnZjCj/cS9Q
	Is9CBpHTtSHS6bXf3f2TJDjMy+gF4sxwKAD07UCqq61UgDyi+GXP5SeB
X-Gm-Gg: AR+sD10/fzn7BwsVZiFM3uDX+djX9euCRWdpSIhKBMrUFxAIMYZ6xG9jPmPdVpc5hgT
	ZsUoLh9Lkg+BKvnGAPhLsMQ9lwUnG818U2kg/TNEyCeqmpTOtZBc1fLQA12k4hEYMTtYRAzGmEM
	ONh3F9JDSB4l4tBByEv14C5a+3UmKTnRj0cj1suYclfnAKoTxDpyKStqFJ45xo5Mb+YG//jAGed
	ZctPJaSfqs5P4HILCh1cluXZ0PwjYkOHNQQn+y5zgb00AvbuzsMl2sAimvxLi/nOqpMKxt4kjJ+
	tBdn66vPX3K0QNU3GYuFj3cssnvqp31ByaJPOL2hwbX3NC/Oqo5xsd/BrMxGvkXR9G8tEI/c/Ha
	rJpjCjq00dZM70q0rjjXs3xkMnPi6MuyFvwJhessFa2WrybHPd5lHaAhKthGce5oB7OE7vI8+xX
	vVJcD+9hNR7ENwdDTLcu2Uc3JqywfrDUJRP1c6p4mNEFWOi7Wbm3i3ugRfk1zHO3DO7tssBWqri
	g0gqyT++lzBfFWnY73kJv+tJI+uGk0VS3cz8sCfYYXTXwBYkZPI9NqMfnZw7GIKX1WO0CEIukez
	LEalyDCCe9MoaVPj7ly3Xefg55WfiTo=
X-Received: by 2002:a17:90b:3d8a:b0:395:4de9:b30 with SMTP id 98e67ed59e1d1-395c353e28dmr36726682a91.5.1787502880486;
        Sun, 23 Aug 2026 09:34:40 -0700 (PDT)
Received: from Mac.net (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860ef75esm17084319c88.7.2026.08.23.09.34.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 09:34:39 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmad Byagowi <ahmadexp@gmail.com>
Subject: [PATCH v7 0/3] i2c: mux: Propagate software nodes to channel adapters
Date: Sun, 23 Aug 2026 09:34:35 -0700
Message-ID: <cover.1787502619.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device Tree channel nodes are associated with the adapters created by
i2c-mux, but equivalent software-node descriptions are not. Use generic
firmware-node operations for the channel lookup so child I2C devices can be
instantiated from software-node properties.

This is the I2C prerequisite split out of the Time Card series. The first
patch fixes the existing Device Tree channel-node leak on adapter-add
failure. The second factors the Device Tree lookup into a helper without
changing behavior. The third converts that helper and the node lifetime
handling to generic firmware-node operations.

The dependent ptp_ocp board profiles will be resent to net-next after the
LED and I2C prerequisites land.

---

Changes since v6:
  - Split the existing Device Tree leak fix into its own patch.
  - Add a preparatory patch that only factors out the OF lookup.
  - Convert the helper to generic firmware-node operations in the final
    patch.
  - Drop the separate private software-node pointer and use the adapter's
    firmware node for cleanup.
  - Save the firmware node before adapter deletion, then release it
    afterwards following the i2c-atr lifetime pattern.
  - Rebase onto the current I2C i2c-next branch.

Validation:
  - git diff --check
  - strict checkpatch
  - x86-64 Clang syntax check

v6: https://lore.kernel.org/r/eb4a8ab1eedd8a01ca34c6a7e0685639d0498423.1787247467.git.ahmadexp@gmail.com/

Ahmad Byagowi (3):
  i2c: mux: Fix channel node leak on adapter add failure
  i2c: mux: Factor out channel node lookup
  i2c: mux: Propagate software nodes to channel adapters

 drivers/i2c/i2c-mux.c | 96 +++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 44 deletions(-)


base-commit: cd5fec79af3fa04e88e5900cdfa56d5525f5740b
-- 
2.50.1 (Apple Git-155)
