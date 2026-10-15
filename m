Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1D550E5A3
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062167; cv=none; b=mZx3liomZK3kjtkoCRr/3vuZJL5xIrNxHqE1H6yjixh4FJxxRQxeTK1KyZYv2PMulAZ7GUdVWz8VQPSi0tA+8615+GcX1U1bPu3WNULgS2L5VjLMQt5udoDd1Nhl5fxcTlzjl+4T2SFR9EMtcMWGcHYefLEneQGHs/kij0uITBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062167; c=relaxed/simple;
	bh=iKke+G/eNR2RT5FNmfua7QaFLxyZFtZs0AmBr8q2Caw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bq7sV6bSqn1Yh+WiWA/fDnCm/ecFrkdGjuhF0ZupRzt4eL2+RLHZ5IxgEuCHya2hfYfRaxkW4YaF0YyaiAHRqUjFozuFJ90ao/3/xSOy4DLUS1j/IJPjS2w0XNBPgegvn0lYuSqBK1Hk8YitvKov/O7aiu46GbgSoYRB6qOaNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUr+aUuY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUr+aUuY"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a75f960be3so22090931fa.2
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 04:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792062163; x=1792666963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbC49oHT8EOPgFnh+Zvmlc3sy+VsXibXhhbWKtG+dZI=;
        b=jUr+aUuYNPuivW6/klbqI2i9rKWxDEngKtSqE2hQnatKTS7NBkG7+QElpJaa54SDrL
         r68t++poclZ40QvSOmQvCaSqNuse64shpY3g31ouZMx6VrsUERBtxJo1Blvy6uZ4ccif
         3o1Z1U80zb0+DRTaWDIXZVLKi8YbZ3PLwT7G+QT7h7mi8mszZtK/ix/b+cGqPRxNSbNd
         wyia7hlKSmyz+9k3m8OdkoMXoZFsvFU4WzmQC0tUN7rVuGWj8dY5Q85eZxFMDsj3uYdo
         gRLy/8o2Fz7MELhxUlgVkqIlkj1pAbXLyK149st6YX6CMfEqN+km7q1oHNy3M5K12nnt
         78Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062163; x=1792666963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbC49oHT8EOPgFnh+Zvmlc3sy+VsXibXhhbWKtG+dZI=;
        b=Jsvewsoc7JbXn032fV+VOykgD8Gx95bnRI92j5tAAIPByh3/SVPMBEPl/v2ANd4VUf
         MzUAVuEwCR0UMqTKynzcIDvj2vTLpPKW/mtk52Whgq7n9xsIOfOq4JDa8QRqiEtn5L0m
         TMaIqQdRSouGIVmXCL5UmY/CFOZjUisUmLcDII5kOQ/tiTfRMZ10yU1cHNLBQlvazDfe
         bg+OfpUcaHikNysWAl7vOLRSLcvH9oH2zuiZlacF5Akvgu3Yr7xJX7t1wN4BXbZr7oqd
         tfOP7KKwuTBaCURhjYKOmcLSp7O3/CNFn0vZtrJ61rzKLYm9EEktavdXFerXxEHfv4fq
         W/bg==
X-Gm-Message-State: AFq9FYIwlZGBwXFGWmjhpdybgFkqtLNWP90RP4uMTpEWcl89TaOQxR6O
	aPUfFxWjP947NZpYmjNaTbLqv+ZZAhb6TiFNvlyEfgmT7MkHkIWP1iSy
X-Gm-Gg: AYBFou0kuKT48Nhtpt6/fONEEcHpschvwoagyoTldJkphXCuShU/At91w5cGwdxx/af
	jPiABjcl4wBOBR7rfr9kcfEX267GaqNMmv+CQY+hyXu/wj81GjRajcYldwPSeXjC1GfYzicCUTI
	//oE0dcfWV2DjQVBKbD4IolkowwSVfXADGDQwxzssonC78vh9TGjpTtvr36Le4GQ6OKjYYpWOvb
	+2qwobTBl+edyFRUCzO4Y+avSCv59zfI2u/AqsTlDHbO6WLYkcQZWHULI99oyI98VglANx9CuPA
	vtrO56VShuP7iNzrbamXJ9EzjSMUaooIYmiTRsPKkyq6coWhqSU74BK9B4jrjllRRRWJbwtllGy
	Wj4+xEluiiO4iDS8pcGKTSweX5B3FiORjJSvdlKN+d/JSiAYKs8VxBpwcC+DjhWq4Bgnu+Y0rEV
	LLz8PlzRAQDBE9NkiVPbE1bwHqcIcwC5nX00t9lvzPAf8mtHoShU+xPuw6IrQjBRX3TMxunjS2C
	94fcjVzozsRuOXz2XhjzivObLscAE2qBJ7WtWuKUF53ohsVBlI=
X-Received: by 2002:a05:6512:3b94:b0:5be:3f5c:36ae with SMTP id 2adb3069b0e04-5be3f5c3914mr517924e87.67.1792062162836;
        Thu, 15 Oct 2026 04:02:42 -0700 (PDT)
