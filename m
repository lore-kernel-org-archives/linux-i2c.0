From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Fri, 09 May 2008 23:17:19 +0900 (JST)
Message-ID: <20080509.231719.93019066.anemo@mba.ocn.ne.jp>
References: <Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<200805071625.20430.david-b@pacbell.net>
	<Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: macro@linux-mips.org
Cc: david-b@pacbell.net, ab@mycable.de, mgreer@mvista.com, i2c@lm-sensors.org, rtc-linux@googlegroups.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 9 May 2008 01:43:32 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Here is a new version of the patch.  I hope I have addressed all your
> concerns, but I am officially dead at the moment, so please do not disturb
> me until this is no longer the case.

This version works fine for me (with i2c-gpio).  And as Jean said,
using i2c_smbus_(write|read)_i2c_block_data instead of
m41t80_i2c_(write|read) works fine too.

---
Atsushi Nemoto
