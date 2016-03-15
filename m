From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] i2c: Spelling s/propoerty/property/
Date: Tue, 15 Mar 2016 17:51:27 +0100
Message-ID: <1458060690-9738-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:33768 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcCOQvi (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Mar 2016 12:51:38 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Wolfram,

This series fixes the misspelling of "property", which is spreading in
the i2c drivers. Let's stop it ;-)

Geert Uytterhoeven (3):
  i2c: imx: Spelling s/propoerty/property/
  i2c: rcar: Spelling s/propoerty/property/
  i2c: sirf: Spelling s/propoerty/property/

 Documentation/devicetree/bindings/i2c/i2c-imx.txt  | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-sirf.txt | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
