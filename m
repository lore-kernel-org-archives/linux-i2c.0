Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8133B97F
	for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480157; cv=none; b=H5VtuslP+Tt+Hm7z7Z1x1Fu55P+A9mNjWx8rHTrBx7mZzJtNgb9ZZCRyxMGEMEIr9IeLViwF/P7xf1oVdjU1czQynAs+ednAX+IytkbBhzYJZ3+5SL4RHGaGRCZfOlwryB9QPl1c/FyByXMNvKsC9qh0zqp6JQGLGVKX88DCY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480157; c=relaxed/simple;
	bh=GuWaYKwfMV3ENq2uAbPKaKDYJ6qhLIPVj7+qDo+zpgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m19Db4wnjXb28tMmUaRlyrJXrjBvN/oUZ9BlSfBMiIaVBVfiyjfmkd6jHIJR0CHYGTaII5t3WNzl+IgFmth4K4eIV29fZybNq7yzjTNk/0BMsbvJVxdmXTR8CjRsRG/dFqGnGSva38oxJoJ3f0jwNWPAoO40ZFm3xEMALiUuTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3bwdRdo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3bwdRdo"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a76ba6a78so20029071fa.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Mar 2026 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480154; x=1774084954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eVM5njdwmLVkvkbsPkw/voN/xq5dei4oewrLsHcno0=;
        b=B3bwdRdoTZglMVPbk+cclLVLbeOBbCGQM2gLt3uXjqvTe9Kfv+j6EmMlk3HO2V9Z88
         YpWhFz1ybUi2e5ia+ysC0YN3lHkym5lJRBo1TuiJTIuLxwLjss4c1z5y/PO+vVd0icWS
         eMwBUVe5AcdVa2ngucmLYm57KXhN+u2yl+OouKxjxYHzlc8hBNKTKUKa+QLrysy00xWq
         tZvsE3o/oTUg3ChVTdua1VD+YR6xrcKJAamjyCJm9vSbpDXBZf5SypeMB+6ifab++2KV
         GNTAVD1halLLVONrzgBc7/A9a4/a1dXpF32OvWEa4xrpRA10IfnP5527dW072PQLNFBo
         YtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480154; x=1774084954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4eVM5njdwmLVkvkbsPkw/voN/xq5dei4oewrLsHcno0=;
        b=QilcZrJrxg1MPIwcjAn17wruxrQLzv9oxvSvvKFSkQtrhH1ATde0N4jHgVxvxgob+b
         YRBscjPefhqSoq5NUeWBHghQarYiV5X3Qyc6XWbVx+cRxFnSHAzmq3kFH+pDxCsV4Dor
         wA0Ft9wFNw5JjMaTndOhINs4sb0rSdBWakJmhSGorfi2EU1roKxjT0GftOTMSUAocHc2
         MLc2kTknN8Xy25J2fWwNZ1+B7ed8BijzBqi70bRm2TCVtwUQ4iLqyinDOh7hnKFkB/oQ
         VVDb73qPlr3zfsEb0KxRSTlhZdwX2280Jd+y61OHuR3gMqn6KunyGiMGv4G2HSYfUh4P
         eHJw==
X-Gm-Message-State: AOJu0YwHa7t+FJleNhl5ER6EfNLo6BEPEPIPoTuTDHfMTtF4bbAJnLIW
	jw1cVvyHAgn8nSRlGN2Z8wUiH1/GegTzCK6vpxUvsKRBir4sCfWA+/xh
X-Gm-Gg: ATEYQzzIeVwooAgTnisZ2YNLaFKToK6jh4HnU6M0e1d2G+sm0MIA0uBOkxgrY4PcBrG
	lm6ko6mU5b+Ck2Otzdsbh5QKvnkxG/oOWiRg8OrvBrwTqJhYJ6rTLIN5TGbigVTRIpS6cJjlctT
	9BRGhqEHAlpZxcwCJsoytj6zXNmgmN6UaBZpeK8rXVfpDUbINiH/PXtIwmLFGEuQyOU6FtZNOX5
	C9uvNNtlRmhTfbAPh2a1Ms31bVLGV1KOW8/LiZPzlqQV2ezfEqe8MWvYoh5fL0+39XhKOz3+cC8
	DN+7cnX2Luao5JpV6qSe5FajB+4GxOTgBG3SHMnHjU7xEhUlS3ZwCLZQ0xyg3/H/XKXMsR3vVe+
	mTgsVQxfchZdxhFnTfmFVVCDbewlcOF5lETu7WCuu4El5V3ej1lVWTRXX3HcZ146C8Vj/M8pvh1
	xzM6VxnKltT5qOJDmhWc3ORWy62OlPUOT86faQBEgNH+K47QqtpSoenyGtPmK+xvwLNHJx
X-Received: by 2002:a05:651c:f02:b0:389:ef35:fb9e with SMTP id 38308e7fff4ca-38a897a7cc8mr18764551fa.24.1773480153671;
        Sat, 14 Mar 2026 02:22:33 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm18454261fa.22.2026.03.14.02.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:22:33 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Sat, 14 Mar 2026 10:22:44 +0100
Subject: [PATCH v8 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-i2c-mux-v8-5-fb1738a4df0a@gmail.com>
References: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
In-Reply-To: <20260314-i2c-mux-v8-0-fb1738a4df0a@gmail.com>
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
 bh=GuWaYKwfMV3ENq2uAbPKaKDYJ6qhLIPVj7+qDo+zpgI=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBptSkCCHSLTykCPceE5Eh2DSOK2JRFSqcc28ugL
 D1Q4S3H19+JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCabUpAgAKCRCIgE5vWV1S
 MvRLEADX64l8m4MrCjBOkqP74r/edbqERiO45KRk1Ys+KSZoaN2SvKxB46dBr/dSuUeKKkIeU2E
 UbZAKVHN/c4O9KQqee3KSOIN06U2LIbsuezGj4/mNhX/tLn7YfGen7Lb1ckfU8eAU98ftJfoAmE
 WqyI+JIQCPnjWzl4TC/9Y9lFn3w0/KoklRItTV31ZErmKZ3csGChr31ilNJM6x1g0ujwYVt+jkB
 XaFthkJXDsci7GhfNYHJOUtpAOBRmP1KbTZARcmab0KAb+INqFEDvjIbSY/l04jQ8U58jHfRBA4
 vDe850K0z3e9/2hAe/bZpN02pLTFb1i9BOj+8KvPHm6YefCPttwILp5XU15FwykJfxsi9fk61v6
 takavO43LHlMu/zm4QhGSdhZ3FAdrJSf/2EBF3V+iAXNib77Nfq6MIR5Qr2WLArVdYNS2fnyeB9
 8HPLFDfb6gw6DMbnQbSY41boEjXUcGhMsbcOeTrv2hnUGGSZuKmuVQazZqJWN587FxB/irpe6vc
 yMaIXe8JaFq9Dcish2BkXMgyf1hkwS50yMAQDJPu92x4PkbncY/o5jA0K2TmaE/mFqd5ZDyfbBv
 1FjOSXeFmWNQ1jxTcmKwJHpBBaWVJbN/kZeYyf0TbyoXZ9c9IuB+vNA8VsTYkeEiD8kKwEJ4hwR
 jjMF3TSIXEobSZA==
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
2.53.0

