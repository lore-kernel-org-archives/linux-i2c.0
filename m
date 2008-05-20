From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 5/6 #3] RTC: SMBus support for the M41T80, etc. driver
Date: Tue, 20 May 2008 10:25:59 +0900 (JST)
Message-ID: <20080520.102559.25909127.nemoto@toshiba-tops.co.jp>
References: <Pine.LNX.4.55.0805180447210.10067@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <Pine.LNX.4.55.0805180447210.10067@cliff.in.clinika.pl>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: macro@linux-mips.org
Cc: a.zummo@towertech.it, khali@linux-fr.org, rtc-linux@googlegroups.com, i2c@lm-sensors.org, linux-mips@linux-mips.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 18 May 2008 04:53:54 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  The BCM1250A SOC which is used on the SWARM board utilising an M41T81
> chip only supports pure I2C in the raw bit-banged mode.  Nobody sane
> really wants to use it unless absolutely necessary and the M41T80, etc.  
> chips work just fine with an SMBus adapter which is what the standard mode
> of operation of the BCM1250A.  The only drawback of byte accesses with the
> M41T80 is the chip only latches clock data registers for the duration of
> an I2C transaction which works fine with a block transfers, but not
> byte-wise accesses.
> 
>  The driver currently requires an I2C adapter providing both SMBus and raw
> I2C access.  This is a set of changes to make it work with any SMBus
> adapter providing at least read byte and write byte protocols.  
> Additionally, if a given SMBus adapter supports I2C block read and/or
> write protocols (a common extension beyond the SMBus spec), they are used
> as well.  The problem of unlatched clock data if SMBus byte transactions
> are used is resolved in the standard way.  For raw I2C controllers this
> functionality is provided by the I2C core as SMBus emulation in a
> transparent way.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Tested-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
