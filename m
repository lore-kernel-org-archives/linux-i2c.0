From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the bus
Date: Fri, 5 Feb 2010 19:23:43 +0530
Message-ID: <225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	 <1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>
Reply-To: pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Sekhar,

My apologies for the late mail. Had trouble with our mail server and I
seem to have lost mails. Pulling this thread from the list. Comments
inline...


On Mon, Feb 1, 2010 at 11:27 AM, Nori, Sekhar <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> Hi Philby,
>
> On Wed, Jan 27, 2010 at 05:11:33, Kevin Hilman wrote:
>> From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>>
>> Come out of i2c time out condition by following the
>> bus recovery procedure outlined in the i2c protocol v3 spec.
>> The kernel must be robust enough to gracefully recover
>> from i2c bus failure without having to reset the machine.
>> This is done by first NACKing the slave, pulsing the SCL
>> line 9 times and then sending the stop command.
>>
>> This patch has been tested on a DM6446 and DM355
>>
>> Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
>> Signed-off-by: Srinivasan, Nageswari <nageswari-l0cyMroinI0@public.gmane.org>
>> Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> ---
>> =A0drivers/i2c/busses/i2c-davinci.c | =A0 57 +++++++++++++++++++++++=
++++++++++++--
>> =A01 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i=
2c-davinci.c
>> index 35f9daa..5459065 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -36,6 +36,7 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/io.h>
>> =A0#include <linux/cpufreq.h>
>> +#include <linux/gpio.h>
>>
>> =A0#include <mach/hardware.h>
>> =A0#include <mach/i2c.h>
>> @@ -43,6 +44,7 @@
>> =A0/* ----- global defines -----------------------------------------=
------ */
>>
>> =A0#define DAVINCI_I2C_TIMEOUT =A0(1*HZ)
>> +#define DAVINCI_I2C_MAX_TRIES =A0 =A0 =A0 =A02
>> =A0#define I2C_DAVINCI_INTR_ALL =A0 =A0(DAVINCI_I2C_IMR_AAS | \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DAVIN=
CI_I2C_IMR_SCD | \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DAVIN=
CI_I2C_IMR_ARDY | \
>> @@ -130,6 +132,44 @@ static inline u16 davinci_i2c_read_reg(struct d=
avinci_i2c_dev *i2c_dev, int reg)
>> =A0 =A0 =A0 return __raw_readw(i2c_dev->base + reg);
>> =A0}
>>
>> +/* Generate a pulse on the i2c clock pin. */
>> +static void generic_i2c_clock_pulse(unsigned int scl_pin)
>> +{
>> + =A0 =A0 u16 i;
>> +
>> + =A0 =A0 if (scl_pin) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Send high and low on the SCL line */
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 9; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(scl_pin, 0)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(20);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(scl_pin, 1)=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(20);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Before using the pins as GPIO, you would have to set the
> functionality of these pins as GPIO. You had this code in
> previous incarnations of this patch - not sure why it is
> dropped now.
>

Don't seem to remember having the code in the old versions at least
not in generic_i2c_clock_pulse(). The functions disable_i2c_pins() and
enable_i2c_pins() were discarded as the i2c protocol spec. did not
specify the need. Moreover bus recovered without it. (Tested on DM355
and Dm6446).

> Couple of good to haves:
>
> It will be good to do a gpio_request() before using the pins
> as GPIO - though I can see it may have been deemed unnecessary
> - the pins are owned by I2C already - even so it may help catch
> system configuration errors in later platforms.

Yes, I could use gpio_request() in generic_i2c_clock_pulse().

>
> The I2C peripheral on da8xx itself contains a mode where its
> pins could be used as GPIO - so no need for SoC level muxing
> and need for the platform data. This seems to be missing from
> DM355 though. Thankfully there is a revision id within the I2C
> memory map which will help you differentiate the two cases
> (revision 0x5 vs 0x6)

I did not entirely follow your above statement. Will usage of
gpio_request() solve the problem for da8xx and DM355 or does it
require a if else condition? A reminder that the present code will
only work for DM6446 and DM355. I do not have a DA8xx to test specific
functionality if it were to be added.

Regards,
Philby
