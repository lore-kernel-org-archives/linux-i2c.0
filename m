From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 16:22:21 +0200
Message-ID: <49EDD69D.1020104@gmx.de>
References: <49ED6AD3.2060808@gmx.de> <49ED6F03.5050107@grandegger.com> <49ED9132.9050806@gmx.de> <20090421095112.GB3100@pengutronix.de> <49EDC487.8010201@gmx.de> <49EDCC31.2030506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EDCC31.2030506-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfgang Grandegger said the following:
>> Many adapters do initialization of .class in adapter code. A few do not.
>> I haven't checked, but assume the PPC ones, as they have DTS. Thats Ok,
>> as long DTS is really used. In at least one other adapter it is: Exactly
>> Wolfgang Grandegger, who is responsible for removal of the original
>> default initialization, showed me, that it is done in i2c-cpm!
> 
> This property in i2c-cpm existed before the conversion to new style I2C
> drivers. I actually proposed the following patch:
> 
>  http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060016.html
> 
> But after some discussion we came to the conclusion, that legacy device
> probing should be avoided for FDT based systems.
What does this                  ^^^ mean?

I am really without emotion about how it is solved, but dynamic
instantiation should be possible in a clean way. Generating an entry for
every possible device is no clean way, IMHO.
BTW: I can't see what this has to do with legacy, I my case we talk
about new-style ones.

-- 
Michael
