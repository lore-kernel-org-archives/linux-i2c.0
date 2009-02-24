From: "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c: Adapter timeout is in jiffies
Date: Tue, 24 Feb 2009 09:33:15 -0700
Message-ID: <20090224163315.GB25375@mag.az.mvista.com>
References: <20090222160705.63563a14@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090222160705.63563a14-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "Mark A.Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Feb 22, 2009 at 04:07:05PM +0100, Jean Delvare wrote:
> From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Subject: i2c: Adapter timeout is in jiffies
> 
> i2c_adapter.timeout is in jiffies. Fix all drivers which thought
> otherwise. It didn't really matter as long as the value was only used
> inside the driver, but soon i2c-core will use it too so it must have
> the proper unit.
> 
> Note: for the i2c-mpc driver, this fixes a bug in polling mode.
> Timeout would trigger after 1 jiffy, which is most probably not what
> the author wanted.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
> Cc: Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
> Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> Cc: Lennert Buytenhek <kernel-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ibm_iic.c |    6 +++---
>  drivers/i2c/busses/i2c-iop3xx.c  |    2 +-
>  drivers/i2c/busses/i2c-mpc.c     |    4 ++--
>  drivers/i2c/busses/i2c-mv64xxx.c |    7 +++----
>  drivers/i2c/busses/i2c-pca-isa.c |    2 +-
>  5 files changed, 10 insertions(+), 11 deletions(-)

For the i2c-mv64xxx.c part:

Acked-by: Mark A. Greer <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
