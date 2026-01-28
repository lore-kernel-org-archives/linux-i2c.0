Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771434D391
	for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594116; cv=none; b=hX5n47FFZkszMAwGEghgPN5gb5X9obMAvoW+uuS0UkDddo3/hHNV+PTg3xfdDdPPd3kP3lN6fBOsB50/lR6g8iFNITsoT5+uIZfNtBvWsxiV47PGYt541tvZ1NHG/qeTNm0pmch8tjHIxxTKRQEPi9jeQilgyGgTQyap7earWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594116; c=relaxed/simple;
	bh=G8r8z7mFndx6RhNUdA+WKfKocioUhRmN3d9RveqxuFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/mpCiS0ilhqrc6iVmF6fRsR9LcovN0rObUevJlU1guQmsACoonNSj7QQ3eHtHrJtaHmfz1p0QMPy2gmWbOCR5pRU97n+2wpdgXmO2p4vnrp/QNha3NVx0cqTl3uUBOETTZU3BG6lVJx08k/ZHMWoYMBjONVNtFo3NVBPN9/FoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlwvbBP3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlwvbBP3"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b76844f89so6318833e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 28 Jan 2026 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769594112; x=1770198912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk3clnWFlbrxfg7hPFpqEEazCewYQ0BYconZLXp7/hE=;
        b=XlwvbBP3r4b58t7NHxytEMn5ilKIBDrspaFcsel3updvQ5CQw0SjnJk58DmfuU8drJ
         6KqFQqmiZEDOiYU/TkgmXmgAEF7L6D8bAQwNhPRPx2m2LaEygvnsaSmTl4RprhQSWyKf
         jPmkBvqH6BgDBmUaQBWkzgVoP3j65x4aD+Ni8yRDObN0mw/OLFxeC7/KXy0sx6E9f3y6
         q2ccpL2ZFg9XQEF3ho/LsAgCYSzxwmdbrSAjW4ZnOo7tG5YtQRfbSujGmgsAlvPyXwdf
         dIumy87NaVneJ0BZX6wSMUwJ0tk9pt0x1kSzvvy1MdrdG7v2isDNgUC8ouvzWay/YxOO
         gmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594112; x=1770198912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xk3clnWFlbrxfg7hPFpqEEazCewYQ0BYconZLXp7/hE=;
        b=CgNECnVtsLkQ6UkioJROiS6QUoWseeG6gjuVHcTDVOvu+XpwDTwZEAmgEcmrgR4zV1
         15CkX85xwgfRHWaNu7Hmx3DG+AgVDr6iFcsjM4UcfdKOsuB9MlvPNbLeh3qhPsq2A9xJ
         PVWlOe18BcrEZZUvdY2r4og4zr1fLyZBs4m9pd6nH7h97WU1xQm7HYvk727XWTH8E6Dx
         ikd5xuuj5fOc3OSC8JCwf+vkm7r4qrHfldjqhDyW3c+MAqLHN/hr2LR2In/D0dVmNkdb
         4jLCy2hrKHw08dAddPeYsE7lC2IXo5R94IuLRtwsGRBElflcJYzqQC1PKYhhsvp7c2gi
         U7Ug==
X-Gm-Message-State: AOJu0YzPHPtbXBynDnaTtFB6raWBBz8MC91yOYqHIvMfuPGq/VtOyehD
	ghuelU2bkwKwnywAy6uQ4c4I/Dw7lgfPThrCOXfxkCtdlQ++8NMF5v9g
X-Gm-Gg: AZuq6aJwg8+TEhj3Fr4mktJqSNVoMVIiPqRsq90CSkfhBIAfCNuDzBXSVact/fYNDPM
	9FfeNNszXXdtf0hzpRCgpxMB/+gBOWp3wuZ4GKCVSM8uh9fBj/Y0QIthxf0KtFLGvo1cdllL27e
	qZcinmL1d4yhXaAOBFGaM5RZtG2n1DaR2f7E0Se0GDZUVGQjFD0plkDCtwikSAZ/EZqdEaqCmmE
	ZkJJB/8wFvDRoRWWA0KfHu2uIXdGzR+XcBFzECtQY93FCDL/wD+RQiSYr2hv+gzK3SBfAkrGhpP
	s9LnRZ2yagb1mYtYWS/JUV+lJNnfY8JHNL/SsSKVuqTaFcOyVGmQvRQtcRNunwXVgQitFl3YwZo
	JGylaNLqw4vbamwi7Yw3y8FijXpBgkfzr5QVrIhr7PGHmSKTd8k0D4InHBwmWCe84YDi83T32nR
	Qq+XltPjPCtLCNS7jxslFTqh38O1Bilk4zSx6WuotHIK9cDtBr/r4CGrD/
X-Received: by 2002:ac2:4e08:0:b0:59d:e351:57e8 with SMTP id 2adb3069b0e04-59e0401d12amr1955642e87.10.1769594112259;
        Wed, 28 Jan 2026 01:55:12 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bfe83sm459483e87.97.2026.01.28.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:55:11 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 28 Jan 2026 10:54:31 +0100
