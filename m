From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: i2c-mux-gpio platform device ID issue
Date: Wed, 25 Jul 2012 20:32:43 +0100
Message-ID: <20120725193243.GA9792@sirena.org.uk>
References: <20120725144409.1e47bd95@endymion.delvare>
 <20120725163913.60fffd1a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120725163913.60fffd1a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jul 25, 2012 at 04:39:13PM +0200, Jean Delvare wrote:

> I am using magic ID value -4 for this (I left -2 and -3 free in case
> we ever need a couple of other magic values.) The automatically

We could always add the new magic values starting at -3 instead...
