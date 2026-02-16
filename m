Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E02367CF
	for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245522; cv=none; b=gMQoG+nwyEHg0hWnZX6kM4LrnSArszNmdXtJuk4hCEBpvWvKqlB888m9vls1EmO9Z4PozVGuevKwPbi+E5lAihmIeVOkNPJKbt1LIQqa6Xswq1w3gbiLvPBTg/ocFJdHlN7Mm6LfdyKwDBfF6aC25uLr2/ux0+PGnRYxxIVnWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245522; c=relaxed/simple;
	bh=srHk2JrYne2Lr9S+OWYkWWOBdPBDjyWH8AYFfVb4WM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXdiUuDbonI+wVZlFYq48ZaMsDsFqRxe3nYh5lC3zU6u2dDWwiApLG4fHl6syTgQ4Yzs+WkpJ0UTP/VQZdcyyKFyikrdraTwjZHwkXSLc5ToKkulfxziiNg0FusyEX0PTbNJv3XgpZv9eYx5jGuFJ5/OBXNuPExsBvPOSLmPHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwrLouyb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwrLouyb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e62a3ee29so3247358e87.3
        for <linux-i2c@vger.kernel.org>; Mon, 16 Feb 2026 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771245519; x=1771850319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxYzimuJUPEidRiJMQ+HmOdyz4ofi/9h4aHUin0J/KI=;
        b=YwrLouybHT4dfq/CeGyOwir3iuaA47SjjoUOxsLplbqujF2WzIRCKgNQdVzIsqpPXa
         jQpjb59lhaVFvHj4KYCDwnpzKZzYYW8YLVtxpn29yR8qFJ8fsG0S3sfzeG/xe5OiEXq9
         BZoc2UoGjbGDcYPtA9Zp5h5zV+WoDWYwXMxH8A9JBSDOihLmC6EXAPgR6X7lf15gVXKH
         hmwiwkKvDpWzlJdGZRXKOxMo90OL9TX28Bx7jGpSPw+NpnlZrXjYr+iPV6G9m12v4F8x
         6ZLuzL7ur9oFdox+pd9zUJXAe/5WlZ3fx9DBipHZHtW6H+Fzc5jWdYBMvRHt1zmfkNUX
         YGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771245519; x=1771850319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yxYzimuJUPEidRiJMQ+HmOdyz4ofi/9h4aHUin0J/KI=;
        b=JTKxjm4mLsmdQ5ITR3iOgAJ2G86XZG9sBjVvynUEtIZjhHSiNEHydrPDMnWT5+Plia
         xCwEC8sx15x7KPbCyOhY56APdSh05aiIXdCrx0vE65Osxozv6835Psg3DiwK30OBrij/
         PR6iFSVE/MqFLFUwvWVovf0gCekITgi49V/nq3fOdbvuTiJFbBhRa6xtf+qad2P7lhc1
         e8DYb0OL6T7bPtYGiD5Y/L9cjWY8PSDQ5IOGUo244OKroTbZOF5K/IJH6OXuQZcA+JHK
         H/nzGeYk+ba87CoVZ5dn6IFfHBXWKAWyUq+gCRznu7hmVMISsJ1gDIoI0pvYxGKJf1Vi
         a6yA==
X-Gm-Message-State: AOJu0Ywoj5oOTyh4Krsx96yifqQ7s2PqZ9MOWQ1OJnR6RJcMlZkqy9GL
	x6Q6mNrjks5PxkQ57xybuyPPE1Na8rV0Klzz4fwGuLUvhX0w/xtb6EHm
