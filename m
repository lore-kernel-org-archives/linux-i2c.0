From: Peter Rosin <peda@axentia.se>
Subject: Re: Looking for guidance to support 74CBTLV3253 mux
Date: Thu, 10 Nov 2016 13:52:44 +0100
Message-ID: <ca761330-e6de-243f-84eb-7a6c9dd9e59f@axentia.se>
References: <CAAuRgKCgz5gtsCYxvykj9Nf1tMT+HLd--p1wb6ggBYcNJARfVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0139.outbound.protection.outlook.com ([104.47.2.139]:42204
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbcKJWBP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 10 Nov 2016 17:01:15 -0500
In-Reply-To: <CAAuRgKCgz5gtsCYxvykj9Nf1tMT+HLd--p1wb6ggBYcNJARfVQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: MikeB <mabnhdev@gmail.com>, linux-i2c@vger.kernel.org

Hi!

On 2016-11-10 12:59, MikeB wrote:
> Hello,
> 
> I have a system with several 74CBTLV3253 mux set up as below.
> 
> +----------------+
> |                |
> |    PCA9547     |
> |                |
> +-------+----+---+
>         |    |
>         |    +-------------------+
>         |                        |
>    +----+----+          +--------+-------+
>    |         +----------+                |
>    |  CPLD   +----------+   74CBTLV3253  |
>    |         |          |                |
>    +---------+          +--+---+--+---+--+
>                            |   |  |   |
>                            |   |  |   |
>                            +   +  +   +
> 
> In case the ascii-art is unlcear.  At the top is a PCA9547 mux.  On

Looks fine over here!

> one channel of the PCA9547 is a CPLD device.  On another channel of
> the PCA9547 is a 74CBTLV3253 mux.  The CPLD has two signal lines
> connected to the 74CBTLV3253 mux used to select its channel.  There
> are four channels on the 74CBTLV3253.
> 
> I'm looking to provide an i2c mux driver for the 74CBTLV3253 mux.
> 
> A register in the CPLD device controls the channel selection in the 74CBTLV3253.
> 
> To select a 74CBTLV3253 channel, requires the following sequence.
> 
> 1. Select the CPLD channel on PCA9547.
> 2. Write the 74CBTLV3253 channel number to a register in the CPLD.
> 3. Select the 74CBTLV3253 channel on the PCA9547.
> 
> I'm struggling with the best way to deal with the fact that the action
> of selecting a channel on the 74CBTLV3253 must access a device on an
> entirely different i2c-adapter.
> 
> Any advice or guidance on how to attack this mux driver would be appreciated.

The way to think about this is that it is the CPLD that stands for the
muxing. So, you need to write a driver that on mux requests writes
to the CPLD register, presumably 0-3. The fact that the i2c signals then
travel through that 74CBTLV3253 thing is just HW immaterial to the
programming logic. That IC could be replaced by any number of similar
ICs, as long as the two signals from the CPLD does what is expected.

What is different from most other i2c muxes is that you need to point
out both the i2c master that is used to communicate with the CPLD and
the i2c master that is muxed. The first one is the normal one you can
access from the i2c_client struct (like any i2c devices). The other
you need to pass in some other way, probably though devicetree or
ACPI. Take a look at how i2c-mux-gpio gets to the i2c master it is
muxing. Basically, replace the calls that i2c-mux-gpio does to update
gpio pins with calls that update the CPLD register via the i2c master
from the i2c_client struct.

There is however one requirement, the CPLD-mux must be "mux-locked"
as explained in Documentation/i2c/i2c-topology. Otherwise accesses
to devices behind that mux will lock the PCA9547 mux for the full
duration of the transaction and thus lock out any attempts to update
the CPLD mux as part of the transaction. In that topology document,
you are in the "Parent-locked mux as parent of mux-locked mux"
section, with "dev D3" controlling "mux M2".

Cheers,
Peter
