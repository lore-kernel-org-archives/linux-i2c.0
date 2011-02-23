From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST
	controller
Date: Wed, 23 Feb 2011 01:07:03 +0000
Message-ID: <20110223010703.GA15795@trinity.fluff.org>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com> <20110216142708.GA6365@pengutronix.de> <4D5BE45F.5020908@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D5BE45F.5020908-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 03:51:11PM +0100, Jan Andersson wrote:
> On 02/16/2011 03:27 PM, Wolfram Sang wrote:
>> Hi Jan,
>>
>> On Wed, Feb 16, 2011 at 01:30:48PM +0100, Jan Andersson wrote:
>>> This patch adds support for the I2CMST core found on LEON/GRLIB SoCs.
>>>
>>> Signed-off-by: Jan Andersson<jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>> The I2CMST core is basically the OpenCores I2C master with an AMBA APB
>>> interface. This driver re-uses much of i2c-ocores.c. It is submitted as
>>> a separate driver since the register interfaces differ sligthly. Also the
>>> two IP cores are maintained separately so they may diverge further in
>>> the future.
>>>
>>> The driver is identical in terms of transfer handling and HW control.
>>> The original module author string has been kept.
>>
>> Just judging from this message, it seems that algo could be extracted and used
>> by both drivers? Or would this make no sense?
>>
>
> Hi Wolfram,
>
> The control parts of the *_process, *_isr and *_xfer functions could be  
> shared by ripping it out and changing the calls used to read/set 
> registers.
>
> I considered that change more complex and did not think it to be worth  
> the trouble for saving ~50 LOC (probably less with added glue). Of  
> course, it could be beneficial to have the algo part shared if there are  
> future updates to it. At the same time I suppose that it could be bad to  
> have the algo part shared if the updates are only valid for one of the  
> cores.

could at-least the contstants be shared?

>
> Best regards,
>   Jan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
