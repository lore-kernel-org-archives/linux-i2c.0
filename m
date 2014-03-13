From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS [ver
 #2]
Date: Thu, 13 Mar 2014 22:15:39 +0100
Message-ID: <20140313211539.GB2696@katana>
References: <20140306133559.29345.61422.stgit@warthog.procyon.org.uk>
 <20140306133606.29345.97103.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140306133606.29345.97103.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2014 at 01:36:06PM +0000, David Howells wrote:
> The SMBUS tracepoints can be enabled thusly:
>=20
> 	echo 1 >/sys/kernel/debug/tracing/events/i2c/enable
>=20
> and will dump messages that can be viewed in /sys/kernel/debug/tracing/tr=
ace
> that look like:
>=20
>          ... smbus_read: i2c-0 a=3D051 f=3D0000 c=3Dfa BYTE_DATA
>          ... smbus_reply: i2c-0 a=3D051 f=3D0000 c=3Dfa BYTE_DATA l=3D1 [=
39]
>          ... smbus_result: i2c-0 a=3D051 f=3D0000 c=3Dfa BYTE_DATA rd res=
=3D0
>=20
> formatted as:
>=20
> 	i2c-<adapter-nr>
> 	a=3D<addr>
> 	f=3D<flags>
> 	c=3D<command>
> 	<protocol-name>
> 	<rd|wr>
> 	res=3D<result>
> 	l=3D<data-len>
> 	[<data-block>]
>=20
>=20
> The adapters to be traced can be selected by something like:
>=20
> 	echo adapter_nr=3D=3D1 >/sys/kernel/debug/tracing/events/i2c/filter
>=20
> Note that this shares the same filter and enablement as i2c.
>=20
> Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>

Applied to for-next, thanks!


--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIh/7AAoJEBQN5MwUoCm2UD0QAKctRYUHobrs+tz/46xRLziP
s51XmvZMT53z/dQdGcw5HakxnR9p1k7sIywAW8xyC0IQyH2W8gThsiLlQ3DwBY/N
JaPLFSHxa8eQaRA2bIDvShfPA4TJrUYeFHcok7e++p9ljaaA59BJhTY8epFVjok1
AMQz1QXOexH0aBC3qBL+mUF0ZBKtMblkBaGc2Qg/ge1a9sx5agmthUIH8q0YpuG+
hrfaXSmV4nFmOFn1Umj0DJ2qFxULSLkvQJCf6TYi/w2aJ++QEK3nqvcP2MEcJ2V6
5hpTJizjAjYOA36rk1fjIhkAN/IxLkZYqWXRjuFlqE2uWus61lMmS9OO20GR1utb
W3BoGubbjWA2CeLjrYViHq9M8dYGESifnL6ktUEYHrVt7/MVBvUz7M5rHyO38WwP
hKAXYSbUY5d7nZkCY2FrdcaZoPKQHBsQGWJCsMdJSGYTuOI6d1KTbzfYPhU+6Me8
0SwJTvwBlBBpm0x9Ph5GANKuZl5yd4nWy5PqUFQ5US5SWSN3vcYUannbp8OoUyVK
21Rw/J30mGOn0tiJxKt44bzrXtYOeexO5k/s7UOl1edxEYGPush6ZDopWQSVtA4t
ZS7ytsYj2sUfSY+iZSuXShP+tq8HwypbiNonm65e6TWrjNzJODMj5w+8YMLE2zLu
Ub0hFX3NmngT8PM9Knpu
=BlAA
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
