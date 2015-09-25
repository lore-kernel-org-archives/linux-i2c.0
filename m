From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: randconfig build error with next-20150812, in
 drivers/i2c/busses/i2c-i801.c
Date: Fri, 25 Sep 2015 14:37:57 +0100
Message-ID: <20150925133757.GA2857@codeblueprint.co.uk>
References: <CA+r1ZhjyBKcWbNB3hkPxoEKatojYk9=VPqSurZHPk9nfNp_gSQ@mail.gmail.com>
 <20150925093610.64ed7f59@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38244 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932258AbbIYNiA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 25 Sep 2015 09:38:00 -0400
Received: by wiclk2 with SMTP id lk2so20031032wic.1
        for <linux-i2c@vger.kernel.org>; Fri, 25 Sep 2015 06:37:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150925093610.64ed7f59@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jdelvare@suse.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Guenter Roeck <linux@roeck-us.net>

On Fri, 25 Sep, at 09:36:10AM, Jean Delvare wrote:
> On Wed, 12 Aug 2015 08:42:18 -0700, Jim Davis wrote:
> > Building with the attached random configuration file,
> > 
> > drivers/built-in.o: In function `dmi_check_onboard_devices':
> > i2c-i801.c:(.text+0x126b36): undefined reference to `i2c_new_device'
> > drivers/built-in.o: In function `i801_remove':
> > i2c-i801.c:(.text+0x126b86): undefined reference to `i2c_del_adapter'
> > drivers/built-in.o: In function `i801_probe':
> > i2c-i801.c:(.text+0x127d08): undefined reference to `i2c_add_adapter'
> > i2c-i801.c:(.text+0x127d6e): undefined reference to `i2c_new_device'
> 
> Sorry for the late reply. The error is caused by the following
> combination of options:
> 
> CONFIG_I2C=m
> CONFIG_I2C_I801=y
> 
> I can reproduce it even with mainline now. This is caused by
> CONFIG_ITCO_WDT=y, which selects CONFIG_I2C_I801=y without selecting
> its dependencies (CONFIG_I2C.)
> 
> Thanks for reporting, I'll post a fix shortly.

Sorry that you got caught up in this build error Jean.

Guenter (Cc'd) posted a fix here,

  https://lkml.kernel.org/r/1441978088-27288-1-git-send-email-linux@roeck-us.net

-- 
Matt Fleming, Intel Open Source Technology Center
