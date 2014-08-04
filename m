From: dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org
Subject: Re: i2c-i801: Enable interrupts on ICH5/7/8/9/10
Date: Mon, 4 Aug 2014 17:56:32 +0000
Message-ID: <20140804175632.GA5288@fifo99.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi,

I had an issue with the i2c dev-interface. The executable runs i2c_smbus_write_word_data() and it hangs at
that point. The issues wasn't present in earlier kernels , so I was able to bisect this to ,

commit 29b608540b030d38a978c972cbe99d40efdb7267
Author: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Date:   Tue Jul 24 14:13:59 2012 +0200
 
    i2c-i801: Enable interrupts on ICH5/7/8/9/10


The system I'm testing on is an ICH9 from and Intel BearLake.

Daniel
