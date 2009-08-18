From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: "I2C_RDWR" ioctl returning EINVAL on Freescale mxc
Date: Tue, 18 Aug 2009 08:13:35 +0200
Message-ID: <20090818061335.GB29655@pengutronix.de>
References: <528f13590908141409g4b2556e5m10aec0dc15429457@mail.gmail.com> <20090817065313.GJ31727@pengutronix.de> <528f13590908170751u4dcf6d8ftb865103b888225e0@mail.gmail.com> <20090817150159.GT31727@pengutronix.de> <528f13590908171404q2aa4f9aaub98a191c91bd2448@mail.gmail.com> <20090817212127.GB31727@pengutronix.de> <528f13590908172025i276dc634qd0829cfad8c8c608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528f13590908172025i276dc634qd0829cfad8c8c608-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Alfred,

On Mon, Aug 17, 2009 at 10:25:34PM -0500, alfred steele wrote:
> I skimmed through the imx-i2c.c and ompared it to the  driver i have
> mxc-i2c.  I do not understand how the changes might affect the IOCTL
> "I2C_RDWR".Can you please elaborate? At the bottom is the mxc-i2c
> driver i have.
> Isn't  i2c-dev "i2c-dev.c" driver responsible for returning EINVAL
> based on some validation checks. Has that also changed in the latest
> GIT.

Between 2.6.24 and 2.6.31-dirty are about 156849 patches, not to mention
what Freescale may have patched in your kernel. It might effect your
problem or it might not.

Could you test against mxc-master? If you do, others in the community
can reproduce your problem quickly and might find a fix.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
