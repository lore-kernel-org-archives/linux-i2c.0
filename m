From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 3/9] I2C: i2c-ocores: Can add I2C devices to the bus
Date: Fri, 05 Jun 2009 16:40:15 +0200
Message-ID: <87k53qyca8.fsf@macbook.be.48ers.dk>
References: <4A292050.7010602@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A292050.7010602-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org> ("Richard =?utf-8?Q?R?=
 =?utf-8?Q?=C3=B6jfors=22's?= message of "Fri\, 05 Jun 2009 15\:40\:32
 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Richard" =3D=3D Richard R=C3=B6jfors <richard.rojfors.ext@mocean=
-labs.com> writes:

 Richard> There is sometimes a need for the ocores driver to add
 Richard> devices to the bus when installed.

 Richard> i2c_register_board_info can not always be used, because the
 Richard> I2C devices are not known at an early state, they could for
 Richard> instance be connected on a I2C bus on a PCI device which has
 Richard> the Open Cores IP.

 Richard> i2c_new_device can not be used in all cases either since the
 Richard> resulting bus nummer might be unknown.

 Richard> The solution is the pass a list of I2C devices in the
 Richard> platform data to the Open Cores driver. This is useful for
 Richard> MFD drivers.

 Richard> Signed-off-by: Richard R=C3=B6jfors <richard.rojfors.ext@moce=
an-labs.com>

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

--=20
Bye, Peter Korsgaard
