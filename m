Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42A3FE645
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360494; cv=none; b=UYYSnERmIoG2A34c2A/TE9xCmg0hWXuP4hbviU3IhQs4iH3Py50ZwumZJa5KzzVRjaALjpihmovyiFrXlzLKeEJq6pXcTIEq1XFVc55qlbOXjQ0Uad3M8RzSn3CuMQYsI+tgKkqyaEn1V6JrbvNcjhNB1/w80GOMl+xFJKP/vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360494; c=relaxed/simple;
	bh=GuWaYKwfMV3ENq2uAbPKaKDYJ6qhLIPVj7+qDo+zpgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoZumqDO89G1ZN/fOyXi4I5nB8y42Xa/any1/n2e7qZ256dNV9ohc0JtQVj7f0vHIBIHlo+atEzKRcf2P5j4rBw2idlHvh6eIy9OYwikaLuY9eADr9yXqXjg61iNqYdQapW8H7ICInDQ9n4MF+R2rOKjtgOxRV51tYgIAerJXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzHvR1h5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzHvR1h5"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a142464316so5698355e87.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774360490; x=1774965290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eVM5njdwmLVkvkbsPkw/voN/xq5dei4oewrLsHcno0=;
        b=PzHvR1h5dHxr7kVQCZcb34dqA+c0EPB8fRH92JXCF9y8+eo8C9YK0o5H2NuPIJyu/8
         dYx/zavh9/mMp6MwGvilS2+KCdBHmixr+QnLjfMpAKRulm9K8xMnb5BhIQ7S5txR114s
         Ktk8+XAaI5fc+lq7VGbnG83HBor5EgjF0tEHtsNWOKT+0+7IgyysvPBZGrALU5t4dsPO
         +sFV4aj0FI02bZuVCeEZF5DxMhRK3tHNXcUV7g+0OWflZ8FeOzxFWy6KqER7YS/QwELh
         cAa4ldoj0Sg2Qb9oSzb02PBTwBXIxYy5Xbdp8xdHoiE04PRpt2CkFPPECQWpr1mz00K0
         c6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774360491; x=1774965291;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4eVM5njdwmLVkvkbsPkw/voN/xq5dei4oewrLsHcno0=;
        b=DEaAuMhDk9tL624Mps/21guIPx2qrIuTGsSlGJu9Me8JBcI1MN06IYq8sBKcEw/tg8
         BEOO9aucAKeYnpQedfxBpHrDVx2Geetgs/8Hqe1Z7wcBad6S1CzFS0/WkYMp4HA+0Vrt
         mcfe7ebqt7bWGOkNSM/Bud4HICHNs0mND4ptB4LHV6JJpluwyl8v5vLpf/Rl+rs97SFk
         6LifHE8oxA2w6ehiEvmPCpYLDL6aryOk+lLuO+wQYtALM++shGJ16x1YuSiC6RZV5xSt
         e6NKt2HhJQAxZRe2wYSXUo1HFxfshW2QhI7i+2RMZaR+hiVKdD9PFIVZd8fK5CbqWui0
         SuGA==
X-Gm-Message-State: AOJu0Yyfv+ydXpsPe3ZollgAq/K/IqFCnrRik0PwbXfpZ1c+JkqbcaCS
	o2PS2SfARBi5cRBCYDUBBNFb0NdgarKRQU9n11yra/2scTGfxNrw9Bw2
X-Gm-Gg: ATEYQzw0aYwieTI20ax6NCTQzekoimxT0HtUiw7yCxWN9qsJnl9e9HSlF2dO7vCU59F
	+o9bkM6LGwU8pWyfTdlB7zZ/a18u7JVY8/rUruN8bLVHNKWGFoJN22SDm0xY+qStQj93nITJqmj
	rMS6sBpNkPGdIPO8RzvRgL/DJmdFhod/O3uTZGNYsT5kIqpCylRC1kd6L6L2SBsBJRb5hSyMdew
	GP7c0XhaxzI440tzq9iVv3OZgxmMpbBfzybt821WaqKO6DvDTaTNt4dreAOygpekGwiQceZw8sy
	SppQ38i33kvtMtQb2fitjcizWvrnh+phRz5N/TSBDw/kZ28gzGa8mrD/yI6bQ5oWgEvGp4gGhik
	39umzYnxsLJJ3N5+0HnKAwrGIbyHDKTd2noSN95Xo1OtbDIZCcZf2jpNU4KWMol33D5E36AOZ5c
	CVA7dGT4JDt3FTFJTyhFo/AbVZMhaZU7jqQGbZlzjeTcSui6WK7pUCbWUHdQbQpMU2obcw
X-Received: by 2002:a05:6512:2244:b0:5a1:58d3:a78e with SMTP id 2adb3069b0e04-5a285afe997mr5521719e87.16.1774360490303;
        Tue, 24 Mar 2026 06:54:50 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285207454sm3162823e87.48.2026.03.24.06.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:54:49 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 24 Mar 2026 14:54:19 +0100
Subject: [PATCH v9 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-i2c-mux-v9-5-5292b0608243@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpwpegtwHxJOynPPBbWU/7VFhGEIzuMIL/Aqc6/
 e2v/aBzLS2JAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCacKXoAAKCRCIgE5vWV1S
 MiWLEADcTDlo96dNktCHucsX4wxFTvWqQz+/jzYJ6A7WebX+7gMIKlNQyN2TRdddkrastNt2Ffm
 9tgBWrvkpMDAld2okAN+w92oVXZx6mc/41A4hSycbKrW5rcySOYAVo9ZHi1dv33aAWOd5U97+ui
 ffW+uOlg9dbYZOYS1lbuLelB62NUMBaC8uooCCsx3elqhfQ206jf8y7xZbI14s+1TmT9D+fJ7PK
 WHh5WUbHhcrZbjhTK3R6QsZOoTZkL0JfFaKfx8fKgRWGwgLdYwuLPDQOe7zIl+NbXfe5PeaT1eh
 /JiTPrdpVaNvsx0fizNN/rkq6bAqZ4C65GvW6+J/Rm7fS4/rVIbGIbU3WMKrgWbaRrUYX3o1sqb
 70vtE4xp8jilCU9pcMgnDuzfqjZYCHkb+0wziEFNlP5A6awv5CX3qIUne4c0bUCEQtsxruNiAg0
 3vJAHXabmAtLTa2jqXXAXahgF9hYXRENdV3lKStlYvAoj4+GUyTxQYwmHTHBC4ISh7w4CMuBrJD
 qIMY7rQlp4DSX3UVrAs4ccSUzLdJwyy5RbupsNjCoolq88j1Y2pEA5YDrjelOEW7nuUX2NHXcJK
 UWqYqbwYrvO6E8ppxkkqUgeIIGoISAwfsoUjJLA0FdCc6Wpvcb91GFODHosoMQM74uPHEpVre+C
 +4A7DBoe9ZCyUwQ==
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

