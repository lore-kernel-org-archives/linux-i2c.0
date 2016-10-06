From: "Phil Endecott" <phil_gjouf_endecott@chezphil.org>
Subject: i2c-xgene-slimpro.c : dma_buffer overrun
Date: Thu, 06 Oct 2016 22:22:15 +0100
Message-ID: <1475788935324@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; format="fixed"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from japan.chezphil.org ([77.240.5.4]:5183 "EHLO japan.chezphil.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933011AbcJFVqs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 6 Oct 2016 17:46:48 -0400
Received: from localhost ([127.0.0.1] helo=chezphil.org)
        by japan.chezphil.org with esmtp (Exim 4.72)
        (envelope-from <phil_gjouf_endecott@chezphil.org>)
        id 1bsG7M-0000ir-Ju
        for linux-i2c@vger.kernel.org; Thu, 06 Oct 2016 22:22:16 +0100
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>

Dear Experts,

Can someone please have a look at this declaration in i2c-xgene-slimpro.c:

struct slimpro_i2c_dev {
        struct i2c_adapter adapter;
        struct device *dev;
        struct mbox_chan *mbox_chan;
        struct mbox_client mbox_client;
        struct completion rd_complete;
        u8 dma_buffer[I2C_SMBUS_BLOCK_MAX];
        u32 *resp_msg;
};

It seems to me that the size of dma_buffer should be I2C_SMBUS_BLOCK_MAX+2, 
to match this in uapi/linux/i2c.h:

union i2c_smbus_data {
        __u8 byte;
        __u16 word;
        __u8 block[I2C_SMBUS_BLOCK_MAX + 2]; /* block[0] is used for length */
                               /* and one more for user-space compatibility */
};

My debugging shows that 33 is often passed as readlen to dma_map_single() 
in slimpro_i2c_blkrd().  So either the buffer needs to be larger, or the 
caller is misbehaving.  Certainly increasing the size of dma_buffer by 2 
fixes crashes that I have been seeing.

This is the first time I've ever looked at anything in the i2c system so 
I may have completely misunderstood everything....

(If I'm right, is anyone aware of any static analysis method that should have 
been able to detect this?)


Thanks,  Phil.
