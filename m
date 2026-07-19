Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD93A5433
	for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474257; cv=none; b=SePsKHpgtiJADd7xcENS/pvvUcA9YGdrNHAeVi8+UUVt8rXTBMXGudprRP1cZs218K/GlofiY6K3GYhWAtshQFxhhXxNL7WQIMuphBl7HB83VPQIyaKMbcReKOYgaA4TctJ0ApmVYaxXxnbev6xlu17WOqDoI2Ca0iiVBmbL4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474257; c=relaxed/simple;
	bh=B2YqMrgTja5ulsdupqJSWKQwHmegjD8Hbyvf0CUQZgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfCC/xGVnX36E4UGFXXCRBvLcW+vxbDiD1xKGKf93+6WGmtPcuQNutcWrPOFaZINGaU7KYI3JNFZWVlLwXJrph4V5laXpTSqAPBrk1r/F9nrTpIL9uH3PHAjVqO6l5Cf/1UvrbC0JltDC/lVYhli2hN93sc4mY2BYkSjneeQ7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwc/NuKg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwc/NuKg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b018fe8318so4831153e87.3
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784474254; x=1785079054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=Fwc/NuKgW3nOebX4hR7VaLna1vHOwmb0dxIcrhv1cDzzq/E73ADK2e77y0jvEQKrin
         W8p3vYkXYvPPM0qHFGcJD+NQcv7GZnIBQCJTPOOqqLrX8B6KJH44EBZRs2TEXBAkI8gG
         6zJtI3xS47/7VWWPHNj+tGw6qZSoEtAQEENHS2U3+P9cy+7qLf7ycFIwU8RaNwQdiP4x
         m6WOsY2ay+PynaBxSbphSM7vryA8y4CwTSiCjWsF8jAbYq7CHg4KRIU9vCpyW1kre3Um
         Dmm0yKLsQ+Qt0yQ5oI21yL3gizrRSgkY+82KVH8FyQOrvUaLqEBHhwawWzkqOuqfBd4j
         W3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784474254; x=1785079054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=d/YgbVJAfs3aGTLI5wDFbXaRVCA87dZz19IIMaZipzhHlVBGuu7qCKJlYQwUZtw5RP
         DWIDTsaSC7kAQczno1vqS9NDjYIZVk+8m6ZeHDJnNtLfOxmrI8nAimqbHihLN5KJIiar
         MVuCNy1vMlixbFHhV2fq/wEKpue5XBJGzTeFZGhKUZ6PrF9NRm6fXG3It3m/uLptPNGu
         DztNbByWzdnwLB7fX6ZNIr6FEGblF3rKXVvzVJwCykaTZ37qoYs8QumF5beBWUs9MYJR
         M+14W1PJk6hHqnaNbaSFL/5gw1lkVWd/PCX9UckKGIRpILHY+6t1hpY/bZeAawwhK+JV
         ha1A==
X-Gm-Message-State: AOJu0YydLtATQW3FIodxB4F3ywHbfb8wMAMIPaHgdg7wboy8XtnuD+eY
	at2VSd8wu3xGUYWam9agAbOGSaFGZ4k0xS1x1Zc4rOfr5KpQOAxGiZk2
X-Gm-Gg: AfdE7cnBiE48vhGsGjqURlZlBxl7hhoXF3DDrmy8btcdz3VYEkpJUH2RfaJVoDnOlZG
	Qo/yoMVZC8buixhoAfFTJ82o9QykwjK5bUO8xnGq26liZkB75Cpnq0JUirhBxA2oRhN56IBRVnF
	K+9xOApD/kmRQEzrJMS3yGvEd+RsqrCDIS+XahAzeuaDxP//Lgn/qiWYON9YbxZh3LqL5dKcUIb
	LkJP5Q4bgAEGipFNg0Dsk0RSVfssR0Jwf/DnL6mv/8r8ec5Dnt03XvqCd8Rc8NhU0t4RB3+idWP
	dbTtycFWoq1cHfL2D3VZXdcL2P1EM1DoRZqHZ8qi9eJWnlW6l5hlyw+UURk9x2apIplFmYoDjYI
	aWsDWVR7vMgy02Da6l6Z/IcE6RZBgDKjW/Zb1aBTBoyLMWERI5xr+JvHeBHY6QWigqeUnB6S7c9
	8QbJJmoahbn+3Dozh8TVWuy/Lg4sz03ROVPnWsndSAu7B3tuU=
