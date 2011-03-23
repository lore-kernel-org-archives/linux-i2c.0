From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Wed, 23 Mar 2011 15:42:40 +0000
Message-ID: <20110323154240.GA31336@sirena.org.uk>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com> <20110323034524.GA11675@kroah.com> <20110323042507.GA9173@ericsson.com> <20110323045058.GA13606@kroah.com> <20110323054153.GA10275@regiomontanus> <20110323060746.GA9673@ericsson.com> <20110323150014.GB6284@kroah.com> <20110323151021.53e187bb@lxorguk.ukuu.org.uk> <20110323153115.GB7106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110323153115.GB7106@kroah.com>
Sender: linux-doc-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Guenter Roeck <guenter.roeck@ericsson.com>, Bernhard Walle <bernhard@bwalle.de>, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 23, 2011 at 08:31:15AM -0700, Greg KH wrote:

> Odd that windows does it all from userspace, but I guess it doesn't have
> an I2C driver subsystem.

These devices are typically intended to be used for diagnosis evaluation
of hardware so you want to drive the device from a pointy clicky GUI -
they're not terribly useful in production systems.
