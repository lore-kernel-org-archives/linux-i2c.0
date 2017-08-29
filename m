From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep
 handling
Date: Tue, 29 Aug 2017 15:53:41 +0200
Message-ID: <20170829135341.moanebdmbdz3ajjm@sig21.net>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
 <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
 <CAPDyKFp5dpuUeRjmmSSA3sZzFVwJihmzteyCDzqG33s2Xb1ewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:55908 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdH2Nyg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 09:54:36 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFp5dpuUeRjmmSSA3sZzFVwJihmzteyCDzqG33s2Xb1ewA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfounda>

On Tue, Aug 29, 2017 at 01:44:11PM +0200, Ulf Hansson wrote:
> Did you try out my series (v2) if that could fix this problem in a
> more flexible manner?
> 
> In other words, is it fine if the device remains runtime PM enabled
> during the entire device_suspend() phase, and also not being suspended
> until ->suspend_late()?

I tried to try but I also had some test patches applied
and it hung up on suspend but I ran out of time to check why...
I intend to try again soon.

Johannes
