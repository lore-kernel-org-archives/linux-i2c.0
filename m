From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Mon, 10 Jun 2013 14:18:17 +0200
Message-ID: <CACRpkdbBsXB+9wN0oshfZB8Xady9G_wu9d8UkgA-bYqQe=8Mpw@mail.gmail.com>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
	<20130607213241.GB3047@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130607213241.GB3047@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 7, 2013 at 11:32 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> ...
>> I2C devices probed from device tree should subsequently be
>> fixed to handle the case where of_match_table() is
>> used (I think none of them do that today), and platforms should
>> fix their device trees to use compatible strings for I2C devices
>> instead of setting the name to Linux device driver names as is
>> done in multiple cases today.
>
> I guess your solution is the least intrusive one. Still, it could happen
> that of_match_table is scanned three times (by driver core, i2c layer,
> and i2c driver) which is IMO an indication to look for a more elegant
> solution tp find out what really matched?

I think that is a generic problem with the device tree
being completely stateless, and rather a comment on the
of_match_device() intrinsics being inelegant than on this
patch?

Do you see it as a blocker for the patch?

What happens before this patch is that instead of looping
over the of_match_table, the id_table is always iterated
to the end also in the DT case, yielding NULL as the last
argument to driver->probe() anyway.

Maybe the OF people have some comments on this...
I cannot really see how it could be any different given
the way the FDT works :-/

Yours,
Linus Walleij
