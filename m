From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 3/5] misc: Driver for APDS990X ALS and proximity sensors
Date: Tue, 5 Oct 2010 22:42:21 +0100
Message-ID: <20101005214220.GB19895@sirena.org.uk>
References: <1286271779-19819-1-git-send-email-samu.p.onkalo@nokia.com> <1286271779-19819-4-git-send-email-samu.p.onkalo@nokia.com> <20101005122323.2d2870ee@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101005122323.2d2870ee-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 05, 2010 at 12:23:23PM +0100, Alan Cox wrote:

> > +	chip->regs[0].supply = reg_vcc;
> > +	chip->regs[1].supply = reg_vled;

> Shouldn't these come from the provided platform data ? and again if there
> isn't a platform one supplied just skip the regulators. There are going

No, don't do this.  The device should just request the supplies that
correspond to the physical supplies for the device and let the regulator
API worry about actually providing regulators to match it.  If
regulators are getting passed in as platform data something has gone
wrong.

> to be cases of boxes with regulator API stuff in use but who don't have
> regulators for that device.

If there genuinely is no supply present on the pin then the device needs
to know that; if there is a supply present but it's not software managed
then the regulator API can cope with that.

Trying to handle this in individual device drivers just results in reams
of cut'n'paste code in device drivers, frequently requring the addition
of platform data to devices that would not otherwise require any.  We've
tried it, it's painful.  Having the machine specific data provided as a
generic regulator API service provides a great degree of simplification.
