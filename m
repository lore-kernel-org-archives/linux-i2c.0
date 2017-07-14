From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/5 v4] usb: pci-quirks: Protect the I/O port pair of
 SB800
Date: Fri, 14 Jul 2017 13:36:06 +0200
Message-ID: <20170714113606.GA20265@kroah.com>
References: <20170621035349.4125-1-zboszor@pr.hu>
 <20170622132134.7200-1-zboszor@pr.hu>
 <20170622132134.7200-4-zboszor@pr.hu>
 <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42584 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbdGNLgM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Jul 2017 07:36:12 -0400
Content-Disposition: inline
In-Reply-To: <d599eeac-d159-cff6-7140-7b6cce026c7a@pr.hu>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org, Paul Menzel <paulepanter@users.sourceforge.net>, Christian Fetzer <fetzer.ch@gmail.com>, Jean Delvare <jdelvare@suse.com>, Nehal Shah <nehal-bakulchandra.shah@amd.com>, Tim Small <tim@seoss.co.uk>, Guenter Roeck <linux@roeck-us.net>, kernel@ekass.net, wim@iguana.be, jlayton@poochiereds.net, marc.2377@gmail.com, cshorler@googlemail.com, wsa@the-dreams.de, regressions@leemhuis.info, Alex Williamson <alex.williamson@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Toshi Kani <toshi.kani@hpe.com>, Jiang Liu <jiang.liu@linux.intel.com>, Jakub Sitnicki <jsitnicki@gmail.com>, Thierry Reding <tre>

On Fri, Jul 14, 2017 at 10:34:20AM +0200, Boszormenyi Zoltan wrote:
> 2017-06-22 15:21 keltezéssel, Zoltán Böszörményi írta:
> > This patch uses the previously introduced macro called
> > request_declared_muxed_region() to synchronize access to
> > the I/O port pair 0xcd6 / 0xcd7 on SB800.
> > 
> > These I/O ports are also used by i2c-piix4 and sp5100_tco,
> > so synchronization is necessary. The other drivers will also
> > be modified to use the new macro in subsequest patched.
> > 
> > v1: Started with a common mutex in a C source file.
> > 
> > v2: Declared the common mutex in drivers/usb/host/pci-quirks.c
> >      instead of in a common C file.
> > 
> > v3: Switched to using the new request_declared_muxed_region
> >      macro.
> > 
> > v4: Fixed checkpatch.pl warnings and use the new
> >      release_declared_region() macro.
> > 
> > Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>

Why are you responding to your own patches?

You do know this is the middle of the merge window, and we can't do
anything here with patches, right?

thanks,

greg k-h
