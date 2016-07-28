From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 17:39:51 +0300
Message-ID: <496481469716791@web5h.yandex.ru>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
	 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
	 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
	 <1391831469440835@web19h.yandex.ru>
	 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
	 <168841469551868@web14h.yandex.ru> <173323d0-32c0-3093-1f12-718a5d7e4c9e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward1o.cmail.yandex.net ([37.9.109.84]:53879 "EHLO
	forward1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758713AbcG1Ou4 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Jul 2016 10:50:56 -0400
In-Reply-To: <173323d0-32c0-3093-1f12-718a5d7e4c9e@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



28.07.2016, 09:55, "Peter Rosin" <peda@axentia.se>:
> On 2016-07-26 18:51, Kachalov Anton wrote:
>> =C2=A026.07.2016, 18:22, "Peter Rosin" <peda@axentia.se>:
>
> No, I don't think you want that at all. You are using cur_chan to ind=
ex
> your slaves array, and that is b0rken, since you in other places use
> the index into the mux core adapter array to access the slaves array.
> As stated, the channel id and the adapter index are not the same (the=
y
> might be, and probably are in your case, but that is a coincidence).
> What you want is to go from the adapter to the channel id, i.e. a new
> function such as this in i2c_mux.c
>
> u32 i2c_mux_adapter_chan_id(struct i2c_adapter *adap)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct i2c_mux_priv *=
priv =3D adap->algo_data;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return priv->chan_id;
> }
>
> and then always use the channel id to index your slaves array (and
> totally ignore the adapter index). This will work just fine since
> you know that the channel id is 0-7. The mux core does not assume
> such a limited range of channel ids (a mux might use a single client
> adapter with channel id e.g. 400000), and therefore uses a different
> scheme to index its adapter array.

Right. I'll rewrite this part to use i2c_mux_adapter_chan_id.

>> =C2=A0echo aspeed,i2c-ipmb 0x11 > /sys/bus/i2c/devices/i2c-9/new_dev=
ice
>> =C2=A0i2cdetect -y 10
>> =C2=A0# next command will return (-16)
>> =C2=A0# [...] i2c i2c-10: Failed to register i2c client slave-24c02 =
at 0x11 (-16)
>> =C2=A0echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_devi=
ce
>> =C2=A0# [...] i2c i2c-11: Failed to register i2c client slave-24c02 =
at 0x11 (-16)
>> =C2=A0echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-11/new_devi=
ce
>
> Is this with your patch? If so, then that makes perfect sense since
> your dummy device sits on the root adapter, and you are not allowed
> to create address conflicts between clients on the root adapter and
> clients on downstream muxes.

Correct. With my patch. I create one proxy i2c dummy device that sits
on the adapter's bus and proxy slave callback to the target muxed slave=
=2E

> I think the problem is that when you call i2c_new_dummy, it calls
> i2c_new_device without the I2C_CLIENT_SLAVE flag (which you try to
> add too late). If you open code i2c_new_dummy and add this flag
> before calling i2c_new_device, it might work better?

Let me try. That means I need to copy-paste all the dummy part from i2c=
-core
and set flags in i2c_board_info struct?

>> =C2=A0BTW, sometimes I saw new device entries in /sys/bus/... even
>> =C2=A0adding client via sysfs fails.
>
> Further details and a reproducer would be useful...

I'll try to catch it again.

>>> =C2=A0Anyway, one thing that I do not like about that code is that =
it, on mux
>>> =C2=A0changes, clobbers dummy->addr before the slave proxy in unreg=
istered. It's
>>> =C2=A0not really pretty to clobber it at all, but it would feel bet=
ter if the addr
>>> =C2=A0was only clobbered when the slave was not registered.
>>
>> =C2=A0There might be a better way to track slave addr change (on ada=
pter bus) just not to
>> =C2=A0overcall unreg_slave/reg_slave for the same addr.
>>
>>> =C2=A0I'm also a bit surprised that you are allowed to create a new=
 (dummy) device
>>> =C2=A0with an address that is already taken on a downstream mux cli=
ent adapter.
>>> =C2=A0Is that a feature in the i2c core, or is it a bug? Wolfram?
>>
>> =C2=A0This is what I mean under the "populate all the slave devices =
beforehand".
>> =C2=A0From the i2c bus point of view, I just adding one device per b=
us. It's allowed.
>> =C2=A0From the adapter point of view, I duplicates clients with the =
same addr.
>> =C2=A0But I can't use two of them at the same time, so there is no H=
W conflicts.
>> =C2=A0And I've tried to workaround such case to make this possible.
>
> I guess what I'm really surprised about is that it seems to be allowe=
d to
> register a slave address on an adapter which creates an address confl=
ict
> with a client device (and vice versa). But the code seems pretty inte=
ntional
> about it, so what do I know? I have not really considered the slave p=
art of
> the i2c code before this conversation...
>
> Yes, the two devices can probably talk to each other since they both =
know
> who is master at the moment, but what about other masters on the bus?

It is allowed to talk more than two masters on the bus. May be I'm wron=
g.

    http://www.i2c-bus.org/multimaster/

Aspeed SoC has a arbitration lost interrupt and some procedure to win a=
rbitration then.


>> =C2=A0There might be different slaves on muxed bus.
>> =C2=A0I didn't get you on process that may flip the mux selection. I=
t's not clear, but
>> =C2=A0just a note that in our application we have IPMB master/slave =
client that
>> =C2=A0sends request on user-space behalf and waiting for answer/time=
out (atomic operation)
>> =C2=A0keeping muxed bus busy. Right after that we're free to switch =
to another channel
>> =C2=A0if it requested by the user software or use same channel for n=
ext request.
>
> It seems your thing is pretty application specific, in the general ca=
se,
> there is no way to know when a slave access might be needed. So, I pr=
oposed
> that a new mechanism/process should be added that round-robins the mu=
x(es)
> when they are otherwise idle. That mechanism/process could be extende=
d so
> that it lingers on a channel when it has been selected for other reas=
ons,
> which would fit your needs, no? Since this mechanism/process would be
> closely tied to the kernel, it would be easier for it to access inter=
nal
> things such as locks in a sane way.

It is known that in very specific application (IPMB/ICMB and so) but st=
andard there
are high dependency to the timings. For both sides.

=46rom the TI docu:

    http://www.ti.com/lit/ds/symlink/pca9548a.pdf

we get that only upstream is a true Master while downstream channels ar=
e Slaves.
In our situation Slaves shouldn't first initiate a Master Write until t=
hey asked by
requester Master. So, it is not a generic bi-directional multi-master s=
witch.
There is only one true Master that able to select channel and other dev=
ices are
might be only semi-Master.

>> =C2=A0In general my proposal has a number of limitations that you've=
 highlighted.
>> =C2=A0It might not (and trull it is not) fit generic application wit=
h any possible
>> =C2=A0tree structure. I faced only HW design where there is only one=
 i2c switch
>> =C2=A0per adapter bus. No nestings.
>> =C2=A0If it is required to have more channels, then one more i2c ada=
pter's bus is used.
>
> And when you run out of adapters?

Aspeed might have up to 16 bus :) For typical application there is no n=
eed more than 4-5
for different purpose.

It might be possible, that two nested switch might work while we will h=
ave two proxies:
first level on root adapter's bus and second one attached to the muxed =
adapter's bus.

> I'm simply reluctant to add code that may hinder future development
> of something generic.

Probably, we should start with something more specific and improve it i=
n the future for
more generic (or other specific) cases.
