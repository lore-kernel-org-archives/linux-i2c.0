Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A83A7F61
	for <linux-i2c@vger.kernel.org>; Tue,  9 Jun 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996588; cv=none; b=HIrB8fH91aQWlSRTHcy/Ieb4x0mGEiGYmvZyQRGdprcvkKKXnJCe+weYXHxVYb9/OsIRVwvUGsXsM3ReVampjiOTKlU6Ta8qCG+pOeeussqbQrhuTA6zKYy5g5T1/oVzYYvWbSSfGey+JbVSsfig8AtMgfvnKK1TF5Q6nTQlCUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996588; c=relaxed/simple;
	bh=VBEg0S4rcOHeGWu7C+Cb5N6wJHdp1rw4HSNG4etas8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DlukanyMF93wrQqZeEcYW4b0X343CuPWKyp9OeZC7JInTTUC1XZUC2X0WAvAEC0swSL4DNlXmBxOPH8DJbHpUEacxqpf2Z54zgIDxB3FHjENW5yw9w6mrI9eulPL1432dpYeJcG2i8fV1LaCbk2B7BNxPQ521ynPlkv45pNlVSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NJ8Mk1ZO; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="NJ8Mk1ZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Zd28NtHLvrKDBd
	DC9RBme0knu2gtg6Z+utPJyS8tC2w=; b=NJ8Mk1ZO7sh2WmLL0Q1fWAfZCCNkLH
	ZE77TNxI6pCoeT+klAdclXoGc8spHXQbSiQTVeugLPQpxYm9GCxtZ84+++200W0G
	XJB7aOxDvN83vCZVVEflrPDzA+9VXs2jwqcgVUb+l4iawyCYR+3nJkHnZJE/Kyr6
	gToglDcw6rPDy9ijJ7u7+bjeFz2ZWdPzzZyhe6o/97BqzoPkucNJqM36tUxdve0a
	Qrcv9GkneeEyJHDAjUe4PG5rRfsxK6mNslr5ehA/tqWKX5jBOsAayTPvFmpZwZ8N
	xRS9aETMYqeb2pRh/iQCbeKH/7pzDzTU4Nhfcm2CIshmjZegyLBSRNkg==
Received: (qmail 1205462 invoked from network); 9 Jun 2026 11:16:23 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2026 11:16:23 +0200
X-UD-Smtp-Session: l3s3148p1@Qu6slM5TKMEujnvA
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/1] i2c: Andi Shyti is the new maintainer
Date: Tue,  9 Jun 2026 11:16:13 +0200
Message-ID: <20260609091612.8228-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As announced and mentioned in other places before, with this patch and
starting with the v7.2 release cycle, Andi is the new maintainer of the
I2C subsystem. Congratulations, Andi!

Some notes:

* I will stay around. I definitely will support Johan tackling the life
  cycle issues in I2C. Plus, some other selected issues.

* I decided to keep the split in MAINTAINERS between the I2C core and
  the host drivers. I believe it will be useful in the future again.

Everyone, please assist Andi as you assisted me. Andi, I hope you will
enjoy it as much as you enjoyed maintaining the host drivers.

All the best,

   Wolfram

Wolfram Sang (1):
  MAINTAINERS: hand over I2C to Andi Shyti

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.51.0

