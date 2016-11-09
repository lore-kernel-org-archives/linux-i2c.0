From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date: Wed, 9 Nov 2016 15:38:04 +0100
Message-ID: <20161109143804.GE2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore>
 <1595446.2T31j1Ekg5@np-p-burton>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1595446.2T31j1Ekg5@np-p-burton>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Peter Swain <pswain@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, "Steven J. Hill" <Steven.Hill@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 09, 2016 at 02:07:58PM +0000, Paul Burton wrote:
> On Wednesday, 9 November 2016 14:41:03 GMT Jan Glauber wrote:
> > Hi Paul,
> > 
> > I think we should revert commit "70121f7 i2c: octeon: thunderx: Limit
> > register access retries". With debugging enabled I'm getting:
> > 
> > <snip>
> > 
> > This is not caused by the usleep inside the wait_event but by
> > readq_poll_timeout(). Could you try if it works for you if you only revert
> > this patch?
> > 
> > Thanks,
> > Jan
> 
> Hi Jan,
> 
> If I drop both my patches & just revert 70121f7f3725 ("i2c: octeon: thunderx: 
> Limit register access retries") sadly it doesn't fix my system. A boot of a 
> cavium_octeon_defconfig kernel with initcall_debug ends with:
> 
>   calling  octeon_mgmt_mod_init+0x0/0x28 @ 1
>   initcall octeon_mgmt_mod_init+0x0/0x28 returned 0 after 67 usecs
>   calling  ds1307_driver_init+0x0/0x10 @ 1
>   initcall ds1307_driver_init+0x0/0x10 returned 0 after 19 usecs
>   calling  octeon_i2c_driver_init+0x0/0x10 @ 1
>   ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   ata1.00: ATA-9: SanDisk SDSSDA240G, Z22000RL, max UDMA/133
>   ata1.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 31/32)
>   ata1.00: configured for UDMA/133
>   scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDSSDA24 00RL PQ: 0 ANSI: 5
>   sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
>   sd 0:0:0:0: [sda] Write Protect is off
>   sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>   sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
>    sda: sda1 sda2 sda3 sda4
>   sd 0:0:0:0: [sda] Attached SCSI disk
>   ata2: SATA link down (SStatus 0 SControl 300)
>   random: crng init done
> 
> As you can see octeon_i2c_driver_init never returns. Are you able to test on 
> one of your MIPS-based systems?

CC'ing Steven who might be able to test on MIPS.

> Thanks,
>     Paul
