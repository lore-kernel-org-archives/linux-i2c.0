From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
Date: Mon, 03 Oct 2016 12:50:27 -0700
Message-ID: <87int9nrek.fsf@eliezer.anholt.net>
References: <1464818845-5348-1-git-send-email-eric@anholt.net> <20160704003118.GA1381@tetsubishi> <87lh1ip653.fsf@eliezer.anholt.net> <20160722072740.GG1605@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160722072740.GG1605@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Wolfram Sang <wsa@the-dreams.de> writes:

> On Sun, Jul 03, 2016 at 06:02:32PM -0700, Eric Anholt wrote:
>> Wolfram Sang <wsa@the-dreams.de> writes:
>>=20
>> >> +	/*
>> >> +	 * SMBUS says "Devices participating in a transfer will
>> >> +	 * timeout when any clock low exceeds the value of
>> >> +	 * T_TIMEOUT,MIN of 25 ms."
>> >> +	 */
>> >
>> > SMBus has that timeout, but I2C doesn't. How about disabling the timeo=
ut
>> > simply? Or using the max value if you want to keep the timeout
>> > detection?
>>=20
>> Disabling the timeout seems fine to me.  We still have a 1-second
>> timeout around the entire transfer.  I'll be back on my DSI branch this
>> week and test it out then.
>
> Did it work?

Sorry for the long-delayed feedback: It turned out that the reason I was
getting timeouts and looking into i2c in the first place was that the
firmware was driving that controller behind my back, so I couldn't do
useful testing anyway.

I put together a patch
(https://github.com/anholt/linux/commit/894200276239d2e4c60b378bdc52164fcb1=
3af8d)
but I'm a bit concerned by it: I don't see a way to get the controller
back to its idle state without continuing through the I2C state machine,
and if the clock is still being stretched it doesn't continue unless CLK
is triggered.

What is supposed to happen when adap->timeout times out while the clock
is being stretched?  Should we be able to try starting a fresh new I2C
transaction cleanly?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX8raDAAoJELXWKTbR/J7oJdwP/if5ubdJw9HWZ/w5H9Kp2Unf
4cP08OISk5SZGAk1Sj+7Fi1+adRWKwkUXxnWnhVmudc+lexdS9stN6IEvEMzpuGE
1gKLZ+U8n+rAI1nkQe28a2fbLJOLEyE30PNLt4kqVrgiC75WYqGHQ2i+eRZCZmAu
hng7LNyyACPYrUOyM9JyWMMNhBEPzqleO5ZHiL0lEvpf6OIbw+/g/iKHBtqnW3Gu
Mpk0riTmHgc2b/i/Um3Wd2/zzW/Ao/+HBv21kzNpd7sHBphmRDLNz8BtAJHS51mp
yJUzC7+gkKDgnr8wJ9Rz1fyP1cl3Ffwp0NFnf4ejfOehWzzo3gAmZqeLTce6VhZI
Z7wkHi4FpdiBvOZAF0de0ylJA/DsbUx89tGuW60BbmQcEKIK5vZRkiVhqVQvnQK8
IK5iozev6iwTyPTTB9v199uRgmM2jszOXyJ5Np7VzvyH2gXfhAGbRv2NPEFV9YaG
csDH8kpnK+JojQTcP9JoyMyS27XTFxYvi860ygCvZzXd5iMsAhC6kA0bR4AEV3y1
wINE5y5veVRbJAfricKq0wMqMaW0Qijw3oopjDcnfbU6DWGOb2ZMjCvFy+bpOl2Y
QRsjV5H+wZWFCfQax9QLbx6mmwjU+hY6tWBHl7IXA65/qdYhzNhpeYgNEqCT320I
blv1laNkmHIMZ0YPs4Mu
=WjdL
-----END PGP SIGNATURE-----
--=-=-=--
