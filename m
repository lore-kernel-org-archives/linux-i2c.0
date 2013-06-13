From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Thu, 13 Jun 2013 11:02:36 +0200
Message-ID: <CACRpkdZjb0prsORdkn6GQUL0LM38VYCQ-STXnHgOtF1oCAWrwg@mail.gmail.com>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
	<20130607213241.GB3047@katana>
	<20130612132022.39F0C3E0A56@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130612132022.39F0C3E0A56@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 12, 2013 at 3:20 PM, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Fri, 7 Jun 2013 23:32:42 +0200, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:

>> I guess your solution is the least intrusive one. Still, it could happen
>> that of_match_table is scanned three times (by driver core, i2c layer,
>> and i2c driver) which is IMO an indication to look for a more elegant
>> solution tp find out what really matched?
>
> It's what we do on platform_devices. It really isn't an expensive
> operation so I haven't pushed anyone to go optimize it.

I tried to think of something and it ended up with ideas like
decorating the device tree representation and it was just ...
ouch.

Yours,
Linus Walleij
