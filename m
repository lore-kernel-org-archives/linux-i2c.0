From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 0/6] decode-dimms: Add support for DDR4 SDRAM memory
Date: Sun, 19 Nov 2017 13:33:09 +0100
Message-ID: <20171119133309.67d4c596@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48001 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdKSMdL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 19 Nov 2017 07:33:11 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8555AAAB9
        for <linux-i2c@vger.kernel.org>; Sun, 19 Nov 2017 12:33:10 +0000 (UTC)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>

This patch series adds support for DDR4 SDRAM memory modules:

[PATCH 1/6] decode-dimms: Add preliminary DDR4 support
[PATCH 2/6] decode-dimms: Decode size and timings of DDR4
[PATCH 3/6] decode-dimms: Decode misc parameters of DDR4
[PATCH 4/6] decode-dimms: Decode physical characteristics of DDR4
[PATCH 5/6] decode-dimms: Documentation update for DDR4
[PATCH 6/6] decode-dimms: Verify the CRC of DDR4 data block 1

-- 
Jean Delvare
SUSE L3 Support
