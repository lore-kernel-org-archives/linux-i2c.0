From: Shivaraj Shetty <shettyshivaraj@gmail.com>
Subject: [REF] Query regarding process call/repeated start in i2c driver
Date: Tue, 5 Sep 2017 14:08:50 +0530
Message-ID: <CANXXpoBfWccpXNza3xyVXDd7biAdrq+8DyzeRsGidVRE55iNyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:37875 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdIEIiw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Sep 2017 04:38:52 -0400
Received: by mail-io0-f173.google.com with SMTP id j141so8522870ioj.4
        for <linux-i2c@vger.kernel.org>; Tue, 05 Sep 2017 01:38:52 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

 Hello,

1. From I2C_AQ_COMB quirk it looks like if there are two messages in
single i2c_transfer api to i2c-core, it has to be repeated-start.
Is my understanding correct?

2. On calling smbus api for word read (non process call), it calls i2c
transfer api with two messages (emulation on i2c case). Now if 1 is
true we end up in repeated start case.
But this may not be expected by the i2c client.

Basically how to know from the i2c host/core driver, if the client
wants to use Repeated start or not?
Why don't we have a way where i2c client driver can call the i2c core
api with flag to indicate whether to use repeated-start or not?
(similar to protocolparameter in smbus api - can be set as
I2C_SMBUS_PROC_CALL for process call)

- Shivaraj
