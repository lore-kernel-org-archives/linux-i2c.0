From: Matthias Urlichs <matthias-+qxcz+fHsVSELgA04lAiVw@public.gmane.org>
Subject: State of arbitration and =?utf-8?b?aTJjX2dwaW8/?=
Date: Mon, 16 Jul 2012 15:15:29 +0000 (UTC)
Message-ID: <loom.20120710T223443-322@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello people,

I'd like to ask whether anybody is working on adding arbitration suppor=
t to
i2c_algo_bit.c. The code still has the old "FIXME do arbitration here" =
comments,
added five years ago when the I=C2=B2C was imported into Linux 2.3.34pr=
e1. :-/

If not, and I'm going to have to do that myself =E2=80=A6 my main quest=
ion is, even
before I get to that -- how do I even detect that the bus is idle? Turn
interrupts off and busy-loop-check that both SCL and SDA stay high for =
at least
one and a half clock periods?

Ugh.

--=20
-- Matthias Urlichs
