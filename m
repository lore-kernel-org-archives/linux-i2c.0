From: Michael Bachmeier <michael.bachmeier.linux@gmail.com>
Subject: =?UTF-8?Q?i2c_slave_support_f=C3=BCr_i=2Emx6?=
Date: Tue, 10 Nov 2015 09:06:27 +0100
Message-ID: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33970 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbKJIGa (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Nov 2015 03:06:30 -0500
Received: by igbxf8 with SMTP id xf8so13542725igb.1
        for <linux-i2c@vger.kernel.org>; Tue, 10 Nov 2015 00:06:30 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

I am currently working with a I.mx6 quad-core-processor on Linux 3.19.
I would like to implement the "I2C slave support", by Wolfram Sang, In
this processor.

For this purpose, I would have some comprehension questions.

Do I understand it right, I can set the Master in slave mode and the
new slave get his own i2c-adresse?
Say that, I can connect a Master from the outside, without this
leading to problems?
If the master switch to slave, then stops SCL? Or how does it work?

Is the EEPROM simulator only available if I rewrote "i2c-IMX" drivers
to the slave support?

Does anyone know if anyone is working on this driver?

In the "i.MX 6Dual/6Quad Applications Processor Reference Manual",
from freescale, on the page 1895 the "Hardware"-Slave Mode will be
described.

Would it theoretically be enough to write 0x80 in the "I2Cx_I2CR"
register to set MSTA Bit to
slave mode. "Changing MSTA from 1 to 0 generates a Stop and selects Slave mode."
Or then disturbs the old driver?

best regards
