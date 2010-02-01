From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the bus
Date: Mon, 01 Feb 2010 11:40:01 -0800
Message-ID: <87ljfchhim.fsf@deeprootsystems.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
	(Sekhar Nori's message of "Mon\, 1 Feb 2010 11\:27\:15 +0530")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

"Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org> writes:

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
>>  drivers/i2c/busses/i2c-davinci.c |   57 +++++++++++++++++++++++++++++++++++--
>>  1 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index 35f9daa..5459065 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/io.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/gpio.h>
>>
>>  #include <mach/hardware.h>
>>  #include <mach/i2c.h>
>> @@ -43,6 +44,7 @@
>>  /* ----- global defines ----------------------------------------------- */
>>
>>  #define DAVINCI_I2C_TIMEOUT  (1*HZ)
>> +#define DAVINCI_I2C_MAX_TRIES        2
>>  #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
>>                                DAVINCI_I2C_IMR_SCD | \
>>                                DAVINCI_I2C_IMR_ARDY | \
>> @@ -130,6 +132,44 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
>>       return __raw_readw(i2c_dev->base + reg);
>>  }
>>
>> +/* Generate a pulse on the i2c clock pin. */
>> +static void generic_i2c_clock_pulse(unsigned int scl_pin)
>> +{
>> +     u16 i;
>> +
>> +     if (scl_pin) {
>> +             /* Send high and low on the SCL line */
>> +             for (i = 0; i < 9; i++) {
>> +                     gpio_set_value(scl_pin, 0);
>> +                     udelay(20);
>> +                     gpio_set_value(scl_pin, 1);
>> +                     udelay(20);
>> +             }
>
> Before using the pins as GPIO, you would have to set the
> functionality of these pins as GPIO. You had this code in
> previous incarnations of this patch - not sure why it is
> dropped now.
>
> Couple of good to haves:
>
> It will be good to do a gpio_request() before using the pins
> as GPIO - though I can see it may have been deemed unnecessary
> - the pins are owned by I2C already - even so it may help catch
> system configuration errors in later platforms.
>
> The I2C peripheral on da8xx itself contains a mode where its
> pins could be used as GPIO - so no need for SoC level muxing
> and need for the platform data. This seems to be missing from
> DM355 though. Thankfully there is a revision id within the I2C
> memory map which will help you differentiate the two cases
> (revision 0x5 vs 0x6)
>

Philby,

Please update with comments from Sekhar soon so I can get this one queued
for 2.6.34.

Kevin