X-Received: by 2002:a05:6512:2c8c:b0:5b0:17c9:a504 with SMTP id 2adb3069b0e04-5b28f9b7c01mr2056967e87.30.1784474253752;
        Sun, 19 Jul 2026 08:17:33 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e26e5fsm1835096e87.80.2026.07.19.08.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:17:32 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sun, 19 Jul 2026 16:59:50 +0200
Subject: [PATCH v12 7/7] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-i2c-mux-v12-7-a5010d623a57@gmail.com>
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
In-Reply-To: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8176;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=B2YqMrgTja5ulsdupqJSWKQwHmegjD8Hbyvf0CUQZgg=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqXOqRbAOdx8k6mO8EKTe7IxMU4ceiT+Ms2L82E
 3oxUNolewuJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalzqkQAKCRCIgE5vWV1S
 MkchEADG8OL2vD6lnKA5DGjIFgLDPQ75GC9MK5kZUG0dM3y7SaWnxnOqoGfLiqF1DUuPXmhybjM
 pWj/7Zi0NI4IQym5hsKQZQzLcYNN88SxjQ4iCn9rmc/z/bZd1HSTZICb0/eVQJEu5wOeavXa74b
 h0itQXalii90dRPmsYOmZ4pqBXkfw5B0JsbijVhDa/CZfMjZkWVYS7c5ruYC5pb48tCK+vz4oLf
 1ZMfyNGt23LNjBVobXi4veOoVIagw3WT0De0TlObuZlsVNwLtm3P6PtGgch/Z2vAK6XvAsO4gWq
 s5rCzUnqeAZUWJhY91vg68aPZYPo55vBeMW9uTfWHyOMdBKw+Qpgp2FP7wKDe+CMDAC/nyzMoDT
 kXQ8GUHHGpIUNfkLzxzPQLWZf+PY+GvOV+Fp4diJVF7c1C1E+g5J/rlgDsfukOF3f2kiKFvRwlJ
 8wV92RFTD3zwad8bq92cL3YeNez7RF29ZEgbWSN/55cXhvGUOsW0Q2Myc1cNdS41RdqZuhsj1LE
 3GBqCLVNUQqTPukkJMx6+kfL3MXmbGpQ5ehmIbwHcDYV407WbwRMSYpUujbPrY+HheWNCC53axZ
 oZT/5L3VVXY43UbLgjT+1hBpKE3S2iW3qB/51rIVc/urIrpteZ+EvG1iHXkVgKGFLi/pE7Z9SS3
 sZZtDv9tq3/MjtQ==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Describe what needs to be consideraed and taken into account
when using different bus speeds for different mux channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/i2c/i2c-topology.rst | 178 +++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 48fce0f7491b..1ee0de6dbcb4 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -367,6 +367,184 @@ When D1 or D2 are accessed, accesses to D3 and D4 are locked out while
 accesses to D5 may interleave. When D3 or D4 are accessed, accesses to
 all other devices are locked out.
 
