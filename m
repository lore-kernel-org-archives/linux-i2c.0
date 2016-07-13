From: Jan Kandziora <jjj@gmx.de>
Subject: Introducing a kernel driver for the DS28E17 Onewire to I2C master
 bridge; Feature request: introduce I2C_FUNC_STOP
Date: Wed, 13 Jul 2016 12:07:39 +0200
Message-ID: <578612EB.1060709@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:62639 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854AbcGMKHn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 13 Jul 2016 06:07:43 -0400
Received: from [10.0.0.99] ([79.242.247.106]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLvGW-1bSln603TA-007mFZ for
 <linux-i2c@vger.kernel.org>; Wed, 13 Jul 2016 12:07:40 +0200
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi

I have written a driver for the DS28E17 Onewire to I2C master bridge. I=
t
acts as a slave device in the W1 subsystem and as a bus master in the
I2C subsystem.

It's available here:

	https://github.com/ianka/w1_ds28e17

The kernel driver is in the files w1_ds28e17, Kconfig and Makefile. The
other files are test programs for the DS28E17 development kit as sold b=
y
Maxim. Please see the README for further details.

I've already sent a mail to Evgeniy Polyakov, maintainer of the W1
subsystem and Wolfram Sang, maintainer of the I2C subsystem but got no
reply. Maybe due to holiday season.

It would be nice if someone with insight could give me a ping "that
looks okay" or "you have to fix this or that".



I also have a question/feature request for the i2c subsystem. The
DS28E17 can support I2C_M_STOP, which allows to combine write/read into
a single transaction for slaves which need the intermediate stop
condition =E2=80=93 as the DS7505 from the evaluation board. Using I2C_=
M_STOP
instead of splitting the transaction into two would save some overhead
on the Onewire bus (8 bytes at 15kBaud =3D=3D 4ms, of busy-looping when
Onewire is bitbanged.)

However, the test for the I2C_M_STOP feature is made with
I2C_FUNC_PROTOCOL_MANGLING, which also includes I2C_M_REV_DIR_ADDR,
I2C_M_IGNORE_NAK, I2C_M_NO_RD_ACK. All of these *are not* supported by
the DS28E17.

What's the right way to handle this on the I2C driver side? Could we
have a I2C_FUNC_STOP as we have a I2C_FUNC_NOSTART?


Kind regards

	Jan
