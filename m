From: Peter Rosin <peda@axentia.se>
Subject: Re: Sluggish AT91 I2C driver causes SMBus timeouts
Date: Fri, 13 Oct 2017 17:01:04 +0200
Message-ID: <92675fc4-060b-0056-4fe8-3fe3368cb617@axentia.se>
References: <3d83fd8b-ade9-da10-3364-2afefa2e90af@axentia.se>
 <20171013142935.14ef302e@alans-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013142935.14ef302e@alans-desktop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 2017-10-13 15:29, Alan Cox wrote:
> On Thu, 12 Oct 2017 13:35:17 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> I have encountered an "interesting" bug. It silently corrupts data
>> and is generally nasty...
>>
>> On an I2C bus, driven by the at91 driver and DMA (an Atmel
>> sama5d31 chip), I have an 256 byte eeprom (NXP SE97BTP). I'm using
>> Linux v4.13.
> 
> If your force the transfer to PIO does it behave ? Does the controller in
> fact need to siwtch to PIO for SMBUS ?

Like, what if I disable DMA?

I saw no way to do that, short of short-cutting a few things in the
driver code. So, did that and I cannot tickle the bug. But I don't
know if that makes me safe?

Ludovic, any reason to believe disabling DMA will prevent these
stalls, or will they just appear under different circumstances?

I used this dirty "patch" to i2c-at91.c:at91_twi_configure_dma() for
testing:

-	dev->use_dma = true;
+	//dev->use_dma = true;

Cheers,
Peter
