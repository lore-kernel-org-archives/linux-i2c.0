From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c: Don't advertise i2c functions when not available
Date: Fri, 5 Jun 2009 09:42:26 +0100
Message-ID: <20090605084226.GA17158@rakim.wolfsonmicro.main>
References: <20090527070850.GA11221@linux-sh.org> <20090527091831.26b60d6d@hyperion.delvare> <20090527120140.GC1970@sirena.org.uk> <20090602091229.0810f54b@hyperion.delvare> <20090602093431.GA19390@rakim.wolfsonmicro.main> <20090605101330.2f93e9ab@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090605101330.2f93e9ab-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 05, 2009 at 10:13:30AM +0200, Jean Delvare wrote:

> Surround i2c function declarations with ifdefs, so that they aren't
> advertised when i2c-core isn't actually built. That way, drivers using
> these functions unconditionally will result in an immediate build
> failure, rather than a late linking failure which is harder to figure
> out.

Thanks!
