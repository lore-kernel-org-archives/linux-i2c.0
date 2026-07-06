Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8DB18AE3
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311955; cv=none; b=Zcbv3Hmptt2nXpb5BJVODR4fQNHr46AXsIbNypp8q0ZeViEHoaLGXNG3rTod0HlfeNaDB0z8qdxSlVf1jllRV0XKaTdYUJPtEBYj8Qf+J2vq2SGzHR4i4XLvmYnr+2Mkbm7fh2QqJlUGWcOp8V1ertSbu0/mkibhLndd3xaeqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311955; c=relaxed/simple;
	bh=K9Ur+szbTp1BBrBEss3tOSBHTsn2aytqf2L+g0NnveA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rIfmOyAbGzsXmRD8gUY4UbNHjN1KPXXij6OCdpb8ogbTOElUmai2n11jDlwqa7ytiIHzY9il9KGxSflXEfX/bzG22n9zxgplEgkZWoZgSjbrrOuV4jc8whC1jD+KU47gEZDt0OyxuGoJxj0u+qudYrvrNlHqYDLEg3Wlng7huK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=NNLSl4Yv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="NNLSl4Yv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so2776448a91.0
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 21:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1783311953; x=1783916753; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pYoxxyNPcwSpszQU+jQtdXf7218rkPKBApGnjvPDQZ0=;
        b=NNLSl4YviGMc4tYlDv5O05pjxkZKZVlkL2LyHeQVs4usj0s2uqDSWngle0hg6k1NWE
         18QpyjsgNMpMetSenVyayCJns0UubjldSmLEDT51m1OcD/R9RkqA6yT0uTF3ZAKib+E3
         qCJeJ8sakorjub/WuqhoRwumlgZnjbPsBOh7O0l1ZG1tscBo7Uv9LyLRZk36jI2opM0f
         r1xg7mcs3vIsBIlFtsqwLlZvKEVF6pyWRu96om6AjHwFjaNdU9HMWeoHOxm+Kl4QlXkM
         +Q4T43VjTMh09fn7+66sjbxpPbvRPD177qKtBj+5xmvArf4cFeceMlDSvPiyzH8/2SFR
         5Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783311953; x=1783916753;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pYoxxyNPcwSpszQU+jQtdXf7218rkPKBApGnjvPDQZ0=;
        b=FUqpW8VnDwJ4oBykLt8G3jEHZBbxwmKArAu+Xu3MBMqaSXz58DdpAj2giaBWHTyqTg
         ONLf8NPwvZ2ocCShF8M5HzMn3X8XN/aHxAAFM+3m30hW4asrPcdp749JKwEXSkKR1bQT
         jsn7nEqxFksOQvPFf4cbaTYPpSTOGEzDnZcezHtArZYmkXDiKxVUCGYHfkHckeEqAn5O
         JmB90jQp2+R7VNGSt0U8mmnb0pG1yu9UNj6nIQy8MeKoyBGbruzUX8hwtow3/u9Vhsdu
         L8uHcY3Cs1KSwbQBVX19fQ+nnxLaArjhmX6k+BZg2hqVY4eQXdTIzdYKRnf7UQNXKA5f
         KqSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCAiVgZt4rEV8MOR22+jgyhEnv/35TWH+m+fBpgaUC8PlnCGeNz6gv3Wriz8x3TYE8P4jEs+SEkJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGOH+y+LVGFsD/Lf3Ew8BYvvPHP/Sr3Ot03Wqc1YGeWH+R7ss
	LgwZUe0PtYm72DY+BqKxD7E8t2d5g7KStygZtDavqYgoJ8XqnAl4ceSKQD8T7XOO05SrKSNXgcE
	vljKq
X-Gm-Gg: AfdE7clrovMsqNw1JtC3qIz8MGNyuP8I0mt76neT6m/h0yJCQwa1pvWjxMRWQxD7cJS
	vhoDIqvmJlXevDs3xVelRtZZWJo4anqIVjqtA4p/nCSU3OQZcQnP+JlRE/DnqAd3/vcciX2fLHR
	6D++qHjKx2lTj2UdROaOj89R3liTl+yridRJxJAFKcHlIU45s2TVx6ugXNyB8jL8pCqTWhqi7u6
	SxFt5rpGRwkhsH7vHWXdKpwhV7wYnejO2kBuQMy47N7DULouEaMdBi7PO97Mt1Elk0ivCzhKqq6
	WBrREP3c8AzuR+aNsvCR0ZIfna/3VmvTp5o/b1Jh6O7IF5Wo8WbE+Jp31aY+C/Im+GgLA4Q4B7h
	bLfIAhcbTAA4Wa/llTsnWKfyaK2/OLFmp03uo58y8NgEZ9YsLPHsv9bHSDs1HC2XcE//3SCje0p
	bw0BGBQzhCUtQIiziwLw6dC0r/irNazA95lrCaNf/WuxPrYjguJ3qLQy0szA==
