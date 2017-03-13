From: MikeB <mabnhdev@gmail.com>
Subject: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 09:14:08 -0400
Message-ID: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33715 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdCMNOK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 13 Mar 2017 09:14:10 -0400
Received: by mail-vk0-f53.google.com with SMTP id d188so34612363vka.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Mar 2017 06:14:09 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

The current naming scheme for i2c-mux adapters "i2c-<parent adapter
id>-mux (chan_id <id>)" results in duplicate names if there is more
than one mux device on an i2c adapter since each device will have the
same <parent adapter id>.

For example:

                  +--------+
                  |PCA9548 |
                  |  0x70  |
                  |01234567|
                  +--------+
                   |
        +-----------------------------+
        |             |               |
    +--------+    +--------+     +--------+
    |PCA9548 |    |PCA9548 |     |PCA9548 |
    |  0x73  |    |  0x74  |     |  0x75  |
    |01234567|    |01234567|     |01234567|
    +--------+    +--------+     +--------+


will result in eight sets of duplicate names for the channels coming
off the lower three muxes.

Any suggestions on how to modify i2c-mux.c to make these names unique?

Thanks, Mike
