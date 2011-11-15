From: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: (mpc) Add support for SMBUS_READ_BLOCK_DATA
Date: Tue, 15 Nov 2011 19:02:39 +0000
Message-ID: <CAOZdJXVq=0pbrPM_-+Kjf3NhON8oN3Me64R6c9qBiAEFuRsDOw@mail.gmail.com>
References: <1321338462-6138-1-git-send-email-guenter.roeck@ericsson.com>
	<20111115095445.3d34e99e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111115095445.3d34e99e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Content-ID: <037EA2EAA4386F478A02CAA238A16809-KZfg59tc24wqcZcGjlUOXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tang Yuantian-B29983 <B29983-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 15, 2011 at 2:54 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> This needs careful testing (which I can't do.)

I can test these patches, so please CC me on them.

> There may have been a
> reason why the read was done after the writes. Swapping the commands
> may be the wrong thing to do. The dummy read earlier in this function
> suggests that maybe changes to CCR do not take effect until you read
> from (or write to) the DR register.

Unfortunately, I don't know enough about the I2C protocol to answer
this, but I can provide this description on the DR register from the
reference manual:

         Transmission starts when an address and the R/W bit are
written to the data register and the I2C interface
         performs as the master. A data transfer is initiated when
data is written to the I2CDR. The most significant bit
         is sent first in both cases. In master receive mode, reading
the data register allows the read to occur, but also
         allows the I2C module to receive the next byte of data on the
I2C interface. In slave mode, the same function
         is available after it is addressed. Note that in both master
receive and slave receive modes, the very first read
         is always a dummy read.

> Can't the above be rewritten to keep the order of the commands as it
> was before? AFAICS it would only take one or two extra tests.

I think it's very important to keep the order as-is, if at all
possible.  This driver is very old and the hardware is used on all of
our SOCs, dating back several years.  It would be a nightmare to test
it all over again.

-- 
Timur Tabi
Linux kernel developer at Freescale
