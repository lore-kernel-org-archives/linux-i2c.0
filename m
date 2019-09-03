From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RFC,v2 3/6] media: dt-bindings: add DS90UB954-Q1 video
 deserializer
Date: Tue, 3 Sep 2019 13:03:27 +0200
Message-ID: <f3640020-0291-f837-8639-c3ba39800ead@lucaceresoli.net>
References: <20190723203723.11730-1-luca@lucaceresoli.net>
 <20190723203723.11730-4-luca@lucaceresoli.net> <20190902204841.GB7253@kunai>
 <63d99d6d-ecdd-7dd8-0dcb-126bfd89b258@lucaceresoli.net>
 <20190903093455.GD1020@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903093455.GD1020@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-media@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>, Vladimir Zapolskiy <vz@mleia.com>, Peter Rosin <peda@axentia.se>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 03/09/19 11:34, Wolfram Sang wrote:
> 
>> Not if you define enough addresses in the pool. E.g. the DS90UB954
>> hardware can have 8 aliases per port, so if you have (n_ports * 8)
>> addresses in the pool the problem is solved.
> 
> And then you plug-in somewhere another board with another need for ATR
> and you are out of addresses.

Now I got what you mean: the aliases in a pool are reserved to an ATR
and not available to another ATR. What about hoisting the pool one level
up in DT, to the adapter where the ATRs are connected?

>>> And another add-on module with
>>> non-repogrammable devices may occupy addresses from the defined pool
>>> above.
>>
>> You mean a new device on the local (SoC-to-ATR) bus? Well, it could as
>> well occupy a non-described address that the ATR has already picked as
>> an alias.
> 
> Nope, I mean a seperate add-on which has a hardcoded I2C address on the
> bus of the ATR parent. Then this hardcoded address needs to be removed
> from the pool if it is in the wrong range.

As I understand it, we are referring to the same use case:

.---------------.       .-----.   .-------------------.
| adapter (SoC) |---+---| ATR |---| remote slave 0x10 |
'---------------'   |   '-----'   '-------------------'
                    |
              .----------.
              | device X |
              '----------'

Here device X with hard-coded address 0x20 is plugged in at runtime.

As you say it, if 0x20 is in the ATR pool we have a problem.

But even without an explicit pool, initially 0x20 is unused and the ATR
can use it for remote slave 0x10. Then at some point device X is
connected, and suddenly 0x20 conflicts.

To a limited extend the explicit pool could help if the list of possible
addons is known: one can put in the pool only address that will never
appear in addons.

Hey, wait, the no-pool solution could have a way to handle this
conflict. When device X is connected, the adapter can look for a new
alias (0x21), call the i2c_atr_deconfigure_hw() and i2c_atr_setup_hw()
callbacks to stop using 0x20 and start using 0x21. Doesn't look very
lovely, but may be worth considering.

>>> I am not perfectly happy with the assumption that all undescribed
>>> addresses are automatically free. That also might need DTS updates to
>>> describe all clients properly. But this change only needs to be done
>>> once, and it will improve the description of the hardware.
>>
>> Right, but I still suspect some users won't do their homework and
>> discover address conflicts at runtime, maybe months later, in a painful
>> way. Also a chip might be undocumented on a given board, so they could
>> do their homework and still have problems.
> 
> Yes, we probably need a binding to mark an address as used even though
> we don't know the device or don't have a driver for it.
> 
> Don't get me wrong, I know what you mean. One of my boards has a client
> soldered in a way so that it is still in debug mode. That means it
> listens to addresses 0x03-0x07 to provide debug information. Took me a
> while to find out what is happening there.
> 
> But still, 'i2cdetect' showed all of these.
> 
>> Despite my comments, I'm not strongly against your proposal. To me it
>> doesn't seem to solve any problem, while it does introduce some degree
>> of risk. Could you elaborate more on but what benefit it introduces?
> 
> I'd think the risk of running out of defined addresses is somewhere
> equal to running into (after a while) an unexpectedly used address.
> I like the fix for the latter better because describing what is on the
> bus is more helpful and generic than updating the pool-property every
> time you need it. Plus, as mentioned above, other add-on hardware may
> disturb your pool allocation.
> 
> I expect this topic to be one of the discussion points of the BoF.

Definitely.  And having a list of use cases would help a lot IMO. I had
never considered the use case described above, for example.

Thanks,
-- 
Luca
