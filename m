From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Can't read DIMM SPD info (DDR2)
Date: Sun, 11 Sep 2011 10:09:45 +0200
Message-ID: <20110911100945.73fffa6a@endymion.delvare>
References: <op.v1lxasq616tawo@esprimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <op.v1lxasq616tawo@esprimo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Zatloukal <myxal.mxl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Michal,

On Sat, 10 Sep 2011 21:19:30 +0200, Michal Zatloukal wrote:
> I'm unable to get decode-dimms to display SPD info from my memory modules.
> Can someone please advise on finding the problem? The eeprom module is
> loaded. This is on both my main system (Kubuntu 10.10) - 2.6.35 kernel,
> i2c-tools 3.0.3-5 - and "latest" (Kubuntu 11.10 daily) - linux 3.0,
> lm-sensors 3.3.0-4 and i2c-tools 3.0.3-5). The HW is a Fujitsu Esprimo
> Mobile U9200 laptop (intel GM965). FWIW, the memtest that ships with
> 'buntu 11.10 (4.20 I think) reads the SPD info successfully.

Preliminary note: the version of lm-sensors doesn't matter, as
lm-sensors has nothing to do with reading SPD information.

Second preliminary note: as far as I know, memtest86 reads SPD
information using a BIOS call, while decode-dimms gets the information
over the SMBus, assuming that SPD EEPROMs are connected to the SMBus
and reachable at run time. This difference in access methods can
explain why memtest86 can see information and decode-dimms not on the
same system.

Third preliminary note: it is very common to not see SPD EEPROMs on
the SMBus on laptops (or not all of them). On my Thinkpad T60p, SPD
EEPROMs aren't visible on the SMBus at run time, so decode-dimms
doesn't work.

First thing to check is if the SMBus on your system is properly found
and supported:

# modprobe i2c-dev
# i2cdetect -l

On an Intel system you should see an entry like:

i2c-8	smbus     	SMBus I801 adapter at 0400      	SMBus adapter

Then you can check if devices are seen on the bus:

# i2cdetect 8

If you see anything in address range 0x50 to 0x55, this is likely to be
SPD EEPROMs. Then you have to make sure that the eeprom module is
loaded:

# modprobe eeprom
$ decode-dimms

If you do not see anything in address range 0x50 to 0x55, then this
means you are in the same situation as me, i.e. SPD EEPROMs not
reachable at run time (most likely because they are behind an I2C
multiplexer or switch and the bus segment(s) with the SPD EEPROMs are
disabled by the BIOS before handing control to the OS. Unfortunately
the mux/switch control is not standard, so without detailed
documentation from the hardware manufacturer, it's very difficult to
restore access to the SPD EEPROMs at run time.

-- 
Jean Delvare
