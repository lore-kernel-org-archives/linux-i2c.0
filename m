From: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST controller
Date: Wed, 16 Feb 2011 15:51:11 +0100
Message-ID: <4D5BE45F.5020908@gaisler.com>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com> <20110216142708.GA6365@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110216142708.GA6365-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/16/2011 03:27 PM, Wolfram Sang wrote:
> Hi Jan,
>
> On Wed, Feb 16, 2011 at 01:30:48PM +0100, Jan Andersson wrote:
>> This patch adds support for the I2CMST core found on LEON/GRLIB SoCs.
>>
>> Signed-off-by: Jan Andersson<jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
>> ---
>> The I2CMST core is basically the OpenCores I2C master with an AMBA APB
>> interface. This driver re-uses much of i2c-ocores.c. It is submitted as
>> a separate driver since the register interfaces differ sligthly. Also the
>> two IP cores are maintained separately so they may diverge further in
>> the future.
>>
>> The driver is identical in terms of transfer handling and HW control.
>> The original module author string has been kept.
>
> Just judging from this message, it seems that algo could be extracted and used
> by both drivers? Or would this make no sense?
>

Hi Wolfram,

The control parts of the *_process, *_isr and *_xfer functions could be 
shared by ripping it out and changing the calls used to read/set registers.

I considered that change more complex and did not think it to be worth 
the trouble for saving ~50 LOC (probably less with added glue). Of 
course, it could be beneficial to have the algo part shared if there are 
future updates to it. At the same time I suppose that it could be bad to 
have the algo part shared if the updates are only valid for one of the 
cores.

Best regards,
   Jan
