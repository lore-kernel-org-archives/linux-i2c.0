Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489E43F4BE
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783513019; cv=none; b=FXq3Q7WpzCs5btPcjR8agH4VmA+DHKiXK0ixpgiyvkD9mje6j8C71WZqAlKdfaPJ46D1nu0dZx1z9JczNW7wxha/VeIXPgUCn5HWNqyBXGobs2tiMc7rnXSNtMHpAiGI0CZsveM2AUr9fkaFWzpZymAeHtH4lbZK5et9ivI2vMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783513019; c=relaxed/simple;
	bh=B2YqMrgTja5ulsdupqJSWKQwHmegjD8Hbyvf0CUQZgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+2Ej3wFkzXnt3OYtRgENEJhEDkdhFQXcjeKiP9AJ+MddFdxoZ7pOJCze6osAPNY4p6VhmK7A6K2IlihMwrd6SyV+5jyKMw5tLOcjED5l1P70VIf+EZbH7fZfH+DcaXewBiBz4ezb5iaGBpng+tBbupS5zH7Nku40n92LqT8MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+a7bQfo; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+a7bQfo"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b00d083818so1024384e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783513015; x=1784117815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=C+a7bQfotVEOX2jDrmF2Wyht1iKjMACnw0Pqe/iWtp6WmPM7XmG08/9PWjzd8gXBkJ
         Fcfqww3CvqRvN16JQWC7LLOdSt4cGNPMPBVaCHV5bcHWecwF3uOc99GvBes//qoJyl3h
         b2BTZZ/vZaw0C3yNPzvk1jvtoWI2UyTfjwSjvUxTeF0awjkiWUy2ZM+YRrQy9Icm9UGI
         qtn8N4/Qw7DH24fcjfrFYfGBD71ZrHz+bh/pUr6i/3M8ObARfpmSDMk0yVB+uP/wBw1G
         s5A7oBq+JDmRC/pBaoPPsC6k2Xa5jyxwhvKelL/yeiZzRGS/wqVpcveAxn5ddXLRTc2F
         KJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783513015; x=1784117815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nOkF62GGkmnVWUbbVUdf1e4ZunQyMCemxV0335qyJ0=;
        b=LIGucw0VcxQsKGpmtxftU97NpDWBOlliHZHX4NYkjaWTS0dz+xNaALEPtkc9PsZCHd
         UzYmt+qz/VvK+F7GCAMukYjn9td8m6GmIoX87BUMIWcr3moogL6PfUA/bsk1qFDsaS0I
         ylyguHqE8VSDUYd8EWq2WZAkFTILQyREhnt3wCwKOqXJcOUYvLWmj3WYZi5rgwsppTew
         jB8yTFdhEVrWItOaHPBs6/l9Zn5/AzqAbSCaw2e7buwsydLIFs7X2ANFObXdRAKJtAaO
         ryzGVnFbzEA7rOmO78D6jVNUs32aQaFYTGNpW6YvdBPaZMK1XQdu2dlrAvzO2QQ5SE2r
         M7yA==
X-Gm-Message-State: AOJu0YyGioc+02OUQq0XbhPA+I495C5wGreMoo+f29UQS81BWyQzU0ai
	eI2Rr6Mg/H/YwEH0FWRn3f9oIfYJRFmOWc1PkREvIqfwDBLBNETudWzu
X-Gm-Gg: AfdE7cnOpY5/MzSxbXs+0Km/JV0NwI79XVuYnRntw0J1L325wMAmcRFg6lg/l5Oyqh7
	93Xcch8up1/ysxu8fydk0/4plS32SRr7Xx919AdMiy7l7NYzgxloWLH45vOn1ySdAb74YpWLnPk
	WZhTJxYQnF50I4s13e76feux4LU/H1L8Ny+mK4PNgDu0mtUm5dgUiwBHkwgxyRfqnefEyT/9ay+
	56VZ6FajJMwHoH2ycl4FTO+Z5zMUqTMrJAUTCcGuvp1onVmqbGMiocX0dXuS7+tTmA7obKTfTXg
	RVcSM2PEXNZST9Vtal6vu5Z/AzSN5fiXB1WjUw9Imsh3Ura3GjwMwzaxGwlrbf7dP5PknynrfDQ
	ke1T0qRruJJWRuMeYFGLhdava7SfktsfQwrkp03CUrGPCUCVCPpronlVnd4v+ewtKWgYhY1IkfH
	TyHNmvLf/VkH9a07qUY/nfTmODbvn8sRLh4Uly/zyVYcOcYTma2RH0Ncvqdg==
X-Received: by 2002:ac2:5683:0:b0:5b0:1186:fdf with SMTP id 2adb3069b0e04-5b0118611f4mr492063e87.11.1783513014814;
        Wed, 08 Jul 2026 05:16:54 -0700 (PDT)
Received: from [192.168.1.135] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bbbc6sm4471459e87.41.2026.07.08.05.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 05:16:54 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 08 Jul 2026 14:16:19 +0200
Subject: [PATCH v10 7/7] docs: i2c: i2c-topology: add section about bus
 speed
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-i2c-mux-v10-7-09dca03c8a15@gmail.com>
References: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
In-Reply-To: <20260708-i2c-mux-v10-0-09dca03c8a15@gmail.com>
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
 b=owEBbQKS/ZANAwAKAYiATm9ZXVIyAcsmYgBqTj+yr2pwt5lVtroAp8VDBRH+NqX49PDfsesyg
 0Wh/Blhy2yJAjMEAAEKAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCak4/sgAKCRCIgE5vWV1S
 Mg8wD/9ABbtsHUAOFktSFiaBdhhQAAVcESIYxsb+v6Njqy8dAHR+ruwntlOOlqtYh9++TrZB/RV
 NmWUf/GklA80YVa38NVOrIVMnj2G1GMPVRWxtCgiJ4l1JyGlsdc/0o2xhBn0rLbEawQGkNNv9Us
 k3D+creFYhcDe+CDC/cBlzI5oRKM5mEEJd7vc0joRHqvHl/PWSKl+3oXmDS4zieAD+jOmsm9kcT
 7/EpO8UQ+zNkyNesCQg542zfUdbmCZhi01Rz190WtTBo9W8p9uJxxJ5YSpoJvybwXVu71z9O03x
 tG/EGUnk2BfMq91n6leisUR0lvS7SQHiDv9ndVyYgBiwoH0QQ+5KFeIEwJslweUlZHrqS+ddOtR
 DUVjdsM01EVErte9AyYIaon/N1Kr9JezkcVV2Nieu7h/TMvClKRMcmTEx8ubinNiYy8rOulYDFg
 eEKY8pGfNFCJgqCsiskGusai+sW4xJDgFhhcjREbHkCzEITUDDhS9Pogs/g6x2/zlN5wNPkN1ih
 pjqDFW4qdeS2Putl61+amGIqjmqSOZgRJxlZ2LPJ/nZB63Le2U3b4SB0TI/n6CXkptjfiwltd5h
 pJeNF4EYMR8AWZJZ/ehc231EOvBwp2e/eT9K3TXTdS2O5+C0dvdDNSyrUR0hCynv2BmxryxUGjb
 zHcAfC2GKvOucOQ==
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

