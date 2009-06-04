From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Thu, 4 Jun 2009 15:41:16 +0100
Message-ID: <20090604144115.GA2285@sirena.org.uk>
References: <4A2566E8.7080404@mocean-labs.com> <20090602224822.GE18453@fluff.org.uk> <20090603101533.599d41db@hyperion.delvare> <87oct53ewh.fsf@macbook.be.48ers.dk> <4A2639F6.2010505@mocean-labs.com> <20090604150752.6aa7668c@hyperion.delvare> <4A27D91E.1000306@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A27D91E.1000306-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard R????jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 04, 2009 at 04:24:30PM +0200, Richard R????jfors wrote:

> The PCI driver for this device implements an MFD
> (multi function device, check drivers/mfd). The idea of MFD:s is to
> register platform devices for all cells. And to multiplex IRQ:s to the
> platform devices. And by doing this all existing platform drivers
> can be reused.

It's probably worth pointing out here that MFD uses platform devices to
represent the subdevices no matter what the underlying access method for
the device actually is.
