From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] Added empty directories for hardware sensors
Date: Mon, 2 Mar 2009 10:52:38 +0530
Message-ID: <5d5443650903012122p795d51cdr18c1a79c606cd496@mail.gmail.com>
References: <20090226095718.GA24575@buzzloop.caiaq.de>
	 <1235654648-3450-1-git-send-email-daniel@caiaq.de>
	 <20090228124048.GB18336@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090228124048.GB18336-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Daniel,

On Sat, Feb 28, 2009 at 6:10 PM, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> On Thu, Feb 26, 2009 at 02:24:06PM +0100, Daniel Mack wrote:
>> This adds empty directories and the neccessary entries to Makefiles =
and
>> Kconfigs in order to provide a place for hardware sensors which are =
not
>> meant to be based in drivers/hwmon.
>>
>> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
>> ---
>> =A0How about this approach? Take it as RFC ...
>
> Any oppinion on this, anyone? I'm currently writing a driver for an
> accelerometer and will have the same uncertainty of where to put it i=
n
> the end.

Better to submit this patch to LKML too, as it adds new directory. For
accelerometer, few patches were submitted as "Industrial IO" framework
from Jonathan Cameron. If you grep in LKML archive you will get the
idea, also another place for accelerometer could be drivers/hwmon
directory too if it fits in your driver requirements.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
