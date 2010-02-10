From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
 functions and data
Date: Wed, 10 Feb 2010 11:09:25 +0100
Message-ID: <4B7285D5.9060008@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com> 	<1264685141-26391-2-git-send-email-wg@grandegger.com> <fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fa686aa41002090941je3e4fdqbecf2616a8b90e42-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Grant Likely wrote:
> On Thu, Jan 28, 2010 at 6:25 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org> wrote:
>> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>>
>> "__devinit[data]" has not yet been used for all initialization functions
>> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" has
>> been renamed to "mpc_i2c_data", which is even the better name.
>>
>> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
> 
> Several comments below.
> 
>> ---
>>  drivers/i2c/busses/i2c-mpc.c |  103 +++++++++++++++++++----------------------
>>  1 files changed, 48 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
>> index f627001..275ebe6 100644
>> --- a/drivers/i2c/busses/i2c-mpc.c
>> +++ b/drivers/i2c/busses/i2c-mpc.c
>> @@ -66,7 +66,7 @@ struct mpc_i2c_divider {
>>        u16 fdr;        /* including dfsrr */
>>  };
>>
>> -struct mpc_i2c_match_data {
>> +struct mpc_i2c_data {
>>        void (*setclock)(struct device_node *node,
>>                         struct mpc_i2c *i2c,
>>                         u32 clock, u32 prescaler);
>> @@ -165,7 +165,7 @@ static int i2c_wait(struct mpc_i2c *i2c, unsigned timeout, int writing)
>>  }
>>
>>  #ifdef CONFIG_PPC_MPC52xx
>> -static const struct mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
>> +static const struct __devinitdata mpc_i2c_divider mpc_i2c_dividers_52xx[] = {
> 
> __devinitdata goes at the end, immediately before the '='.  Ditto
> throughout the file.

This made a difference and revealed section mismatches. "const" seems to
be incompatible with "__devinitdata".

>>        {20, 0x20}, {22, 0x21}, {24, 0x22}, {26, 0x23},
>>        {28, 0x24}, {30, 0x01}, {32, 0x25}, {34, 0x02},
>>        {36, 0x26}, {40, 0x27}, {44, 0x04}, {48, 0x28},
>> @@ -582,44 +584,35 @@ static int __devexit fsl_i2c_remove(struct of_device *op)
>>        return 0;
>>  };
>>
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_52xx = {
>> +       .setclock = mpc_i2c_setclock_52xx,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8313 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8543 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +       .prescaler = 2,
>> +};
>> +
>> +static struct mpc_i2c_data __devinitdata mpc_i2c_data_8544 = {
>> +       .setclock = mpc_i2c_setclock_8xxx,
>> +       .prescaler = 3,
>> +};
>> +
>>  static const struct of_device_id mpc_i2c_of_match[] = {
> 
> You can make this __devinitdata too.

This results in a section mismatch as it's referenced by fsl_i2c_init().
I just sent out v6. Hope it's OK now.

Thanks,

Wolfgang.
