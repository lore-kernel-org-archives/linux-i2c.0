From: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Sat, 09 Aug 2014 14:18:35 -0700
Message-ID: <53E6902B.9000104@minsoft.com>
References: <53BBC97B.5020805@minsoft.com>	<20140709002017.4c2b332e@endymion.delvare>	<53BD6E61.8070101@minsoft.com> <20140728125248.5bbc0f89@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140728125248.5bbc0f89-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi John,

Well, now it's my turn to be late in replying.    There's been progress.

On 07/28/2014 03:52 AM, Jean Delvare wrote:
> Hi Sanford,
>
> Sorry for the late reply and thanks for the detailed explanation.
>
>
>
> BTW your test program is only waiting for 5 ms instead of the 40 ms
> suggested in the specification. Could this explain your problems?
Just sloppiness in preparing the simplified demo code.  I'm using 50 ms 
in the actual code whenever the spec calls for 40 ms, and I'm generous 
in adding delays for retrys.  The problem with the nvidia driver is 
unrelated to delays (see below).
> Pardon my ignorance but if color profile managers don't currently set 
> monitor settings using DDC/CI, then what are they doing? Are they only 
> doing software color correction? Or asking the graphics card to do so? 
Basic answer:  the calibration process creates a lookup table that is 
loaded into the graphics card.  The lookup table translates the color 
input values into output values that will precisely show the expected 
color on the screen.

Long winded answer:  What is loosely referred to as "profiling" consists 
of two pieces, "calibration" and "characterization". Calibration is the 
process of bringing a monitor into a precisely known state.   That is 
the function of the lookup table. Characterization is process of 
describing a monitor's capabilities, e.g. what colors it is capable of 
displaying.  The characterization tables are used by color managed 
applications, for example, to appropriately render an image whose colors 
are beyond the range of what the monitor can show.   Both pieces of 
information are stored in the profile file.

Very high end monitors, such as the HP Dreamcolor and various EIZOs 
expose a LUT that can be used for color translation.  While the DDC 
protocol allows for manipulating the monitor LUT, some of these monitors 
instead use a special connection, such as USB, and a proprietary 
protocol.  Very high end LCD monitors will also have separate red, 
green, and blue LEDs or CCFL tubes, so that the color temperature can be 
precisely adjusted.  But most flat panel monitors  have just one one 
type of "white" LED or CCFL tube.

Linux calibration programs, such as Argyllcms, simply take as given 
whatever state the on screen controls have put the monitor into, and 
build the lookup table for that state.   dispcalGUI has an optional 
pre-calibration step which displays the measured color temperature of 
the display and suggests which physical monitor controls the user should 
change to achieve the desired color temperature.

There's a school of thought that holds that unless you have a high end 
monitor, you're actually best off setting all the controls (excepting 
brightness) on a LCD monitor to the factory defaults. Graeme Gill, 
create of Argyllcms, has a well considered discussion of this question 
(http://www.arbyllcms/monitor-controls.html).

>> As for the proprietary fglrx driver, it doesn't even create the
>> /dev/i2c-n devices.   End of story.
> I've seen that, yes, that's sad. Well AFAIK the open-source radeon
> driver is better and more popular than the nouveau driver so the impact
> is limited, but it would still be good if the fglrx driver would expose
> the i2c buses.

Well, it turns out that while fglrx doesn't expose /dev/i2c devices, it 
has a group of APIs for accessing the I2C bus, executing the DDC 
protocol, reading the EDID, etc.  notably.:
    ADL_Display_WriteAndReadI2C()
    ADL_Display_DDCBlockAccess_Get()
    ADL_Display_EdidData_Get()

After more munging, I'm able to use this API (called ADL) to communicate 
with monitors using DDC.   The code is actually simpler than the 
/dev/i2c version, because the API  knows something about the DDC 
protocol, handles retries, etc.  ( Interestingly, there's ifdef'd code 
in ddccontrol to use ADL.  Whether it actually works I don't know. )


>
> Or alternatively, the X11 stack could provide a DDC/CI API which
> drivers would implement and color profile tools would use. I personally
> don't care if this happens in X11 or through /dev/i2c* nodes, I'm not
> familiar enough with the area to tell which approach is the best.

 From an overall architecture perspective, it seems to me that X11 is 
the desirable place from a DDC/CI API.   I'm also sure that there are 
excellent reasons, far beyond my pay grade, why this has not been 
implemented.   However, there does seem to be discussion of putting 
support into Wayland.   See, for example, this comment by Richard Hughes 
(author of colord) on the Wayland list: 
http://lists.freedesktop.org/archives/wayland-devel/2013-April/008406.html

>> 2) It's time to head over to a nvidia forum to explore why the code
>> doesn't work with the proprietary driver.  Maybe there's a work around,
>> or maybe I can light a fire under the nvidia developers.
> Good idea, I hope you get somewhere with that. Odds are that this part
> of the code saw little testing so far, because almost all device
> drivers use the SMBus command set rather than raw I2C messages.
>

I was able to narrow the nvidia driver problem to just the write() call, 
so the delay between write() and read() plays no role. Moreover, I only 
see the problem on my (relatively) new GTX660Ti. write() calls of 1 or 2 
bytes succeed.   Calling write() for 3 or more bytes fails.   The 
problem does not occur on an older GT220 card.  So it appears that the 
driver was not properly upgraded to handle newer cards.   I posted a 
report along with sample code on the Nvidia developer website ( 
https://devtalk.nvidia.com/default/topic/760798/linux/ddc-ci-over-i2c-fails-gtx660ti/ 
).  Other than a comment from one other user who believed that this was 
the same issue as the known problem of ddccontrol not working for more 
recent cards, there's been no response.

Lastly, a question.  I have one monitor, a relatively recent 
"professional" quality Dell P2411H, which has a propensity to return 
duplicated bytes on read(), .e.g.  0x01020203 instead of 0x010203. The 
DDC protocol works, but has high retry counts.   Any thoughts on what I 
might do here as a workaround?

Regards,
Sanford
