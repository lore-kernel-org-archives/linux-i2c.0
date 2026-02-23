Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B37364EAE
	for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857239; cv=none; b=oQPYNuW2XU5sGIG3kvalt3uq623uhGGGOcwFgHaztE1sY+RrUutAyJbNWTbhpnig9O51anQs6UMsKk6NOTYASzaCPlG5lz5LQUPGAJ3WmWDaU5u3/L9OKlNEXTniVC7U6SaeUPT+KmEhQesgUm3YUqmzLtNMsY7X9OUukR8vY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857239; c=relaxed/simple;
	bh=srHk2JrYne2Lr9S+OWYkWWOBdPBDjyWH8AYFfVb4WM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ani0amnWYPqCK3zBDR4exvBLuXtkvdKrhktWO/Yft0cDMdo75g/nINNuC4rWTbKBZNzK/Z5vzwKWTULcvB+ywyAWbrKvDKhN1HPqnHcVeCW0ON40wHQSyZYmIpa6rmtI5QaD+LTJ+NvUs6O/+zpPFkwgTYOqzcb3yZuOsZtCzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m61Nxfem; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m61Nxfem"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59f850cdeafso4688794e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 23 Feb 2026 06:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771857236; x=1772462036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxYzimuJUPEidRiJMQ+HmOdyz4ofi/9h4aHUin0J/KI=;
        b=m61Nxfemp6sF6YS6F0753erC+o+atsdnmywXWd0AVN1h55TS4UROvuE/1rnkkBHb58
         sEaYuQySoItDPvdqmi/wLjndjaijGS0vligDws5KDH69th9Wl3+J+dDfntSvhxICl31M
         4NZSmc+eW4KYctIRFO5s69R2RCI5fQFnX+j3vYyeLMMcj/a5xVhdNyewJvdIpA4O6ulZ
         0ccadgreEEHScHUzy5Y2x8Vu1QuptknAd5GzflXSiBHEozvKNHY2GWRaJnxk7Oz5En05
         OLSIOtHUYJw9fzAk30FJRMaIYtyot6d3Mp4T0XAo/WwzFVwKE+3buh9DyP1EyOXOXBkY
         KfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857236; x=1772462036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yxYzimuJUPEidRiJMQ+HmOdyz4ofi/9h4aHUin0J/KI=;
        b=YdK5Sg0BWH4ohUUtMG5ldrNfies4zwCkYMY7taKcM7GC3Etoe5Ei+cwliNLbvsoC3T
         UngMHjVFtKDXGSw7vbwWbOrWhhDxzyDXuAXhNLp4UebhR/BcLoCp5xAi5HmTrKNmQ68t
         /4KFNtu3g87EnGaX76j1MQJPMbTS7thWibq68scCDpMEkcajGUtXjt6AwQWbzVL/kGs1
         X01q5u0FOIMOcOaQDZ2cpsz3Sf2Jjf+YdxzucuzbxmgnSJdiTKKCL3OHpjzRBNfIMFjd
         /8Ic4q19UGExsvg2K/GjL3vMJ0VejIRdnnhTH/589c1yT9liHI5q3K1eGg55kWOADT2a
         +0EQ==
X-Gm-Message-State: AOJu0YyRgUXHolND4VZNcdbzt4vD3XjpmcrWi9glHFXhyEFtT+vhu5uC
	lzGMattZGPQBECFTZeNpP2rR8i+G4FKPBsXKE3R7VQpRWKfggo54h5Iqnhfo7w==
X-Gm-Gg: AZuq6aKzO5pYS9I6yzMgTVdNJ19xmHYM73lj3TLUiC39GHrt8LUY5kar97Ef4yyKvV7
	ZGW8cseTbSjQ4FTv58ODQvQrkOt0A6KjKtL8TFsCVt4V62Fpu62DegSuc5G/QO+QxjGey38uVKP
	l58xeOEzQIghl0yLVxoMMhp+aqgYBwKWXcvYkGuhNs1bw7w8z299/9CzIkPsZbpfxzYD9tmC9WL
	TVrnZPx61z/ExuJof5cG5aFdnigvSDJZ5i94yDW70qvLEiC2+5BhFh/wrnVgzXcdZIdYhVnVXe0
	n6f28R64VYVFx9YOhyIBEqfkWPvAD6vzQbLeB27552ChDhtAcNrB/jgnUdw11lFlaTPZTtu/ahZ
	Y9suh5F1kZ5smYezCi5aeMbmYFn9C/UyBOB45HxIyYn8zJ6Zqr8DwgtuSlPp0Orsd/5IgBhlB+0
	KNdWj+Km7k8jv8yw8n9+JmO8DiKELk77LYnn8QwyQ8MFBU9mRMj7zSToas+O/9UyQOsKRH
X-Received: by 2002:ac2:51cb:0:b0:5a0:f49d:1802 with SMTP id 2adb3069b0e04-5a0f49d183emr741484e87.46.1771857235661;
        Mon, 23 Feb 2026 06:33:55 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb16344sm1631709e87.37.2026.02.23.06.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:33:54 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 23 Feb 2026 15:33:54 +0100
Subject: [PATCH v7 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-i2c-mux-v7-5-ec75b214718a@gmail.com>
References: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
In-Reply-To: <20260223-i2c-mux-v7-0-ec75b214718a@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpnGVmfI/iyqEJtwfCGjYa/ktan0zKU2eHHY9M/
 DYuLBGkY9GJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaZxlZgAKCRCIgE5vWV1S
 Mlc3EACpRNiY/EUkVtCG0Oc8jRcpzfZewydd3Pz0EzMarqemaE2gMsPLgbfI+prQTxPZ2aakp+L
 QOv9D+zAwYy0RexyT1ybojEaz3BQ3c75MgcPoVQdQbjhOpyfmlbc+97v2mMgmcufuUjrHxIGoBT
 PLR+ZRy4qBkGajDojKJAnsnX+lQGQ1xH9oIqjbTh4LHZhWARX5IIH39rOMkelfY5S6cW6X7SSzv
 3oshi3OlLkEKLo1FUSeuV2Z4wENVRq7J7S76CWuU9Xcs8aSar6vWcnAMm+uxbZkIq58OBBBVrml
 r4iurrVgAUz1W6CRbmMzk6V1WhcH9rPPvlnj3akBQ3Xv6aUW1lfTzuxN4rNJ5iY+eCNS2JF1Vyc
 fpXEDBdn4SobypFJyGp9MVYX64TWAEiFMADEvyIMKKP0eKJ1+H+eK4NN7Nrx25igLN9OrS/L2pM
 DND6r00lETYp8iE7SCF7sEMftYmC3pgvgu3y2vedZ89IK02fnIgCWNBGb5X6CyN3udrRHcK3zZA
 ySeDhBTYm9zlNzvOnaTTn2cfJfB88Ch99KxpeK6yoikS/8tJPuLNlAatUlCut0JIc9HKYYg+UpA
 D2ymIlyEJVGUb4NdPniZG6HR52uNPWYzetampZjleNZuj0y8fKwnanbwgIwifzZ8x4szb3XFk4v
 xwm+Kysr7HfX4vQ==
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

