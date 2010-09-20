From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3] i2c: davinci: Fix race when setting up for TX
Date: Mon, 20 Sep 2010 14:14:49 -0700
Message-ID: <4C97CEC9.8060602@boundarydevices.com>
References: <70E876B0EA86DD4BAF101844BC814DFE093ED5F50E@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE093ED5F50E-lPJtnb2sqtq44ywRPIzf9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Cc: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Dirk Behme <dirk.behme-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>> On 9/17/2010 6:09 AM, Sudhakar Rajashekhara wrote:
>>> I remember I had some issues on OMAP-L138 with this fix, that's when
>>> I reverted to configuring ICMDR before writing to DXR (Please see
>>> here: https://patchwork.kernel.org/patch/75262/). I checked the BIOS
>>> I2C driver code for OMAP-L138 and there also we are configuring MDR
>>> before accessing DXR.
> 
> Ah :/
> 
>>
>> and resetting the i2c upon a NAK interrupt (after the stop)
>> to clear the bad fifo data?
> 
> I can't really comment on how valid that would be and can't easily test it.
> 
> However preloading DXR does save one interrupt on transmit so the whole operation is faster and more efficient.
> 
> Maybe v1 of my patch, with locking, is the best option?
> 
> --
> Jon Povey

How about writing MDR twice? Once where Sudakar wants it, without the start bit.
And then where you want it with the start bit?


Troy
