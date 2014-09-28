From: atull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH] i2c designware add support of I2C standard mode
Date: Sat, 27 Sep 2014 22:40:12 -0500
Message-ID: <alpine.DEB.2.10.1409272238450.2655@shineypoop>
References: <20140820124231.GD21734@leverpostej> <1408544948-22339-1-git-send-email-romainba@abilis.com> <20140920092456.GD1612@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140920092456.GD1612@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, yvanderv-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 20 Sep 2014, Wolfram Sang wrote:

> On Wed, Aug 20, 2014 at 04:29:08PM +0200, Romain Baeriswyl wrote:
> > From: Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > 
> > Some legacy devices support ony I2C standard mode at 100kHz.
> > This patch allows to select the standard mode through the DTS
> > with the use of the existing clock-frequency parameter.
> > 
> > When clock-frequency parameter is not set, the fast mode is selected.
> > Only when the parameter is set at 100000, the standard mode is selected.
> > 
> > Signed-off-by: Romain Baeriswyl <romainba-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > Reviewed-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> 
> Applied to for-next, thanks to all involved!
> 
> 

I don't see this in 
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
Is this in i2c/i2c/for-next?

Alan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
