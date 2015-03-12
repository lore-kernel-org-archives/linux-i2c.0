From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/7] iio: mlx90614: Add power management
Date: Thu, 12 Mar 2015 10:30:27 +0000
Message-ID: <55016AC3.2060704@kernel.org>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com> <1424879712-28304-7-git-send-email-vianney.leclement@essensium.com> <54FDBEB7.8030403@kernel.org> <20150309164308.GA2320@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150309164308.GA2320@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?= <vianney.leclement-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Arnout Vandecappelle (Essensium/Mind)" <arnout-agwphqFHkxc@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09/03/15 16:43, Wolfram Sang wrote:
> On Mon, Mar 09, 2015 at 03:39:35PM +0000, Jonathan Cameron wrote:
>> On 25/02/15 15:55, Vianney le Cl=C3=A9ment de Saint-Marcq wrote:
>>> Add support for system sleep and runtime power management.
>>>
>>> To wake up the device, the SDA line should be held low for at least=
 33ms
>>> while SCL is high.  As this is not possible using the i2c API (and =
not
>>> supported by all i2c adapters), a GPIO connected to the SDA line is
>>> needed.  The GPIO is named "wakeup" and can be specified in a devic=
e
>>> tree with the "wakeup-gpios" binding.
>> Needs some i2c specialist input on this!  As you mentioned it is lia=
ble
>> to be controversial.  Wolfram, is this a one off special or do
>> any other devices do this sort of magic?
>=20
> s/magic/insanity/ :)
>=20
> I have never heard of something like this. Unsuprisingly, I can
> not recommend doing it this way. But we all know hardware...
>=20
> And while we could think about reusing the bus_recovery_infrastructur=
e,
> I don't think it is worth the hazzle. So, doing this GPIO fallback ma=
y
> well be the best we can do now.
>=20
=46air enough.  Lets go with this approach then and hope this is the on=
ly bit
of hardware ever to do this (yeah right ;)
