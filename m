From: minyard@acm.org
Subject: [PATCH 0/5]
Date: Tue, 19 Jan 2016 11:09:32 -0600
Message-ID: <1453223377-20608-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173025pub.verizon.net ([206.46.173.25]:62032 "EHLO
	vms173025pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbcASSJ5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:09:57 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173025.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O1700MCQMC4R430@vms173025.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:09:40 -0600 (CST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org

This is a small set of patches for the i801 I2C driver that are
mostly cleanups and consolidation.  No real behaviour change, except
not enabling PEC when it's not needed.

I have tested these pretty extensively on qemu with various configurations
and errors (I've hacked up qemu a bit to do this) and it seems to be ok.

Not sure if you are interested, but thought I would offer.

-corey
