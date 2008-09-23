From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: New style I2C driver for KXSD9 accelerometer
Date: Tue, 23 Sep 2008 11:19:55 +0100
Message-ID: <48D8C2CB.30505@cam.ac.uk>
References: <20125.80062.qm@web7902.mail.in.yahoo.com>	<5d5443650809221038u7bece6fco2a123c7c85014318@mail.gmail.com>
	<20080922224345.GL2716@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080922224345.GL2716-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, invincible_6-/E1597aS9LQxFYw1CcD5bw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,
>>>
>>>
>>>
>>> I m implementing a driver for accelerometer KXSD9 in linux kernel 2.6.24.7
>>> for OMAP-3430. KXSD9 sensor will be connected to the i2c bus so it will be
>>> an i2c client.
>> You could implement this under input subsystem itself, like how openmoko
>> did it.
> 
> That argument has been had on linux-kernel already, I liked it but the
> input subsystem is aparently not good enough for input devices. There
> is quite extensive discussion about this if you want to have a look
> in the linux-kernel archives.

The conclusion of that discussion and some subsequent ones around
particular drivers came down to the first question I asked. Basically
it depends on what you want to do with it.  If it is indeed being used as
an input device, at least for the time being, the input subsystem is going
to be the place to put it. (though the input guys aren't overly keen)
An alternative that has been proposed is to temporarily put any such drivers
in misc on the basis that they can then get swept up when a suitable
alternative hits the mainline.  This is what is happening with those
accelerometer that have yet another purpose (free fall detection and disk
parking).

My particular applications and the reason for sparking the original discussion
are concentrated around measurement of various things including acceleration
with a view to use within various realtime algorithms. I'm not trying to drive
a gui.  Hence the requirements are quite different (things like ring buffer
handling, high accuracy flexible timing of sampling etc).  

There was a suggestion that it might be possible to make dual mode drivers
that work for both purposes but at them moment this is someway down the line
and I'm not personally convinced it will necessarily be a good idea (too many
compromises may be necessary to fit both frameworks).  Possibly we are looking
at a shared code situation rather than actually sharing the whole driver.
 
>> http://wiki.openmoko.org/wiki/Technical:Accelerometer_Fundamentals
>> http://wiki.openmoko.org/wiki/Accelerometer_data_retrieval
>> https://svn.openmoko.org/trunk/src/target/kernel/patches/lis302dl.patch
> 
> I've an Bosch SMB380 driver as well, but until someone gets this
> sorted out there's not much we can do.

Cool, is the driver available somewhere? (I wouldn't mind taking a look)

> I belive one of the posters
> to this thread has proposed an alternative, but I have no idea what
> the current state of affairs is wrt to getting this or anything
> else merged.

That'll be me I guess ;( (and industrialio as it's currently called - I'm
still hoping someone comes up with a better name). Anyhow I'll give a
quick update here as it may be a week or two before I've cleaned up
the code enough to send out another patch set.

Things have gotten a bit hectic for me over the last few weeks (project
deadlines) so work has slowed somewhat.  

Based on feedback to the previous patch set I posted, I've been mostly
concerned with breaking the structure down considerably so as to end up
with a larger set of more focussed elements.

The current plan is to have a core module that handles registration etc
(and things like chrdev and sysfs allocations)  This is really just
a fairly slim management layer that all device drivers will utilize.
Then there is a generic ring buffer framework.  Ring buffers are either
separate modules implementing certain core functionality which can then
be used by a driver, or driver specific implementations (for example
for a hardware ring buffer on the actual sensor - e.g. VTI's
accelerometers).  Further modules (and this is the bit I haven't finished)
handle timers to allow varying degrees of control over when readings are
taken.  Currently the only implementation in here uses a periodic interrupt
capable rtc.  Whilst this works there aren't many drivers that support that
functionality and in any case there may not be a suitable rtc available.
Hence alternative timer functionality is needed.

Thus any given driver can use any of the above functionality. In a sense,
other than the core code, the majority of the modules are really about
sharing functionality across a range of similar drivers.

Current test drivers are max1363 and similar adc's, ST lis3l02dq (I think
that's very similar to the openmoko chip, but just happens to be what
I have) VTI SCA3000 accelerometers (way more complex accelerometer with
hardware ring buffering) and Analog ADIS16350 (imu with accels and gyros).

As a quick summary for those who haven't been following the previous
discussions, the drivers can provide any (some sysfs elements are obligatory)
or all of:

1) Sysfs control interfaces and direct reading from the device (or last
   ring buffer element if appropriate)
2) Chrdev event interface (things like motion detection etc as implemented
   in the hardware)
3) Chrdev ring buffer event interface.
4) Chrdev ring buffer access interface (this may be talking to in kernel
   ring buffer or directly to hardware).

Once things have firmed up a bit I'll get a git repository up so that
people can keep a closer track on what is going on.

Timescale wise, it isn't going to be ready for the next merge window, but
I would hope to get it into linux-next not long after that.  There are
some controversial elements that I may be able to separate out so we can
get something that is usable in the kernel and do the fancy stuff later!

If anyone wants a look I'm happy to send patches offlist.

Cheers
