From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Thu, 20 Mar 2008 17:58:51 +0100
Message-ID: <20080320175851.2d4afb49@hyperion.delvare>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080320123315.648911cd@hyperion.delvare>
	<Pine.LNX.4.58.0803200733220.16142@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803200733220.16142-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Mar 2008 07:59:37 -0700 (PDT), Trent Piepho wrote:
> On Thu, 20 Mar 2008, Jean Delvare wrote:
> > FYI, we already have a way to achieve this, using the i2c-stub kernel
> > driver and the standard i2c tools. For simple cases, the
> > i2c-stub-from-dump helper script (in the i2c-tools SVN repository [1])
> > automates almost everything. That's what I used to test your new DDR2
> > timing decoding code, as my workstation doesn't have DDR2 memory.
> >
> > The main drawback compared to your approach is that one needs root
> > access to the development system, but in practice I doubt that this is
> > a problem. The advantage is that it works without any change to the
> > application (e.g. decode-dimms) so all applications are supported right
> > away.
> 
> It's also seriously inconvenient to have to compile and install a kernel
> module just to decode some SPD data.  You can also only decode one file at
> a time, since you can only load a single i2c-stub module.

In fact you can decode up to 8 files at once (since kernel 2.6.24), as
i2c-stub can create up to 10 virtual devices (could be increased if
needed) and the eeprom driver attaches to devices at addresses
0x50-0x57. We could also create more than one I2C adapter in i2c-stub
if needed.

> It also requires
> one to be running Linux, a new enough kernel that has i2c-stub, and have
> the kernel source if your distribution didn't come with i2c-stub (we have
> people using Linux vmware images that aren't loaded with all this extra
> stuff).  And there is no way to _not_ decode all the other DIMMs you have
> in your system at the same time as one of files you want to inspect.

You can unload the on-board SMBus adapter driver, that's what I did to
test your DDR2 decoding patch. This might not be an option if there are
other chips on the SMBus and you can't live without them, though.

> 
> And of course one needs root access.  Doesn't that seem a little
> ridiculous, that one needs to be root to decode a spd data file?  I can
> hear the windows developers mocking me already.  "I can't decode SDP data
> with your lunix tools because I need root access?  That's stupid!  My
> windows tools for decoding spd don't need to be run as administrator!  Do
> you need to be root to uncompress zip files?"

I fail to see what Windows developers [1] have to do in the picture.
Either the requirement to be root for this operation is acceptable to
us in practice, or it is not. If it isn't, we fix it, for example by
applying the patch you submitted. What people NOT using the code in
question think about its usage requirements, I couldn't care less.

I didn't mean to suggest that your patch was not welcome. I was only
mentioning an alternative which is already implemented, for your
information (thus the leading "FYI" in my reply.) Of course i2c-stub is
not perfect for the job, it was not designed for it. i2c-stub was
designed to allow I2C device emulation at kernel level. Using it for a
purely user-space job as I suggested is a side use.

-- 
Jean Delvare

[1] Especially when your Windows developer friend is most probably
always logged as Administrator anyway because there are so many things
that don't work properly as a regular user ;)


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
