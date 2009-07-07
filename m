From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [lm-sensors] HMC6343
Date: Tue, 07 Jul 2009 11:54:03 +0000
Message-ID: <4A53375B.9070304@cam.ac.uk>
References: <23114.97301.qm@web28307.mail.ukl.yahoo.com>	<20090707095934.7b86524f@hyperion.delvare>	<4A5333C6.3080802@cam.ac.uk> <20090707134638.6ff1b324@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090707134638.6ff1b324-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Hugo Meric <hugo.meric-Qt13gs6zZMY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Tue, 07 Jul 2009 11:38:46 +0000, Jonathan Cameron wrote:
>> Basically it's protocol is a standard smbus type write byte command
>> (address 0x19) followed by a delay (command specific) and then
>> a read of multiple bytes (number is command dependant.)
>>
>> Unfortunately the device doesn't seem do anything helpful like notify
>> you of how many bytes it is sending (as per smbus block read).
>>
>> I fear to make this work you'll need to write a kernel space driver.
>> The first step is a conventional smbus send byte command. Follow this
>> with a suitable delay. The second will need to make use of
>> i2c_transfer with a msg looking something like
>>
>> char bob[6];
>> struct i2c_msg read_msg = {
>>        .addr = 0x19,
>>        .flags = I2C_M_RD,
>>        .len = 6, // as appropriate to the command
>>        .buf = bob,
>> };
>>
>> then i2c_transfer(adap, &read_msg, 1);
>>
>> should do the job.
> 
> Note: this could be done from userspace too if needed. The i2c-dev
> interface supports raw reads and writes.
> 
Good point, I'd missed that functionality (did seem a little odd
that I couldn't find it!)

Method's much the same, but involves using the relevant ioctl
(I2C_RDWR), in conjunction iwth an appropriately filled
i2c_rdwr_ioctl_data structure.

The i2c_smbus_access function in i2c-dev.h (lm-sensors version)
is similar enough to show how to do it.


Jonathan
