From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Thu, 18 Mar 2010 18:48:48 +0100
Message-ID: <20100318184848.4ec62327@hyperion.delvare>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
	<20100316180946.GC20160@linux-mips.org>
	<20100316200647.3803edf1@hyperion.delvare>
	<20100318170030.GJ4554@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100318170030.GJ4554-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ralf,

On Thu, 18 Mar 2010 18:00:30 +0100, Ralf Baechle wrote:
> On Tue, Mar 16, 2010 at 08:06:47PM +0100, Jean Delvare wrote:
> 
> > The Linux kernel doesn't care, but user-space may. As a matter of fact,
> > there is a script out there (decode-dimms, in the i2c-tools package)
> > decoding the SPD data and presenting it to the user. Some people want
> > to know the details about their memory modules.
> > 
> > > I also wonder how this will work for configurations with multiple memory
> > > modules thus multiple SPD EEPROMS.
> > 
> > The kernel code should instantiate one spd device per memory module
> > (assuming they are all reachable.) Obviously this can't be done in a
> > static way.
> 
> SPD is virtually omnipresent these days so I wonder if maybe there already
> is some probing functionality already available?

Not that I aware of, except for the fact that the "eeprom" driver will
probe all i2c adapters with class bit I2C_CLASS_SPD set for chips at
addresses 0x50-0x57, and it will instantiate a device for each of them.
This will instantiate devices for non-SPD EEPROM, and even non-EEPROMs
living at these addresses, so this can't really be considered a generic
solution.

A generic solution would let the platform (not the eeprom driver) probe
for devices at selected I2C addresses (the ones where SPD EEPROMs can
live of the specific platform) and instantiate spd devices (possibly
after integrity checking). This would avoid false positives.

-- 
Jean Delvare
