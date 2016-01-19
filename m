From: minyard@acm.org
Subject: [PATCH 0/3] Add parameters to sysfs added i2c devices
Date: Tue, 19 Jan 2016 11:14:11 -0600
Message-ID: <1453223654-20724-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:58049 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbcASSOU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:14:20 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O17002AEMJSHK40@vms173019.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:14:16 -0600 (CST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

When I was testing with qemu, I needed a way to pass in the irq to
the smbus alert handler, and I needed a way to set some IPMI SSIF
parameters.  These patches add a way to pass in parameters to
sysfs, show how the IPMI SSIF driver can use this, and then adds
handling of irq setup for the i2c-smbus alert handler.

-corey
