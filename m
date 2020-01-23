From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/2] Move the SMBus API documentation to libi2c
Date: Thu, 23 Jan 2020 10:52:46 +0100
Message-ID: <20200123105246.67732e33@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgAWJws (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Jan 2020 04:52:48 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Lei YU <mine260309@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Luca Ceresoli <luca@lucaceresoli.net>

This is a cross-project patch set moving the SMBus-level API
documentation from the kernel to libi2c.

[1/2] libi2c: Add a manual page to document the API
[2/2] docs: i2c: dev-interface: document the actual implementation

It applies on top of Luca's recent patch set which cleans up the whole
i2c documentation. I'll rebase it if needed when Luca sends v2 of his
patch set.

-- 
Jean Delvare
SUSE L3 Support
