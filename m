From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Mon, 8 Dec 2014 17:16:02 +0100
Message-ID: <20141208161602.GE14346@localhost>
References: <1417241944-17799-1-git-send-email-muth@cypress.com>
 <20141208153701.GD14346@localhost>
 <BN1PR06MB069088C07483AEA527DD338CC640@BN1PR06MB069.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BN1PR06MB069088C07483AEA527DD338CC640@BN1PR06MB069.namprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Muthu Mani <muth@cypress.com>
Cc: Johan Hovold <johan@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 08, 2014 at 04:00:13PM +0000, Muthu Mani wrote:
> > On Sat, Nov 29, 2014 at 11:49:04AM +0530, Muthu Mani wrote:
> > > Adds support for USB-I2C/GPIO interfaces of Cypress Semiconductor
> > > CYUSBS234 USB-Serial Bridge controller.
> > >
> > > Details about the device can be found at:
> > > http://www.cypress.com/?rID=84126
> > >
> > > Signed-off-by: Muthu Mani <muth@cypress.com>
> > > Signed-off-by: Rajaram Regupathy <rera@cypress.com>
> > > ---
> >
> > This patch as well as the other two patches in the series is white-space
> > damaged. Please always make sure to run your patches through
> > checkpatch.pl before submission (and/or fix your mailer).
> >
> > Also use git-send-email when submitting your series so that the individual
> > patches get threaded properly.
> 
> Sorry about the inconvenience.
> I ran checkpatch.pl for all the patches before I submitted them using
> git-send-email.
> checkpatch doesn't show any error.

Then the problem could be your mail server. All (leading) tabs have been
converted to spaces.

> I used the following command to submit patch. Please let me know if anything wrong.
> $ git format-patch -s -n -v4 master..Driver_v4
> $ git send-email --smtp-encryption=tls --smtp-server=<mail-server> --smtp-user=muth@cypress.com --smtp-server-port=<port#> --to="Samuel Ortiz <sameo@linux.intel.com>" --to="Lee Jones <lee.jones@linaro.org>" --to="Wolfram Sang <wsa@the-dreams.de>" --to="Linus Walleij <linus.walleij@linaro.org>" --to="Alexandre Courbot <gnurou@gmail.com>" --to="gregkh@linuxfoundation.org"  --to="Johan Hovold <johan@kernel.org>" --cc="linux-usb@vger.kernel.org"  --cc="linux-kernel@vger.kernel.org" --cc="linux-i2c@vger.kernel.org" --cc="linux-gpio@vger.kernel.org" v4-0001-mfd-add-support-for-Cypress-CYUSBS234-USB-Serial-.patch

Have a look at git-send-email's --thread switch. Depending on your
settings you may only need to specify all three patches to
git-send-email at once to have them threaded properly.

> > And always increase (or add a "resend" prefix) when resending. I got two
> > v4 series in my inbox. No idea what's the difference, if any.
> 
> In the second v4 patch, I added Greg KH and usb group. There is no code changes.
> I will take care when I resend again.
> 
> Thanks,
> Muthu
> 
> >
> > Thanks,
> > Johan
> 
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received in
> error, please advise the sender and immediately delete this message.

Make sure not to include such disclaimers when posting to public mailing
lists.

Thanks,
Johan