X-Received: by 2002:a17:90a:c88f:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-382802bf839mr8593181a91.1.1783311953118;
        Sun, 05 Jul 2026 21:25:53 -0700 (PDT)
Received: from brighamcampbell.com ([2605:fb40:0:c09:9ca9:e0fd:b7cd:be76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31151fff32fsm13610010eec.21.2026.07.05.21.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:25:52 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v4 0/2] i2c-tools: Make tools accept bus path
Date: Sun, 05 Jul 2026 22:27:52 -0600
Message-Id: <20260705-accept-device-path-v4-0-c62caa708a9e@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6DIBQFr2JYlwZBae2q92hcwPcrNCoEqGljv
 HvR7rucZN68lUQMFiO5FSsJuNho3ZyhOhUEjJoHpLbLTDjjktWCUQWAPtEuu4DUq2RoLZpSVtB
 A2fUkD33A3r6P6KP9cXzpJ0LaS7thbEwufI7XReze34NFUEY5A1bqay8vXN51sINRE6jJaxzHM
 7iJtNu2fQFYQXGU0AAAAA==
X-Change-ID: 20260530-accept-device-path-539164c9c1df
To: Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 =?utf-8?q?Gero_Schw=C3=A4ricke?= <gero.schwaericke@sevenlab.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1974;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=K9Ur+szbTp1BBrBEss3tOSBHTsn2aytqf2L+g0NnveA=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ5a33sne2B3d7ycfNWp6EqXQfOBfthtrunT2yodZB/mmH
 GGYJrino5SFQYyLQVZMkUXl1iz1i5OtHx2M4J8AM4eVCWQIAxenAEzkVQvDP62Hi+Iv756VMGkO
 c/b5R2eSazP6XErsPx/+cv2qdOcTYQWG/zWW51lWy/0zTtWf+3vlzkmlDo6Ld3++zZRfYxzqKs5
 XyA4A
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

The purpose of this series is to make i2c-tools userspace utilities
accept an i2c bus character device file path as an argument. This is
useful, for example, if a sysadmin creates udev rules to create a
persistent symlink to an i2c bus and wishes to use that symlink with
i2c-tools.

I've tested these changes by running i2cdetect, i2cget, and i2cset.
Please be aware that my current test setup has an i801 bus controller
with what seems to be no slave devices connected, so my testing has been
superficial, involving mostly failed read/writes. This patch series only
touches code that actually opens the character device file, so I'm
satisfied with this testing. If maintainers prefer, I'm happy to test
more rigorously.

Since v1:
 * Scrapped brittle checking against device major number 89 in favor of
   an i2c_bus_hint variant struct.
Since v2:
 * Scrapped i2c_bus_hint variant in favor of combining the lookup and
   open steps into one function. No more awkward variant.
Since v3:
 * Rebased onto `master` and fixed minor conflicts.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
Brigham Campbell (2):
      i2c-tools: Allow passing device file paths
      i2c-tools: Document device paths as I2CBUS arg

 tools/i2cbusses.c   | 40 ++++++++++++++++++++++++++++++++++------
 tools/i2cbusses.h   |  4 +++-
 tools/i2cdetect.8   |  8 ++++----
 tools/i2cdetect.c   | 14 +++++---------
 tools/i2cdump.8     |  7 ++++---
 tools/i2cdump.c     | 14 +++++---------
 tools/i2cget.8      |  9 +++++----
 tools/i2cget.c      | 13 +++++--------
 tools/i2cset.8      | 12 ++++++------
 tools/i2cset.c      | 13 +++++--------
 tools/i2ctransfer.8 |  2 +-
 tools/i2ctransfer.c | 13 +++++--------
 12 files changed, 82 insertions(+), 67 deletions(-)
---
base-commit: 5852f5375eea6ca9dabf31f4772cb8b8ecc905d8
change-id: 20260530-accept-device-path-539164c9c1df

Best regards,
--  
Brigham Campbell <me@brighamcampbell.com>

