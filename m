From: Kachalov Anton <mouse@mayc.ru>
Subject: Re: i2c: slave support framework improvements
Date: Tue, 26 Jul 2016 19:51:08 +0300
Message-ID: <168841469551868@web14h.yandex.ru>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
	 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
	 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
	 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
	 <1391831469440835@web19h.yandex.ru> <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from forward2m.cmail.yandex.net ([5.255.216.20]:60320 "EHLO
	forward2m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757252AbcGZQvN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Jul 2016 12:51:13 -0400
In-Reply-To: <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

26.07.2016, 18:22, "Peter Rosin" <peda@axentia.se>:
> On 2016-07-25 12:00, Kachalov Anton wrote:
>> =C2=A0You are welcome.
>>
>> =C2=A0In my implementation in PCA954x I did the following things tha=
t I would like to highlight:
>>
>> =C2=A01. handle slave register and store i2c_client data to the inte=
rnal array
>> =C2=A0(length equal to number of channels). First obstacle =E2=80=93=
 get the right offset in
>> =C2=A0the array (channel number). It's better to expose "chan_id" fi=
eld from
>> =C2=A0i2c_mux_priv as a public function. I did a hack during init by=
 writing down
>> =C2=A0first muxc->adapter's number ("nr" field store in private adap=
_off).
>
> The i2c-mux.c file is not sacred, nor set in stone, just add the acce=
ssor
> if you need it. (But the function would be kind of dangerous as there=
 is
> no way that I know of to verify that the passed adapter is in fact a =
mux
> child adapter. So, if you'd pass something else, you'd get to keep al=
l
> the pieces...)
>
> HOWEVER, chan_id is not necessarily the same as the index into the
> muxc->adapter array. The index in the muxc->adapter array is just the
> order in which the mux child adapters were registered, and bears no
> relation to the chan_id. At least none that can be relied upon.

I just need any way to get offset into the muxc->adapter when accessing
mux bus in reg_slave/unreg_slave.

> So, a better (but totally different) addition to the mux core might b=
e
> to add a function to set the reg_slave and unreg_slave pointers in
> i2c_mux_priv->algo, instead of copying the whole algo struct.

Something like a: i2c_mux_set_slave_funcs(mux, reg_slave, unreg_slave) =
?

> Another thing is that it seems that data->last_chan represents the sa=
me
> thing as your new variable data->cur_chan, but in a different form (b=
itmask
> vs. enumeration), and they are not always kept in sync. Please use ju=
st
> one variable to prevent nasty surprises, as two variables are bound t=
o get
> out of sync.

Yeah, I leave separate variable right not to touch original bitmask.
I needed to create a proof-of-concept before clean things up and rewrit=
e
parts in robust way.

>
>> =C2=A02. during handling of select_chan I'm trying to register new i=
2c dummy
>> =C2=A0device with newly selected slave addr corresponding to the cha=
nnel
>> =C2=A0number (if it has a slave). This is the second problem =E2=80=93=
 after I've registered
>> =C2=A0dummy device with some slave address, I'm not able to register=
 slave
>> =C2=A0devices for other mux'ed busses with the same slave addr. In o=
ther words,
>> =C2=A0I have to populate all the slave devices (with the same slave =
addr)
>> =C2=A0right before I'm going to use the bus first time.
>
> That description doesn't really match the code (or maybe I'm misunder=
standing
> or the code has changed or something). What do you mean that you have=
 to
> populate all the slave devices beforehand? The code only creates one =
dummy
> device and reuses that one for all "slave proxying".

I'm able to register individual slave clients on each muxed bus like th=
e following:

echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-9/new_device
echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
echo slave-24c02 0x1013 > /sys/bus/i2c/devices/i2c-11/new_device
echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-12/new_device

only if I do not access i2c muxed bus somewhere between adding devices,=
 like:

echo aspeed,i2c-ipmb 0x11 > /sys/bus/i2c/devices/i2c-9/new_device
i2cdetect -y 10
# next command will return (-16)
# [...] i2c i2c-10: Failed to register i2c client slave-24c02 at 0x11 (=
-16)
echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
# [...] i2c i2c-11: Failed to register i2c client slave-24c02 at 0x11 (=
-16)
echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-11/new_device

I use one dummy device just not to call unreg/reg each time while proxy=
 callback
as far simple as just passing arguments from one object to another.

BTW, sometimes I saw new device entries in /sys/bus/... even
adding client via sysfs fails.

> Anyway, one thing that I do not like about that code is that it, on m=
ux
> changes, clobbers dummy->addr before the slave proxy in unregistered.=
 It's
> not really pretty to clobber it at all, but it would feel better if t=
he addr
> was only clobbered when the slave was not registered.

There might be a better way to track slave addr change (on adapter bus)=
 just not to
overcall unreg_slave/reg_slave for the same addr.

> I'm also a bit surprised that you are allowed to create a new (dummy)=
 device
> with an address that is already taken on a downstream mux client adap=
ter.
> Is that a feature in the i2c core, or is it a bug? Wolfram?

This is what I mean under the "populate all the slave devices beforehan=
d".
=46rom the i2c bus point of view, I just adding one device per bus. It'=
s allowed.
=46rom the adapter point of view, I duplicates clients with the same ad=
dr.
But I can't use two of them at the same time, so there is no HW conflic=
ts.
And I've tried to workaround such case to make this possible.

