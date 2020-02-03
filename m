From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 2/2] docs: i2c: dev-interface: document the actual
 implementation
Date: Mon, 3 Feb 2020 13:21:37 +0100
Message-ID: <20200203132137.6bed750a@endymion>
References: <20200123105246.67732e33@endymion>
        <20200123111137.5899fa5a@endymion>
        <20200129211337.GG7586@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBCMVk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 3 Feb 2020 07:21:40 -0500
In-Reply-To: <20200129211337.GG7586@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Lei YU <mine260309@gmail.com>, Luca Ceresoli <luca@lucaceresoli.net>

On Wed, 29 Jan 2020 22:13:37 +0100, Wolfram Sang wrote:
> >  So let's say you want to access an I2C adapter from a C program.
> > -First, you need to include these two headers::
> > +First, you need to include these three header files::  
> 
> Just stumbled over it: maybe just drop the 'three'? No number makes
> maintenance easier and it is not important for the user, I'd think.
> 
> >  
> > +  #include <linux/i2c.h>
> >    #include <linux/i2c-dev.h>
> > -  #include <i2c/smbus.h>
> > +  #include <sys/ioctl.h>  

Agreed, fixed.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
