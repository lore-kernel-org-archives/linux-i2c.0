From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v8 0/8] i2c-octeon and i2c-thunderx driver
Date: Wed, 11 May 2016 19:20:57 +0200
Message-ID: <20160511172057.GA2687@hardcore>
References: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0097.outbound.protection.outlook.com ([65.55.169.97]:10880
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751648AbcEKRVN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 11 May 2016 13:21:13 -0400
Content-Disposition: inline
In-Reply-To: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>

Hi Wolfram,

we want to add ACPI support to the ThunderX i2c driver
because it is meant for servers and some distributions
require ACPI there. The changes are small but I'll post
a new version of the remaining patches shortly.

Thanks,
Jan


On Mon, May 02, 2016 at 07:35:40PM +0200, Jan Glauber wrote:
> Hi Wolfram,
> 
> this are the remaining patches that implement the ThunderX driver.
> I like to send them now even if they might not make 4.7.
> After the Octeon parts are merged the ThunderX driver code is
> quite straight-forward, as should be the driver split.
> 
> Patch #5 - #7 are (final) cleanup patches.
> 
> Patches are on-top of next-20160502.
> 
> Thanks,
> Jan
> 
> -------------------------------------------------
> 
> Changes to v7:
> - Sort include files also in octeon-core.c
> - Add cleanup bool patch (left-over from v7)
> - Dropped read-write function shuffle patch
> 
> Changes to v6:
> - Fixed read_int kerneldoc
> - Removed udelay after write-int in recovery
> - Killed retries in recovery, use EAGAIN
> - Disable SMBUS QUICK and remove unneeded length check
> - Spell out enable/disable
> - Switch to wait_event_timeout
> - Removed superfluous status check in HLC write
> - Optimize wait-queue also for HLC
> - Use readq/writeq instead of __raw_* in some places
> - Add STAT_IDLE to status check (valid after a write)
> 
> Changes to v5:
> - Switch to i2c recovery framework
> - Clean-up register access, introduce new helper functions
> - Fixed ready bit check in combined write
> - Fixed IFLG clear in hlc_enable
> - Removed complicated last phase logic, not needed when we send
>   START for every message part
> 
> Changes to v4:
> - Splitted the High-Level Controller patch into several patches
> - Reworded some commit messages
> 
> Changes to v3:
> - Added more functionality flags for SMBUS
> - Removed both module parameters
> - Make xfer return also other errors than EGAIN
> - Return EPROTO on invalid SMBUS block length
> - Use devm_ioremap_resource
> - Added rename-only patch
> - Removed kerneldoc patch from series
> - Improved defines
> 
> Changes to v2:
> - Split clenaup patch into several patches
> - Strictly moved functional changes to later patches
> - Fixed do-while checkpatch errors
> - Moved defines to the patches that use them
> - Use BIT_ULL macro
> - Split ThunderX patch into 2 patches
> 
> Changes to v1:
> - Fixed compile error on x86_64
> - Disabled thunderx driver on MIPS
> - Re-ordered some thunderx probe functions for readability
> - Fix missing of_irq.h and i2c-smbus.h includes
> - Use IS_ENABLED for CONFIG options
> 
> Jan
> 
> -------------------------------------------------
> 
> Jan Glauber (8):
>   i2c: octeon: Rename driver to prepare for split
>   i2c: octeon: Split the driver into two parts
>   i2c: thunderx: Add i2c driver for ThunderX SOC
>   i2c: thunderx: Add smbus alert support
>   i2c: octeon,thunderx: Move register offsets to struct
>   i2c: octeon: Sort include files alphabetically
>   i2c: cavium: Use booleon values for booleon variables
>   i2c: octeon: thunderx: Add MAINTAINERS entry
> 
>  MAINTAINERS                                       |   25 +-
>  drivers/i2c/busses/Kconfig                        |   10 +
>  drivers/i2c/busses/Makefile                       |    3 +
>  drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} | 1033 ++++++---------------
>  drivers/i2c/busses/i2c-cavium.h                   |  214 +++++
>  drivers/i2c/busses/i2c-octeon-core.c              |  288 ++++++
>  drivers/i2c/busses/i2c-thunderx-core.c            |  306 ++++++
>  7 files changed, 1132 insertions(+), 747 deletions(-)
>  rename drivers/i2c/busses/{i2c-octeon.c => i2c-cavium.c} (57%)
>  create mode 100644 drivers/i2c/busses/i2c-cavium.h
>  create mode 100644 drivers/i2c/busses/i2c-octeon-core.c
>  create mode 100644 drivers/i2c/busses/i2c-thunderx-core.c
> 
> -- 
> 1.9.1
