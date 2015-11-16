From: Michael Bachmeier <michael.bachmeier.linux@gmail.com>
Subject: =?UTF-8?Q?Re=3A_i2c_slave_support_f=C3=BCr_i=2Emx6?=
Date: Mon, 16 Nov 2015 07:47:55 +0100
Message-ID: <CAH-Fpeouz=DKaNxegRkc5X4VB5y4r0kT3EnqNdB+_MqdPUs16w@mail.gmail.com>
References: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
	<20151110085955.GA1532@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35472 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbKPGrz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 16 Nov 2015 01:47:55 -0500
Received: by igl9 with SMTP id 9so51406255igl.0
        for <linux-i2c@vger.kernel.org>; Sun, 15 Nov 2015 22:47:55 -0800 (PST)
In-Reply-To: <20151110085955.GA1532@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>

Hi,

I'm just going to rewrite your rcar driver for the i.mx6 processor.

thanks to your comments in the rcar driver, I understand the function
of each register. But I'd like a manual of this board. Where is
accurately entered into the individual registers.
The product spectrum from Renesas is very large and actually very
confusing for me.
Had someone for me a manual by the individual registers are explained.
So that I can understand the rcar driver better.


thanks

2015-11-10 9:59 GMT+01:00 Wolfram Sang <wsa@the-dreams.de>:
> Hi Michael,
>
>> Do I understand it right, I can set the Master in slave mode and the
>> new slave get his own i2c-adresse?
>
> Yes, you can have your own address then. Note that I recently gave a
> talk about the slave framework. You can find the slides here:
>
> http://elinux.org/ELCE_2015_Presentations
>
> Search for my name there. And if you wait some more, the video will be
> there, too, which will be much more helpful than the slides only. And
> there is the regular documentation:
>
> Documentation/i2c/slave-interface
>
>> Say that, I can connect a Master from the outside, without this
>> leading to problems?
>> If the master switch to slave, then stops SCL? Or how does it work?
>
> I suggest getting the I2C specifications from the web and read about
> "multi master" and "bus arbitration" to understand how it works. Please
> note that true multi-master busses can in practice be tricky. Shall your
> mx6 also be master, or slave only?
>
>> Is the EEPROM simulator only available if I rewrote "i2c-IMX" drivers
>> to the slave support?
>
> Yes.
>
>> Does anyone know if anyone is working on this driver?
>
> I don't know of; but I put some more people on CC who regularly work on
> Freescale SoCs.
>
>> Would it theoretically be enough to write 0x80 in the "I2Cx_I2CR"
>> register to set MSTA Bit to
>> slave mode. "Changing MSTA from 1 to 0 generates a Stop and selects Slave mode."
>> Or then disturbs the old driver?
>
> You need more to do this. You need to handle slave interrupts. See the
> documentation.
>
> Good luck,
>
>    Wolfram
>
