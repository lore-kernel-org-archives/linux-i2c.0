From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: Problem with multiple i2c multiplexers on the same bus
Date: Fri, 31 Oct 2014 22:03:02 +0100
Message-ID: <20141031210301.GA4169@katana>
References: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAB0SmAFZ5KPpeSbQia9kq668G5kE6hpw9eBRy=59U6GOymkj9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 27, 2014 at 11:46:01AM -0700, Martin Belanger wrote:
> This is regarding a series of emails between Guenter Roeck and Jean
> Delvare titled "Problem with multiple i2c multiplexers on one bus, and
> mux bus naming" sent in November 2013. Ref:
> http://thread.gmane.org/gmane.linux.drivers.i2c/16980

Please CC those people then, too. That helps getting their attention.
I've done this now.

> I'm having the same problem with multiple PCA954x multiplexers on the
> same bus and there is no way to tell them apart just by looking at the
> "name" file.
>=20
> There was a suggestion to change the name from "i2c-N-mux (chan_id M)"
> to "i2c-N-mux-XX (chan_id M)" or even "i2c-N-mux-i2c-XX (chan_id M)",
> where XX is the multiplexer's i2c address. That would solve my
> problem, but unfortunately it looks like Guenter never submitted the
> patch (or maybe it was rejected?).

It just dropped off :( But you guys have my attention now, let's fix
this issue for 3.19! I am just reading through the old mails and will
think about it. Input is welcome.

> I would like to submit a similar change, but I was thinking of adding
> a module parameter so that the change is not the default behavior.
> The idea is to preserve backward compatibility for applications that
> don't require this fix. For example, modprobe i2c-dev
> explicit_mux_id=3D1 would use i2c-N-mux-i2c-XX (chan_id M), whereas
> modprobe i2c-dev would default to the current behavior: i.e. i2c-N-mux
> (chan_id M).

I don't like the need to set a module parameter to fix a flaw. I do
consider changing the ABI to have better strings in "name". But as said,
I need to think about it a little more...

Thanks,

   Wolfram


--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUU/kFAAoJEBQN5MwUoCm2WcUQAJWwKOi2RjR/vPoq6n23VWwh
FDaJnlygy5yU1q+oKnbnRKHT8QoWqGUkWwRAKK/tKaWGese8tmbS9htQFruJnP4k
mopaUOLdChqfowlToA152jtsyw4nPbsmtHUlDo20U8/iaIy0cwXD8JPaNm4KCjru
j21XLAbdutN7XtiDx7K0SEQu0LqCcEoUs101DpgryBv7b0671f+DeeQs9q8r+kwA
n9L2Tm9QL7vBNtrmS+fHVS8KP/b4ZgnjKml3T7sdvrPIeus1uz/e3BJgqWlORUke
7sNYTK9SD4d0sggITnKWfkZjOvTnT86fonI267DOwOllTLfxXUHYr6Me8mZF7X+h
Bf6kNxNbM3u4wuHqQ1mDmRtz9kOk1Cvy0KTFjkHpU+Hkk9jdKNgaGnco1syjVGwb
RAPeBHxNcR8etAuP1jgYdscfIuT0Lk3AtGPy5cnfMmFiVmf1LXa1TgcPN8RRyanS
PSHgS9cy1o8UuZSmwDGbOiRlGCPDdSj4sCDP46UIpMY4MC2q28n9kRjxSEMZlPwB
BpYKk/CBy0ChDamqcezS4yycaCFxcIXQ7Gboj+BXHT4k/F6MyXg+qoxw+ytSRef/
cJsbwrf0KnycTOSuM+K+fsQeZn5VRBJnBm8kCFS/MleMk5RsygWiAM76YpK1smNg
Af/W1ZjV0VAQMU/wSvry
=+T9m
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
