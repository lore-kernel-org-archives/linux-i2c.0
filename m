From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: Re: [RFC] i2c: designware: Avoid initcall and initialize the driver
 like a regular one
Date: Tue, 23 Dec 2014 12:32:42 -0300
Message-ID: <54998B1A.9020208@vanguardiasur.com.ar>
References: <1419272149-28716-1-git-send-email-walter@vanguardiasur.com.ar> <20141222190233.GA1014@katana> <549982BE.3080500@vanguardiasur.com.ar> <20141223152621.GA3692@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mC0of0Pq1V06bNOXOkgt4I8UjVO1fXauW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141223152621.GA3692@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Walter Lozano <walter-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mC0of0Pq1V06bNOXOkgt4I8UjVO1fXauW
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/23/2014 12:26 PM, Wolfram Sang wrote:
>=20
>>>> This guarantees it will probe after GPIOs drivers.
>=20
> BTW this is not true to the best of my knowledge. It will make that
> "very likely" but not "guarantee" anything. So, the race window is
> smaller but it is still there. You need a proper fix anyhow.
>=20

Right.

>>>> Platforms based on devicetree won't be affected by this change.
>>>
>>> Huh, why is that?
>>>
>>
>> Unless I'm missing something here, our beloved DeviceTree guarantees t=
o
>> model the dependency between I2C slaves devices and the I2C master the=
ir
>> connected to.
>=20
> Frankly, you are missing quite some things here. The I2C core registers=

> the clients when a master gets registered. No difference between
> platform and DT here.
>=20
>> So, a machine fully-based on DeviceTree would never attempt to use the=
 I2C
>> bus without first registering the master, right?
>=20
> Neither would platform, that would be quite a bug.
>=20
>> This means there won't be any early users of the I2C platform driver i=
n this
>> scenario.
>=20
> There won't be with platform as well.

Oh, OK. Then maybe you can clarify why all those i2c busses need to be
registered with initcall in the first place?

> But I think you are missing the
> point. We are a *consumer* of GPIOs here. All of the above has nothing
> to do with GPIO controllers being already available.
>=20

Hm, true. I was missing the fact that probe call order does not
guarantee a succesful probe order.

>>>> Legacy platforms, relying on the I2C being available early, might ne=
ed
>>>> to implement proper defered mechanisms to overcome potential problem=
s.
>>>
>>> NAK. We can't say "Let's cause a regression to force people to fix
>>> things that used to work" IMO. You exactly pointed out the problem th=
at using
>>> subsys_initcall() creates.
>>>
>>> What about fixing the drivers you use to support deferred probing whe=
n
>>> acquitin the irq?
>>>
>>
>> Maybe we can fix the legacy ones instead. However, a quick look shows =
there
>> aren't any!
>>
>> $ git grep i2c_designware
>> drivers/i2c/busses/i2c-designware-pcidrv.c:MODULE_ALIAS("i2c_designwar=
e-pci");
>> drivers/i2c/busses/i2c-designware-platdrv.c:MODULE_ALIAS("platform:i2c=
_designware");
>> drivers/i2c/busses/i2c-designware-platdrv.c:            .name   =3D "i=
2c_designware",
>>
>> Looks like this patch is pretty harmless.
>=20
> In-tree you are right. Out-of-tree, you probably aren't. I wouldn't car=
e
> about the latter if that would block a real bugfix. But since the above=

> patch is not the proper fix IMO, I prefer being stable here.
>=20

Fair enough.

Thanks for the feedback,
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar


--mC0of0Pq1V06bNOXOkgt4I8UjVO1fXauW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUmYsjAAoJEIOKbhOEIHKiho8QALpxL91TydJ1OSclPZVR2Ts9
ZJk+uGjsZYaMy0cYBQ/Vok7hze/syfWuseewrTX+ImlGjtcTy/DwOs0GV2T97CiO
oCK6alzM40kETkzG7gqgZZzAFq820lrJdkMN6xEkjQHt2zD2p8jyfvjFVv1YZde+
+qm2TSvlFtQdPib8ps2U4sUKx8ydBHJHKiaMJ/an2ceV9HJRzWF5jXUqtt/moxJh
8XRZMwgtmKaz4AVuA2SJ5xBk0DoPAMLa8ljxaMsrAVUaRAzDFiyaiHWVJsQsf215
+AlQYgO+swcoJMirt+SeV2WGc5Zo6I6ix9DqMf0ZEDpDTqMrdNjlZgzRg11ditZN
ZhLx/hHzB6EzWr9Ey4ymeulUhw8hYWaYobuhn71OuNQcwknxDM3Z6+Ji9ypPZnkt
SWioNgXTOduRcVAfIZ+H9gDrq5aO1hSCm7m9ktsJmrr8Mnylq3T5B9ggJy2vrFHO
PDrNF6+XdWhs4yk6TLiuQtG4Y5jixD+B0fML3HjpfDszBXfmHk1WHpo/UsFZpjWx
t9zu7MSxu/C566NoufJiAMt/R0gBN02UOk8eaPoZ4tBCYwVgH9OoSzKIxTZiYAV6
KjkXBz7k6MQs0gKcSEIx/L5BhYBoE4pjBcV6fl/LvWVyJ4UTjaQUN99rGLW3hx1k
b/fQ7/ne+vbC0v+Ht6kl
=nvzF
-----END PGP SIGNATURE-----

--mC0of0Pq1V06bNOXOkgt4I8UjVO1fXauW--
