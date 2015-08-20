From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH RFC] eeprom: at24: extend driver to plug into the NVMEM
 framework
Date: Thu, 20 Aug 2015 18:38:51 +0200
Message-ID: <20150820163851.GG27457@lunn.ch>
References: <1439693649-10809-1-git-send-email-andrew@lunn.ch>
 <2080648987.23864.1439713686409.JavaMail.open-xchange@oxbsltgw04.schlund.de>
 <20150816131130.GC10094@lunn.ch>
 <1511754934.28154.1439739426390.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <55D1DB24.8090602@linaro.org>
 <20150817130945.GE7537@lunn.ch>
 <55D1F6CB.2010606@linaro.org>
 <20150817152504.GI7537@lunn.ch>
 <20150820155729.GG30520@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150820155729.GG30520@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> It's true that this is something that we might have overlooked. Is it
> expected to maintain that compatibility when moving a driver from one
> framework to another (and this is a real question, not a troll)?

Yes. There will be user space applications reading from the eeprom
file in /sys. In fact, until the NVMEM framework arrived, it was not
easy to access the eeprom from kernel space, meaning the majority of
users must of been user space...
 
> If so, we might provide a compatibility layer to add the former file
> too, protected by a kconfig option maybe ?

There is one other detail you might of missed. Both AT24 and AT25 do
have an in kernel API. In the at24_platform_data you can have a
callback function "setup" which gets called when the device is
probed. setup() is called with a struct memory_accessor which contains
function pointers for reading and writing to the EEPROM. A few
platforms use these for getting the MAC address out of the EEPROM.
And these platforms are old style, not DT.

    Andrew
