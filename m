Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0638D3E0
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927250; cv=none; b=Wolll3vr0qAoBSME7lORU15tErSPUK96WVjzXjQkNzmok5HYPaknOEUNYlkmPElFTSOUFB9GvsRchDdwrmY+jiytKoRBlVkenq2Kn6dyl1TB87s42XOxxZDEusXG0MhwrRFlUWnQu7HnyKB9DA8XkQjXfiKlO4B7n0YGxaBkZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927250; c=relaxed/simple;
	bh=B2YqMrgTja5ulsdupqJSWKQwHmegjD8Hbyvf0CUQZgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5fT1wv144X+hACBm0gZppy1WMw63btE9eiaMRl3vGMrAbTP/TlewIuvYYZlT5JHHlBHhAREziMx35GiT9QjA1CQyRxoyn/IJDwTbhKJPv/fFhpSWDuInJo1g6BSMDWH/6AAR+D8STqjrFBZ/CcLwyOd5SAxg4ApsDsF5ESGnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkFh1X3M; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkFh1X3M"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso2550373e87.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 00:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927246; x=1784532046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=rkFh1X3MNSifCDiRPl7+RXVkEqqypG10lQf85WdhK64v88A80MDjGrkanYhPHRSN8B
         jOQIFKp+fc8uY9+MDJCsw1rrzPUbfqque+whS/ifcuUnimNZys84SI0R1xYMovvuQYfD
         xXtllNH2qdBoRTz8dBQSLo82/5a4w2i+3U9JQfq4fTb7oB+SgADp16iKDwA53pnzL9VC
         02tvMgczRx9OVSJUZmI9z5SdB5clpWnbQkIpJBWD/iaEEl4KNLF947TITR2ybfqRPzpO
         eHt7kb0SoDJvKOtt+HIPNgT9shhE0WXwJ+AjPlrt/Qb7AWQtB4gQQ7YGyHJ2kPrq+9uj
         A6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927246; x=1784532046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=dEiD5/uTbR2MXstEmhcSVwbVj4uDisqe+n4h//F21Pybgm++dwMi3FOw4OY+GshWIy
         baZpabqWEyhQCSQWt+DnFwqI/3mFPxrtCtzvPrOd3PHv3I8a3GZVLYlV3U3U8lT1IZca
         a9oydNgwIB+Y+FFnaW3cbY5QVillWAQ+rsJU8KflNdh4lj0HP+s8Ro+hPasZVI70SeP5
         OmNfKfRALKajL4amKRqWNZbX6BTcyCJo6/edWEz8zA4NExwBKgJ1rcHP3ZZB5ip6Y42B
         9Dz1cpM/5rCVmN5kiUCCLzBXNwKCMtYfQJM4Bjm2pxCQjztejaLFsmnEWrUkt9aE26XW
         f1Bw==
X-Gm-Message-State: AOJu0YyjeKdA6oDiBy23FSFMqHYswiZ7asv4rh746O5r9xtIqQzgSHAN
	Aj+Emvk9fTkPzHidC+cBw1aBrL37l2PWmuuDdU2UfxRw+KnblKVtei1c
X-Gm-Gg: AfdE7clnrmANN2baA6DgstsDz9XEEU2+EWsX2LBoHbuSq9MmPkhJr5GVo3wT3YYvrKx
	/IC6xhRqby7gw8YBSiu9bOkJSAaNSPm+n7AX3tKbqj3ncYxLBL5T57RXIkk5SeaXacsZURjAq19
	ab8pw1Qe7qS5nF1EvIz53assczZx7OM6yyGlJA9maZEiVZys5Yzyu861m4V/z8zqW0NzwyGyIdT
	Y8EI0uSxV3V4d/kyqnht2sBaPQ5ms2Kj0r72YvDCDV6W4b4j2Lt1O+hJnM3QSyniXGozTc5B4wU
	2cbw33QFuyHeOgfLDZ+I7/bCuwG6nmKFsa2nc6qpRpciNIKWtKoSj/HtLy9yO5Hw146Ta3KGt/5
	dSjNDrATR4orwXjzPUQQlJdJvtuFjkaz3OWLFO25fWXmQfSQhZoGMXq3MQNpYm3WOZgRUQJSDvy
	gG1E1XCyQFivLyWdYOvmjTl20NtrBFFpAZOXegefalISUbBElzeW/CehXMew==
X-Received: by 2002:a05:6512:1448:10b0:5ae:c34c:aecb with SMTP id 2adb3069b0e04-5b0236c8074mr1227281e87.41.1783927246050;
        Mon, 13 Jul 2026 00:20:46 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca55723sm2625636e87.35.2026.07.13.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:20:45 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Mon, 13 Jul 2026 09:20:03 +0200
Subject: [PATCH v11 7/7] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-i2c-mux-v11-7-72bb8af8ee8c@gmail.com>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
In-Reply-To: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqVJHNuKyI0yNLKsQJG4GN5P1WhzEMYHleBlk62
 DTxJOazLuCJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCalSRzQAKCRCIgE5vWV1S
 MrdWEADPLGXRkVU0zPINh6949Chkjripdi5y3umm5HOULOIHGi9eMA9pceYq+IigsxfwU5Df2XB
 HYQJKvnC+vzTxikIsDb+RFo+3rf+pqu+4kMr7HHFyMFQKNJYl0ThYKzFlLWlxlsptKphWzW6Rp5
 449ayJi00lXvdfzWd2VrjoMHk7s6eU4BMHmLwQMdEogZV8JaOT6ErelaJEBiCvvw2Sk49In9krp
 RFb/cnlAtRPO6zQ+emjgP80FUGfidG7RHk1aQnOJb55ZWLt03DpAiUtloywdLt0zLPoG010Drb9
 yCzjYQ+cHoqFP6wlzk05ygNI/w4Cqq5C0THvTj63HN9p7Mg+44iNx6DOfr8FQ79gifWEyFhlxEY
 huWjuIoAKZSxsdAXpoUMkQYiG+58w9sUKGXYjs030pHWZs0szCA/75vpXDl+IPrRasvh6XrpJju
 PWjCdpYhOfzJecVct8yn4QBlwrhVRsP/HcFvqjK8nZeCpSBdUd08A7TQT5fS7UnPNDJr48FmNJ9
 5JIb/Vt5jSko2iU0nTOQ3SSgGoZSJWoVfBFDKmQnrkvn617aOd11XbLBjacdTRZnjRRLIZvjs4x
 EgQjBdNn6o4h99xnEhdGhRxMIgRG/i3boiGDaZIqsPJXHjJvirwunqu1fnWEDTOFh7JRTHg0FRl
 7N6h4tdt15p9adQ==
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

