From: MikeB <mabnhdev@gmail.com>
Subject: Looking for guidance to support 74CBTLV3253 mux
Date: Thu, 10 Nov 2016 06:59:41 -0500
Message-ID: <CAAuRgKCgz5gtsCYxvykj9Nf1tMT+HLd--p1wb6ggBYcNJARfVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:36517 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932632AbcKJMFM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 10 Nov 2016 07:05:12 -0500
Received: by mail-yb0-f170.google.com with SMTP id v78so87815359ybe.3
        for <linux-i2c@vger.kernel.org>; Thu, 10 Nov 2016 04:05:12 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hello,

I have a system with several 74CBTLV3253 mux set up as below.

+----------------+
|                |
|    PCA9547     |
|                |
+-------+----+---+
        |    |
        |    +-------------------+
        |                        |
   +----+----+          +--------+-------+
   |         +----------+                |
   |  CPLD   +----------+   74CBTLV3253  |
   |         |          |                |
   +---------+          +--+---+--+---+--+
                           |   |  |   |
                           |   |  |   |
                           +   +  +   +

In case the ascii-art is unlcear.  At the top is a PCA9547 mux.  On
one channel of the PCA9547 is a CPLD device.  On another channel of
the PCA9547 is a 74CBTLV3253 mux.  The CPLD has two signal lines
connected to the 74CBTLV3253 mux used to select its channel.  There
are four channels on the 74CBTLV3253.

I'm looking to provide an i2c mux driver for the 74CBTLV3253 mux.

A register in the CPLD device controls the channel selection in the 74CBTLV3253.

To select a 74CBTLV3253 channel, requires the following sequence.

1. Select the CPLD channel on PCA9547.
2. Write the 74CBTLV3253 channel number to a register in the CPLD.
3. Select the 74CBTLV3253 channel on the PCA9547.

I'm struggling with the best way to deal with the fact that the action
of selecting a channel on the 74CBTLV3253 must access a device on an
entirely different i2c-adapter.

Any advice or guidance on how to attack this mux driver would be appreciated.

Regards, Mike
