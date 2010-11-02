From: Chris Metcalf <cmetcalf-kv+TWInifGbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drivers/i2c: add support for tile architecture "bus"
 for I2C devices
Date: Tue, 2 Nov 2010 13:50:05 -0400
Message-ID: <4CD04F4D.2020403@tilera.com>
References: <201011021712.oA2HCsMe028141@farm-0010.internal.tilera.com> <20101102101912.3df5012c.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101102101912.3df5012c.rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/2/2010 1:19 PM, Randy Dunlap wrote:
> On Tue, 2 Nov 2010 13:05:34 -0400 Chris Metcalf wrote:
>> This change enables the Linux driver to access i2c devices via
>> the Tilera hypervisor's virtualized API.
>>
>> Note that the arch/tile/include/hv/ headers are "upstream" headers
>> that likely benefit less from LKML review.
>>
>> [...]
>> +++ b/arch/tile/include/hv/drv_i2cm_intf.h
>> [...]
>> +/**
> In kernel source code, "/**" is used to begin kernel-doc notation blocks.
> Please don't use it for non-kernel-doc comments.
>
> (multiple times...)

These headers are essentially "upstream" for the Linux port; they are owned
by the Tilera hypervisor.  The "/**" comments in those files are Doxygen
comments used to generate standalone API documentation for the hypervisor. 
The same answer applies to your comment later in the file where you pointed
out some brace-positioning issues and the use of typedefs, since the coding
style for those headers is different the Linux coding style.  (Note also
that these headers are using two-space indents rather than tab indents.)

To avoid stylistic clash, we could have released the hypervisor headers as
a separate tarball (somewhere) and required that the kernel build take an
environment variable or some such to locate them, but it seemed simpler to
incorporate them into the Tilera Linux code so that the kernel can build in
a reasonably self-contained way.  The hypervisor header model is that the
client can use any internally consistent set of hypervisor headers and just
register the version number associated with that set of headers when
starting up.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
