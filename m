From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Mon, 28 Jul 2014 12:52:48 +0200
Message-ID: <20140728125248.5bbc0f89@endymion.delvare>
References: <53BBC97B.5020805@minsoft.com>
	<20140709002017.4c2b332e@endymion.delvare>
	<53BD6E61.8070101@minsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53BD6E61.8070101-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sanford,

Sorry for the late reply and thanks for the detailed explanation.

On Wed, 09 Jul 2014 09:31:29 -0700, Sanford Rockowitz wrote:
> > Your code reads 11 data bytes, not 12.
> 
> Correct.  A bit of sloppy exposition.   I had to stand on my head three 
> times over and look sideways to properly mung
> the DDC spec into the i2c-dev calls.  From the DDC perspective, 1 more 
> byte is written and read than are written and read using write(), 
> read(), i2c_smbus_write_i2c_block_data(), etc.  Byte 0 of a DDC request 
> or response is implicit (the result of ioctl(fh, I2C_SLAVE, 0x37);) but 
> from a DDC perspective you need to think of it as being there for the 
> checksums to be properly calculated.

OK, I understand.

> (...)
> As noted, a DDC exchange is write/read sequence of 2 separate messages 
> (or in some cases a simple write). Each write or read begins with a 
> start bit and ends with a stop bit.  So if I understand your terminology 
> correctly, there's no direction change within a message.

Correct. I think this is because the protocol allows for a delay of up
to 40 ms for the display to prepare the answer message. Well in theory
this could still be done with a single transfer and a direction change,
with the slave (display) holding SCL low until it is ready. This would
have avoided unneeded delays when the display is faster. But well
apparently they did not want to implement it that way.

BTW your test program is only waiting for 5 ms instead of the 40 ms
suggested in the specification. Could this explain your problems?

> (...)
> Some context of why I'm doing this may be appropriate here.  This 
> project came about because of my interest in monitor profiling and 
> calibration.  A monitor calibration is relative to the current monitor 
> settings for luminosity, contrast, color temperature, etc. Setting a 
> profile only makes sense if you know that the monitor settings are 
> unchanged from when you made the profile.  Currently in Linux, the only 
> way to do this is leave the buttons on the monitor untouched.   None of 
> the major profiling tools - dispcal, dispcalGUI, colord, oyranos - 
> record or restore the monitor settings.  At most they can give you 
> advice on how to adjust the physical monitor controls to obtain the 
> desired color temperature. There once was a program to manage monitor 
> settings, ddccontrol, but it hasn't been maintained and has been dropped 
> from distros.

I took a quick look at this and while it looked promising, it indeed
seems to be unmaintained for almost a decade. From a design
perspective, I seem to understand that the tool is trying to access the
DDC channels directly instead of relying on the i2c buses exposed by
the graphics drivers. That's very bad so I'm not surprised that
distributions ended up dropping this tool.

> When I enquired about this on the color lists, the gist 
> of the responses was that it was too hard to do because the DDC spec was 
> inconsistently implemented across monitors.  I decided to try to come up 
> with a solution that works for at least MY set of monitors.

I agree. Just because we can't support all monitors out there, is no
good reason to not try to support at least some of them.

> Basically, 
> at the time of monitor calibration, the program records whatever color 
> related settings exist for the monitor, and can then restore those 
> settings when the profile is set.   Interestingly, the variation among 
> monitor implementations has proven quite manageable.  Almost all the 
> effort has gone into getting DDC over I2C right.  At this point, it 
> appears that the biggest obstacle to a general solution comes from the 
> proprietary drivers.

Well, if your tool is good and gains popularity, it might be a good
incentive for driver authors to fix the problems.

Pardon my ignorance but if color profile managers don't currently set
monitor settings using DDC/CI, then what are they doing? Are they only
doing software color correction? Or asking the graphics card to do so?

> >> (....)
> >> According to this document, only the following functionality is
> >> supported, which would be consistent with what I've seen: I2C_FUNC_I2C,
> >> I2C_FUNC_SMBUS_QUICK, I2C_FUNC_SMBUS_BYTE, I2C_FUNC_SMBUS_BYTE_DATA,
> >> I2C_FUNC_SMBUS_WORD_DATA
> > I would trust the output of i2cdetect -F more than the documentation.
> 
> With the proprietary nvidia driver loaded,  i2cdetect -F 0 reports:
> 
> Functionalities implemented by /dev/i2c-0:
> I2C                              yes
> SMBus Quick Command              yes
> SMBus Send Byte                  yes
> SMBus Receive Byte               yes
> SMBus Write Byte                 yes
> SMBus Read Byte                  yes
> SMBus Write Word                 yes
> SMBus Read Word                  yes
> SMBus Process Call               no
> SMBus Block Write                no
> SMBus Block Read                 no
> SMBus Block Process Call         no
> SMBus PEC                        no
> I2C Block Write                  no
> I2C Block Read                   no
> 
> 
> This is (unsurprisingly) consistent with what I get calling ioctl I2C_FUNCS.

Of course, as i2cdetect -F is simply calling ioctl I2C_FUNCS :-) The
output above points at a buggy driver implementation. If the driver can
do I2C then it can definitely do I2C Block Write and I2C Block Read.
That being said, for DDC/CI, you don't actually care, all you need is
I2C.

> > This suggests that the driver authors were lazy and/or did something
> > stupid. A driver that can do I2C_FUNC_I2C, can do most SMBus transfers,
> > including I2C block transfers (which despite the name are close to
> > SMBus transfers.)
> >
> > OTOH, if the driver really supports I2C_FUNC_I2C then the I2C_RDWR
> > ioctl should do the trick. But I wouldn't hope too much, because then
> > read and write should also work, when your experiments apparently show
> > they do not.
> As a first test case, I just replaced the write() call with ioctl 
> I2C_RDWR.  It works for nouveau, and fails with errno=5 (EIO) for the 
> proprietary nvidia driver.  I don't think there's any reason to believer 
> other uses of ioctl I2C_RDWR will fare better.

Indeed not :-(

> As for the proprietary fglrx driver, it doesn't even create the
> /dev/i2c-n devices.   End of story.

I've seen that, yes, that's sad. Well AFAIK the open-source radeon
driver is better and more popular than the nouveau driver so the impact
is limited, but it would still be good if the fglrx driver would expose
the i2c buses.

Or alternatively, the X11 stack could provide a DDC/CI API which
drivers would implement and color profile tools would use. I personally
don't care if this happens in X11 or through /dev/i2c* nodes, I'm not
familiar enough with the area to tell which approach is the best.

> (...)
> So I think the bottom line from this exchange is as follows:
> 
> 1) Use write() and read().  They really are doing the right thing. 
> Forget about i2c_smbus_write/read_block_data().

I agree.

> 2) It's time to head over to a nvidia forum to explore why the code 
> doesn't work with the proprietary driver.  Maybe there's a work around, 
> or maybe I can light a fire under the nvidia developers.

Good idea, I hope you get somewhere with that. Odds are that this part
of the code saw little testing so far, because almost all device
drivers use the SMBus command set rather than raw I2C messages.

-- 
Jean Delvare
SUSE L3 Support