Subject: [PATCH v4 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-i2c-mux-v4-5-dee49ce276c0@gmail.com>
References: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
In-Reply-To: <20260128-i2c-mux-v4-0-dee49ce276c0@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Peter Rosin <peda@axentia.se>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8159;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=G8r8z7mFndx6RhNUdA+WKfKocioUhRmN3d9RveqxuFs=;
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpedz3ayCz4hIuoaAf9as6dbL/CguP9iycbTa1a
 HYpkfvi2+SJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaXnc9wAKCRCIgE5vWV1S
 MhLyD/9g6rixHuYEpXz2umKPHT07E4y/jjWHMeiM0NQi12GeE79wmvswD6wNcNyWN4mi7AGKf3i
 cQd3TtbCh/lXw1CY5ezARXKRG9UfTkbHh3npBOdQb7Qag3iyp92/sIZXi5j6RnypZM2nGxc3WxM
 3hIMXf2Q3CFfkAgNOKNS2MbGATdu2ZeFRBqQ+B4LVpI3a8J0SDsVLbKjZ14MnMD/b5upaJe9w/E
 ikU+yDvHi2OAdHjW9dXGGoQEN/7eOX91RJ780aX5f0OUo1THZjHAxFpZYoKkVa1r3hZ2BcuYSn2
 3SNiALo14Rf3pQcmLXZEBjTix8IMdSWBWHy2wHxHjt6PvAD3XI4GlsFNvOsfBaJlioHoevg/KnB
 0sgX08+LiPwxw87nu7Q+UnGDmVDATZ5PV+Md3mHNzNFgVasZ99vO37/bMAR1O9IoXhGD6Gek9Oa
 2OCV/F5j51SBXQpziKzO8F0Ys0u2QfFu6KbstEvpUoLlc+le0ta57RqRUoWxYeY9FH8dPZarScf
 Nc2Rx43D1M2s6/Owp16pVmYBDh6SV5tnushh9gNcGDdT3IT6ghGOI+BmGG+MdbNbbJq4xiRGfye
 t34VVOCnQ2vkN2mTIsLPyQY2O0dOjwbBbLWAIicC4sdo+FU4zXhYoeHqp3ouiVscOl37rd80O8/
 5sGfADmexTHd5wA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

Describe what needs to be consideraed and taken into account
when using different bus speeds for different mux channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 Documentation/i2c/i2c-topology.rst | 176 +++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/Documentation/i2c/i2c-topology.rst b/Documentation/i2c/i2c-topology.rst
index 48fce0f7491b..2c4a1364ce82 100644
--- a/Documentation/i2c/i2c-topology.rst
+++ b/Documentation/i2c/i2c-topology.rst
@@ -367,6 +367,182 @@ When D1 or D2 are accessed, accesses to D3 and D4 are locked out while
 accesses to D5 may interleave. When D3 or D4 are accessed, accesses to
 all other devices are locked out.
 
+Bus Speed and I2C Multiplexers
+================================
+
+I2C bus multiplexers allows multiple downstream channels to be exposed
+as separate I2C adapters which also could set their own bus speed.
+
+The multiplexer itself cannot change the bus speed as it use the upstream
+clock and data lines to communicate with the downstream devices. The speed
+is therfor changed in the root adapter resulting in that the whole bus is
+affected.
+
+This increases the complexity of the topology and some considerations must
+be taken into.
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
+but D2 can operate at 400kHz. When D1 is selected, the bus speed of the
+root adapter would have to be is set to 400kHz, a speed that D2 may not support.
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
+Other multiplexers in parallell is still okay as those are locked out during transfers.
+
+This is the preferred topology: ::
+
+                          .----------. 100kHz .--------.
+        .--------. 400kHz |   mux-   |--------| dev D2 |
+        |  root  |--+-----|  locked  |        '--------'
+        '--------'        |  mux M1  |--. 400kHz .--------.
+                          '----------'  '--------| dev D1 |
+                                                 '--------'
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
+Multiple muxes in parallell
+----------------------------
+
+When multiple muxes are used in parallell all access to other muxes are locked out
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
+Muxes have an idle state, which is the state the channels is put into when no channel
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
+- All channels disconnected: No problem, D1 and D2 are not affected by communication
+  to D3.
+- Last selected channel: Problem if D1 was the last selected channel. High speed
+  communication to D3 will be "leaked" to D1.
+- Predefined channel: Problem, if the predefined channel D1. Set predefined channel
+  to D2 as D2 may handle 400kHz.
+
+Supported controllers
+-----------------------
+
+Not all I2C controllers support setting the bus speed dynamically.
+At the time of writint, the following controllers has support:
+
+============================   =============================================
+i2c-davinci                    Supports dynamic bus speed
+============================   =============================================
 
 Mux type of existing device drivers
 ===================================

-- 
2.52.0

