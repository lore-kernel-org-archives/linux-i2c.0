From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH v5 0/4] iMC SMBUS and DIMM bus probing
Date: Fri, 8 Nov 2013 12:41:38 -0800
Message-ID: <CALCETrX4-WHrCumnOxEoa53-2otNOPBFk_Q6yL3ufyhWbaJ1wQ@mail.gmail.com>
References: <cover.1380315959.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1380315959.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 27, 2013 at 6:02 PM, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org> wrote:
> Intel LGA2011 machines have dedicated SMBUS controllers for DIMM
> sockets.  Because they're dedicated, they can be safely and accurately
> probed, since all devices on them are known to be attached to DIMMs.
> The devices found are:
>  - SPD EEPROMs
>  - TSODs (Temperature Sensor on DIMMs)
>  - Other interesting things, with drivers hopefully to follow...
>
> This patch series adds a simple generic layer for probing for DIMMs over
> SMBUS and an i2c bus driver for the iMC controller found on Intel
> LGA2011 chips.
>
> It now uses only modern infrastructure -- new-style I2C probing and the
> at24 (instead of eeprom) driver.
>
> I've tested this on a Core i7 Extreme and on a Xeon E5 server.
>
> Patches 1-3 are useful even without patch 4.  I'm still hoping for feedback
> on patch 4.
>
> Changes from v4:
>  - Added the sb_edac changes -- i2c_imc and sb_edac can now coexist
>  - Added some paranoid race detection.
>  - The driver now confirms its ability to claim software control of the SMBUS
>    master.  This prevents unpleasant problems on systems that enable CLTT
>    (closed loop thermal throttling).
>  - Reordered the patches so that the DIMM bus code is last.
>
> Changes from v3:
>  - Dropped redundant "tsod" driver
>  - Dropped eeprom modalias
>  - Switched to probing for the "eeprom" and "jc42"
>
> Andy Lutomirski (4):
>   Move Intel SNB device ids from sb_edac to pci_ids.h
>   sb_edac: Claim a different PCI device
>   i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
>   i2c, i2c_imc: Add DIMM bus code
>
>  drivers/edac/sb_edac.c        |  32 +--
>  drivers/i2c/busses/Kconfig    |  19 ++
>  drivers/i2c/busses/Makefile   |   5 +
>  drivers/i2c/busses/dimm-bus.c |  97 ++++++++
>  drivers/i2c/busses/i2c-imc.c  | 562 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/dimm-bus.h  |  24 ++
>  include/linux/pci_ids.h       |  15 ++
>  7 files changed, 723 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/i2c/busses/dimm-bus.c
>  create mode 100644 drivers/i2c/busses/i2c-imc.c
>  create mode 100644 include/linux/i2c/dimm-bus.h

Any update on these?  It would be nice to get them reviewed and applied.

Thanks,
Andy
