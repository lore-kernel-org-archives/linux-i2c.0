From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: davinci: Rework racy ISR
Date: Fri, 3 Apr 2015 22:15:30 +0200
Message-ID: <20150403201530.GG2016@katana>
References: <55003E64.2030701@nokia.com>
 <550191AB.8000103@linaro.org>
 <550299D5.5080000@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550299D5.5080000-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: "ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Mastalski Bartosz <bartosz.mastalski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2015 at 09:03:33AM +0100, Alexander Sverdlin wrote:
> Hello!
>=20
> On 12/03/15 14:16, ext Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org wrote:
> >> There is one big problem in the current design: ISR accesses the contr=
oller
> >> > registers in parallel with i2c_davinci_xfer_msg() in process context=
=2E The whole
> >> > logic is not obvious, many operations are performed in process conte=
xt while
> >> > ISR is always enabled and does something asynchronous even while it'=
s not
> >> > expected. We have faced these races on 4-cores Keystone chip. Some e=
xamples:
> >> >=20
> >> > - when non-existing device is accessed first comes NAK IRQ, then ARD=
Y IRQ. After
> >> >    NAK we already jump out of wait_for_completion_timeout() and depe=
nding on how
> >> >    lucky we are ARDY IRQ will access MDR register in the middle of s=
ome other
> >> >    operation in process context;
> >> >=20
> >> > - STOP condition is triggered in many places in the driver, in ISR, =
in
> >> >    i2c_davinci_xfer_msg(), but there is no code which guarantees tha=
t STOP will
> >> >    be really completed. We have seen many STOP conditions simply mis=
sing in
> >> >    back-to-back transfers, when next i2c_davinci_xfer_msg() call sim=
ply overwrites
> >> >    MDR register while STOP is still not generated.
> >> >=20
> >> > So, make the design more robust and obvious:
> >> > - leave hot path (buffers management) in ISR, remove other registers=
 access from
> >> >    ISR;
> >> > - introduce second synchronization point, to make sure that STOP con=
dition is
> >> >    really generated and it's safe to begin next transfer;
> >> > - simplify the state machine;
> >> > - enable IRQs only when they are expected, disable them in ISR when =
transfer is
> >> >    completed/failed;
> >> > - STOP is normally set simultaneously with START condition (in case =
of last
> >> >    message); only special case when STOP is additionally generated i=
s received NAK
> >> >    -- this case is handled separately.
> > I'm not sure about this change (- It's too significant and definitely w=
ill need more review & Tested-by.
>=20
> Maybe you can offer this patch the customers who suddenly cannot access t=
he devices on the bus until reboot...
> Because it's not a "bus lockup".=20
>=20
> > We need to be careful with it, especially taking into account DAVINCI_I=
2C_MDR_RM mode and future
> > changes like https://lkml.org/lkml/2014/5/1/348.
> >=20
> > May be you can split it?
>=20
> I can may be split it into two patches, but I'm not sure about the result=
=2E Each of them will only solve
> 50% of the problem and then nobody will see a clear benefit applying only=
 one. But what I can offer you is
> to spend the same effort on rebasing the "DAVINCI_I2C_MDR_RM mode" patch =
you are referring to. I can rebase
> it and take it into my series if you wish.

So, shall I take this into i2c/for-next?


--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVHvTiAAoJEBQN5MwUoCm2HZwP/3fOe0x6wy8uteB0tQ7XX8wH
3dRJ6yFP8bm9fjEnyWbAo+rLTRNb8qNYTk/E+OnJgxD9R4OFGMKxp68WDbYour4u
YiD4yrvDzNMIWXQz/na7tFNgCFBqLuLSUDoJFCxXKY4P41bd/cqnPzcZthVA+bYl
ygIN9LZN9dQipIG00ceEAC7LoHsnt70Uv+QBGtEPi/v5tPJzec1cmoMD5FfFrJoI
6QOMzXYAU7CVxBqdtltXpfbThPmj6mXUsnW8wJnVbEBGy3R14wgaAGQzH7wFQ30L
D9STqHWYKQc9v31Wf42NEQFr24oka6ZPVPuABpEhHD6sG3HfWEamLX/B5BAbtPhI
cJhfDkE1jqUZCeLRVFHKk/3pnW+LKZOlMClvggCkQ4TJpmGKBQxqDdYM/RZyq1Dd
ZVEQGusZc3/2cikAtb8oP4uKIXp1dk1K+Mde6YpaEYnU0eGl3nTgV6BVoTsj4vqH
FM1vquH//4f4MAzIFBtbIgEqRpCnT5iW/qUQBCVZRBnd8hWmpmjmE6/kr+eD6az+
6aPigIXzh4KXQZp/iF4YZ3Xl+Swuc7cKOzLlxAb1ZzO0DKLw/oGmTHtubT++eegF
HNJeM/Hw0HJza3FzKotMLgJoQft3XoNzO+TlG/PZv9T4LPzUd64Rj2fZPOaKk8io
IsWZGOLAZCSKb/4uWlSg
=wtzd
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
