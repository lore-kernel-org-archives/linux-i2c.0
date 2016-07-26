From: Peter Rosin <peda@axentia.se>
Subject: Re: i2c: slave support framework improvements
Date: Tue, 26 Jul 2016 11:50:03 +0200
Message-ID: <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
References: <137031469256709@web4j.yandex.ru> <20160723195114.GA2104@katana>
 <27421469430128@web19h.yandex.ru> <20160725072151.GA1599@katana>
 <354241469432837@web19h.yandex.ru> <20160725082813.GA3376@katana>
 <1025301469437877@web19h.yandex.ru> <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:18438
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757053AbcGZPV7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Jul 2016 11:21:59 -0400
In-Reply-To: <1391831469440835@web19h.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kachalov Anton <mouse@mayc.ru>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2016-07-25 12:00, Kachalov Anton wrote:
> You are welcome.
>=20
> In my implementation in PCA954x I did the following things that I wou=
ld like to highlight:
>=20
> 1. handle slave register and store i2c_client data to the internal ar=
ray
> (length equal to number of channels). First obstacle =E2=80=93 get th=
e right offset in
> the array (channel number). It's better to expose "chan_id" field fro=
m
> i2c_mux_priv as a public function. I did a hack during init by writin=
g down
> first muxc->adapter's number ("nr" field store in private adap_off).

The i2c-mux.c file is not sacred, nor set in stone, just add the access=
or
if you need it. (But the function would be kind of dangerous as there i=
s
no way that I know of to verify that the passed adapter is in fact a mu=
x
child adapter. So, if you'd pass something else, you'd get to keep all
the pieces...)

HOWEVER, chan_id is not necessarily the same as the index into the
muxc->adapter array. The index in the muxc->adapter array is just the
order in which the mux child adapters were registered, and bears no
relation to the chan_id. At least none that can be relied upon.

So, a better (but totally different) addition to the mux core might be
to add a function to set the reg_slave and unreg_slave pointers in
i2c_mux_priv->algo, instead of copying the whole algo struct.

Another thing is that it seems that data->last_chan represents the same
thing as your new variable data->cur_chan, but in a different form (bit=
mask
vs. enumeration), and they are not always kept in sync. Please use just
one variable to prevent nasty surprises, as two variables are bound to =
get
out of sync.

> 2. during handling of select_chan I'm trying to register new i2c dumm=
y
> device with newly selected slave addr corresponding to the channel
> number (if it has a slave). This is the second problem =E2=80=93 afte=
r I've registered
> dummy device with some slave address, I'm not able to register slave
> devices for other mux'ed busses with the same slave addr. In other wo=
rds,
> I have to populate all the slave devices (with the same slave addr)
> right before I'm going to use the bus first time.

That description doesn't really match the code (or maybe I'm misunderst=
anding
or the code has changed or something). What do you mean that you have t=
o
populate all the slave devices beforehand? The code only creates one du=
mmy
device and reuses that one for all "slave proxying".

Anyway, one thing that I do not like about that code is that it, on mux
changes, clobbers dummy->addr before the slave proxy in unregistered. I=
t's
not really pretty to clobber it at all, but it would feel better if the=
 addr
was only clobbered when the slave was not registered.

I'm also a bit surprised that you are allowed to create a new (dummy) d=
evice
with an address that is already taken on a downstream mux client adapte=
r.
Is that a feature in the i2c core, or is it a bug? Wolfram?

> 3. registering and/or unregister first (if applicable) slave device o=
n the parent
> bus adapter. This is the third obstacle. While the bus is already loc=
ked,
> calling generic i2c_slave_{register,unregister} lead to the deadlock.
> I did it directly via the reg_slave/unreg_slave calls of appropriate =
data structure.

BTW, your open-coded unlocked versions of i2c_slave_register and
i2c_slave_unregister do not handle errors and skips some tests. Maybe a=
dd
unlocked versions to i2c-core.c instead? Also, why do you need to forbi=
d
10-bit addresses in pca954x_reg_slave? Is that a property of the mux, o=
r
is it really a property of your root adapter?

> Notes:
> Slave works only with keeping channel selected while generic i2c-mux =
logic
> is to deselect channel after each i2c transfers.
>=20
> 25.07.2016, 12:41, "Wolfram Sang" <wsa@the-dreams.de>:
>>>  There is no way to switch mux and request to BMC #2. Logically, th=
is shouldn't
>>>  happen too.
>>
>> I see. I think I have the big picture now, thanks for the heads up.
>>
>> However, I am not sure what recommendations I can give to you. I'd s=
tart
>> with adding reg_slave to the muxed adapters and then try to reconfig=
ure
>> the real adapter when the mux switches (I assume you did that alread=
y).
>> But I don't have the bandwidth to dive into that and see what gory
>> details come up. Maybe Peter Rosin has something to add, though?

The whole thing seems a bit fragile, as Wolfram already stated...

Let me see if I got how this works; You have some process that accesses=
 some
device on the different mux segments, with some amount of time between =
each
access. The mux leaves the segment selected after this access. During t=
his
time slot, when the mux segment is selected but idle, there might come =
in a
slave access from that mux segment.

This all depends on the external process that round-robins the mux. I d=
on't
like that. It should be some system process with a much closer tie to t=
he
kernel (maybe it should be in-kernel?) that is responsible for the
round-robin of the mux. And, AFAIU, there is no need for any access to =
the
child side of the mux to enable these slave accesses, this process may =
just
flip the mux selection and that should be enough, no? This process can =
also
step past any mux segments that do not have any slave registered so tha=
t
the waiting time can be reduced, and it can be completely disabled if t=
here
are no slaves registered.

A bigger issue is that the process also needs to consider other muxes i=
n
case there is a large mux tree on the root adapter. So, I think it need=
s to
be a central process connected to the root adapter, and not something l=
ocal
to the mux for it to be generic? This seems to get nastier the more I t=
hink
about it...

*time passes*

I realize that in the large mux tree case, your code doesn't work very
well at all. I.e. if you have

           dev1
          /
      mux1      dev2
     /    \    /
 root      mux2
     \         \
      etc       dev3

then accesses to dev1 will flip mux1 and prevent any slave accesses fro=
m
dev2 and dev3. I guess this just shows the fundamental fragility with t=
he
approach of having multiple devices doing slave accesses to the same
root adapter in some ad-hoc manner. I guess you could refuse slave
registration in case the mux isn't sitting directly on the root adapter=
,
but I don't know how to detect and prohibit slave accesses from paralle=
l
muxes on a root adapter.

Cheers,
Peter
