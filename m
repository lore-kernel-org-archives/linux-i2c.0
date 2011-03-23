From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] i2c/busses: Driver for Devantech USB-ISS I2C adapter
Date: Tue, 22 Mar 2011 21:50:58 -0700
Message-ID: <20110323045058.GA13606@kroah.com>
References: <1300851827-13627-1-git-send-email-guenter.roeck@ericsson.com>
 <20110323034524.GA11675@kroah.com>
 <20110323042507.GA9173@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110323042507.GA9173@ericsson.com>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 22, 2011 at 09:25:07PM -0700, Guenter Roeck wrote:
> On Tue, Mar 22, 2011 at 11:45:24PM -0400, Greg KH wrote:
> > On Tue, Mar 22, 2011 at 08:43:47PM -0700, Guenter Roeck wrote:
> > > This patch adds support for the I2C interface of the Devantech USB-ISS
> > > Multifunction adapter.
> > > 
> > > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > ---
> > > The driver has one problem: It competes with the cdc_acm driver for device
> > > access. Copying the usb mailing list in the hope that someone can tell me
> > > if there is a way to prevent this from happening.
> > 
> > Why does it "compete"?
> > Is it because this driver also exposes a cdc-acm class interface?  Why
> 
> I guess so.
> 
> > is it doing that if it doesn't follow that spec?  We do already support
> 
> I don't know if it follows the cdc-acm specification or not, though I would
> think it does since the cdc-acm driver recognizes it. I do see the
> "This device cannot do calls on its own. It is not a modem." message.
> 
> I suspect the device exposes the cdc-acm class interface because it is
> a convenient means to make it show up as COM port in Windows.
> But I am not associated with the manufacturer, so that is just a wild guess.
> 
> If it does follow the cdc-acm specification, does that help me anything ?

It should, you can talk to the device from userspace using that virtual
serial port, right?  Isn't that what you need to do here?

Why try to create a new type of interface to the device from what it was
supposed to be by the manufacturer?

thanks,

greg k-h
