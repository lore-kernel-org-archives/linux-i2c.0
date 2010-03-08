From: Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Mon, 08 Mar 2010 19:06:47 +0530
Message-ID: <4B94FD6F.7050603@mvista.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>	 <1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>	 <B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com> <225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 02/08/2010 04:05 PM, Nori, Sekhar wrote:
> Hi Philby,
>
> On Fri, Feb 05, 2010 at 19:23:43, Philby John wrote:
>> Hello Sekhar,
>>
>
> [...]
>
>>>> +/* Generate a pulse on the i2c clock pin. */
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

I now think that the previous versions were incorrect since 
davinci_cfg_reg() does not set the scl or sda pins for gpio 
functionality. Instead they set them as scl or sda which is not what we 
want at the time of pulsing. The previous versions used gpio_set_value() 
in disable_i2c_pins() and then called davinci_cfg_reg(). After which it 
called pulse_i2c_clock().

Please correct me if my interpretation of the code is incorrect.

Regards,
Philby
