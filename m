From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Thu, 28 Jul 2016 08:55:09 +0200
Message-ID: <173323d0-32c0-3093-1f12-718a5d7e4c9e@axentia.se>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0139.outbound.protection.outlook.com ([104.47.2.139]:31520
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1162820AbcG1HLB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Jul 2016 03:11:01 -0400
In-Reply-To: <168841469551868@web14h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-26 18:51, Kachalov Anton wrote:
> 26.07.2016, 18:22, "Peter Rosin" <peda@axentia.se>:
>> On 2016-07-25 12:00, Kachalov Anton wrote:
>>>  You are welcome.
>>>
>>>  In my implementation in PCA954x I did the following things that I =
would like to highlight:
>>>
>>>  1. handle slave register and store i2c_client data to the internal=
 array
>>>  (length equal to number of channels). First obstacle =E2=80=93 get=
 the right offset in
>>>  the array (channel number). It's better to expose "chan_id" field =
from
>>>  i2c_mux_priv as a public function. I did a hack during init by wri=
ting down
>>>  first muxc->adapter's number ("nr" field store in private adap_off=
).
>>
>> The i2c-mux.c file is not sacred, nor set in stone, just add the acc=
essor
>> if you need it. (But the function would be kind of dangerous as ther=
e is
>> no way that I know of to verify that the passed adapter is in fact a=
 mux
>> child adapter. So, if you'd pass something else, you'd get to keep a=
ll
>> the pieces...)
>>
>> HOWEVER, chan_id is not necessarily the same as the index into the
>> muxc->adapter array. The index in the muxc->adapter array is just th=
e
>> order in which the mux child adapters were registered, and bears no
>> relation to the chan_id. At least none that can be relied upon.
>=20
> I just need any way to get offset into the muxc->adapter when accessi=
ng
> mux bus in reg_slave/unreg_slave.

No, I don't think you want that at all. You are using cur_chan to index
your slaves array, and that is b0rken, since you in other places use
the index into the mux core adapter array to access the slaves array.
As stated, the channel id and the adapter index are not the same (they
might be, and probably are in your case, but that is a coincidence).
What you want is to go from the adapter to the channel id, i.e. a new
function such as this in i2c_mux.c

u32 i2c_mux_adapter_chan_id(struct i2c_adapter *adap)
{
	struct i2c_mux_priv *priv =3D adap->algo_data;

	return priv->chan_id;
}

and then always use the channel id to index your slaves array (and
totally ignore the adapter index). This will work just fine since
you know that the channel id is 0-7. The mux core does not assume
such a limited range of channel ids (a mux might use a single client
adapter with channel id e.g. 400000), and therefore uses a different
scheme to index its adapter array.

>> So, a better (but totally different) addition to the mux core might =
be
>> to add a function to set the reg_slave and unreg_slave pointers in
>> i2c_mux_priv->algo, instead of copying the whole algo struct.
>=20
> Something like a: i2c_mux_set_slave_funcs(mux, reg_slave, unreg_slave=
) ?

Yes, that would work.

>> Another thing is that it seems that data->last_chan represents the s=
ame
>> thing as your new variable data->cur_chan, but in a different form (=
bitmask
>> vs. enumeration), and they are not always kept in sync. Please use j=
ust
>> one variable to prevent nasty surprises, as two variables are bound =
to get
>> out of sync.
>=20
> Yeah, I leave separate variable right not to touch original bitmask.
> I needed to create a proof-of-concept before clean things up and rewr=
ite
> parts in robust way.
>=20
>>
>>>  2. during handling of select_chan I'm trying to register new i2c d=
ummy
>>>  device with newly selected slave addr corresponding to the channel
>>>  number (if it has a slave). This is the second problem =E2=80=93 a=
fter I've registered
>>>  dummy device with some slave address, I'm not able to register sla=
ve
>>>  devices for other mux'ed busses with the same slave addr. In other=
 words,
>>>  I have to populate all the slave devices (with the same slave addr=
)
>>>  right before I'm going to use the bus first time.
>>
>> That description doesn't really match the code (or maybe I'm misunde=
rstanding
>> or the code has changed or something). What do you mean that you hav=
e to
>> populate all the slave devices beforehand? The code only creates one=
 dummy
