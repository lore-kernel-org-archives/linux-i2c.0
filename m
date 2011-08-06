From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: move OF i2c related functions into i2c core
Date: Sat, 6 Aug 2011 09:50:16 +0100
Message-ID: <CACxGe6uKs1Bxq3SXdLgdMK3RxoOrq_iiOuFaYKYK-aAopoaefA@mail.gmail.com>
References: <1312579468-19365-1-git-send-email-robherring2@gmail.com>
 <1312579468-19365-3-git-send-email-robherring2@gmail.com> <20110805225637.GB6404@ponder.secretlab.ca>
 <4E3C79AF.80901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4E3C79AF.80901-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 6, 2011 at 12:15 AM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> Grant,
>
> On 08/05/2011 05:56 PM, Grant Likely wrote:
>> On Fri, Aug 05, 2011 at 04:24:27PM -0500, Rob Herring wrote:
>>> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>>
>>> This simplifies i2c drivers by removing calls to of_i2c_register_de=
vices
>>> and resolves a module circular dependency between i2c-core and of_i=
2c.
>>>
>>> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> ---
>>> =A0arch/powerpc/platforms/44x/warp.c | =A0 =A01 -
>>> =A0drivers/i2c/i2c-core.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 85 +++++++++=
++++++++++++++++++++++-
>>> =A0drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 -
>>> =A0drivers/of/of_i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 97 -------=
------------------------------
>>> =A0include/linux/i2c.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++
>>> =A0include/linux/of_i2c.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 30 ---------=
--
>>> =A06 files changed, 87 insertions(+), 131 deletions(-)
>>> =A0delete mode 100644 drivers/of/of_i2c.c
>>> =A0delete mode 100644 include/linux/of_i2c.h
>>>
>>> diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platf=
orms/44x/warp.c
>>> index 8f77139..9327ccf 100644
>>> --- a/arch/powerpc/platforms/44x/warp.c
>>> +++ b/arch/powerpc/platforms/44x/warp.c
>>> @@ -16,7 +16,6 @@
>>> =A0#include <linux/interrupt.h>
>>> =A0#include <linux/delay.h>
>>> =A0#include <linux/of_gpio.h>
>>> -#include <linux/of_i2c.h>
>>> =A0#include <linux/slab.h>
>>>
>>> =A0#include <asm/machdep.h>
>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> index 011e195..478c7f2 100644
>>> --- a/drivers/i2c/i2c-core.c
>>> +++ b/drivers/i2c/i2c-core.c
>>> @@ -22,7 +22,10 @@
>>> =A0 =A0 SMBus 2.0 support by Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> =
and
>>> =A0 =A0 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>> =A0 =A0 Mux support by Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org> and
>>> - =A0 Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org> */
>>> + =A0 Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
>>> + =A0 OF support by Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org> and
>>> + =A0 Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> + =A0 */
>>>
>>> =A0#include <linux/module.h>
>>> =A0#include <linux/kernel.h>
>>> @@ -32,7 +35,6 @@
>>> =A0#include <linux/init.h>
>>> =A0#include <linux/idr.h>
>>> =A0#include <linux/mutex.h>
>>> -#include <linux/of_i2c.h>
>>> =A0#include <linux/of_device.h>
>>> =A0#include <linux/completion.h>
>>> =A0#include <linux/hardirq.h>
>>> @@ -790,6 +792,85 @@ static void i2c_scan_static_board_info(struct =
i2c_adapter *adapter)
>>> =A0 =A0 =A0up_read(&__i2c_board_lock);
>>> =A0}
>>>
>>> +#ifdef CONFIG_OF_I2C
>>
>> I think this becomes simply "#ifdef CONFIG_OF" since CONFIG_I2C is i=
mplied at this point.
>
> I was going to remove CONFIG_OF_I2C altogether, but it depends on !SP=
ARC
> so I thought it should be kept.

Good point.  I keep forgetting that SPARC has different behaviour.

g.
