From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: Re : [lm-sensors] HMC6343
Date: Wed, 08 Jul 2009 10:37:11 +0000
Message-ID: <4A5476D7.7090705@cam.ac.uk>
References: <23114.97301.qm@web28307.mail.ukl.yahoo.com> <20090707095934.7b86524f@hyperion.delvare> <4A5333C6.3080802@cam.ac.uk> <20090707134638.6ff1b324@hyperion.delvare> <4A53375B.9070304@cam.ac.uk> <874671.80619.qm@web28313.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874671.80619.qm-KpgP/9vcbyPGRxTy+Q50vsz6deESKz/lQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hugo Meric <hugo.meric-Qt13gs6zZMY@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hugo Meric wrote:
> 
> Thank you for the advice. So today I try and I finally got something
> (using code on the internet:
> http://www.stlinux.com/docs/manual/distribution/distribution_guide6.php#1124364
> ). The code seems right and the only problem is that I don't know how to
> get the data at the end.
> 
> After the call ioctl(file, I2C_RDWR, (unsigned long)&work_queue), the
> datas are in work_queue (I hope so) but I don't know how to get the 6
> values of the HMC6343 sensor.
That's a somewhat odd looking bit of code. I'm not remotely sure what they
are doing with it.

As I've never used this particular ioctl, Jean please correct me if I'm wrong.


For some reason they've configured the messages to have length 0 and no associated
data buffer.

     (work_queue.msgs[idx]).len   = 0;
//this next line is really odd.  Either they were adressing a whole array
//or something no where near standard. This should be fixed at the address
//of the chip you are talking to.
     (work_queue.msgs[idx]).addr  = start_address + idx;
     (work_queue.msgs[idx]).buf   = NULL;


so set len to 6 and the buf to point to a 6 byte character array.
You'll also need to set .flags = I2C_M_RD in the msg
in question in order to ensure a read occurs (rather than
attempting to write the contents of buf.

After the ioctl call, your data should  be character array
that you set the pointer buf to point at.

Note you only want the one message to be sent after the delay
after your command message (for which you can use a simple smbus
write byte command).
Jonathan
 