>
>> =C2=A03. registering and/or unregister first (if applicable) slave d=
evice on the parent
>> =C2=A0bus adapter. This is the third obstacle. While the bus is alre=
ady locked,
>> =C2=A0calling generic i2c_slave_{register,unregister} lead to the de=
adlock.
>> =C2=A0I did it directly via the reg_slave/unreg_slave calls of appro=
priate data structure.
>
> BTW, your open-coded unlocked versions of i2c_slave_register and
> i2c_slave_unregister do not handle errors and skips some tests. Maybe=
 add
> unlocked versions to i2c-core.c instead? Also, why do you need to for=
bid
> 10-bit addresses in pca954x_reg_slave? Is that a property of the mux,=
 or
> is it really a property of your root adapter?

My bad, it is incomplete code. I keep commented i2c_slave_unregister/re=
gister
right for the future improvements. Direct call isn't good idea, but I n=
eed unlocked
version.

I forbid 10-bit address just as a copy-paste from another code. And, ye=
s, my HW
doesn't support it either. This check should be eliminated.

>> =C2=A0Notes:
>> =C2=A0Slave works only with keeping channel selected while generic i=
2c-mux logic
>> =C2=A0is to deselect channel after each i2c transfers.
>>
>> =C2=A025.07.2016, 12:41, "Wolfram Sang" <wsa@the-dreams.de>:
>>>> =C2=A0=C2=A0There is no way to switch mux and request to BMC #2. L=
ogically, this shouldn't
>>>> =C2=A0=C2=A0happen too.
>>>
>>> =C2=A0I see. I think I have the big picture now, thanks for the hea=
ds up.
>>>
>>> =C2=A0However, I am not sure what recommendations I can give to you=
=2E I'd start
>>> =C2=A0with adding reg_slave to the muxed adapters and then try to r=
econfigure
>>> =C2=A0the real adapter when the mux switches (I assume you did that=
 already).
>>> =C2=A0But I don't have the bandwidth to dive into that and see what=
 gory
>>> =C2=A0details come up. Maybe Peter Rosin has something to add, thou=
gh?
>
> The whole thing seems a bit fragile, as Wolfram already stated...
>
> Let me see if I got how this works; You have some process that access=
es some
> device on the different mux segments, with some amount of time betwee=
n each
> access. The mux leaves the segment selected after this access. During=
 this
> time slot, when the mux segment is selected but idle, there might com=
e in a
> slave access from that mux segment.

In general it's fragile. Absolutely. For generic i2c-mux, right after m=
aster IO
completes, i2c-mux logic tries to deselect channel, but there is a work=
around
in pca954x to keep channel selected after transfer is completed. Slave =
support
in pca954x moves this "window" further to allow slave IO. In applicatio=
n of such
setup MUX used only for master IO to slaves on different channels. Mean=
while,
I need to follow IPMB proto spec and allow to receive answers as slave =
IO
(from the stand of my system). So, in general such fragile situation wi=
th unwanted
slave IO is uncommon while slaves do not acts as master until they aske=
d for.
Only one reason that might arise is a very slow answer from previously =
selected channel
(from previous round of switch). However, such case means bogus IPMB no=
de and
shouldn't every happen. Switching only occurs with following of request=
<->response
time specs. For IPMB/ICMB application, user software asks to switch to =
the next
channel only on successful response or timeout (both should be handled =
by IPMB i2c driver).
One question here: how proper lock the muxed channel bus while waiting =
for answer/timeout?

>
> This all depends on the external process that round-robins the mux. I=
 don't
> like that. It should be some system process with a much closer tie to=
 the
> kernel (maybe it should be in-kernel?) that is responsible for the
> round-robin of the mux. And, AFAIU, there is no need for any access t=
o the
> child side of the mux to enable these slave accesses, this process ma=
y just
> flip the mux selection and that should be enough, no? This process ca=
n also
> step past any mux segments that do not have any slave registered so t=
hat
> the waiting time can be reduced, and it can be completely disabled if=
 there
> are no slaves registered.

There might be different slaves on muxed bus.
I didn't get you on process that may flip the mux selection. It's not c=
lear, but
just a note that in our application we have IPMB master/slave client th=
at
sends request on user-space behalf and waiting for answer/timeout (atom=
ic operation)
keeping muxed bus busy. Right after that we're free to switch to anothe=
r channel
if it requested by the user software or use same channel for next reque=
st.


> A bigger issue is that the process also needs to consider other muxes=
 in
> case there is a large mux tree on the root adapter. So, I think it ne=
eds to
> be a central process connected to the root adapter, and not something=
 local
> to the mux for it to be generic? This seems to get nastier the more I=
 think
> about it...
>
> *time passes*
>
> I realize that in the large mux tree case, your code doesn't work ver=
y
> well at all. I.e. if you have
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux1 dev2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/ \ /
> =C2=A0root mux2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\ \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0etc dev3
>
> then accesses to dev1 will flip mux1 and prevent any slave accesses f=
rom
> dev2 and dev3. I guess this just shows the fundamental fragility with=
 the
> approach of having multiple devices doing slave accesses to the same
> root adapter in some ad-hoc manner. I guess you could refuse slave
> registration in case the mux isn't sitting directly on the root adapt=
er,
> but I don't know how to detect and prohibit slave accesses from paral=
lel
> muxes on a root adapter.

In general my proposal has a number of limitations that you've highligh=
ted.
It might not (and trull it is not) fit generic application with any pos=
sible
tree structure. I faced only HW design where there is only one i2c swit=
ch
per adapter bus. No nestings.
If it is required to have more channels, then one more i2c adapter's bu=
s is used.
