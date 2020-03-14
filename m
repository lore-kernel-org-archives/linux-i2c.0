From: James Feeney <james@nurealm.net>
Subject: i2c-tools - at24 vs eeprom - decode-dimms fails with the at24 module
Date: Sat, 14 Mar 2020 09:22:57 -0600
Message-ID: <dc5201ea-de3f-f26c-c95e-fca392b521aa@nurealm.net>
Reply-To: james@nurealm.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:42038 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728582AbgCONSL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 15 Mar 2020 09:18:11 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>

The log says "kernel: eeprom 3-0050: eeprom driver is deprecated, please use at24 instead", but decode-dimms will only work with the deprecated eeprom driver.  With the at24 module, "Number of SDRAM DIMMs detected and decoded: 0".  With the eeprom module, "Number of SDRAM DIMMs detected and decoded: 6". This is on Arch Linux, with linux 5.5.9.arch1-2, on an old Asus P6T DELUXE V2 with a Core i7.
