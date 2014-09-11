From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: [RFC 0/4] i2c: slave support framework for Linux devices
Date: Thu, 11 Sep 2014 14:06:06 +0200
Message-ID: <5110809.ZO3zEWmmzZ@fb07-iapwap2>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Andrey Danin <danindrey@mail.ru>
List-Id: linux-i2c@vger.kernel.org

Hello Wolfram,

Am Dienstag, 9. September 2014, 16:54:26 schrieb Wolfram Sang:
> Finally, here is my take on the often desired feature that Linux can not
> only be an I2C master, but also an I2C slave. Compared to my draft sent out
> last week, this RFC has been tested on hardware (Renesas Lager board) and
> works \o/

first, thanks for taking up this job.

> One big part still missing is documentation, so brave ones need to "use the
> source". However, this approach turned out to be even less intrusive than
> expected, so that is hopefully a good sign.
> 
> Basically, an I2C slave is a standard I2C client providing a callback
> function. When registering as a slave, the connection to the I2C adapter is
> made which uses the callback when a slave event happens. That splits the HW
> support (enabling slave mode on the adapter) and SW support (here a generic
> eeprom simulator) nicely IMO.

>From what I can tell, this approach may also work with our driver 
(staging/nvec). I especially like the split between the adapter and the client 
support.

I only have one question so far regarding the device tree representation 
attached patch 4.

Marc

