Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FB27603A;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547845; cv=none; b=qo60yNVid+J+TScKqZhpxITgXcOy8J5SmRDjJ4V3eEvAQsRWynIqCbuMJn8K71Vg1Yuroaw+ONWGVcAmIOJV6Kw9XGC0+QyiLIxrtdpX3Oly6j46KlNYua049oDlGZ5tm15y46wSu74NoBg7QPEbZ6AQWsJ+LpoAmLL1OjFUcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547845; c=relaxed/simple;
	bh=CRHikQs9eZ3gVMFAp8sJsNNcBwuKXFyi0QLHDmdzutM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oWxeOw7Gc7rGgBN6FMdUHdU8aiW6dsUwlcu/ge6wg3ZNV9ZtdBMaE04jb0NIAbrOjeOWygvS7EXa7oNZezQ/6nBCwTRCM1lG8MPrJ0/at2/I6HUvieYdbpQdT5y9ZrEkZWvt00AlY41mQ+nYiyioQc2VxruyQKa7WPmdmhcR4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh/mJHDc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh/mJHDc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85B18C19422;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547844;
	bh=CRHikQs9eZ3gVMFAp8sJsNNcBwuKXFyi0QLHDmdzutM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gh/mJHDcI9vh2OnKWSskfmTiUBv/6fPf8UpZx0Sg3tPbV80LTrvGxAkyWi7O++AmE
	 TFoBRaRkloKYO3LymsIOkN3EaVXQn5sVtpkl8VM69Tx9N5+/RirU4a4dqb4IaAcS/h
	 4Uwz9guUBllfVps63+vV8R8fJCGEw5AawDjJ/XJ6iOmXUramoIQSeqW896j6z9+8Vi
	 AQAQpTrRAZ21E7KvCFEvEd8vC0X2wU86B7Ci1xghrS0z6gK3OKKcl+HnZWEbFTglRf
	 buUkFMVMzUnWr6yLcxxtTY3brHZpExBKjRAg6vsnSvINuOxZnm3i/FWyF+Ro4atX5M
	 KLDM7rv5XUkVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA1FD2FEDF;
	Tue, 27 Jan 2026 21:04:04 +0000 (UTC)
From: Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>
Subject: [PATCH v6 0/7] i2c: xiic: use generic device property accessors
Date: Tue, 27 Jan 2026 21:03:54 +0000
Message-Id: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADooeWkC/3XOTW7DIBCG4atErEsEw49xV71HlcUAQ80idoRdy
 1HkuxdnRZV2+UnzvJoHm6lkmtn76cEKrXnO01iHfTuxMOD4RTzHuhkIsEIC8AyBbzkHrjy6PiV
 D2CtWz2+FUt6eqc9L3alMV74MhbAJSCMEOG3PYJTrueTo43cpOFxx/BhpW4bpdsZ89IY8L1O5P
 z9b4aj+8cQKXHCpdDKx04qcbyPHF6tqpWqkqpJ8F6IGo2N6lfo/qavUqMijMlIEepGmlbaRpkr
 nUFoE14EMv+S+7z+QR6/pjwEAAA==
X-Change-ID: 20260122-i2c-xiic-3ba89ff5ea93
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769547843; l=2329;
 i=abdurrahman@nexthop.ai; s=20260119; h=from:subject:message-id;
 bh=CRHikQs9eZ3gVMFAp8sJsNNcBwuKXFyi0QLHDmdzutM=;
 b=PWVfIljp5RtV1b3Ejs67BgpI6Rpc4YgzjejvMPiI2S0pW+r7a/CdumGaGfTx7/6I81QMfYzDQ
 EiCAfZfAZsLCMgksT3CZ9o4DNvhsHFV2SI3DWFGQQa/+ss/aoTZHbw2
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=S+ysnf+NwMcBdHBlyKIUEAtaFGSIhQwcJcgcXhq0osg=
X-Endpoint-Received: by B4 Relay for abdurrahman@nexthop.ai/20260119 with
 auth_id=608
X-Original-From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Reply-To: abdurrahman@nexthop.ai

Switch to generic device property accessors.

Switch to managed devm_ functions to simplify error handling.

Make the clock optional since the driver is designed to operate without
explicit configuration in firmware thus making it useful on platforms
where clock is not or cannot be provided.

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
Changes in v6:
- Cosmetic changes to address the comments.
- Added a patch to use resource format specifier in debug log.
- Link to v5: https://lore.kernel.org/r/20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai

Changes in v5:
- Reorder the cosmetic patch to be the last in the series.
- Added a documentation patch to describe the optional clock.
- Minor commit body rewording.
- Link to v4: https://lore.kernel.org/r/20260123-i2c-xiic-v4-0-4a3eba3510ce@nexthop.ai

Changes in v4:
- Reorder the cosmetic patch to be the first in the series.
- Amend the mutex_init patch to also switch to the managed pm_runtime_
  variant.
- Link to v3: https://lore.kernel.org/r/20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai

Changes in v3:
- Reorder the "optional clock" patch to be the first in the series. 
- Add a patch to switch to devm_mutex_init().
- Remove dup message in error path.
- Cosmetic: use temporary dev variable.
- Link to v2: https://lore.kernel.org/r/20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai

Changes in v2:
- Split the patch into two independent changes.
- Added struct device *dev at the top of probe() and remove() to re-use.
- Switched to device_set_node(...)

---
Abdurrahman Hussain (7):
      dt-bindings: i2c: xiic: make clocks optional
      i2c: xiic: make the clock optional
      i2c: xiic: switch to devres managed APIs
      i2c: xiic: remove duplicate error message
      i2c: xiic: switch to generic device property accessors
      i2c: xiic: cosmetic cleanup
      i2c xiic: cosmetic: use resource format specifier in debug log

 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |  1 -
 drivers/i2c/busses/i2c-xiic.c                      | 92 +++++++++-------------
 2 files changed, 38 insertions(+), 55 deletions(-)
---
base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
change-id: 20260122-i2c-xiic-3ba89ff5ea93

Best regards,
-- 
Abdurrahman Hussain <abdurrahman@nexthop.ai>


