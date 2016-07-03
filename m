From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 0/1] Portable Device Tree Connector -- conceptual
Date: Sat, 2 Jul 2016 23:06:43 -0700
Message-ID: <5778AB73.2030603@gmail.com>
References: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467503750-31703-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, david@gibson.dropbear.id.au, pantelis.antoniou@konsulko.com, stephen.boyd@linaro.org, broonie@kernel.org, grant.likely@secretlab.ca, mark.rutland@arm.com
Cc: mporter@konsulko.com, koen@dominion.thruhere.net, linux@roeck-us.net, marex@denx.de, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, panto@antoniou-consulting.com
List-Id: linux-i2c@vger.kernel.org

On 07/02/16 16:55, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Hi All,
> 
> This is version 2 of this email.

< snip >

> The one remaining piece that this patch does not provide is how
> the overlay manager (which does not yet exist in the mainline
> tree) can apply an overlay to two different targets.  That
> final step should be a trivial change to of_overlay_create(),
> adding a parameter that is a mapping of the target (or maybe
> even targets) in the overlay to different targets in the
> active device tree.
> 
> This seems like a more straight forward way to handle connectors.
> 
> First, ignoring pinctrl and pinmux, what does everyone think?
> 
> Then, the next step is whether pinctrl and pinmux work with this method.
> Pantelis, can you point me to a good example for
> 
>   1) an in-tree board dts file
>   2) an overlay file (I am assuming out of tree) that applies to the board
>   3) an in-tree .dtsi file that would provide the same features as
>      the overlay file if it was included by the board dts file
> 
> It should be easier to discuss pinctrl and pinmux with an example.

And I should have added that there are other complexities beyond
pinctrl and pinmux that are not addressed.  Baby steps first,
before the whole enchilada.

-Frank
