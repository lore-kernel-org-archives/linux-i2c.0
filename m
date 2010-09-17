From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3] i2c: davinci: Fix race when setting up for TX
Date: Fri, 17 Sep 2010 12:15:39 -0700
Message-ID: <4C93BE5B.6090701@boundarydevices.com>
References: <1284691607-9697-1-git-send-email-jon.povey@racelogic.co.uk>	<1284692531-10100-1-git-send-email-jon.povey@racelogic.co.uk> <001201cb5669$a0200940$e0601bc0$@raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001201cb5669$a0200940$e0601bc0$@raj-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Cc: 'Jon Povey' <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 9/17/2010 6:09 AM, Sudhakar Rajashekhara wrote:
> Hi,
> 
> On Fri, Sep 17, 2010 at 08:32:11, Jon Povey wrote:
>> When setting up to transmit, a race exists between the ISR and
>> i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
>> This is mostly visible for transmits > 1 byte long.
>>
>> The hardware starts sending immediately that MDR is loaded. IMR trickery
>> doesn't work because if we start sending, finish the first byte and an
>> XRDY event occurs before we load IMR to unmask it, we never get an
>> interrupt, and we timeout.
>>
>> Move the MDR load after DXR,IMR loads to avoid this race without locking.
>>
>> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
>>
> 
> I remember I had some issues on OMAP-L138 with this fix, that's when I
> reverted to configuring ICMDR before writing to DXR (Please see here:
> https://patchwork.kernel.org/patch/75262/). I checked the BIOS I2C
> driver code for OMAP-L138 and there also we are configuring MDR before
> accessing DXR.
> 
> Regards,
> Sudhakar

How about killing the lines from commit c6c7c729a22bfeb8e63eafce48dbaeea20e68703
-------------------------------
/*
 * First byte should be set here, not after interrupt,
 * because transmit-data-ready interrupt can come before
 * NACK-interrupt during sending of previous message and
 * ICDXR may have wrong data
 */
if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
        davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
        dev->buf_len--;
}
----------------------

and resetting the i2c upon a NAK interrupt (after the stop) to clear the bad fifo data?
