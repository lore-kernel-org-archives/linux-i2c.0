Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A853596FF
	for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980885; cv=none; b=Rkfmzcv3RTTbEt6pmyCCKFyHcp7fxwiNe3FSHLzv+FXCr+Uehz3tGq9xadLa2Hv7bT+qRDye++sHXgZ0AT2jkGTX34N8MXfjQC5+G12PlixailjnpZCgs6VPDQVxqHcTD6Pmpk6/kqfy+6LnsIUc0FB4x4Jgz5CN1bJBKhbjmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980885; c=relaxed/simple;
	bh=G8r8z7mFndx6RhNUdA+WKfKocioUhRmN3d9RveqxuFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jIRGeElEKOpWFblmcj/PO0YQDpywqCPVxp8zoqoIywxYcWc+fXboYYtqB5VRiMQAFeqpEXkFW3Inb0yOLUJuTCRT4SvgBOcBh6ssJY8UQhE9bU05NfmuIejA79Iswe1TQigLfXZroCzACUHyBJD01AiXDrwlizFtKYYuyABzv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CICdaxL/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CICdaxL/"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59de66fda55so866278e87.3
        for <linux-i2c@vger.kernel.org>; Fri, 13 Feb 2026 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770980882; x=1771585682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk3clnWFlbrxfg7hPFpqEEazCewYQ0BYconZLXp7/hE=;
        b=CICdaxL/+sZG12V9wy52qksRAvslHRTGR4HLXRkZzfuOH8LVrsGbxp5iM0kRHlcvI1
         nFtoGJcwAiKszTMBSnDWmrseRxGGWB2iPt5PlM4UnWPgASoTXzAHZxvOs5CaKm8zSt/k
         /K+Ljr02hWBTpMsqKNSEZECUo7jPop08F/Zk7y0f8NqSvBqR7JISpUHq3d1JASCMQXb0
         kJTS2yZ7NN348jkLARR1V69geyS+MJvh13jXjNgCFEIm6Lffp6QqicA1v42n13biVQKE
         kqI3RRe8bXBfYgqfye/UeSKSIXtaRic5geUPVS56jf0NYZ2rITZrTM33k/ym72bUUeSs
         xpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980882; x=1771585682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xk3clnWFlbrxfg7hPFpqEEazCewYQ0BYconZLXp7/hE=;
        b=JTe7jXhSG3cU/bjaOABaaZyOmpmSPv0BR7cLeV8l93zl1lGxA23aDhHbPpYfzQYmUz
         VmDIBtwax39Q9MsStyqbnAgOCKD91qYxYnSgG4bqh0NTsjhV3ysUKRIwGS9Qz9+jD7Xn
         jG/BvwVCEI2ECYiZ7VR/NT5ml4/IcBugdDlQILhoB9MS9rZy8IcfnIj3J1+Wp45jjJCy
         CC9phpYW3YcRspeUo9Sdj5EsKPdHLBGta3YIQKL9NrxKGpn0Wp5hQtBh1m0PNkitZerM
         siaeuMXCxzD43LxaJ9CoviMRgQfcfjvA6vJCVRSUfbTGk9Xxij12jLov6KnDLg3gvhE2
         FKdg==
X-Gm-Message-State: AOJu0YxpJSD6ia/ylUZNAdxWVjPjieyU4kiZXcezEX6l/kZ40KdRpFLy
	9IaEc2jNptq+4r7vMDOniqpoqvgxxFTHstbSQ3s6S46yz7bjN1Sx5ZTq
X-Gm-Gg: AZuq6aJ4KiYivm1CKZBFX1T35jjDb63nYmr7jq4zaErOIvdcVCGZx1PM/I/7Sc+iDFc
	uHHSOMqFj5fZjdxptXqj3NTy95T9J52BxlFClI2CWUEF1aXEotxs2au2Gg5Rh/JW0nvOOOy+gpF
	o8+Gr64tNdtUQhVvUZ2AxUKQe040CsourDAIyvxwBtBkWDwe7G7Ptn5XAZAw/1iwoiHVFl0MhPB
	Ple0w/7ghCSKE4afYDP7+NKXlgIOy4u9DhFRiB9VRqKcBLC4NcCuExQGsDDMwvXIEwDKC+GsFYV
	6VIaPGPtBvyV//nuMFXkQ3sTyWRTygtzGd4pjYLxKDfDG2IGXk9zVhrR+8yLk9oo7h1KIs3AuKa
	uFE6GD5iUiET+Jg3W3KowMZKVYuIu7XAIpYXdvmDFxXptd09My5mg6YgP7xAevQ0AwWtb/On978
	W2qZaTN7MP0HIs6cgt08jPbj8mz6Xb5+YducTyvVZVfhsa467nMWv5Nn318ntwfVxof+2D
X-Received: by 2002:a05:6512:3e0e:b0:59d:fb43:5474 with SMTP id 2adb3069b0e04-59f69c0e3cdmr497918e87.7.1770980881611;
        Fri, 13 Feb 2026 03:08:01 -0800 (PST)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-387068924c3sm13635831fa.1.2026.02.13.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:08:01 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Fri, 13 Feb 2026 12:06:54 +0100
Subject: [PATCH v5 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-i2c-mux-v5-5-fb2cbf9979b3@gmail.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
In-Reply-To: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBpjwYULntuXqppCKAp6MHQLjAs03e3JoMx/lAL1
 tbwKPGiJwyJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaY8GFAAKCRCIgE5vWV1S
 MpsND/4kSp3FQNG2wRur+bl+h5XFJUP4SFef4onkUAsftA/Z4zisGI5ysGEOpwFB86rerq5Hc34
 rjeoM6nfEDWOLlRvwraAl1NeeuN7Z1XbwEOWYpp+aF+QUC4y8F0xqAcgsdljehfBOKkpdLh8mpQ
 lVBwoUWN6dFozHJZk+Ry9qY3f47n6A7MDGrgWW57xuxnGz2/617YRfgmcllA2u8Af4Ln32V65JM
 wvBOgUm0lnUJWln2xjIycdxHLRGGCcKv97MzChmtPFjFKoX5sFjfkTuXKT1/Zxb2ejFExtChQH5
 UxVppsMYDiOI8nQ+DxmYejfRcL9ACM2dQDlvx28WxHEZCv7PL33Ve33hXIfR+75eOIXLzFIYwMg
 z5LQLVQTeDlFSGpDGsRJ2yZNhurziRy/0u6LN3x2TKri3U2j6TUXjSLrOhVuS4aAIiwkzmq4uN7
 SdGZwI4hpsKXvnCC+RNi3x8XkVoUP+DWe3wKK6ZUNhrqBEC5jO5fn2lyipL1pGM+IKacKBEd9eA
 N4NhOMgKHwPEDVnT3SLUDIdpYHPyaqL5ZLkBcttD0YNXgHXjymo9hRLwMFuNLDlt91kVr4cgQCP
 M2mGFO+g16ANe5RThYamHGhfFx3M9RMh0bJqcmy00jlZBo5yRKx/8mDzDmvIojkWIo7tr+7aKXr
 Nl2YZh8LYcPQb/Q==
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

