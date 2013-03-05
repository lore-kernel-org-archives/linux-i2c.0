From: Michael Powell <mwpowellhtx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Cross compiling I2C code
Date: Tue, 5 Mar 2013 10:45:20 -0600
Message-ID: <CAMEoF_Ez25RLAjaPQ3SmCB0BxuO_f5-uaUPp6tjoxudK-vbQ7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

We've got an environment that builds okay where the libi2c-dev
installed for the x86 tool chain.

However, now I want to cross compile that for ARM. I've got a
ready-built cross compiler, however, am failing: can't find the
i2c_smbus_write_i2c_block_data symbol.

I've read before, this is a common problem, requires libi2c-dev, for
instance. Okay for x86. Where does libi2c-dev install that we can find
the headers for *any* tool chain to find?

Or, otherwise, how to locate that?

Thank you...

Regards,

Michael Powell
