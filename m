From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: Poulsbo I2C - /dev/i2c not seen when loading i2c-dev
Date: Fri, 8 Apr 2011 16:11:48 -0400
Message-ID: <0bd85f87b0023c4c1cd417a732789f36.squirrel@host171.canaca.com>
References: <fb407773c6a76f3ffef06ff357df2118.squirrel@host171.canaca.com>
    <20110401121027.49ce012b@endymion.delvare>
    <b9ff3e86cbf2aa2c34f614adf80e7ffb.squirrel@host171.canaca.com>
    <22a6003c213a91452d2a7312e4e5ad32.squirrel@host171.canaca.com>
    <20110406192059.369c3143@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110406192059.369c3143-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


>> I got a bit further, if I boot the device with the 'acpi=off' kernel
>> option then I can modprobe both lpc_sch and i2c_dev, at which point
>> i2c-detect works fine.
>
> As expected. but acpi=off is a little harsh. acpi_enforce_resources=no
> would work too, and is less risky.

Jean & I both (independantly) knocked up quick patches to 'lpc_sch' to
allow it to load should any of the subsystems (GPIO or SMBus) load OK - it
was previously failing at the first subsystem failure. This gave me access
to the I2C controller whilst ACPI was active.

Start discussion on whether this is a good idea...

> * As I seem to understand that the board is developed by your own
>   company, you should ask the BIOS developers what they are up to. They
>   should be able to tell you if the ACPI code above is intended and
>   needed, or if it can be dropped (together with the PHO operation
>   region.)

It's nice that you assume some level of competence here ;-)
Simon.
