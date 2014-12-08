From: Muthu Mani <muth@cypress.com>
Subject: RE: [PATCH v4 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Mon, 8 Dec 2014 16:00:13 +0000
Message-ID: <BN1PR06MB069088C07483AEA527DD338CC640@BN1PR06MB069.namprd06.prod.outlook.com>
References: <1417241944-17799-1-git-send-email-muth@cypress.com>
 <20141208153701.GD14346@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20141208153701.GD14346@localhost>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

> On Sat, Nov 29, 2014 at 11:49:04AM +0530, Muthu Mani wrote:
> > Adds support for USB-I2C/GPIO interfaces of Cypress Semiconductor
> > CYUSBS234 USB-Serial Bridge controller.
> >
> > Details about the device can be found at:
> > http://www.cypress.com/?rID=84126
> >
> > Signed-off-by: Muthu Mani <muth@cypress.com>
> > Signed-off-by: Rajaram Regupathy <rera@cypress.com>
> > ---
>
> This patch as well as the other two patches in the series is white-space
> damaged. Please always make sure to run your patches through
> checkpatch.pl before submission (and/or fix your mailer).
>
> Also use git-send-email when submitting your series so that the individual
> patches get threaded properly.

Sorry about the inconvenience.
I ran checkpatch.pl for all the patches before I submitted them using git-send-email.
checkpatch doesn't show any error.

I used the following command to submit patch. Please let me know if anything wrong.
$ git format-patch -s -n -v4 master..Driver_v4
$ git send-email --smtp-encryption=tls --smtp-server=<mail-server> --smtp-user=muth@cypress.com --smtp-server-port=<port#> --to="Samuel Ortiz <sameo@linux.intel.com>" --to="Lee Jones <lee.jones@linaro.org>" --to="Wolfram Sang <wsa@the-dreams.de>" --to="Linus Walleij <linus.walleij@linaro.org>" --to="Alexandre Courbot <gnurou@gmail.com>" --to="gregkh@linuxfoundation.org"  --to="Johan Hovold <johan@kernel.org>" --cc="linux-usb@vger.kernel.org"  --cc="linux-kernel@vger.kernel.org" --cc="linux-i2c@vger.kernel.org" --cc="linux-gpio@vger.kernel.org" v4-0001-mfd-add-support-for-Cypress-CYUSBS234-USB-Serial-.patch

>
> And always increase (or add a "resend" prefix) when resending. I got two
> v4 series in my inbox. No idea what's the difference, if any.

In the second v4 patch, I added Greg KH and usb group. There is no code changes.
I will take care when I resend again.

Thanks,
Muthu

>
> Thanks,
> Johan

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
