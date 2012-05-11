From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V3] i2c: Add generic I2C multiplexer using pinctrl API
Date: Fri, 11 May 2012 15:13:11 -0600
Message-ID: <4FAD80E7.5050304@wwwdotorg.org>
References: <1335893011-24231-1-git-send-email-swarren@wwwdotorg.org> <20120503122417.GH9574@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120503122417.GH9574-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 05/03/2012 06:24 AM, Wolfram Sang wrote:
> On Tue, May 01, 2012 at 11:23:31AM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> 
>> This is useful for SoCs whose I2C module's signals can be routed
>> to different sets of pins at run-time, using the pinctrl API.
>> 
>> +-----+  +-----+ | dev |  | dev | +------------------------+
>> +-----+  +-----+ | SoC                    |      |        | |
>> /----|------+--------+ |   +---+   +------+     | child bus A, on
>> first set of pins |   |I2C|---|Pinmux|     | |   +---+   +------+
>> | child bus B, on second set of pins |
>> \----|------+--------+--------+ |                        |      |
>> |        | +------------------------+  +-----+  +-----+  +-----+ 
>> | dev |  | dev |  | dev | +-----+  +-----+  +-----+
>> 
>> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> Acked-by:
>> Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> --- v3: Renamed
>> pinctrl-i2cmux.c to i2c-mux-pinctrl.c to match recent changes to
>> other I2C mux files.
> 
> Thanks for doing the rename already. While I think I could follow
> your argument regarding the compatible-binding, I'd still like to
> have an ack from one of the device tree maintainers. The bindings
> are non-trivial and I am missing the insight to judge them.

Rob, Grant, any chance you could take a quick look at the bindings for
this? I'd love to see the driver in 3.5 so I could make use of it for
Tegra in 3.6 without cross-subsystem dependencies. Thanks.
