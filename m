From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RFC] i2c: octeon: allow receiving of signals.
Date: Thu, 11 Jun 2015 22:44:36 +0900
Message-ID: <20150611134435.GA6143@katana>
References: <1434029032-8811-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434029032-8811-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 03:23:52PM +0200, Nicholas Mc Guire wrote:
> Change wait_event_timeout() to wait_event_interruptible_timeout() allowing
> signals to be received while waiting on event (task state set to=20
> TASK_INTERRUPTIBLE) as the dev_dbg() string indicates that signals
> are expected to be possible. While at it fix the type to long (as returned
> by schedule_timeout().=20
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> ---
>=20
> From the dev_dbg string "wait interrupted" it seems that interrupts are
> expected to be on - so most likely this should be
> wait_event_interruptible_timeout() and not wait_event_timeout() as the
> later return >=3D 0 always and sets the task state to TASK_UNINTERRUPTIBL=
E.
> Someone that knows the details of this driver needs to confirm this thoug=
h.

Use 'git log drivers/i2c/busses/i2c-octeon.c' and you will find commit
2637e5fd232d421b680757944f613d4b1a36ae26 which disabled the signals.
For further digging, you could do
'git log --grep=3D"interruptible" drivers/i2c/busses' to find that signals
cause a lot of problems with i2c transactions.

Summary: The code still handling signal code simply needs to go.

Thanks,

   Wolfram


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeZDDAAoJEBQN5MwUoCm2XxMP/0ESZ0yGF9vzV8eKYLH8kfl6
5A4CmR18PwexU4VjSfcM7gXSlLPh8bfuuBqT5V/fC4KOTTB1F/LGMxdZilhdpvOY
9doxfLUwwU9OqAO/+SXJ5yRjkk9yIl1j2VuyT45jeRAo+j4kMmjLmvY5zXi7iK/j
ow2sPUoyQ8hE+pwX87mGLJy1z8ZMGx5RelZ9lGYGfStSOLLNIT6/l139DROmh9ln
YGT1FLepI9JRgxYJDPTZFXzXUAXb6tTNVcYJcS8R2YTi7Uzzgk07D7tvBWC46P9w
UnzUMdQg5wOuwWWas2FsA9pHBtQJd9S7y5H3Ys7xjBdMKUqDJi5OZGGPVqDaX2RL
PzwwM8fHEhmSpyYDIX706wqRkECB/NzckMAk/b2i6M1igt91LORxsdqH2cvWInb8
F62ppEMpL1PU8u5Oy+m0LDd1U5z5x0Bd6/D3alOnGWDSHpa/+E39nSEdM4RPvRJl
H3hWazIfwHEkvIAdpg4rLlvcNwcyya5U0OE4EG6Ug5cBzkYzOcElgAwe32UEcYQI
qrjtZ1RYDD9qPGZY0ac1SDHn2AJ0dmrTm4KzkFeEmIInC8GuieRVDgFIBuCpfmAm
MnZ/3BKd1b8gTb9QGw91PzUQeC9ANrhubwu/H7XFfRdTgJWuXAuoBY+c34OiPxtY
y+MHBlVbgQ5QFMjlis8o
=iAq3
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