X-Gm-Gg: AZuq6aIaF8odU20U3X92qmQWxyfVojJKYTie75Cz+pH5RTDkg37GslHrJ3DamkpANYM
	92pvlqNglULtxOeb9K/EnheOR3dogMa4AK+zqWI/pbbmvoDO+KV77MXJvGYuzm/auV3WPC97jwN
	HYv6riN/oxqHWZnZAi9jD+JLI/OdOMt//A6fCvtFGHQmUW+X/DWkG+YNnDR82OJ1aoCNSbtWAYC
	ieeJ1G4QBPlmJz3/NNn8HXvgAHUkZOroJg27t1cRbYsINMurGW7UIOiCL+NSbWERhN58D4zgzpI
	DxI1DKVIhUPRvCdWLMftY2zWR7nXX16lOYlGjQSVmKMKuX3AEVLqTctvSxM3xpSCBouzyOrxqD+
	nmFj5WYxWa/6MoHGnOftqPdrsG9Q/2R18mzjPFfb4rCoSS+1TWUBdZfZaSH+nkYfPqJHy/iEFU1
	oGCgbD0SDOdiDtL2YYeqMKNW6tVfv42I69PZlkYtAWHpJo8m20WgY7nWSPn6GYZWRcgpHi
X-Received: by 2002:a05:6512:3349:b0:59e:1663:941 with SMTP id 2adb3069b0e04-59ef97e8962mr4718009e87.3.1771245518393;
        Mon, 16 Feb 2026 04:38:38 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5b0577sm3175920e87.71.2026.02.16.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 04:38:37 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 16 Feb 2026 13:38:17 +0100
Subject: [PATCH v6 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-i2c-mux-v6-5-9be28ecfd7e3@gmail.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
In-Reply-To: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8169;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=srHk2JrYne2Lr9S+OWYkWWOBdPBDjyWH8AYFfVb4WM4=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpkw/XbLu7lth7GLLf8U9ly9/S3XxpZEAm8IvRe
 sDkymr8Km2JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZMP1wAKCRCIgE5vWV1S
 MrCeD/kBIgHp5wo4RriNM3Ho5EKUx0YkZ0shf+c7g0bha3DjkzejasJNnO3nGwrZ7CfwD6Kjvbi
 pZOyi/Raz5n76EulZwQ2NyFUfqAQn+PqznU+B/ROwqxkQUL1sXVhclqYirKwJxQTxVVFM8Hnslw
 Cc3nYhr7rmnooDTQAAZ1CrVnGCTjfa26jHTbHAMG/BQx+G3G9MoMxy6ND1HNPX5c9MZVXMzfAD3
 G3dBar7nZD7Vh2q6gFWCuE3hUnpAWe/KL5ZjORVz+KLu2d/+2LfB+kQdB834cD4XiuWdI9GM+zn
 t/wMYtFwG3jbfdSOJB/Sgk4D89v31XylUqYxp0dn5sp41C+xt2wKmMgz0m3h36K4QzfkhnSbjaU
 UiFcZQi6gqJOR2bybnGP6lTnw6ysjHEm9XXxm7/ZN2vOzVXsNvmiWnOiJadCnOLzl6jCwl4w4Ws
 GF42Frn34dvlZVc5heSdQt5251OPVQSd1BpRqUz/mtmv1996ZoNq6jWW56KWB2dBf1+vRJzWIMi
 ym2n7LJcqR1Xt1xSwQRKF1c9zHFIxXM12eP0Xc7TiQhmqJHyBZOkQ8Lu6etwB3u799YsKc0pREh
 h+CZNcON10BgifHyMU3ZJ7aq+ftlqo2Iaw11Co+TFVrPbt/DrCqJB4L1830BI/xRXBWQtABLNLk
 w8r8L5jBMH6fE8Q==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Describe what needs to be consideraed and taken into account
when using different bus speeds for different mux channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/i2c/i2c-topology.rst | 178 +++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 48fce0f7491b..24df553ca8c7 100644
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
+The multiplexer itself cannot change the bus speed as it use the upstream
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
+This topology is therefor not allowed: ::
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
+Other multiplexers in parallel is still okay as those are locked out during transfers.
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
+When multiple muxes are used in series the same rules applies.
+
+Transfers to D3 may interleave between select-transfer-deselect to D1, which
+results that the bus speed to D2 or D3 will be at 100KHz.
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
+- Predefined channel: Problem if the predefined channel D1. Set predefined channel
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
2.52.0

