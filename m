From: Juergen Fitschen <me@jue.yt>
Subject: Re: I2C slave mode for i2c-at91 driver
Date: Wed, 18 Oct 2017 14:32:53 +0200
Message-ID: <029b74bfca29bb33fe551975e3d1f7ce@jfitschen.de>
References: <97ba9ab73b527ac882e7d591b42ae621@jfitschen.de>
 <20171018073725.6qtglbpquyqx5xyq@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from srv1.host37.de ([176.28.54.59]:49932 "EHLO srv1.host37.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752905AbdJRNBt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Oct 2017 09:01:49 -0400
In-Reply-To: <20171018073725.6qtglbpquyqx5xyq@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Hi Wolfram,

>> 1) According to [1] the return value of the I2C_SLAVE_WRITE_RECEIVED 
>> event
>> determines whether the received byte shall be ACKed or NACKed. The 
>> problem
>> with the Atmel hardware is that it is not possible to manipulate the 
>> ACK bit
>> of the current byte in flight; it will be ACKed automatically. It is 
>> only
>> possible to (N)ACK the following byte(s) since some FIFO magic is 
>> going on
>> inside the hardware.
>
> So, it is not possible to NACK the last byte?

If you would like to receive 3 bytes from a remote master and the last 
byte shall be NACKed, the backend must have the following behaviour to 
be compatible with the SAMA5 MPUs:

                                  +-----+-+-----+-+-----+-+
   Data on wire:                  |BYTE1|A|BYTE2|A|BYTE3|N|
                                  +-----+-+-----+-+-----+-+
   I2C_SLAVE_WRITE_RECEIVED fired:        ^       ^       ^
   Event's return value:                  A       N       X  (X=don't 
care)

But if I understand the documentation correctly, the return value 
corresponds to the currently received byte and not the next byte. So the 
following backend behaviour is described by the docs:

                                  +-----+-+-----+-+-----+-+
   Data on wire:                  |BYTE1|A|BYTE2|A|BYTE3|N|
                                  +-----+-+-----+-+-----+-+
   I2C_SLAVE_WRITE_RECEIVED fired:      ^       ^       ^
   Event's return value:                A       A       N

Or am I wrong?


>> Do you think it is a valid approach to ignore the return value and 
>> always
>> ACK received bytes? Or would you rather set the behaviour for the 
>> following
>> bytes? That would delay the desired ACK bit by at least one byte.
>
> Tricky, since both options are really sub-optimal. I tend to think 
> that
> reporting the error a bit later is the slightly better option. Most
> client drivers will act on the fact that the whole transfer failed
> somehow. Where it fails is not so essential. We don't have proper 
> means
> to report the exact position of the failure currently anyhow.

I had a look into the i2c-designware driver sources. As far as I 
understand it also does not respect the return value of the 
I2C_SLAVE_WRITE_RECEIVED event. It just prints out debug messages if the 
received byte shall be ACKed.


>> How would you implement blocking master transactions while slave 
>> mode is
>> enabled? I would return EBUSY if master_xfer is called.
>
> The i2c-designware driver has the same problem. We decided to have
> seperate struct i2c_algorithms for master and slave. The core helper
> i2c_detect_slave_mode() can help you to determine which mode should 
> be
> used. The designware drive might give you some inspiration.

Thank you for the hint! This really helps.


Kind regards,
   Juergen
