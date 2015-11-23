From: Michael Bachmeier <michael.bachmeier.linux@gmail.com>
Subject: =?UTF-8?Q?Re=3A_i2c_slave_support_f=C3=BCr_i=2Emx6?=
Date: Mon, 23 Nov 2015 10:11:24 +0100
Message-ID: <CAH-Fpeo6R1haEb0qdw5merP5tpAhaEL7FKJ3HV6WFLfiB_B0Cg@mail.gmail.com>
References: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
	<20151110085955.GA1532@katana>
	<CAH-Fpeouz=DKaNxegRkc5X4VB5y4r0kT3EnqNdB+_MqdPUs16w@mail.gmail.com>
	<20151118111142.GC11028@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33172 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbbKWJLY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 23 Nov 2015 04:11:24 -0500
Received: by igcmv3 with SMTP id mv3so24682748igc.0
        for <linux-i2c@vger.kernel.org>; Mon, 23 Nov 2015 01:11:24 -0800 (PST)
In-Reply-To: <20151118111142.GC11028@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

Hi,

Is the recognition of IAAS a hardware interrupt (according to manual,
yes)? I set IEN (I2C enable) and IIEN (Interrupt Enable).
I set the slave address to 0x1c (chosen at random). The IMX bus driver
is unchanged. With my external Master I ask for the address on the
bus. But the IAAS bit is never set.
In this test, I want to see if the hardware interrupt work.
Should i modified the bus driver (IRQ handler???) or is this a real
hardware interrupt?

Where is my misconception?

Best regards

2015-11-18 12:11 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi,
>
>> thanks to your comments in the rcar driver, I understand the function
>> of each register. But I'd like a manual of this board. Where is
>> accurately entered into the individual registers.
>
> As far as I know, there is no public user manual for RCar SoCs. I can
> ask, though.
>
>> Had someone for me a manual by the individual registers are explained.
>> So that I can understand the rcar driver better.
>
> However, if you have a specific question, you could ask and I could try
> improving the driver's documentation :)
>
> Regards,
>
>    Wolfram
>
