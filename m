From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH linux 2/6] hwmon: occ: Add sysfs interface
Date: Tue, 10 Jan 2017 11:45:08 -0600
Message-ID: <1484070308.21117.31.camel@kernel.crashing.org>
References: <1483120568-21082-1-git-send-email-eajames.ibm@gmail.com>
         <1483120568-21082-3-git-send-email-eajames.ibm@gmail.com>
         <20161230193404.GB8516@roeck-us.net>
         <OFA812992D.D19B1368-ON002580A0.007A2966-862580A0.007A72F0@notes.na.collabserv.com>
         <8b182766-32a0-9eb1-7917-14abf811cef5@roeck-us.net>
         <1483919532.2950.1.camel@aj.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1483919532.2950.1.camel@aj.id.au>
Sender: linux-doc-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>, Guenter Roeck <linux@roeck-us.net>, Edward James <eajames@us.ibm.com>
Cc: corbet@lwn.net, devicetree@vger.kernel.org, eajames.ibm@gmail.com, jdelvare@suse.com, joel@jms.id.au, linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-01-09 at 10:22 +1030, Andrew Jeffery wrote:
> Alternatively, in the style of your first para, we could push the
> host
> CPU state management into the kernel and expose a boot/reboot/power-
> off 
> API to userspace. That would give us a place to hook calls for
> configuring and cleaning up any host-dependent drivers on the BMC.

That's nasty. Each machine has a subtly different way of controller
host power, that would mean a different kernel driver for each of them,
which we are trying to avoid.

This is userspace policy.

Cheers,
Ben.
