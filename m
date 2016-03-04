From: Maxim Syrchin <syrchin@dev.rtsoft.ru>
Subject: Re: [PATCH] i2c: imx: add slave support. v2
Date: Fri, 4 Mar 2016 14:06:10 +0300
Message-ID: <56D96C22.8030104@dev.rtsoft.ru>
References: <1453824880-4844-1-git-send-email-dbaranov@dev.rtsoft.ru>
 <20160303213509.GF1501@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45376 "EHLO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbcCDL0s (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 4 Mar 2016 06:26:48 -0500
In-Reply-To: <20160303213509.GF1501@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Dmitriy Baranov <dbaranov@dev.rtsoft.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Wolfram,
I'm now working on creating new driver version. I think I'll be able to=
=20
sent it soon.

04.03.2016 0:35, Wolfram Sang =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> There are might be race conditions.
> Can you name them
Most of races are fixed already. There were some issues with interrupt=20
latencies  - sometimes slave interrupt appears in process of starting=20
master xfer.
>> +enum imx_i2c_slave_state {
>> +	I2C_IMX_SLAVE_IDLE,
>> +	I2C_IMX_SLAVE_IRQ,
>> +	I2C_IMX_SLAVE_POLLING
> Highlevel question first: Why do you have polling? Why would anyone n=
ot
> want to use interrupts here?
Since imx doesn't generate interrupt on "bus stop" condition we'd had t=
o=20
implement polling scheme. Interrupts are used for starting polling and=20
for  waking polling loop on new slave request. Without polling we can't=
=20
handle "end-of-packet" event correctly.

In current version states are:

	I2C_IMX_SLAVE_IDLE // default state. slave process is waiting for inte=
rrupt
	I2C_IMX_SLAVE_POLLING // slave transfer is in process.
	I2C_IMX_MASTER   // master transfer is in process.
