Received: from 2.mo576.mail-out.ovh.net (2.mo576.mail-out.ovh.net [178.33.251.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61876280A56
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923272; cv=none; b=nDm2CvbTeqnHO9GYUnthQHVDKO98hQ13m0j6lHS11k+rUuSPpbcX8MX+RgURRXNHS2PMkvk4FOgs3PUy8JWzBhd9/6PH7q+zxC8zVy2wTo4OMtqKAa4sE8hEi5p9B/CXK0lKBqhzK7Z90vBsx6J17lhcoBBHpR0uTSHQENI4eU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923272; c=relaxed/simple;
	bh=6wrhloUcw66LZeJCqJpRpYIYwEAHdgmCuOR42hM9cFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H1tAz61YtudeN4tjI5Z2ubzgVYBQvgpWK9mdwgo5TUbCyUV8y9Zb31S51u9NnaesbOOHEQaTBPMeOLQgYT/J7H1MkJFeetojvp4D0BgQHC52L/bEJY3qEC6qYsDrCaZVOac9Z6nLn/XBy3WAVKriIzE49UiYX1z1V7B6YZup3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=178.33.251.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director4.ghost.mail-out.ovh.net (unknown [10.110.0.145])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4gYsLJ4Zp4z62dM
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 12:49:12 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-74q4d (unknown [10.110.168.159])
	by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 1CE74C21CD;
	Mon,  8 Jun 2026 12:49:12 +0000 (UTC)
Received: from etezian.org ([37.59.142.96])
	by ghost-submission-7d8d68f679-74q4d with ESMTPSA
	id DpxFNUe6JmqeFgAAshgZVQ
	(envelope-from <andi@etezian.org>); Mon, 08 Jun 2026 12:49:12 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-96R0015a66f833-7e00-436a-9ef0-af28d25546a7,
                    738EBADB1DE2E82600AFA6E31038C942E6F5F19F) smtp.auth=andi@etezian.org
X-OVh-ClientIp:178.82.31.9
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c <linux-i2c@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] MAINTAINERS: i2c: designware: Remove inactive reviewer
Date: Mon,  8 Jun 2026 14:49:03 +0200
Message-ID: <20260608124903.1188986-1-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 13422978692513371165
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFNH8Z55uxoAhkTjpeJxR7Nd700/wphrk0PB637Kgx8GWjPZZWvvtV1MT18yQu5L+p4uVFbc/mDCSMlgz3PFbcbXhPDEsxIqaapBKtjM4+xVCrnGjFf2Q/kkrgMigCekx9sBtoVF26+cGbQWtFHbxCRG3PLKmvl5e8OqVykEX5bnJ4dCFYFr5K1OuvdN2WQrddRZKeQzq/tFiflg0A37MqoO4mXEl1gN1s2snk2OZrKYX1aD3MR/aj1GHdBRTjrBZAaZ7FZrk/w7xj6OvKH1o0FMv0dzXnur0JC0HlEcBBst6Vq/GjNUsG8pAwn+vrYVjY+4R90ytehEr5O2RmnkD+RZRs9FwYYOwq2H74g7uv1Vfyi3lE9iO+1bvvzUHkDB8g9gI8EaAugwZRG0BO7PY42Bog8Y6uwvvEVbyPJOCVcbTf2JyBFbKGFeRRM6QmRc/6eaCWtjCpQMtX+8EJzPvEwaTcM0L4heJ+UsyWC881Ad52h+zQz9XKofdkm4dItbU3hDIynsPJilRI7ks2Ecixgwv8a8xp1dkQoKuNimCklWmTSFpFsdHmEwIpOgAYQBPkS00P+6UdaSI6J1PBInnf+XS/s66yD6p4SHXizvIllfp4nA5W9+rFVkbd+awtgUHpMVCqMyGFPyuwYpLzBL3wFbFJfGPWdopTu2OS8/cLEIA

Emails to Jan Dabros bounce with a permanent failure due to an
inactive account. Remove him from the list of reviewers.

Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..04542eebfbea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25925,7 +25925,6 @@ F:	drivers/media/platform/synopsys/hdmirx/*
 SYNOPSYS DESIGNWARE I2C DRIVER
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
-R:	Jan Dabros <jsd@semihalf.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-designware-*
-- 
2.53.0

