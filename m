From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] [RFC][PATCH 0/4] RTC: Use class devices as a
 persistent clock
Date: Wed, 7 May 2008 08:57:39 +0200
Message-ID: <20080507085739.4f538d2e@i1501.lan.towertech.it>
References: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761915AbYEGG6C@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: macro@linux-mips.org, Jean Delvare <khali@linux-fr.org>, Ralf Baechle <ralf@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 7 May 2008 01:39:59 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> 
> Hello,
> 
>  While investigating why Linux on the MIPS64 Broadcom BCM91250A board (the
> SWARM, based on the SiByte BCM1250A SOC) does not support an RTC device
> anymore I discovered the "wiring" of code to access /dev/rtc to the RTC
> device driver got removed with some changes that happened a while ago.  
> The board uses the ST M41T81 I2C chip with a driver buried within the
> architecture code.  There is a standard driver for this chip in our tree
> already, which is called rtc-m41t80, and which as a part of the RTC driver
> suite provides the necessary "wiring" to /dev/rtc.

 [...]


 Hi Maciej,

   you did a great work. you have my Acked-by on the rtc/ntp code, but
 I think we'd need some reports from current users of the m41t81 driver
 before pushing that one in.


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
