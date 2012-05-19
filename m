From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/5] i2c: Convert i2c-octeon.c to use device tree.
Date: Sat, 19 May 2012 00:05:09 -0600
Message-ID: <20120519060509.DAD0F3E046E@localhost>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com> <1335489630-27017-2-git-send-email-ddaney.cavm@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335489630-27017-2-git-send-email-ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 26 Apr 2012 18:20:26 -0700, David Daney <ddaney.cavm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> 
> There are three parts to this:
> 
> 1) Remove the definitions of OCTEON_IRQ_TWSI and OCTEON_IRQ_TWSI2.
>    The interrupts are specified by the device tree and these hard
>    coded irq numbers block the used of the irq lines by the irq_domain
>    code.
> 
> 2) Remove platform device setup code from octeon-platform.c, it is
>    now unused.
> 
> 3) Convert i2c-octeon.c to use device tree.  Part of this includes
>    using the devm_* functions instead of the raw counterparts, thus
>    simplifying error handling.  No functionality is changed.
> 
> Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Is the DT binding for this device documented?

Otherwise the code looks good.  Please make sure the binding
documentation is in place before merging.

g.
