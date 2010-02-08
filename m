From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Mon, 08 Feb 2010 20:43:27 +0530
Message-ID: <4B702A17.3070104@mvista.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>	 <1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com> <225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello Sekhar,

On 02/08/2010 04:05 PM, Nori, Sekhar wrote:
>>>> +static void generic_i2c_clock_pulse(unsigned int scl_pin)
>>>> +{
>>>> +     u16 i;
>>>> +
>>>> +     if (scl_pin) {
>>>> +             /* Send high and low on the SCL line */
>>>> +             for (i = 0; i<  9; i++) {
>>>> +                     gpio_set_value(scl_pin, 0);
>>>> +                     udelay(20);
>>>> +                     gpio_set_value(scl_pin, 1);
>>>> +                     udelay(20);
>>>> +             }
>>>
>>> Before using the pins as GPIO, you would have to set the
>>> functionality of these pins as GPIO. You had this code in
>>> previous incarnations of this patch - not sure why it is
>>> dropped now.
>>>
>>
>> Don't seem to remember having the code in the old versions at least
>> not in generic_i2c_clock_pulse(). The functions disable_i2c_pins() and
>> enable_i2c_pins() were discarded as the i2c protocol spec. did not
>> specify the need. Moreover bus recovered without it. (Tested on DM355
>> and Dm6446).
>
> Yes, I was referring to the davinci_cfg_reg() calls in
> {disable|enable}_i2c_pins() functions. Per the specification
> of the DaVinci devices, a pin needs to be muxed as 'GPIO' if
> it is to be used as GPIO controlled by GPIO module. It may
> have worked on couple of devices but cannot be guaranteed to
> work on all DaVinci devices (esp. DA8XX ones).


I think that using davinci_cfg_reg() in generic_i2c_clock_pulse() is the 
wrong place to put it. This would require adding davinci_cfg_reg() for 
all know davinci platforms. The i2c recovery procedure is correct to 
assume that it owns the SCL line at that very moment.

Instead I believe pinmuxing using davinci_cfg_reg(), should be done way 
early, just like we do for DM6446 in devices.c --> davinci_init_i2c(), 
for all other platforms. What I could do in function 
generic_i2c_clock_pulse() is, set SCL to output, and use gpio_request() 
by checking REVID2 register value (0x6) for DA8xx and 0x5 for others.

Let me know what you think.

Regards,
Philby
