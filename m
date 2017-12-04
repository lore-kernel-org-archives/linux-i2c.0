From: Sven Van Asbroeck <thesven73-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/1] at24: support eeproms that do not auto-rollover reads.
Date: Mon, 4 Dec 2017 17:24:33 -0500
Message-ID: <CAGngYiXR83+0phkeAvJYYEm8HvmN-c9d0B9p1BRiPHyUz1ogAA@mail.gmail.com>
References: <1512401778-20366-1-git-send-email-svendev@arcx.com>
 <1512401778-20366-2-git-send-email-svendev@arcx.com> <20171204214023.ml2ujacezsop5ilb@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171204214023.ml2ujacezsop5ilb-sGAanXTfQ4777SC2UrCW1FMQynFLKtET@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sven Van Asbroeck <svenv-fuHqz3Nb1YI@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> If this is truly specific to at24, then vendor prefix would be appropriate,
> plus it'd go to an at24 specific binding file. However if it isn't I'd just
> remove the above sentence. I guess the latter?

Yes, no-read-rollover is truly specific to at24.c, because it applies only
to i2c multi-address chips. The at25 is spi based so cannot have multiple
addresses.

So yes, "at24,no-read-rollover" would perhaps be a better name.

Regarding an at24 specific binding file. You're saying I should create
Documentation/devicetree/bindings/eeprom/at24.txt ? Should I indicate
that at24.txt "inherits from" eeprom.txt? Note that at25.txt does not
currently do this.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
