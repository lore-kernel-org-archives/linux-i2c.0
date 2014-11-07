From: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Fri, 7 Nov 2014 12:05:37 -0500
Message-ID: <CANQojO5DuiVaNg=awJEj4C6SNDUyp=rXO=_YTuWikkE=jMVtDA@mail.gmail.com>
References: <CANQojO4jbSM=03WfJtw-iSNfexBNSt6GwRLpVSmBx_KrAa0bWQ@mail.gmail.com>
	<20130806192228.GB8246@roeck-us.net>
	<CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
	<52026530.2080301@roeck-us.net>
	<CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
	<20130807174801.GB1862@roeck-us.net>
	<CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
	<20130807192556.GA31395@roeck-us.net>
	<20140807101147.34087264@endymion.delvare>
	<CANQojO4sCTmPaV7joQS4=XdifRx61q1Ac0xcdgJ-MW_URN1A=A@mail.gmail.com>
	<20141105112217.0e1925f3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141105112217.0e1925f3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 5, 2014 at 5:22 AM, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
>> Gentoo stabilized 3.16 a couple weeks ago, and I just realized "oh
>> yeah, I forgot to follow up with the i2c guys".  3.16.5 works withou=
t
>> reverting commit 6676a847.

Okay, so I guess I spoke too soon.  Using 3.16.5, the sensors can be
read for a little while after boot (anywhere from 20=E2=80=9350 minutes=
), and
then it locks up again: any process that tries to read the sensors
gets stuck in disk-wait.

But using the debug version of the i2c-i801.c that Jean linked to
above, I was able to figure out the problem.  It's in
drivers/i2c/busses/i2c-i801.c:386 (line number in commit 7cfc183b3d63,
which is the latest GIT commit at the time I'm writing this):

wait_event(priv->waitq, (status =3D priv->status));

The debug version uses wait_event_timeout() instead of wait_event().
It looks like this call hangs about once an hour at irregular and
unpredictable intervals, because the debug version dumps the following
message into the kernel logs:

Nov 07 10:04:03 jens kernel: i801_smbus 0000:00:1f.3: Timeout waiting
for interrupt!
Nov 07 10:04:03 jens kernel: i801_smbus 0000:00:1f.3: Reg dump: STS=3D4=
2
CNT=3D08 CMD=3D81 ADD=3D5d DAT0=3D40 DAT1=3D00 BLKDAT=3D00
Nov 07 10:04:03 jens kernel: i801_smbus 0000:00:1f.3: Reg dump: PEC=3D0=
0
AUXSTS=3D00 AUXCTL=3D00
Nov 07 10:04:03 jens kernel: i801_smbus 0000:00:1f.3: Transaction timeo=
ut
Nov 07 10:04:03 jens kernel: i801_smbus 0000:00:1f.3: Failed
terminating the transaction

This error shows up about once an hour, at irregular and unpredictable
intervals.  The stock kernel doesn't have the timeout, so I infer that
that's what causing it to hang.

I'm not sure what's actually causing the "timeout waiting for
interrupt"; I hope you guys can figure that out from the dumped
registers.  At the very least, it looks like we need to work around
buggy hardware by using wait_event_timeout().

--=20
Soren Harward
