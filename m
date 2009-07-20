From: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [lm-sensors] Use the Linux I2C subsystem for a two wire interface
	protocol
Date: Mon, 20 Jul 2009 01:25:29 -0500
Message-ID: <528f13590907192325m7d53ed38g42aaef9cba9d6f9e@mail.gmail.com>
References: <528f13590907140925h7aa36452o60da32d3bf941241@mail.gmail.com>
	 <4A5D6C0A.7030903@gmx.de>
	 <528f13590907150722q2a91139bve72d65cbd555b8e9@mail.gmail.com>
	 <4A5DEB12.3020602@cam.ac.uk>
	 <528f13590907151032y30ae62beo486d4e1056219983@mail.gmail.com>
	 <4A5E206F.8000001@cam.ac.uk>
	 <528f13590907160913n73dcb4fcuf09f4946d7578793@mail.gmail.com>
	 <528f13590907160929r1385c99el6c1ed16ca1b592d2@mail.gmail.com>
	 <4A5F76A8.8080001@cam.ac.uk>
	 <528f13590907171421m26bc67ecg8d0334d20365406f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <528f13590907171421m26bc67ecg8d0334d20365406f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> A very naive question at this point. Wouldnt it be possible to "not"
> use =A0a GPIO irq and bottom half and instead to simplify the driver =
to
> start with, use a synchronous read routine.? I know this may violate
> the kernel framework
I  stuck a scope, i could see the lines wiggling, but no "AC" was sent
from the sensor.
-Alfred.
