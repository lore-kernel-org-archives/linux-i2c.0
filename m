From: Stephen Douthit <stephend@adiengineering.com>
Subject: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Mon,  7 Aug 2017 17:10:58 -0400
Message-ID: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0102.outbound.protection.outlook.com ([104.47.0.102]:13680
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751761AbdHGVLe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 7 Aug 2017 17:11:34 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: seth.heasley@intel.com, nhorman@tuxdriver.com
Cc: wsa@the-dreams.de, danp@adiengineering.com, stephend@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hello all,

We ran into an issue where the ipmi_ssif and i2c-ismt drivers don't
agree on the format for data returned by i2c_smbus_read_block_data()

Looking at the traffic on the wire with a beagle analyzer:
-----
Packet Details   (Values in hex; [S] = Start condition;
                  [P] = Stop condition; * = No Ack)
[S] <10:R> 12 1C 01 00 00 80 02 1C 02 8F BE 12 00 25 12 41 01 00 00* [P]
-----

Looking at the matching kernel trace:
-----
kssif0010-759   [001] ....  1435.891090: smbus_read: i2c-0 a=010 f=0000 c=3 BLOCK_DATA
kssif0010-759   [001] ....  1436.202906: smbus_reply: i2c-0 a=010 f=0000 c=3 BLOCK_DATA l=20 [13-12-1c-01-00-00-80-02-1c-02-8f-be-12-00-25-12-41-01-00-00]
kssif0010-759   [001] ....  1436.202908: smbus_result: i2c-0 a=010 f=0000 c=3 BLOCK_DATA rd res=0
-----

So basically the byte count already precedes the data in the dma_buffer,
then the driver sticks desc->rxbytes in front of this resulting in the
trace above.

The first patch tackles this.

The second patch in the series adds a sanity check on the byte count
supplied by the slave device.  This might be a nice to have, but is
probably less critical.

-Steve
