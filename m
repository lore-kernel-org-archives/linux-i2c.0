From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay
 enabling irqs
Date: Wed, 25 Jan 2017 01:17:30 -0800
Message-ID: <d9e92666-0c92-891d-7481-1800f5b4efac@gmail.com>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-6-git-send-email-preid@electromag.com.au>
 <312e32e9-a828-d692-895b-4042729e5417@axentia.se>
 <61c38233-abf2-df31-6f7c-c4214f4103aa@electromag.com.au>
 <71f756e1-4677-8b59-81a2-2b12fbf12621@axentia.se>
 <35c35708-3bbc-88d1-1d60-4faf68ca5af9@electromag.com.au>
 <CAAVjN7eGNsQOPiy0HuDq26MPNrD0xk7uxiN2+UO=hyuCSBa5nw@mail.gmail.com>
 <f203f28f-51c8-a7a0-6e82-16d587310be9@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ChXneUs9Ji26a1xuhIrTUsm2elvBd4Du6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f203f28f-51c8-a7a0-6e82-16d587310be9-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ChXneUs9Ji26a1xuhIrTUsm2elvBd4Du6
Content-Type: multipart/mixed; boundary="TscwxUJALXwHICfcKbsLUWh7Mt2hG8cWW";
 protected-headers="v1"
From: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <d9e92666-0c92-891d-7481-1800f5b4efac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay
 enabling irqs
References: <1484640029-22870-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
 <1484640029-22870-6-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
 <312e32e9-a828-d692-895b-4042729e5417-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
 <61c38233-abf2-df31-6f7c-c4214f4103aa-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
 <71f756e1-4677-8b59-81a2-2b12fbf12621-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
 <35c35708-3bbc-88d1-1d60-4faf68ca5af9-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
 <CAAVjN7eGNsQOPiy0HuDq26MPNrD0xk7uxiN2+UO=hyuCSBa5nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <f203f28f-51c8-a7a0-6e82-16d587310be9-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
In-Reply-To: <f203f28f-51c8-a7a0-6e82-16d587310be9-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

--TscwxUJALXwHICfcKbsLUWh7Mt2hG8cWW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/25/2017 12:15 AM, Peter Rosin wrote:
> On 2017-01-25 04:50, Danielle Costantino wrote:
>> On Mon, Jan 23, 2017 at 1:02 AM, Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org> w=
rote:
>>> On 20/01/2017 06:56, Peter Rosin wrote:
>>>> On 2017-01-19 08:48, Phil Reid wrote:
>>>>> On 18/01/2017 20:19, Peter Rosin wrote:
>>>>>> On 2017-01-17 09:00, Phil Reid wrote:
>>>
>>> [snip]
>>>
>>>
>>>>>> Hmm, this whole thing is fiddly and while it solves your problem i=
t doesn't
>>>>>> allow for solving the more general problem when there are "problem=
atic"
>>>>>> devices mixed with other devices. At least, I don't see it. And th=
e
>>>>>> limitations we are walking into with tracking number of enables et=
c suggests
>>>>>> that we are attacking this at the wrong level. Maybe you should tr=
y to work
>>>>>> around the hw limitations not in the pca954x driver, but in the ir=
q core?
>>>>>
>>>>> I'm looking at the option of getting the hardware changed to not ro=
ute
>>>>> the irq for my chips thru the i2c mux. Fortunately the hardware is =
going thru a
>>>>> revision for some other changes. Messing with the irq core sounds d=
angerous
>>>>> with my level of knowledge.
>>>>
>>>> Yeah, but I bet you'd get some attention from people with more irq
>>>> experience. That can't be bad :-)
>>>>
>>>>> The other way I think I can tackle it after reading the datasheet f=
or the ltc1760 is that
>>>>> it'll deassert it's irq (smbalert) line when the host sends a ARA r=
equest on the bus segment.
>>>>> There's a driver in the kernel for this already, but it's not DT en=
able and doesn't
>>>>> handle multiple bus segments. I'll have a look at that as well.
>>>>> Pretty sure it would need the mux to become an irq parent as per pa=
tch 1-3 of this series.
>>>>> This would be so the system can figure out which segment to do the =
poll on.
>>>>
>>>> Yeah sounds neater. It has the slight drawback that it may not work
>>>> for pure i2c buses since it an SMB thing??
>> If you need to send SMBus commands like ARA, you should be using an
>> SMBus 2.0+ compatible bus multiplexer. muxes like the pca954x do not
>> automatically select the bus segment that the ARA is destined for. It
>> usually is more efficient to only request the data you need from each
>> device, rather than checking every segment on each interrupt for the
> We are not talking about checking every segment on every interrupt, we
> are talking about checking the segments indicated by the INTx bits in
> the control register.
>
>> cause, one could implement a delayed worker to schedule
>> checking+clearing the interrupt at a time when the bus is selected for=

