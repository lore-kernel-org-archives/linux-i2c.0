From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] i2c: npcm7xx: add i2c controller master mode only
Date: Tue, 07 Aug 2018 14:26:25 +0300
Message-ID: <3a50932025929d1b318cb42c05a727892603d31d.camel@linux.intel.com>
References: <20180807110709.31847-1-tali.perry1@gmail.com>
         <20180807110709.31847-3-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807110709.31847-3-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tali Perry <tali.perry1@gmail.com>, avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com, yuenn@google.com, brendanhiggins@google.com, robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de, pierre-yves.mordret@st.com, cedric.madianga@gmail.com, baolin.wang@spreadtrum.com, jarkko.nikula@linux.intel.com, hdegoede@redhat.com, rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org, thor.thayer@linux.intel.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, tglx@linutronix.de
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-08-07 at 14:07 +0300, Tali Perry wrote:
> Nuvoton NPCM7XX I2C Controller
> NPCM7xx includes 16 I2C contollers. THis driver operates the
> controller.
> This module also includes a slave mode, which will be submitted later
> on.
> 
> Any feedback would be appreciated.  
> 
> v2 -> v1:
> 	- run check patch in strict mode.
> 	- use linux crc.
> 	- define regs in constant offset without base.
> 	- remove debug prints.
> 	- no declerations for local functions.
> 	
> v1: initial version

I don't know / remember why I'm in Cc list here, but you can go through
my other reviews and find style recommendations for your code as well.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
