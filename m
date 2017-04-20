From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 4/4] i2c: octeon: thunderx: Add I2C_CLASS_HWMON
Date: Thu, 20 Apr 2017 11:16:32 +0200
Message-ID: <20170420091632.GA8383@hc>
References: <20161209093158.3161-1-jglauber@cavium.com>
 <20161209093158.3161-5-jglauber@cavium.com>
 <20161211220434.GH2552@katana>
 <20170125204923.2mxtlszvco6wxjok@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn3nam01on0047.outbound.protection.outlook.com ([104.47.33.47]:24928
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S939843AbdDTJQr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 20 Apr 2017 05:16:47 -0400
Content-Disposition: inline
In-Reply-To: <20170125204923.2mxtlszvco6wxjok@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-i2c@vger.kernel.org, Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>

On Wed, Jan 25, 2017 at 09:49:23PM +0100, Wolfram Sang wrote:
> On Sun, Dec 11, 2016 at 11:04:35PM +0100, Wolfram Sang wrote:
> > On Fri, Dec 09, 2016 at 10:31:58AM +0100, Jan Glauber wrote:
> > > It was reported that ipmi_ssif fails to create the
> > > ipmi device on some systems if the adapter class is not containing
> > > I2C_CLASS_HWMON. Fix it by setting the class.
> > > 
> > > Reported-by: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> > > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > 
> > The intention of adapter classes is to *limit* probing to a certain
> > class of devices. If a class is needed to *enable* probing, then
> > something there looks wrong. From the details given, this must be solved
> > elsewhere I'd say.
> 
> Makes sense?
> 

Hi Wolfram,

I've looked at this again because apparently auto-detection of BMCs
(ipmi_ssif driver) is not working anymore.

Debugging it shows that ssif_probe is not called when ipmi_ssif is
trying to automatically detect BMCs. Adding the i2c device manually
works fine (ssif_probe called).

Setting the class value in the ThunderX i2c driver to I2C_CLASS_HWMON
makes the autodection of ipmi_ssif work.

Looking for clues how to solve this (because you mentioned this might be
the wrong solution) I've stumbled over this:

Documentation/i2c/writing-clients:
  You simply have to define a detect callback which will attempt to
  identify supported devices (returning 0 for supported ones and -ENODEV
  for unsupported ones), a list of addresses to probe, and a device type
  (or class) so that only I2C buses which may have that type of device
  connected (and not otherwise enumerated) will be probed.  For example,
  a driver for a hardware monitoring chip for which auto-detection is
  needed would set its class to I2C_CLASS_HWMON, and only I2C adapters
  with a class including I2C_CLASS_HWMON would be probed by this driver.
  Note that the absence of matching classes does not prevent the use of
  a device of that type on the given I2C adapter.  All it prevents is
  auto-detection; explicit instantiation of devices is still possible.

We do want auto-detection, so either this text is wrong or setting
I2C_CLASS_HWMON in our i2c adapter is correct. Am I missing
something?

thanks,
Jan
