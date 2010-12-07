From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-algo-bit: Complain about masters which can't
 read SCL
Date: Tue, 7 Dec 2010 15:35:11 +0000
Message-ID: <20101207153511.GF9689@rakim.wolfsonmicro.main>
References: <20101207110705.69792a1a@endymion.delvare>
 <20101207121009.GD10722@sirena.org.uk>
 <20101207123011.GO20097@trinity.fluff.org>
 <20101207162933.3ad206a8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101207162933.3ad206a8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 07, 2010 at 04:29:33PM +0100, Jean Delvare wrote:
> Hi Marc, Ben,

Ahem.

> > On Tue, Dec 07, 2010 at 12:10:10PM +0000, Mark Brown wrote:

> > > It'd be good to also flag this via sysfs so that it's more readily
> > > visible to things like diagnostic tools.

> In what form do you expect this, and what do you expect diagnostic

A sysfs file that got created if the issue is present, or a warnings file
that read back a set of values as a bitmask.

> tools to do about it?

Report it - it'd increase the chances of us finding out about the error.
A message in dmesg will often just be lost in the noise, and may be long
gone before the users tarts doing diagnostics.
