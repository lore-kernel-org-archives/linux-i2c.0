From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: removing set_clientdata(NULL)
Date: Mon, 29 Mar 2010 16:49:10 +0100
Message-ID: <20100329154910.GE13239@sirena.org.uk>
References: <20100327121558.GA5880@pengutronix.de> <20100329162812.548d131b@hyperion.delvare> <20100329150956.GB6717@pengutronix.de> <20100329172734.7cd7341d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100329172734.7cd7341d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 29, 2010 at 05:27:34PM +0200, Jean Delvare wrote:
> On Mon, 29 Mar 2010 17:09:56 +0200, Wolfram Sang wrote:

> > - shall this better go via the i2c-tree?

> This seems simpler, yes. I don't think subsystem or driver maintainers
> need to be bothered with what is really only a cleanup.

What about those subsystems where the maintainers applied the patch from
the first round (adding the explicit set to NULL where it had been
missing)?