Received: from [192.168.1.135] (81-229-40-193-no2450.tbcn.telia.com. [81.229.40.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be3739b5d1sm905465e87.22.2026.10.15.04.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:02:40 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Thu, 15 Oct 2026 13:01:54 +0200
Subject: [PATCH v13 7/8] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-i2c-mux-v13-7-778a12cfe93b@gmail.com>
References: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
In-Reply-To: <20261015-i2c-mux-v13-0-778a12cfe93b@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8159;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=iKke+G/eNR2RT5FNmfua7QaFLxyZFtZs0AmBr8q2Caw=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBq0LLBqnf4VadPYtQtNP1pSSr8b6jP2655lIqvm
 DrCtEdgtZGJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCatCywQAKCRCIgE5vWV1S
 MnTYEACRfhJUq7i1TSqeziWX5JnOdVDUWP1uiIGWv83igdN3aP7D3BlFRfepKEOHNr+7v2HJm+u
 0z99E47j7erdRXE4PoqFdzJSSzUuFbId2/JhGhlV/xHVQCCK0lD26ZQI7abF7GA4hnfIacdQ0eB
 gGduArrBgqZjhyUmzBGZZqrj6Pf/HTtqRMhimeT3ugbNUWnuEoDamBRil7OBj7BCpag+Ao1MEYt
 ULy4ja9anxWvv33wBfJqGgWo8fZdkGykxdKOgS4Qe1EBGBIeaPj23WnMI4nzqpiBKJg2/ze4Kh7
 dseSFMbgPjp6qv21L2Qn2P5bLpA9p3TnBbHcKu+V8j+gJIbKzgxO2ZLsqpI9UQqztEupuZr0365
 3CStZ/JNs/s6WK3G7s0n2Ozqizh8D8UNfyyie5eA3PLeQ9uaJdvQXYAvB7mj932LUeZ3jZLHNGD
 gFBRzE3j2lL5P0mIfoNuk6Oc/VPIV3u6eEUo4Hyppj6ogqfVFwlVESMFBdYwJUOiggCAWJDcNjM
 OEOI/WVFUnSAf+kU/jC5fNhhG/CDWzA6QIvde06QcU4sjmZ+DxQGVQBK9acnBhgEuHtWU3lonui
 f0opKfaY5sw5Xq9NUbrCWXgUxLJmTgPURYDK2yrRxxqQsol6uWA1iyoiygUNADNjVJg3hoa878w
 sYAyirGvo0SPFWA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Describe what needs to be considered and taken into account
when using different bus speeds for different mux channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/i2c/i2c-topology.rst | 180 +++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 48fce0f7491b..97fe0e34a7ba 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -367,6 +367,186 @@ When D1 or D2 are accessed, accesses to D3 and D4 are locked out while
 accesses to D5 may interleave. When D3 or D4 are accessed, accesses to
 all other devices are locked out.
 
+Bus Speed and I2C Multiplexers
+==============================
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
+---------
+
+Downstream channels of an I2C multiplexer can only operate at the same or
+lower bus speed as the upstream bus. This is because the upstream bus may
+have devices that cannot operate at higher speeds and those will be affected
+by the speed change.
+
+The example below illustrates the problem.
+The root adapter is operating at 100kHz. D2 can only operate with 100kHz,
+but D1 can operate at 400kHz. When D1 is selected, the bus speed of the
+root adapter would have been set to 400kHz, a speed that D2 may not
+support.
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
+------------------
+
+The preferred topology when using different bus speeds is to have the
+multiplexer connected directly to the root adapter without any devices as
+siblings. By this arrangement, the bus speed can be changed without
+affecting any other devices and many of the caveats are avoided.
+
+Other multiplexers in parallel are still okay as those are locked out
+during transfers.
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
+-------
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
+------------------------
+
+When multiple muxes are used in series the same rules apply.
+
+Transfers to D3 may interleave between select-transfer-deselect to D1, which
+results in that the bus speed to D2 or D3 will be at 100KHz.
+
+Transfers to D2 may interleave between select-transfer-deselect to D1,
+which may result in a bus speed to D1 at 400kHz as the transfer to D2 may
+clobber the bus speed before the transfer to D1 starts.
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
+--------------------------
+
+When multiple muxes are used in parallel all access to other muxes are
+locked out so this is not a problem.
+
+If the muxes are mux-locked, access to D3 may still interleave though.
+
+In the example below, D3 may not interleave between select-transfer-deselect
+for D1 or D2 as both muxes are parent-locked: ::
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
+----------
+
+Muxes have an idle state, which is the state the channels are put into when
+no channel is active. The state is typically one of the following:
+
+- All channels are disconnected
+- The last selected channel is left as-is
+- A predefined channel is selected
+
+Muxes that support an idle state where all channels are disconnected are
+preferred when using different bus speeds. Otherwise high bus speeds may
+"leak" through to devices that may not support that higher speed.
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
+- All channels disconnected: No problem, D1 and D2 are not affected by
+  communication to D3.
+- Last selected channel: Problem if D1 was the last selected channel. High
+  speed communication to D3 will be "leaked" to D1.
+- Predefined channel: Problem if the predefined channel is D1. Set the
+  predefined channel to D2 as D2 may handle 400kHz.
+
+Supported controllers
+---------------------
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
2.55.0

