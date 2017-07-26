From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: can't write more than one byte to AT24C64 EEPROM using
 "eeprog"
Date: Wed, 26 Jul 2017 17:31:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1707261729480.3404@localhost.localdomain>
References: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca> <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain> <alpine.LFD.2.20.1707261427010.32595@localhost.localdomain> <20170726205740.GB1510@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cpanel2.indieserve.net ([199.212.143.6]:42471 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdGZVbQ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Jul 2017 17:31:16 -0400
In-Reply-To: <20170726205740.GB1510@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Wed, 26 Jul 2017, Wolfram Sang wrote:

> >   thoughts? is no one else seeing this issue?
>
> Just for the record: I always use the kernel at24 driver for eeproms
> and haven't used those tools for ages. I could imagine this is true
> for most people and would explain undiscovered bugs and bitrot.

  i'm not even sure what that means ... how do you distinguish between
the kernel drivers and the user space utilities?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
