From: Danielle Costantino <danielle.costantino@gmail.com>
Subject: Re: i2c-mux adapter names not unique
Date: Mon, 13 Mar 2017 23:46:32 -0700
Message-ID: <275e8255-0728-add7-f737-70708f423229@gmail.com>
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
 <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
 <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
 <CAAuRgKDJBoQ8v6a=nOpcVDYOeycgP+WayRhXG7YNzt0pjXphxA@mail.gmail.com>
 <152b649c-76c0-9541-4159-43ad77b14469@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KXoO9vn03mJ5Twij8d5iQDSVHuJItcqwD"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36811 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdCNGqu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 14 Mar 2017 02:46:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id 25so22390939pgy.3
        for <linux-i2c@vger.kernel.org>; Mon, 13 Mar 2017 23:46:49 -0700 (PDT)
In-Reply-To: <152b649c-76c0-9541-4159-43ad77b14469@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, MikeB <mabnhdev@gmail.com>
Cc: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KXoO9vn03mJ5Twij8d5iQDSVHuJItcqwD
Content-Type: multipart/mixed; boundary="vIh4lgElofP0nQdR1smOqeX6RBt6uJsk0";
 protected-headers="v1"
From: Danielle Costantino <danielle.costantino@gmail.com>
To: Peter Rosin <peda@axentia.se>, MikeB <mabnhdev@gmail.com>
Cc: linux-i2c@vger.kernel.org
Message-ID: <275e8255-0728-add7-f737-70708f423229@gmail.com>
Subject: Re: i2c-mux adapter names not unique
References: <CAAuRgKAVRUKCYdZAH3Atn4d09OmubUZN2trNRQ4aEZkEey6WNg@mail.gmail.com>
 <0cf3f298-87ab-0dfc-9453-cc46e31d4979@axentia.se>
 <CAAuRgKAYgBjk=FhQfMsGdOB+-4ObUkYgWVb-Uu+0wgM+ORWOug@mail.gmail.com>
 <26e08683-2bdb-4c8e-bd6e-b4887bc26dc3@axentia.se>
 <CAAuRgKDJBoQ8v6a=nOpcVDYOeycgP+WayRhXG7YNzt0pjXphxA@mail.gmail.com>
 <152b649c-76c0-9541-4159-43ad77b14469@axentia.se>
In-Reply-To: <152b649c-76c0-9541-4159-43ad77b14469@axentia.se>

--vIh4lgElofP0nQdR1smOqeX6RBt6uJsk0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Using an adapter id is not a valid and deterministic method for
identifying a i2c bus. The way you can identify what adapter you need to
bind to is by identifying the unique parent device that hosts the
adapter (pci, platform, usb, ....) and identifying a constant parameter
like bus id/ SN/ bus address, using this as your adapter base and
traversing the bus tree based on the channel you need to connect to your
mux. Take a look at the work done with lsi2c and i2cdev.
https://github.com/costad2/i2cdev

Good luck,

Danielle


On 03/13/2017 02:01 PM, Peter Rosin wrote:
> On 2017-03-13 16:05, MikeB wrote:
>> On Mon, Mar 13, 2017 at 10:48 AM, Peter Rosin <peda@axentia.se> wrote:=

>>> And why not fix the bad assumption in OpenSwitch instead and kill the=

>>> generic problem for every kind of adapter? Limiting yourself to a
>>> band-aid for i2c-mux adapters seems short-sighted and not very helpfu=
l
>>> for the next victim of this OpenSwitch problem...
>>>
>>> Note that you do not need two muxing levels to get duplicate names li=
ke
>>> this, it's enough with two parallel multiplexers on the root adapter.=
 Or,
>>> of course, two AT91 adapters (or similar, i.e. with a fixed name).
>> If I thought that OpenSwitch's expectation of Linux to name unique
>> adapters uniquely, I would push for a change in OpenSwitch.
>>
>> I personally think Linux's naming convention is a short-sighted and
>> insufficient which is why I came to Linux first.
>>
>> I don't want a short-sighted band-aid which is why I asked the
>> original question.
>>
>> I'll try elsewhere for a solution...
> That's probably best, since if we do change the adapter naming conventi=
on
> to something that is unique and stable across reboots (which presumably=
 is
> what is sought, and BTW probably not a trivial problem) some other pers=
on
> is going to suffer a regression when OpenSwitch fails to associate with=

> the intended adapter after a kernel update. I.e. the very fact that
> OpenSwitch is already using this interface makes it harder to change. A=
nd
> who knows, maybe there are other users that will suffer if naming is
> changed?
>
> [Note that I know nothing about OpenSwitch, I'm just deducing the above=

> from what you have stated previously]
>
> I'm sorry, but there's not always a simple and convenient answer...
>
> Cheers,
> peda
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in=

> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--vIh4lgElofP0nQdR1smOqeX6RBt6uJsk0--

--KXoO9vn03mJ5Twij8d5iQDSVHuJItcqwD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAljHkc8ACgkQydVmv66v7jP5NwEAjxOUW4GYZfNOo/45PJnt+ZNH
xM/elUPYafG3raswBhwBAMAbCpA8gvjFJbNWERVecI69Brdx9f6kOpwWJkvcsBaV
=tFr/
-----END PGP SIGNATURE-----

--KXoO9vn03mJ5Twij8d5iQDSVHuJItcqwD--