>> device and reuses that one for all "slave proxying".
>=20
> I'm able to register individual slave clients on each muxed bus like =
the following:
>=20
> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-9/new_device
> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
> echo slave-24c02 0x1013 > /sys/bus/i2c/devices/i2c-11/new_device
> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-12/new_device
>=20
> only if I do not access i2c muxed bus somewhere between adding device=
s, like:
>=20
> echo aspeed,i2c-ipmb 0x11 > /sys/bus/i2c/devices/i2c-9/new_device
> i2cdetect -y 10
> # next command will return (-16)
> # [...] i2c i2c-10: Failed to register i2c client slave-24c02 at 0x11=
 (-16)
> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-10/new_device
> # [...] i2c i2c-11: Failed to register i2c client slave-24c02 at 0x11=
 (-16)
> echo slave-24c02 0x1011 > /sys/bus/i2c/devices/i2c-11/new_device

Is this with your patch? If so, then that makes perfect sense since
your dummy device sits on the root adapter, and you are not allowed
to create address conflicts between clients on the root adapter and
clients on downstream muxes.

I think the problem is that when you call i2c_new_dummy, it calls
i2c_new_device without the I2C_CLIENT_SLAVE flag (which you try to
add too late). If you open code i2c_new_dummy and add this flag
before calling i2c_new_device, it might work better?

> I use one dummy device just not to call unreg/reg each time while pro=
xy callback
> as far simple as just passing arguments from one object to another.
>=20
> BTW, sometimes I saw new device entries in /sys/bus/... even
> adding client via sysfs fails.

=46urther details and a reproducer would be useful...

>> Anyway, one thing that I do not like about that code is that it, on =
mux
>> changes, clobbers dummy->addr before the slave proxy in unregistered=
=2E It's
>> not really pretty to clobber it at all, but it would feel better if =
the addr
>> was only clobbered when the slave was not registered.
>=20
> There might be a better way to track slave addr change (on adapter bu=
s) just not to
> overcall unreg_slave/reg_slave for the same addr.
>=20
>> I'm also a bit surprised that you are allowed to create a new (dummy=
) device
>> with an address that is already taken on a downstream mux client ada=
pter.
>> Is that a feature in the i2c core, or is it a bug? Wolfram?
>=20
> This is what I mean under the "populate all the slave devices beforeh=
and".
> From the i2c bus point of view, I just adding one device per bus. It'=
s allowed.
> From the adapter point of view, I duplicates clients with the same ad=
dr.
> But I can't use two of them at the same time, so there is no HW confl=
icts.
> And I've tried to workaround such case to make this possible.

I guess what I'm really surprised about is that it seems to be allowed =
to
register a slave address on an adapter which creates an address conflic=
t
with a client device (and vice versa). But the code seems pretty intent=
ional
about it, so what do I know? I have not really considered the slave par=
t of
the i2c code before this conversation...

Yes, the two devices can probably talk to each other since they both kn=
ow
who is master at the moment, but what about other masters on the bus?

>>
>>>  3. registering and/or unregister first (if applicable) slave devic=
e on the parent
>>>  bus adapter. This is the third obstacle. While the bus is already =
locked,
>>>  calling generic i2c_slave_{register,unregister} lead to the deadlo=
ck.
>>>  I did it directly via the reg_slave/unreg_slave calls of appropria=
te data structure.
>>
>> BTW, your open-coded unlocked versions of i2c_slave_register and
>> i2c_slave_unregister do not handle errors and skips some tests. Mayb=
e add
>> unlocked versions to i2c-core.c instead? Also, why do you need to fo=
rbid
>> 10-bit addresses in pca954x_reg_slave? Is that a property of the mux=
, or
>> is it really a property of your root adapter?
>=20
> My bad, it is incomplete code. I keep commented i2c_slave_unregister/=
register
> right for the future improvements. Direct call isn't good idea, but I=
 need unlocked
> version.
>=20
> I forbid 10-bit address just as a copy-paste from another code. And, =
yes, my HW
> doesn't support it either. This check should be eliminated.
>=20
>>>  Notes:
>>>  Slave works only with keeping channel selected while generic i2c-m=
ux logic
>>>  is to deselect channel after each i2c transfers.
>>>
>>>  25.07.2016, 12:41, "Wolfram Sang" <wsa@the-dreams.de>:
>>>>>   There is no way to switch mux and request to BMC #2. Logically,=
 this shouldn't
