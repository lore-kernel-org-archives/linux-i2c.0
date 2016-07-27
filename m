From: Phil Reid <preid@electromag.com.au>
Subject: [RFC PATCH 0/1] i2c: i2c-mux-pca954x: Add interrupt controller support
Date: Wed, 27 Jul 2016 11:05:55 +0800
Message-ID: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:51396 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751561AbcG0DO1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jul 2016 23:14:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, linux-i2c@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

G'day All,

I'm seeking some feedback on this. Not really happy with it but can't think
of a good solution.  

This patch adds support to read the irq status register from the a PCA9543
i2c mux. This chip has two active low interrupt inputs with are combined    
into a single active low interrupt output. It does not provide the ability 
to mask interrupts. Only to read which interrupt line is active.

On the hardware I'm interfacing too I have an ltc1760 sbs manager on each 
multiplexed bus. On booting these may assert there SMBALERT irq outputs 
immediately, again these devices have no ability to mask there interrupt. 
So the irq is asserted during boot until the ltc1760 driver is started.
And there's no way to mask it. My work around is to enable the irq until both
irq pins are unmasked. Not sure what else to do. The masking could be a dts
property to make it configurable.

ltc1760 driver is currently being review for submission in 
Karl-Heinz Schneider <karl-heinz@schneider-inet.de> patch series.

Appreciate any feedback on what could be done here.


Phil Reid (1):
  i2c: i2c-mux-pca954x: Add interrupt controller support.

 drivers/i2c/muxes/i2c-mux-pca954x.c | 116 ++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

-- 
1.8.3.1
