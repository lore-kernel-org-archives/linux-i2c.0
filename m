From: Jean Delvare <jdelvare@suse.de>
Subject: RE: i2c-tools available commands
Date: Mon, 02 Nov 2015 15:07:36 +0100
Message-ID: <1446473256.4659.1252.camel@chaos.site>
References: <BN4PR12MB0753BFBF4E74CD966C61449CE6230@BN4PR12MB0753.namprd12.prod.outlook.com>
	 <1446036811.4659.1054.camel@chaos.site>
	 <BN4PR12MB0753763D8979E33B80683D92E62C0@BN4PR12MB0753.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbbKBOHj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 Nov 2015 09:07:39 -0500
In-Reply-To: <BN4PR12MB0753763D8979E33B80683D92E62C0@BN4PR12MB0753.namprd12.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Davis <stephen.davis@lumet.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>

Stephen,

Please keep the list on Cc and don't top-post.

Le Monday 02 November 2015 =C3=A0 13:23 +0000, Stephen Davis a =C3=A9cr=
it :
> Thanks for the response. What I'm trying to do is use the i2c port on=
 the Pi. I've
> seen how it can be done with Python, but we are trying to do it witho=
ut it
> (if possible). I've got a slew of microcontrollers on the i2c bus and=
 am an in
> the process of writing our comm protocol so I really just need a read=
 and write
> from the Pi's i2c. Is this possible? I'm running Raspbian Wheezy (Des=
bian).

If your micro-controllers are connected to the I2C port of the Pi, you
should indeed be able to talk to them from user-space. Anyway if it
worked with python you can definitely do it without it. Depending on th=
e
exact protocol required by the micro-controllers, i2cget and i2cset may
be enough (if the micro-controllers only use basic SMBus-compliant
commands) or you may need Wolfram Sang's upcoming i2ctransfer tool (I
reviewed it some times ago, no news since, Wolfram where are we with
it?)

If even that isn't enough, you may have to write your code in C
directly, linking with the upcoming libi2c library. It's a bit difficul=
t
at the moment though with the hosting website being down.

> Is this the i2cget and i2cset functions? Those seem to want an
> internal address of the slave devices (seems more geared towards
> external memory).

i2cget and i2cset want a slave address function. Your micro-controllers
need to have a slave I2C address if you want to be able to talk to them
from the Pi. Check the python code and the hardware documentation, the
slave address is certainly mentioned there.

--=20
Jean Delvare
SUSE L3 Support
