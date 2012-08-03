From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 0/2] I2C: SIS964: Bus driver
Date: Fri, 3 Aug 2012 19:07:58 +0200
Message-ID: <20120803190758.34e67b1e@endymion.delvare>
References: <1344008145-14579-1-git-send-email-amaury.decreme@gmail.com>
	<20120803180712.1e768042@endymion.delvare>
	<CAPXEm73QX7haU5p7HU+=+qo5wnivt6j+WH5bQGZ0ZK0Ek2Cuyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPXEm73QX7haU5p7HU+=+qo5wnivt6j+WH5bQGZ0ZK0Ek2Cuyw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Amaury =?UTF-8?B?RGVjcsOqbWU=?= <amaury.decreme@gmail.com>
Cc: ben-linux@fluff.org, w.sang@pengutronix.de, rob@landley.net, jeffrey.t.kirsher@intel.com, akpm@linux-foundation.org, davem@davemloft.net, gregkh@linuxfoundation.org, joe@perches.com, ralf@linux-mips.org, dirk.brandewie@gmail.com, jayachandranc@netlogicmicro.com, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 3 Aug 2012 18:36:36 +0200, Amaury Decr=C3=AAme wrote:
> > What is the rationale for not adding support for the new chip to
> > i2c-sis630 then? That would probably be a lot easier to review.
> >
>=20
> I was afraid that adding SIS964 support to i2c-sis630 would lead
> to confusion.

There's nothing confusing, drivers supporting several devices are
legion. If the devices are really almost compatible, reusing an
existing driver is the way to go.

> I can try to submit a patch for i2c-sis630. In this case, do you thin=
k
> we should keep the 630 name or change it to something else to
> avoid misunderstanding ?

Keep the name. It is very common to name drivers by the name of the
first supported device, and changing a driver name is always a source
of trouble.

--=20
Jean Delvare
