From: Munir Bandukwala <munirb-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>
Subject: Re: Writing to AT24C64C EEPROM fails on RHEL based kernels
Date: Mon, 07 Mar 2011 12:48:39 -0800
Message-ID: <4D7544A7.3090509@riverbed.com>
References: <4D753233.8060208@riverbed.com> <20110307194819.GA17883@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110307194819.GA17883-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Munir Bandukwala <Munir.Bandukwala-DUeqMYwuH4dWk0Htik3J/w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks Wolfram for your response, my comments are inline ...

On 03/07/2011 11:48 AM, Wolfram Sang wrote:
>> While looking for patches, I came accross
>> https://bugzilla.redhat.com/show_bug.cgi?id=182687 and adding an extra delay
>> in the piix4_transaction function fixes the problem for me as well.
> So, this is not a problem anymore if I understand you correctly?
>
yes thats correct, I have to add a delay for the chip on my box (its not 
the same as the one used in the patch above) and it works, what I was 
wondering was why ubuntu/2.6.35 works without the additional delay or 
any changes to code.
>> I think the problems are related, but any pointers would be appreciated. I am
>> pasting information about my machine, please let me know if you guys needs
>> any more information
> This seems normal to me. The eeprom needs time to write the data. Any reasons
> for not using the in-kernel eeprom driver (drivers/misc/eeprom/at24.c)? It
> deals with all of that (and probably more).
>
I did try the at24 driver and had a similar issue, for ease of testing 
and comparing different kernels, I switched to the user space code.
> Regards,
>
>     Wolfram
>