>> use by another slave device on that segment when possible. This will
>> reduce the number of bus setup operations per transfer to slaves on
>> deeper busses, reducing your i2c latency.
> i2c traffic scheduling does not exist in linux to the best of my knowle=
dge,
> it's all handled with a simple mutex AFAIK. So, while traffic schedulin=
g
> is an interesting problem, I think it is out of scope at this time.
>
> If you happen to have a pca954x mux (with irq support) and happen to
> have devices behind it that needs ARA support, I just don't see how any=

> of the above is relevant. Yes, it could be more efficient to have the
> hardware done differently, but that is in many cases not a possibility.=

> You have to make do with what you have, and if that costs latency, then=

> there is little to do about that. You only have to make the new stuff
> optional so that old working setups don't suffer.
Yes traffic scheduling of I2C transactions is out of the scope of the
current problem but I thought that it may be useful to bring it up.
>>>> BTW, why do you need special treatment for multiple segments? Will i=
t not
>>>> simply have an ARA appear on whatever i2c bus the device sits on? An=
d if
>>>> something requests to send an ARA message on a bus that happens to b=
e a
>>>> muxed segment, my mental picture is that the mux will be operated as=
 usual
>>>> so that the ARA appears on the muxed segment. Maybe I'm missing some=
thing?
>>>
>>> My think was the following.
>>> When the SMBALERT is asserted a ARA needs to be sent by the master.
>>> If the device sending the SMBALERT is behind a mux when need to know =
which segment of the bus to enable.
>>> Using shared interrupts should work I think, but you have to iterate =
thru each bus segment.
>>> If the alert device is nested behind a couple of muxes this could get=
 expensive.
>>> But yeah otherwise I think the correct mux segment will get enabled a=
utomatically.
>>> The current SMBALERT driver only seems to attached to the root i2c ad=
apter.
>> Using ARA in a multi mux environment is very expensive, setting up
>> each mux segment and then sending ARA will consume more time than it
>> would take if the mux structure was optimized to service devices on
>> similar busses, reducing the setup operation count. ARA was only
>> implemented on the root bus due to the design of the arbiter and mux
>> cannot guarantee that you are the only owner of the bus when you are
>> disconnected.
> ARA handling should take the irq register of the pca95x into account an=
d
> only send ARAs to indicated mux segments. If more than one segment need=
s
> servicing, then of course one ARA for each segment needs to be sent. If=

> someone builds hardware like this and then expect no latency, that some=
one
> will hopefully at least learn something.
>
> I do not know how this fits with the existing ARA handling (it probably=

> doesn't), but what needs to happen is fairly easy to picture.
>
>>    You would also need to handle the cases where segments
>> lock up and must be released using the bus reset mechanism, this
>> resets the IRQs as well. The added cost of a I2C read to coincide the
>> write operation to the mux when the irq pin is asserted is
>> unacceptable for low latency applications.
> I bet there are a lot of corner cases, and yes, this added cost has to =
be
> optional. Perhaps with each mux child segment opting in for ARA support=
?
> If a mux then has a way to determine that an ARA isn't needed for some =
of
> its child segments (by reading some status register), then linux is fre=
e
> to not send ARAs there. And more importantly, if no mux child segment o=
pts
> in for ARA support, it should be possible to preserve current behavior.=
=2E.
I agree with making ARA handling for child bus segments optional based
on the need of ARA or other SMBus features. We have needed IRQ support
for muxes for a while now, I was always concerned about dead locks
between setting up the bus and servicing the IRQ. The current patch v6
0/3 appears to handle child IRQs without selecting the bus associated
with it. Is the plan to have the irq handling of the child require an
i2c transaction on its registered bus, which will in turn select that
bus? I also thought i2c transactions were not allowed inside an IRQ
handler? Could a delayed work struct could be used to fire off the read
transaction that would then trigger the nested IRQs (based on the set
bits)? Also the PCA954x has an internal OR of the INT signals coming
into it, not an AND like the patch says. Before allowing IRQs to be
handled by the assertion of the active low INT out signal from the
PCA954x all child interrupts must be de-asserted else the IRQ will
always be set. You could read the value of the interrupt register to see
if all bits are clear before allowing unmasking of the devices interrupts=
=2E
>
> Cheers,
> peda
>



--TscwxUJALXwHICfcKbsLUWh7Mt2hG8cWW--

--ChXneUs9Ji26a1xuhIrTUsm2elvBd4Du6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAliIbTQACgkQydVmv66v7jM4XgD+LsjaRjShK25kkVmvGo1kzbhu
pzmjsAsJDfQG/TFfmeoBAOZ7G9ugJ0B6lYvn3RgssTigM+SJyMHtBRIbM97Wsg3p
=M2GV
-----END PGP SIGNATURE-----

--ChXneUs9Ji26a1xuhIrTUsm2elvBd4Du6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
