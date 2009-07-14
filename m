From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Sample DTS entries and sample user space code
Date: Tue, 14 Jul 2009 09:57:01 +0200
Message-ID: <20090714095701.0aec363e@hyperion.delvare>
References: <50A8E1F8D9122546A7F67134915EDB7AB91AB4@xmb-rtp-21a.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50A8E1F8D9122546A7F67134915EDB7AB91AB4-1urkduz2x36J+CMdqUBC+pT4Y6eR2OpR0E9HWUfgJXw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco)" <ingsl-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 10 Jul 2009 17:09:47 -0400, Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco) wrote:
> 
> 
> Resend of message in plain text form.
> 
> 
> I understand the concepts involved in this project but that doesn't help me actually make use of it.

For reference for other readers who have no clue what you're talking
about: Lindsey is referring to Rodolfo's I2C multiplexing support
project, described at:
http://i2c.wiki.kernel.org/index.php/I2C_bus_multiplexing

> Is there a sample of how to put the mux and (if feasible) I2C clients in a DTS?

Not yet. Rodolfo's code is not even in mainline. But once
implementation is complete, then yes it should be possible to declare
I2C multiplexers and other I2C devices in a DTS.

> Also is there a user application sample of how to access the devices downstream from the mux?

This wouldn't make sense. Multiplexing is handled in the kernel and
user-space does not even know it is happening.

> Are the mux's created as a device so that the devices downstream are accessed as non-mux'd devices? i.e. is dev D in segment 2 (from the diagram on the wiki) accessed as so:
> 
> int fd;
> fd = open( "/dev/i2c-2", O_RDWR );
> 
> #define ADDRESS 0x38 // address of dev D
> ioctl( fd, I2C_SLAVE, ADDRESS )
> 
> // Now r/w dev D
> 
> // Write 0xAA to dev D
> i2c_smbus_write_byte( fd, 0xAA );
> // etc.

Yes, this is how the code would look like.

Note that I am still waiting for Rodolfo to update his patch set so
that it applies again on top of Linus' latest kernel.

-- 
Jean Delvare
