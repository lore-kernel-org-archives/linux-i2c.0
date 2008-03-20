From: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Thu, 20 Mar 2008 07:59:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0803200733220.16142@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080320123315.648911cd@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080320123315.648911cd-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 20 Mar 2008, Jean Delvare wrote:
> Hi Trent,
>
> On Sun, 16 Mar 2008 14:33:23 -0700 (PDT), Trent Piepho wrote:
> > This is updated version of the previous patch.  I realized that I used four
> > space indent in the last one.  I changed it to 8, and then mode the hexdump
> > reading code to another function as it was getting too indented.  Also, it
> > can now understand the format of "eeprog".
> >
> > This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
> > file names to read SPD data from.  It can parse various hexdump formats,
> > such as the output from i2cdump and the util-linux and Busybox hexdump
> > progams run on a sysfs eeprom file.
> >
> > Useful for decoding SPD data that you cut and pasted from a manufacturer's
> > website or from a DIMM installed on an embeded system that does not have
> > perl/etc, but does have a serial console with busybox.
>
> FYI, we already have a way to achieve this, using the i2c-stub kernel
> driver and the standard i2c tools. For simple cases, the
> i2c-stub-from-dump helper script (in the i2c-tools SVN repository [1])
> automates almost everything. That's what I used to test your new DDR2
> timing decoding code, as my workstation doesn't have DDR2 memory.
>
> The main drawback compared to your approach is that one needs root
> access to the development system, but in practice I doubt that this is
> a problem. The advantage is that it works without any change to the
> application (e.g. decode-dimms) so all applications are supported right
> away.

It's also seriously inconvenient to have to compile and install a kernel
module just to decode some SPD data.  You can also only decode one file at
a time, since you can only load a single i2c-stub module.  It also requires
one to be running Linux, a new enough kernel that has i2c-stub, and have
the kernel source if your distribution didn't come with i2c-stub (we have
people using Linux vmware images that aren't loaded with all this extra
stuff).  And there is no way to _not_ decode all the other DIMMs you have
in your system at the same time as one of files you want to inspect.

And of course one needs root access.  Doesn't that seem a little
ridiculous, that one needs to be root to decode a spd data file?  I can
hear the windows developers mocking me already.  "I can't decode SDP data
with your lunix tools because I need root access?  That's stupid!  My
windows tools for decoding spd don't need to be run as administrator!  Do
you need to be root to uncompress zip files?"

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