>>>>>   happen too.
>>>>
>>>>  I see. I think I have the big picture now, thanks for the heads u=
p.
>>>>
>>>>  However, I am not sure what recommendations I can give to you. I'=
d start
>>>>  with adding reg_slave to the muxed adapters and then try to recon=
figure
>>>>  the real adapter when the mux switches (I assume you did that alr=
eady).
>>>>  But I don't have the bandwidth to dive into that and see what gor=
y
>>>>  details come up. Maybe Peter Rosin has something to add, though?
>>
>> The whole thing seems a bit fragile, as Wolfram already stated...
>>
>> Let me see if I got how this works; You have some process that acces=
ses some
>> device on the different mux segments, with some amount of time betwe=
en each
>> access. The mux leaves the segment selected after this access. Durin=
g this
>> time slot, when the mux segment is selected but idle, there might co=
me in a
>> slave access from that mux segment.
>=20
> In general it's fragile. Absolutely. For generic i2c-mux, right after=
 master IO
> completes, i2c-mux logic tries to deselect channel, but there is a wo=
rkaround
> in pca954x to keep channel selected after transfer is completed. Slav=
e support
> in pca954x moves this "window" further to allow slave IO. In applicat=
ion of such
> setup MUX used only for master IO to slaves on different channels. Me=
anwhile,
> I need to follow IPMB proto spec and allow to receive answers as slav=
e IO
> (from the stand of my system). So, in general such fragile situation =
with unwanted
> slave IO is uncommon while slaves do not acts as master until they as=
ked for.
> Only one reason that might arise is a very slow answer from previousl=
y selected channel
> (from previous round of switch). However, such case means bogus IPMB =
node and
> shouldn't every happen. Switching only occurs with following of reque=
st<->response
> time specs. For IPMB/ICMB application, user software asks to switch t=
o the next
> channel only on successful response or timeout (both should be handle=
d by IPMB i2c driver).
> One question here: how proper lock the muxed channel bus while waitin=
g for answer/timeout?

There is no way to lock the mux with anything but transfers, as it stan=
ds.
So I guess that is something you will have figure out. :-)

>> This all depends on the external process that round-robins the mux. =
I don't
>> like that. It should be some system process with a much closer tie t=
o the
>> kernel (maybe it should be in-kernel?) that is responsible for the
>> round-robin of the mux. And, AFAIU, there is no need for any access =
to the
>> child side of the mux to enable these slave accesses, this process m=
ay just
>> flip the mux selection and that should be enough, no? This process c=
an also
>> step past any mux segments that do not have any slave registered so =
that
>> the waiting time can be reduced, and it can be completely disabled i=
f there
>> are no slaves registered.
>=20
> There might be different slaves on muxed bus.
> I didn't get you on process that may flip the mux selection. It's not=
 clear, but
> just a note that in our application we have IPMB master/slave client =
that
> sends request on user-space behalf and waiting for answer/timeout (at=
omic operation)
> keeping muxed bus busy. Right after that we're free to switch to anot=
her channel
> if it requested by the user software or use same channel for next req=
uest.

It seems your thing is pretty application specific, in the general case=
,
there is no way to know when a slave access might be needed. So, I prop=
osed
that a new mechanism/process should be added that round-robins the mux(=
es)
when they are otherwise idle. That mechanism/process could be extended =
so
that it lingers on a channel when it has been selected for other reason=
s,
which would fit your needs, no? Since this mechanism/process would be
closely tied to the kernel, it would be easier for it to access interna=
l
things such as locks in a sane way.

>> A bigger issue is that the process also needs to consider other muxe=
s in
>> case there is a large mux tree on the root adapter. So, I think it n=
eeds to
>> be a central process connected to the root adapter, and not somethin=
g local
>> to the mux for it to be generic? This seems to get nastier the more =
I think
>> about it...
>>
>> *time passes*
>>
>> I realize that in the large mux tree case, your code doesn't work ve=
ry
>> well at all. I.e. if you have
>>
>>            dev1
>>           /
>>       mux1      dev2
>>      /    \    /
>>  root      mux2
>>      \         \
>>       etc       dev3
>>
>> then accesses to dev1 will flip mux1 and prevent any slave accesses =
from
>> dev2 and dev3. I guess this just shows the fundamental fragility wit=
h the
>> approach of having multiple devices doing slave accesses to the same
>> root adapter in some ad-hoc manner. I guess you could refuse slave
>> registration in case the mux isn't sitting directly on the root adap=
ter,
>> but I don't know how to detect and prohibit slave accesses from para=
llel
>> muxes on a root adapter.
>=20
> In general my proposal has a number of limitations that you've highli=
ghted.
> It might not (and trull it is not) fit generic application with any p=
ossible
> tree structure. I faced only HW design where there is only one i2c sw=
itch
> per adapter bus. No nestings.
> If it is required to have more channels, then one more i2c adapter's =
bus is used.

And when you run out of adapters?

I'm simply reluctant to add code that may hinder future development
of something generic.

Cheers,
Peter
