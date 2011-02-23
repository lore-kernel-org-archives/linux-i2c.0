From: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST	controller
Date: Wed, 23 Feb 2011 10:38:52 +0100
Message-ID: <4D64D5AC.3060301@gaisler.com>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com> <20110216142708.GA6365@pengutronix.de> <4D5BE45F.5020908@gaisler.com> <20110223010703.GA15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110223010703.GA15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/23/2011 02:07 AM, Ben Dooks wrote:
> On Wed, Feb 16, 2011 at 03:51:11PM +0100, Jan Andersson wrote:
>> On 02/16/2011 03:27 PM, Wolfram Sang wrote:
>>> Hi Jan,
>>>
>>> On Wed, Feb 16, 2011 at 01:30:48PM +0100, Jan Andersson wrote:
>>>> This patch adds support for the I2CMST core found on LEON/GRLIB SoCs.
>>>>
>>>> Signed-off-by: Jan Andersson<jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
>>>> ---
>>>> The I2CMST core is basically the OpenCores I2C master with an AMBA APB
>>>> interface. This driver re-uses much of i2c-ocores.c. It is submitted as
>>>> a separate driver since the register interfaces differ sligthly. Also the
>>>> two IP cores are maintained separately so they may diverge further in
>>>> the future.
>>>>
>>>> The driver is identical in terms of transfer handling and HW control.
>>>> The original module author string has been kept.
>>>
>>> Just judging from this message, it seems that algo could be extracted and used
>>> by both drivers? Or would this make no sense?
>>>
>>
>> Hi Wolfram,
>>
>> The control parts of the *_process, *_isr and *_xfer functions could be  
>> shared by ripping it out and changing the calls used to read/set 
>> registers.
>>
>> I considered that change more complex and did not think it to be worth  
>> the trouble for saving ~50 LOC (probably less with added glue). Of  
>> course, it could be beneficial to have the algo part shared if there are  
>> future updates to it. At the same time I suppose that it could be bad to  
>> have the algo part shared if the updates are only valid for one of the  
>> cores.
> 
> could at-least the contstants be shared?
> 

The register field definitions can currently be shared. The register
offsets (steps) are different since the two prescaler registers have
been merged into one register on the i2cmst core.

For V2 I will move the register field defines from i2c-ocores.c to
i2c-ocores.h and include that file in the new driver - unless anyone
objects.

Thanks to you both for reviewing!

Best regards,
  Jan
