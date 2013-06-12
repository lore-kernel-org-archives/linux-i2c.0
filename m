From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 2/9] i2c: mv64xxx: make the registers offset configurable
Date: Wed, 12 Jun 2013 17:03:12 +0200
Message-ID: <51B88DB0.90302@gmail.com>
References: <1371024438-16631-1-git-send-email-maxime.ripard@free-electrons.com> <1371024438-16631-3-git-send-email-maxime.ripard@free-electrons.com> <20130612135735.GR18614@n2100.arm.linux.org.uk> <20130612144447.GI16699@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130612144447.GI16699@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 06/12/13 16:44, Maxime Ripard wrote:
> Hi Russel,
>
> On Wed, Jun 12, 2013 at 02:57:35PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Jun 12, 2013 at 10:07:11AM +0200, Maxime Ripard wrote:
>>> The Allwinner i2c controller uses the same logic as the Marvell one, but
>>> with slightly different register offsets.
>>>
>>> Introduce a structure that will be passed by either the pdata or
>>> associated to the compatible strings, and that holds the various
>>> registers that might be needed.
>>
>> I don't like this change.  It introduces further indirection where it's
>> not really necessary, and it's also using platform data to specify this
>> which is in the opposite direction to what's required for moving towards
>> DT.
>
> Well, some users of this aren't converted to DT, hence why I made the
> changes to the platform_data.

Actually, this is not quite true. Yes of course, there are still users
of non-DT Marvell SoCs and it is still in the progress of full-DT. But
also ppc is using DT, except that they parse it and put in in
platform_data. Reasonable since back then, there was no global DT API
available.

IMHO for the time in between (i.e. now) check for pdev->dev.of_node
and !pdev->dev.platform_data will allow you to distinguish all users
perfectly:

- non-DT has platform_data set only
- ppc DT has of_node and platform_data set
- pure DT has of_node set only

This will allow you to limit your register offset modifications to
Allwinner exclusively and for pure DT (if that is what you want for
Allwinner).

Checkout mv643xx_eth in net-next where the above discrimination
strategy was chosen.

[...]
>> I'd suggest making the default register offsets be the drivers existing
>> offsets, and allowing it to be overriden.  That nicely sorts out the
>> next comment below, and also gets rid of it in platform data.  Moreover,
>> if you're going to re-use this driver, you should do it via a different
>> "compatible" name in DT, which the driver can then use to identify the
>> different register set layout.
>
> The logic here will change quite a bit in the next iteration thanks to
> the comments I received.
>
> I'm now using a platform_device_id structure to match the name of the
> driver just like what was done with the DT in that patchset. This also
> removes the need to add the regs field to the platform data and ...

Also here, if Allwinner is pure DT, you can call some
mv643xx_i2c_of_probe() for pure DT only with the above discrimination.

Sebastian