+Bus Speed and I2C Multiplexers
+================================
+
+I2C bus multiplexers allow multiple downstream channels to be exposed
+as separate I2C adapters which also could set their own bus speed.
+
+The multiplexer itself cannot change the bus speed as it uses the upstream
+clock and data lines to communicate with the downstream devices. The speed
+is therefore changed in the root adapter resulting in that the whole bus is
+affected.
+
+This increases the complexity of the topology and some considerations must
+be taken into account.
+
+Bus speed
+----------
+
+Downstream channels of an I2C multiplexer can only operate at the same or
+lower bus speed as the upstream bus. This is because the upstream bus may
+have devices that cannot operate at higher speeds and those will be affected
+by the speed change.
+
+The example below illustrates the problem.
+The root adapter is operating at 100kHz. D2 can only operate with 100kHz,
+but D1 can operate at 400kHz. When D1 is selected, the bus speed of the
+root adapter would have to be set to 400kHz, a speed that D2 may not support.
+
+This topology is therefore not allowed: ::
+
+                          .----------. 400kHz .--------.
+        .--------. 100kHz |   mux-   |--------| dev D1 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'  |     |  mux M1  |
+                    |     '----------'
+                    |  .--------.
+                    '--| dev D2 |
+                       '--------'
+
+
+This topology is allowed: ::
+
+                          .----------. 100kHz .--------.
+        .--------. 400kHz |   mux-   |--------| dev D2 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'        |  mux M1  |--. 400kHz .--------.
+                          '----------'  '--------| dev D1 |
+                                                 '--------'
+
+Preferred topology
+-------------------
+
+The preferred topology when using different bus speeds is to have the multiplexer
+connected directly to the root adapter without any devices as siblings.
+By this arrangement, the bus speed can be changed without affecting any other devices
+and many of the caveats are avoided.
+
+Other multiplexers in parallel are still okay as those are locked out during transfers.
+
+This is the preferred topology: ::
+
+                          .----------. 100kHz .--------.
+        .--------. 400kHz |   mux-   |--------| dev D2 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'        |  mux M1  |--. 400kHz .--------.
+                          '----------'  '--------| dev D1 |
+                                                 '--------'
+
+Locking
+--------
+
+If the multiplexer is mux-locked, transfers to D3 may interleave between the
+select-transfer-deselect to D1 or D2.
+This results in a situation where the bus speed to D3 may be lower than it
+is supposed to be. This is usually not a problem.
+
+This topology is allowed but some transfers to D3 may be at 100kHz: ::
+
+                          .----------. 100kHz .--------.
+        .--------. 400kHz |   mux-   |--------| dev D1 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'  |     |  mux M1  |--. 400kHz .--------.
+                    |     '----------'  '--------| dev D2 |
+                    |  .--------.                '--------'
+                    '--| dev D3 |
+                       '--------'
+
+Multiple muxes in series
+--------------------------
+
+When multiple muxes are used in series the same rules apply.
+
+Transfers to D3 may interleave between select-transfer-deselect to D1, which
+results in that the bus speed to D2 or D3 will be at 100KHz.
+
+Transfers to D2 may interleave between select-transfer-deselect to D1, which
+results in that the bus speed to D1 may be at 400kHz as the transfer to D2
+will set the bus speed to before the transfer to D1 starts.
+
+This is probably a bad topology ::
+
+                     .----------. 400kHz .----------. 100kHz .--------.
+    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
+    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
+    '--------'  |    |  mux M1  |--.     |  mux M2  |
+                |    '----------'  |     '----------'
+                |  .--------.      |  .--------.
+                '--| dev D3 |      '--| dev D2 |
+                   '--------'         '--------'
+
+Multiple muxes in parallel
+----------------------------
+
+When multiple muxes are used in parallel all access to other muxes are locked out
+so this is not a problem.
+
+If the muxes are mux-locked, access to D3 may still interleave though.
+
+In the example below, D3 may not interleave between select-transfer-deselect for D1
+or D2 as both muxes are parent-locked: ::
+
+
+                   .----------. 100kHz   .--------.
+                   |  parent- |----------| dev D1 |
+                .--|  locked  |          '--------'
+                |  |  mux M1  |
+                |  '----------'
+                |      .----------. 400KHz  .--------.
+    .--------. 400kHz  |  parent- |---------| dev D2 |
+    |  root  |--+------|  locked  |         '--------'
+    '--------'  |      |  mux M2  |
+                |      '----------'
+                |  .--------.
+                '--| dev D3 |
+                   '--------'
+
+Idle state
+-----------
+
+Muxes have an idle state, which is the state the channels are put into when no channel
+is active. The state is typically one of the following:
+
+- All channels are disconnected
+- The last selected channel is left as-is
+- A predefined channel is selected
+
+Muxes that support an idle state where all channels are disconnected are preferred when using
+different bus speeds. Otherwise high bus speeds may "leak" through to devices that
+may not support that higher speed.
+
+Consider the following example: ::
+
+                          .----------. 100kHz .--------.
+        .--------. 400kHz |   mux-   |--------| dev D1 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'  |     |  mux M1  |--. 400kHz .--------.
+                    |     '----------'  '--------| dev D2 |
+                    |  .--------.                '--------'
+                    '--| dev D3 |
+                       '--------'
+
+If the idle state of M1 is:
+
+- All channels disconnected: No problem, D1 and D2 are not affected by communication
+  to D3.
+- Last selected channel: Problem if D1 was the last selected channel. High speed
+  communication to D3 will be "leaked" to D1.
+- Predefined channel: Problem if the predefined channel is D1. Set predefined channel
+  to D2 as D2 may handle 400kHz.
+
+Supported controllers
+-----------------------
+
+Not all I2C controllers support setting the bus speed dynamically.
+At the time of writing, the following controllers have support:
+
+============================   =============================================
+i2c-davinci                    Supports dynamic bus speed
+============================   =============================================
 
 Mux type of existing device drivers
 ===================================

-- 
2.54.0

