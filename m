From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: sead3: Select NEW_LEDS, LEDS_CLASS and I2C symbols
Date: Tue, 3 Sep 2013 16:58:39 +0200
Message-ID: <20130903145839.GA14258@linux-mips.org>
References: <1378218420-28011-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1378218420-28011-1-git-send-email-markos.chandras@imgtec.com>
Sender: linux-leds-owner@vger.kernel.org
To: Markos Chandras <markos.chandras@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: linux-mips@linux-mips.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 03, 2013 at 03:27:00PM +0100, Markos Chandras wrote:

> Select NEW_LEDS and LEDS_CLASS since they export symbols
> needed by leds-sead3.c. Fixes the following build problem:
> 
> leds-sead3.c:(.text+0xf0c): undefined
> reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0xf18): undefined
> reference to `led_classdev_unregister'
> 
> Also select I2C since it's needed by sead3-pic32-i2c-drv.c
> Fixes the following build problem:
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:350:2: error:
> implicit declaration of
> function 'i2c_add_numbered_adapter'

You probably should setup a bus like all the other callers of
i2c_add_numbered_adapter() in drivers/i2c/busses/; similar for the LED
issue.

  Ralf
