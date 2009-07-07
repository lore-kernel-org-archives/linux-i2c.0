From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [lm-sensors] HMC6343
Date: Tue, 07 Jul 2009 11:38:46 +0000
Message-ID: <4A5333C6.3080802@cam.ac.uk>
References: <23114.97301.qm@web28307.mail.ukl.yahoo.com> <20090707095934.7b86524f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090707095934.7b86524f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hugo Meric <hugo.meric-Qt13gs6zZMY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Moved to linux-i2c, as per Jean's suggestion.

> On Tue, 7 Jul 2009 01:04:30 +0000 (GMT), Hugo Meric wrote:
>> Hello,
>>
>> I'm currently working with the HMC6343. I don't succeed to
>> communicate using the i2c interface and unfortunately the company
>> does not have any experience with Linux... 
Just to simplify things (specifically people looking for data sheets
to try and answer your question) please put more details / links
in for the chips you are talking about.
I already use your file
>> i2c-dev.h to communicate with four DS1050
Googling suggests that's a pulse-width modulator
http://www.maxim-ic.com/getds.cfm?qv_pk=2614
 and one SRF02, 
Ultrasonic range finder?
http://www.robot-electronics.co.uk/htm/srf02techSer.htm
and I'd
>> like to know if it is possible to use it for the HMC6343 because
>> the communication protocol seems to be different.
http://www.magneticsensors.com/datasheets/HMC6343.pdf

Basically it's protocol is a standard smbus type write byte command
(address 0x19) followed by a delay (command specific) and then
a read of multiple bytes (number is command dependant.)

Unfortunately the device doesn't seem do anything helpful like notify
you of how many bytes it is sending (as per smbus block read).

I fear to make this work you'll need to write a kernel space driver.
The first step is a conventional smbus send byte command. Follow this
with a suitable delay. The second will need to make use of
i2c_transfer with a msg looking something like

char bob[6];
struct i2c_msg read_msg = {
       .addr = 0x19,
       .flags = I2C_M_RD,
       .len = 6, // as appropriate to the command
       .buf = bob,
};

then i2c_transfer(adap, &read_msg, 1);

should do the job.

---
Jonathan Cameron
