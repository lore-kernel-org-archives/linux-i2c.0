From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 5/5] at24: Support probing while off
Date: Fri, 10 Jan 2020 13:28:51 +0200
Message-ID: <20200110112851.GC5440@paasikivi.fi.intel.com>
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com>
 <20200109154529.19484-6-sakari.ailus@linux.intel.com>
 <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:51015 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgAJL3G (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 10 Jan 2020 06:29:06 -0500
Content-Disposition: inline
In-Reply-To: <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rajmohan Mani <rajmohan.mani@intel.com>, Tomasz Figa <tfiga@chromium.org>

Hi Bartosz,

On Fri, Jan 10, 2020 at 12:16:14PM +0100, Bartosz Golaszewski wrote:
> czw., 9 sty 2020 o 16:44 Sakari Ailus <sakari.ailus@linux.intel.com> napisał(a):
> >
> > In certain use cases (where the chip is part of a camera module, and the
> > camera module is wired together with a camera privacy LED), powering on
> > the device during probe is undesirable. Add support for the at24 to
> > execute probe while being powered off. For this to happen, a hint in form
> > of a device property is required from the firmware.
> >
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Why am I not Cc'ed on this patch?

I'll make sure you'll be cc'd on any future versions of the patch.

-- 
Kind regards,

Sakari Ailus
